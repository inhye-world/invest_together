package bit.it.into.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.parser.ParseException;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.AccountSalaryDTO;
import bit.it.into.dto.AccountTransactionDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.BankService;
import bit.it.into.service.OpenBankingService;
import bit.it.into.service.SalaryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.sf.json.JSONArray;
import net.sf.json.JSONException;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONTokener;

@Controller
@AllArgsConstructor
@Log4j
public class SalaryController {

	private OpenBankingService open;
	private SalaryService salary;
	private BankService service;

	@RequestMapping(value = "/salaryList-{year}-{month}")

	public String accountSalary(Authentication authentication, @PathVariable String year, @PathVariable String month,String category,
			Model model) throws UnsupportedEncodingException, IOException, ParseException, JSONException {

		log.info("SalaryController - accountTransaction()");

		if (authentication == null) {
			return "login/login_require";
		}

		CustomUser user = (CustomUser) authentication.getPrincipal();
		String access_token = user.getDto().getAccess_token();

		int user_num = user.getDto().getMember_num();
		List<AccountDTO> accountList = service.getAccountList(user_num);
		List<AccountSalaryDTO> accountSalaryList = new ArrayList<AccountSalaryDTO>();
		

		int sum1 = 0;
		int sum2 = 0;
		int sum3 = 0;

		for (AccountDTO dto : accountList) {
			AccountSalaryDTO salaryDTO = new AccountSalaryDTO();

			String fintech_use_num = dto.getFintech_use_num();
			String account_alias = dto.getAccount_alias();
			String bank_name = dto.getBank_name();

			JsonNode node = open.getAccountBalance(access_token, fintech_use_num);
			String balance_amt = node.get("balance_amt").asText();

			String result = open.getBreakdown(access_token, fintech_use_num, year, month);
			JSONObject root = (JSONObject) new JSONTokener(result).nextValue();
			JSONArray brArr = (JSONArray) root.get("res_list");
			
			 if(salary.hasSalary(fintech_use_num)) { 
				salaryDTO = salary.getSalaryList(fintech_use_num);
			 }
			
			salaryDTO.setFintech_use_num(fintech_use_num);
			salaryDTO.setAccount_alias(account_alias);
			salaryDTO.setBank_name(bank_name);
			salaryDTO.setBalance_amt(balance_amt);

			
			for (int i = brArr.size()-1; i>=0; i--) {
				String inout_type = brArr.getJSONObject(i).getString("inout_type");
				String tran_amt = brArr.getJSONObject(i).getString("tran_amt");
				
				if(inout_type.equals("입금")) {
					salaryDTO.setTran_amt(tran_amt);
				}else if(inout_type.equals("출금")) {
					continue;
				}
			}

			accountSalaryList.add(salaryDTO);

			for (int j = 0; j < accountSalaryList.size(); j++) {
				category = salaryDTO.getCategory();
				if(category!=null) {
					if (category.equals("적금")) {
						salaryDTO.setSum1(sum1);
						sum1 += Integer.valueOf(balance_amt);
						break;
					} if (category.equals("예금")) {
						salaryDTO.setSum2(sum2);
						sum2 += Integer.valueOf(balance_amt);
						break;
					} if (category.equals("자유 입출금")) {
						salaryDTO.setSum3(sum3);
						sum3 += Integer.valueOf(balance_amt);
						break;
					} 
				}	
			}
			

			if (accountSalaryList.isEmpty()) {
				return "bank/account_transaction_empty";
			}
		}

		model.addAttribute("accountSalaryList", accountSalaryList);
		model.addAttribute("sum1", sum1);
		model.addAttribute("sum2", sum2);
		model.addAttribute("sum3", sum3);
		
		return "bank/account_salary";

	}

	@PostMapping(value = "/salary_modify")
	public String modify(Authentication authentication, AccountSalaryDTO accountSalaryDTO) throws Exception {
		log.info("SalaryController - modify()");

		if (authentication == null) {
			return "login/login_require";
		}

		log.info("==============" + accountSalaryDTO.getFintech_use_num());

		salary.modify(accountSalaryDTO);

		return "redirect:salaryList";

	}

	// ---------------------------------------
	@RequestMapping(value = "/account_salary", produces = "application/json", method = { RequestMethod.GET,
			RequestMethod.POST })
	public String aTransaction(Authentication authentication, HttpServletRequest request, Model model)
			throws ParseException, java.text.ParseException {
		log.info("BankController - aTransaction()");

		if (authentication == null) {
			return "login/login_require";
		}

		CustomUser user = (CustomUser) authentication.getPrincipal();

		String access_token = user.getDto().getAccess_token();

		int user_num = user.getDto().getMember_num();
		List<AccountDTO> accountList = service.getAccountList(user_num);
		List<AccountTransactionDTO> accountTransactionList = new ArrayList<>();

		int incomeSum = 0;
		int expenseSum = 0;

		String fintech_use_num = request.getParameter("fin");
		JsonNode node = open.getAccountTransactionList(access_token, fintech_use_num, "2020", "09");

		String product_name = open.getAccountBalance(access_token, fintech_use_num).get("product_name").asText();

		int count = 0;
		while (true) {
			String tran_date = node.get("res_list").get(count).get("tran_date").asText();
			String tran_time = node.get("res_list").get(count).get("tran_time").asText();
			String inout_type = node.get("res_list").get(count).get("inout_type").asText();
			String tran_type = node.get("res_list").get(count).get("tran_type").asText();
			String print_content = node.get("res_list").get(count).get("print_content").asText();
			String tran_amt = node.get("res_list").get(count).get("tran_amt").asText();
			String branch_name = node.get("res_list").get(count).get("branch_name").asText();
			LocalDateTime tran_date_time = LocalDateTime.parse(tran_date + tran_time,
					DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

			String after_balance_amt = node.get("res_list").get(count).get("after_balance_amt").asText();

			int day = tran_date_time.getDayOfMonth();

			AccountTransactionDTO transactionDTO = new AccountTransactionDTO(tran_date_time, inout_type, tran_type,
					print_content, tran_amt, branch_name, product_name, after_balance_amt, day);
			accountTransactionList.add(transactionDTO);

			if (inout_type.equals("입금")) {
				incomeSum += Integer.valueOf(tran_amt);
			}
			if (inout_type.equals("출금")) {
				expenseSum += Integer.valueOf(tran_amt);
			}

			++count;
			if (node.get("res_list").get(count) == null) {
				break;
			}

		}

		Collections.sort(accountTransactionList, new Comparator<AccountTransactionDTO>() {
			@Override
			public int compare(AccountTransactionDTO d1, AccountTransactionDTO d2) {
				if (d1.getTran_date_time().isBefore(d2.getTran_date_time())) {
					return -1;
				} else if (d1.getTran_date_time().isAfter(d2.getTran_date_time())) {
					return 1;
				}
				return 0;
			}
		});

		model.addAttribute("accountTransactionList", accountTransactionList);
		model.addAttribute("incomeSum", incomeSum);
		model.addAttribute("expenseSum", expenseSum);

		if (accountTransactionList.isEmpty()) {
			return "bank/account_transaction_empty";
		}

		return "bank/account_salary_list";

	}

}
