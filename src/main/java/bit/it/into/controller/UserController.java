package bit.it.into.controller;



import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.OpenBankingService;
import bit.it.into.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class UserController {
	
	private UserService service;
	private OpenBankingService open;
	
	@RequestMapping("/user/myPage")
	public String myPage(Model model) {
		log.info("UserController - myPage()");
		
		model.addAttribute("open_url", open.getUrl());
			
		return "user/myPage";
	}
	
	@RequestMapping(value = "/user/addAccount", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST })
	public String addAccount(@RequestParam("code") String code, Authentication authentication) {
		log.info("OpenBankingController - addAccount()");
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		
		JsonNode node = open.getAccessToken(code);
		String access_token = node.get("access_token").asText();
		String refresh_token = node.get("refresh_token").asText();
		String user_seq_no = node.get("user_seq_no").asText();
		
		JsonNode userInfo = open.getUserInfo(access_token, user_seq_no);
		String fintech_use_num = userInfo.get("res_list").get(0).get("fintech_use_num").asText();
		String account_alias = userInfo.get("res_list").get(0).get("account_alias").asText();
		String bank_name = userInfo.get("res_list").get(0).get("bank_name").asText();
		
		
		int user_num = user.getDto().getMember_num();
		
		AccountDTO accountDTO = new AccountDTO(user_num, fintech_use_num, account_alias, bank_name);
		
		service.addUserAccountInfo(accountDTO, user_num, access_token, refresh_token, user_seq_no);
		
		return "user/addAccount_clear";
	}
}
