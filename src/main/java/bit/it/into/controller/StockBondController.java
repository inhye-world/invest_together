package bit.it.into.controller;

import java.util.List;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


import bit.it.into.dto.BondDTO;
import bit.it.into.dto.StockDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.OpenBankingService;
import bit.it.into.service.StockBondService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class StockBondController {

	private StockBondService service;
	private OpenBankingService open;
	
	@RequestMapping("/stockBondTable")
	public String stockBondTable(Authentication authentication, Model model) {
		log.info("StockBondController - stockBondTable()");
		
		if(authentication==null) {
			return "login/login_require";
		}
		
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		
		List<StockDTO> stockList = service.getStockList(user_num);
		List<BondDTO> bondList = service.getBondList(user_num);
		
		model.addAttribute("stockList", stockList);
		model.addAttribute("bondList", bondList);
		
		return "stockbond/table";
	}
	
	@PostMapping("/buyStock")
	public String buyStock(Authentication authentication, StockBuyDTO stockBuyDTO) {
		log.info("StockBondController - buyStock");
		
		if(authentication==null) {
			return "login/login_require";
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
		log.info("StockBondController - sellStock");
		
		if(authentication==null) {
			return "login/login_require";
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
		log.info("StockBondController - deleteStock");
		
		if(authentication==null) {
			return "login/login_require";
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
		log.info("StockBondController - stockInfo()");
		
		String strCode = String.format("%06d", code); 
		String stockInfoXml = service.getStockInfoXml(strCode);
		JSONObject stockInfoJson = XML.toJSONObject(stockInfoXml);
		
		return stockInfoJson.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/stockAutocomplete", produces="application/text; charset=utf8")
	public String stockAutocomplete(HttpServletRequest request) {
		log.info("StockBondController - stockAutocomplete()");
		
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
