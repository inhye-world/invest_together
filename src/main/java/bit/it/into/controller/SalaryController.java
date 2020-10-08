package bit.it.into.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.parser.ParseException;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.AccountSalaryDTO;
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
	public String accountSalary(Authentication authentication, @PathVariable String year, @PathVariable String month, Model model) throws UnsupportedEncodingException, IOException, ParseException, JSONException{
		log.info("SalaryController - accountTransaction()");

		if (authentication == null) {
			return "login/login_require";
		}

		CustomUser user = (CustomUser) authentication.getPrincipal();
		String access_token = user.getDto().getAccess_token();

		int user_num = user.getDto().getMember_num();
		List<AccountDTO> accountList = service.getAccountList(user_num);
		List<AccountSalaryDTO> accountSalaryList = new ArrayList<AccountSalaryDTO>();
		
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
			
			salaryDTO = salary.getSalaryList(fintech_use_num);
			
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
			
			if(accountSalaryList.isEmpty()) {
				return "bank/account_transaction_empty";
			}
		}
		model.addAttribute("accountSalaryList", accountSalaryList);
		
		return "bank/account_salary";

	}

	@PostMapping(value = "/salary_modify")
	public String modify(Authentication authentication, AccountSalaryDTO accountSalaryDTO) throws Exception {
		log.info("SalaryController - modify()");

		if (authentication == null) {
			return "login/login_require";
		}
		
		log.info("=============="+accountSalaryDTO.getFintech_use_num());
		
		salary.modify(accountSalaryDTO);

		return "redirect:salaryList";
	}

}
