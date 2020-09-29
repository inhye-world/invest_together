package bit.it.into.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountBalanceDTO;
import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.AccountSalaryDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.BankService;
import bit.it.into.service.OpenBankingService;
import bit.it.into.service.SalaryService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class SalaryController {

	private OpenBankingService open;
	private SalaryService salary;
	private BankService service;

	@RequestMapping(value = "/salaryList")
	public String accountSalary(Authentication authentication, Model model) {
		log.info("BankController - accountTransaction()");

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

			
			/* 실질입금액 확인용
			String year=null;
			String month=null;
			*/
			
			
			JsonNode node = open.getAccountBalance(access_token, fintech_use_num);
			
			/*실질입금액 확인용
			JsonNode node2 = open.getAccountTransactionList(access_token, fintech_use_num, year, month);
			*/

			//String product_name = node.get("product_name").asText();
			String balance_amt = node.get("balance_amt").asText();
			//String tran_amt = node2.get("res_list").get("tran_amt").asText(); //제일 마지막 이체 금액만 나오도록
			
			/* 화면구현 완성되면 할일
			if(product_name.indexOf("적금") != -1) { 
				log.info("예적금으로 sorting"); 
			}
			*/ 
			
			
			salaryDTO = salary.getSalaryList(fintech_use_num);
			
			salaryDTO.setFintech_use_num(fintech_use_num);
			salaryDTO.setAccount_alias(account_alias);
			salaryDTO.setBank_name(bank_name);
			//salaryDTO.setProduct_name(product_name);
			salaryDTO.setBalance_amt(balance_amt);
			//salaryDTO.setTran_amt(tran_amt);
			
			accountSalaryList.add(salaryDTO);
			
		}
		model.addAttribute("accountSalaryList", accountSalaryList);
		
		return "bank/account_salary3";

	}

	@RequestMapping(value = "/salary_modify")
	public String modify(Authentication authentication, AccountSalaryDTO accountSalaryDTO) throws Exception {
		log.info("BankController - modify()");

		if (authentication == null) {
			return "login/login_require";
		}
		
		log.info("=============="+accountSalaryDTO.getFintech_use_num());
		
		salary.modify(accountSalaryDTO);

		return "bank/account_salary3";
	}

}
