package bit.it.into.controller;

import java.text.ParseException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.LinkedList;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountBalanceDTO;
import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.AccountTransactionDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.BankService;
import bit.it.into.service.OpenBankingService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class BankController {

	private OpenBankingService open;
	private BankService service;
	
	
	@RequestMapping(value = "/accountBalance", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST })
	public String accountBalance(Authentication authentication, Model model) {
		log.info("BankController - accountBalance()");
		
		if(authentication == null) {
			return "login/login_require";
		}
		
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String access_token = user.getDto().getAccess_token();
		
		int user_num = user.getDto().getMember_num();
		List<AccountDTO> accountList = service.getAccountList(user_num);
		
		List<AccountBalanceDTO> accountBalanceList = new LinkedList<>();
		
		int sum = 0;
		
		for(AccountDTO dto : accountList) {
			AccountBalanceDTO balanceDTO = new AccountBalanceDTO();
			
			String fintech_use_num = dto.getFintech_use_num();
			JsonNode node = open.getAccountBalance(access_token, fintech_use_num);
			
			String product_name = node.get("product_name").asText();
			String balance_amt = node.get("balance_amt").asText();
			
			balanceDTO.setAccountDTO(dto);
			balanceDTO.setProduct_name(product_name);
			balanceDTO.setBalance_amt(balance_amt);
			
			accountBalanceList.add(balanceDTO);
			
			sum += Integer.valueOf(balance_amt);
		}
		
		
		model.addAttribute("accountBalanceList", accountBalanceList);
		model.addAttribute("balanceSum", sum);
		
		if(accountBalanceList.isEmpty()) {
			return "bank/account_balance_empty";
		}
		
		return "bank/account_balance";
	}
	
	
	
	@RequestMapping(value = "/accountTransaction-{year}-{month}", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST })
	public String accountTransaction(Authentication authentication, @PathVariable String year, @PathVariable String month, Model model) throws ParseException {
		log.info("BankController - accountTransaction()");
		
		if(authentication == null) {
			return "login/login_require";
		}
		
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String access_token = user.getDto().getAccess_token();
		
		int user_num = user.getDto().getMember_num();
		List<AccountDTO> accountList = service.getAccountList(user_num);
		
		List<AccountTransactionDTO> accountTransactionList = new ArrayList<>();
		
		LocalDateTime startDate = LocalDateTime.parse(year+month+"010000", DateTimeFormatter.ofPattern("yyyyMMddHHmm"));
		LocalDateTime endDate = startDate.plusMonths(1);
		
		int incomeSum = 0;
		int expenseSum = 0;
		
		for(AccountDTO dto : accountList) {
			String fintech_use_num = dto.getFintech_use_num();
			JsonNode node = open.getAccountTransactionList(access_token, fintech_use_num, year, month);
			
			String product_name = open.getAccountBalance(access_token, fintech_use_num).get("product_name").asText();
			
			int count = 0;
			while(true) {
				String tran_date = node.get("res_list").get(count).get("tran_date").asText();
				String tran_time = node.get("res_list").get(count).get("tran_time").asText();
				String inout_type = node.get("res_list").get(count).get("inout_type").asText();
				String tran_type = node.get("res_list").get(count).get("tran_type").asText();
				String print_content = node.get("res_list").get(count).get("print_content").asText();
				String tran_amt = node.get("res_list").get(count).get("tran_amt").asText();
				String branch_name = node.get("res_list").get(count).get("branch_name").asText();
				LocalDateTime tran_date_time = LocalDateTime.parse(tran_date+tran_time, DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));
				String after_balance_amt = node.get("res_list").get(count).get("after_balance_amt").asText();
				if(startDate.isBefore(tran_date_time) && endDate.isAfter(tran_date_time)) {
					int day = tran_date_time.getDayOfMonth();
					
					AccountTransactionDTO transactionDTO = new AccountTransactionDTO(tran_date_time, inout_type, tran_type, print_content, tran_amt, branch_name, product_name,after_balance_amt, day);
					accountTransactionList.add(transactionDTO);
					
					if(inout_type.equals("입금")) {
						incomeSum += Integer.valueOf(tran_amt);
					}
					if(inout_type.equals("출금")) {
						expenseSum += Integer.valueOf(tran_amt);
					}
				}	
				
				++count;
				if(node.get("res_list").get(count) == null) {
					break;
				}
			}
		}
		
		Collections.sort(accountTransactionList, new Comparator<AccountTransactionDTO>(){
			@Override
			public int compare(AccountTransactionDTO d1, AccountTransactionDTO d2) {
				if(d1.getTran_date_time().isBefore(d2.getTran_date_time())) {
					return 1;
				}else if(d1.getTran_date_time().isAfter(d2.getTran_date_time())) {
					return -1;
				}
				return 0;
			}
		});
		
		
		model.addAttribute("accountTransactionList", accountTransactionList);
		model.addAttribute("incomeSum", incomeSum);
		model.addAttribute("expenseSum", expenseSum);
		
		if(accountTransactionList.isEmpty()) {
			return "bank/account_transaction_empty";
		}
		
		return "bank/account_transaction";
	}
	
}
