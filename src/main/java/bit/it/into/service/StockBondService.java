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
	
}
