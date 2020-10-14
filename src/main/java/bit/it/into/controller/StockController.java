package bit.it.into.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.json.XML;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.BondDTO;
import bit.it.into.dto.StockBuyDTO;
import bit.it.into.dto.StockDTO;
import bit.it.into.dto.StockSellDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.BankService;
import bit.it.into.service.OpenBankingService;
import bit.it.into.service.StockService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class StockController {

	private StockService service;
	private BankService bank;
	private OpenBankingService open;
	
	
	@RequestMapping("/stockBondTable")
	public String stockBondTable(Authentication authentication, Model model) {
		log.info("StockController - stockBondTable()");
		
		if(authentication==null) {
			return "login/loginForm";
		}
		
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		String access_token = user.getDto().getAccess_token();
		
		List<StockDTO> stockList = service.getStockList(user_num);
		List<BondDTO> bondList = service.getBondList(user_num);
		
		int accountSum = 0;
		
		List<AccountDTO> accountList = bank.getAccountList(user_num);
		
		for(AccountDTO dto : accountList) {
			String fintech_use_num = dto.getFintech_use_num();
			JsonNode node = open.getAccountBalance(access_token, fintech_use_num);
			String balance_amt = node.get("balance_amt").asText();
			accountSum += Integer.valueOf(balance_amt);
		}
		
		model.addAttribute("stockList", stockList);
		model.addAttribute("bondList", bondList);
		model.addAttribute("accountSum", accountSum);
		
		
		return "stockbond/table";
	}
	
	@PostMapping("/buyStock")
	public String buyStock(Authentication authentication, StockBuyDTO stockBuyDTO) {
		log.info("StockController - buyStock()");
		
		if(authentication==null) {
			return "login/loginForm";
		}
		
		
		StockDTO stockDTO = new StockDTO(stockBuyDTO);
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		stockDTO.setMember_num(user_num);
		
		boolean hasStock = service.hasStock(stockDTO);
		
		if(hasStock) {
			service.modifyAddstock(stockDTO);
		}else {
			service.addStock(stockDTO);
		}
		
		
		return "redirect:/stockBondTable";
	}
	
	@PostMapping("/sellStock")
	public String sellStock(Authentication authentication, StockSellDTO stockSellDTO) {
		log.info("StockController - sellStock()");
		
		if(authentication==null) {
			return "login/loginForm";
		}
		
		
		StockDTO stockDTO = new StockDTO(stockSellDTO);
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		stockDTO.setMember_num(user_num);
		
		service.modifyRemoveStock(stockDTO);
		
		
		return "redirect:/stockBondTable";
	}
	
	@PostMapping("/deleteStock")
	public String deleteStock(Authentication authentication, HttpServletRequest request) {
		log.info("StockController - deleteStock()");
		
		if(authentication==null) {
			return "login/loginForm";
		}
		
		String[] stockSymbols = request.getParameterValues("deleteStockSymbol");
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		
		service.deleteStocks(user_num, stockSymbols);
		
		
		return "redirect:/stockBondTable";
	}
	
	
	@ResponseBody
	@RequestMapping("/rest/stockInfo/{code}")
	public String stockInfo(@PathVariable int code) {
		log.info("StockController - stockInfo()");
		
		String strCode = String.format("%06d", code); 
		String stockInfoXml = service.getStockInfoXml(strCode);
		JSONObject stockInfoJson = XML.toJSONObject(stockInfoXml);
		
		return stockInfoJson.toString();
	}
	
	@ResponseBody
	@RequestMapping("/rest/stockSymbolValid")
	public String stockSymbolValid(HttpServletRequest request) {
		log.info("StockController - stockSymbolValid()");
		
		String symbol = request.getParameter("symbol");
		
		boolean hasStock = service.hasStockInfoBySymbol(symbol);
		
		JSONObject object = new JSONObject();
		object.put("hasStock", hasStock);
		
		return object.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/stockAutocomplete", produces="application/text; charset=utf8")
	public String stockAutocomplete(HttpServletRequest request) {
		log.info("StockController - stockAutocomplete()");
		
		String value = request.getParameter("value");
		
		List<String> autocompleteList = service.getAutocompleteList(value);
		
		JSONArray jarr = new JSONArray();
		
		for(String str : autocompleteList) {
			JSONObject object = new JSONObject();
			object.put("label", str);
			object.put("value", str);
			
			jarr.put(object);
		}
		
		return jarr.toString();
	}
	
}
