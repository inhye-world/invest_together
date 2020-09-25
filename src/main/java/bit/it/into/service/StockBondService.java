package bit.it.into.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.BondDTO;
import bit.it.into.dto.StockDTO;
import bit.it.into.mapper.StockBondMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class StockBondService {

	@Inject
	private StockBondMapper mapper;

	
	public List<StockDTO> getStockList(int member_num) {
		log.info("StockBondService - getStockList()");
		
		return mapper.selectStockList(member_num);
	}

	public List<BondDTO> getBondList(int member_num) {
		log.info("StockBondService - getBondList()");
		
		return mapper.selectBondList(member_num);
	}

	public boolean hasStock(StockDTO stockDTO) {
		log.info("StockBondService - hasStock()");
		
		Integer count = mapper.selectStockCount(stockDTO);
		
		if(count == 0) {
			return false;
		}
		
		return true;
	}

	public void addStock(StockDTO stockDTO) {
		log.info("StockBondService - addStock()");
		
		int count = mapper.insertStock(stockDTO);
		
		if(count != 1) {
			log.info("insertStock 오류");
		}
	}

	public void modifyAddstock(StockDTO stockDTO) {
		log.info("StockBondService - modifyAddstock()");
		
		StockDTO original = mapper.selectStock(stockDTO);
		
		int quantity_result = original.getQuantity() + stockDTO.getQuantity();
		int purchase_price_result = ((original.getPurchase_price()*original.getQuantity())
									+(stockDTO.getPurchase_price()*stockDTO.getQuantity()))
									/quantity_result;
		
		stockDTO.setQuantity(quantity_result);
		stockDTO.setPurchase_price(purchase_price_result);
		
		int count = mapper.updateAddStock(stockDTO);
		
		if(count != 1) {
			log.info("updateAddStock 오류");
		}
	}

	public void modifyRemoveStock(StockDTO stockDTO) {
		log.info("StockBondService - modifyRemovestock()");
		
		StockDTO original = mapper.selectStock(stockDTO);
		
		int qutity_result = original.getQuantity() - stockDTO.getQuantity();
		
		stockDTO.setQuantity(qutity_result);
		
		int count = mapper.updateRemoveStock(stockDTO);
		
		if(count != 1) {
			log.info("updateRemoveStock 오류");
		}
	}
	
	public void deleteStocks(int member_num, String[] stockSymbols) {
		log.info("StockBondService - deleteStocks()");
		
		int countSum = 0;
		for(int i=0; i<stockSymbols.length; ++i) {
			int count = mapper.deleteStock(member_num, stockSymbols[i]);
			countSum += count;
		}
		
		if(countSum != stockSymbols.length) {
			log.info("deleteStock 오류");
		}
	}

	
	
	
	public String getStockInfoXml(String strCode) {
		log.info("StockBondService - getStockInfoXml()");
		
		String url = "http://asp1.krx.co.kr/servlet/krx.asp.XMLSiseEng?code="+strCode;
		
		try {
			URL targetUrl = new URL(url);
		    BufferedReader reader = new BufferedReader(new InputStreamReader(targetUrl.openStream()));
		    StringBuilder html = new StringBuilder();
		    String current = "";
		    while ((current = reader.readLine()) != null) {
		    	html.append(current);
		    }
			reader.close();
		    return html.toString();
		
		} catch (Exception e) {
	    	e.printStackTrace();
	    }	 
		
		return null;
	}

	public List<String> getAutocompleteList(String value) {
		log.info("StockBondService - getAutocompleteList()");
		
		return mapper.selectAutocompleteList(value);
	}

}
