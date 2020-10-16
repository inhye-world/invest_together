package bit.it.into.controller;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.BondDTO;
import bit.it.into.dto.CalculatorDTO;
import bit.it.into.dto.StockDTO;
import bit.it.into.dto.SubscribeDTO;
import bit.it.into.dto.SubscribeInfoDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.BankService;
import bit.it.into.service.BondService;
import bit.it.into.service.CalculatorService;
import bit.it.into.service.IamportService;
import bit.it.into.service.OpenBankingService;
import bit.it.into.service.StockService;
import bit.it.into.service.SubscribeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class SubscribeController {

	private SubscribeService service;
	private IamportService imp;
	private OpenBankingService open;
	private BankService bank;
	private StockService stock;
	private BondService bond;
	private CalculatorService cal;
	
	
	@RequestMapping("/subList")
	public String subList(Authentication authentication, Model model) {
		log.info("SubscribeController - subList()");
		
		if(authentication==null) {
			return "login/login_require";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		
		List<SubscribeDTO> subList = service.getSubscribeList(user_num);
		List<SubscribeInfoDTO> list = new ArrayList<>();
		
		for(SubscribeDTO dto : subList) {
			SubscribeInfoDTO infoDTO = new SubscribeInfoDTO(dto);
			
			String seller_nickname = service.getNicknameByMemberNum(dto.getSeller_num());
			infoDTO.setSeller_nickname(seller_nickname);
			
			list.add(infoDTO);
		}
		
		model.addAttribute("list", list);
		
		return "subscribe/sub_list";
	}
	
	@RequestMapping("/subInfo")
	public String subInfo(HttpServletRequest request, Authentication authentication, Model model) {
		log.info("SubscribeController - subInfo()");
		
		if(authentication==null) {
			return "login/login_require";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		
		if(request.getParameter("seller_num")==null) {
			// 에러페이지?
			return "error/accessDenied";
		}
		
		Integer seller_num = Integer.valueOf(request.getParameter("seller_num"));
		
		if(!service.isSubscribe(user_num, seller_num)) {
			return "error/accessDenied";
		}
		
		//////////////////////////////////////////////////////////////////////////
		
		String nickname = service.getNicknameByMemberNum(seller_num);
				
		//////////		
		
		String access_token = service.getAccessToken(seller_num);
		
		List<AccountDTO> accountList = bank.getAccountList(seller_num);
		
		int accountSum = 0;
		for(AccountDTO dto : accountList) {
			String fintech_use_num = dto.getFintech_use_num();
			JsonNode node = open.getAccountBalance(access_token, fintech_use_num);
			String balance_amt = node.get("balance_amt").asText();
			accountSum += Integer.valueOf(balance_amt);
		}
		
		//////////
		
		List<StockDTO> stockList = stock.getStockList(seller_num);
		List<BondDTO> bondList = bond.getList(seller_num);
		
		//////////
		
		List<CalculatorDTO> calList = cal.getSymbolsList(seller_num);
		
		
		
		model.addAttribute("seller_num", seller_num);
		model.addAttribute("nickname", nickname);
		model.addAttribute("accountSum", accountSum);
		model.addAttribute("stockList", stockList);
		model.addAttribute("bondList", bondList);
		model.addAttribute("calList", calList);
		
		
		return "subscribe/sub_info";
	}
	
	@RequestMapping("/paymentComplete")
	public String paymentComplete(HttpServletRequest request, Model model) {
		log.info("SubscribeController - paymentComplete()");
		
		String merchant_uid = request.getParameter("merchant_uid");
		SubscribeDTO dto = service.getSubscribe(merchant_uid);
		
		model.addAttribute("dto", dto);
		
		return "subscribe/payment_complete";
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/getMerchantSeq", produces="application/text; charset=utf8")
	public String getMerchantSeq() {
		log.info("SubscribeController - getMerchantSeq()");

		String seq = String.format("%04d", service.getMerchantSeq());
		
		JSONObject result = new JSONObject();
		result.put("seq", seq);
	
		return result.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/completePayment", method=RequestMethod.POST)
	public String completePayment(SubscribeDTO subscribeDTO) {
		log.info("SubscribeController - completePayment()");
		
		int seller_num = subscribeDTO.getSeller_num();
		
		Integer set_price = service.getSetPrice(seller_num);
		int payment_price = subscribeDTO.getSub_price();
		
		
		JSONObject result = new JSONObject();
		
		if(set_price==null) {
			result.put("successPayment", false);
			result.put("hasSetPrice", false);
			
			return result.toString();
		}
		
		if(set_price==payment_price) {
			service.successPayment(subscribeDTO);
			
			result.put("successPayment", true);
		}else {
			result.put("successPayment", false);
			result.put("hasSetPrice", true);
		}
		
		return result.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/cancelPayment", produces="application/text; charset=utf8", method=RequestMethod.POST)
	public String cancelPayment(HttpServletRequest request) throws UnsupportedEncodingException {
		log.info("SubscribeController - cancelPayment()");
		
		String merchant_uid = request.getParameter("merchant_uid");
		String reason = request.getParameter("reason");
		
		JsonNode node = imp.getAccessToken();
		String access_token = node.get("response").get("access_token").asText();
		
		JsonNode result = imp.cancelPayment(merchant_uid, reason, access_token);
		
		
		return result.toString();
	}
	
	@ResponseBody
	@RequestMapping("/rest/getCalculatorInfo")
	public CalculatorDTO getCalculatorInfo(CalculatorDTO calculatorDTO){
		log.info("SubscribeController - getCalculatorInfo()");
		
		log.info("=====");
		log.info(calculatorDTO.getMember_num());
		log.info(calculatorDTO.getStockinfo_symbols());
		
		return cal.getList(calculatorDTO);
	
	}
}
