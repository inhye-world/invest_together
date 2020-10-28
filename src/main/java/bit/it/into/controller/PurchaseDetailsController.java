package bit.it.into.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.dto.MemberDTO;
import bit.it.into.dto.SubscribeDTO;
import bit.it.into.dto.SubscribeInfoDTO;
import bit.it.into.page.PurchaseCriteria;
import bit.it.into.security.CustomUser;
import bit.it.into.service.SubscribeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class PurchaseDetailsController {
	
	private SubscribeService service;
	
	@RequestMapping("/purchaseDetails")
	public String purchaseDetails(Authentication authentication,  Model model) {
		log.info("PurchaseDetailsController - purchaseDetails()");
		
		if(authentication==null) {
			return "login/login_require";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		
		List<SubscribeDTO> subList = service.getmySellSubscribeList(user_num);
		List<SubscribeInfoDTO> list = new ArrayList<>();
		
		for(SubscribeDTO dto : subList) {
			SubscribeInfoDTO infoDTO = new SubscribeInfoDTO(dto);
			
			String buyer_nickname = service.getNicknameByMemberNum(dto.getMember_num());
			infoDTO.setBuyer_nickname(buyer_nickname);
			
			list.add(infoDTO);
		}
		
		model.addAttribute("list", list);
		
		Integer price = service.getSetPrice(user_num);

		model.addAttribute("price", price);
		
		return "user/purchaseDetails";
	}
	
	@RequestMapping("/setPrice")
	public String setPrice(MemberDTO memberDTO,Authentication authentication, Model model) {
		log.info("PurchaseDetailsController - setPrice()");
				
		if(authentication==null) {
			return "redirect:/loginForm";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		int member_num = user.getDto().getMember_num();
		int set_price = memberDTO.getSet_price();
		
		Map<String, Integer> user_info = new HashMap();
		
		user_info.put("member_num", member_num);
		user_info.put("set_price", set_price);
	
		service.SetPrice(user_info);
		
		return "redirect:/purchaseDetails";
	}
	
}
