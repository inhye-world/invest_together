package bit.it.into.controller;

import java.util.LinkedList;
import java.util.List;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountBalanceDTO;
import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.BondDTO;
import bit.it.into.dto.StockDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.BankService;
import bit.it.into.service.BondService;
import bit.it.into.service.OpenBankingService;
import bit.it.into.service.StockService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class AssetsController {

	private StockService stock;
	private BondService bond;
	private BankService bank;
	private OpenBankingService open;
	
	@RequestMapping("/assets")
	public String assets(Authentication authentication, Model model) {
		log.info("AssetsController - assets()");
		
		if(authentication==null) {
			return "login/login_require";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		String access_token = user.getDto().getAccess_token();
		
		//////////////////////////////////////////////////////////
		
		int accountSum = 0;
		
		List<AccountDTO> accountList = bank.getAccountList(user_num);
		
		List<AccountBalanceDTO> accountBalanceList = new LinkedList<>();
		
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
			
			accountSum += Integer.valueOf(balance_amt);
		}
		
		//////////////////////////////////////////////////////////
		
		List<StockDTO> stockList = stock.getStockList(user_num);
		List<BondDTO> bondList = bond.getList(user_num);
		
		//////////////////////////////////////////////////////////
		
		model.addAttribute("accountBalanceList", accountBalanceList);
		model.addAttribute("accountSum", accountSum);
		model.addAttribute("stockList", stockList);
		model.addAttribute("bondList", bondList);
		
		
		return "assets/list";
	}
}
