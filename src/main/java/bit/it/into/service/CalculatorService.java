package bit.it.into.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.CalculatorDTO;
import bit.it.into.dto.StockInfoDTO;
import bit.it.into.mapper.CalculatorMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CalculatorService {
	
	@Inject
	private CalculatorMapper mapper;

	public void writeCalculator(CalculatorDTO calculatorDTO) {
		mapper.insert(calculatorDTO);
	}

	public void updateCalculator(CalculatorDTO calculatorDTO) {
		mapper.update(calculatorDTO);
	}

	public int checkSymbols(CalculatorDTO calculatorDTO) {
		return mapper.checkSymbols(calculatorDTO);
	}

	public List<CalculatorDTO> getSymbolsList(int i) {
		return mapper.getSymbolsList(i);
	}
	
	public CalculatorDTO getList(CalculatorDTO calculatorDTO){
		return mapper.getList(calculatorDTO);
	}

	public List<StockInfoDTO> getStockinfo() {
		return mapper.getStockinfo();
	}

	public String getStockInfoXml(String strCode) {
		log.info("CalculatorService - getStockInfoXml()");
		
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

	public void delete(CalculatorDTO calculatorDTO) {
		mapper.delete(calculatorDTO);	
	}
	
	public List<String> getAutocompleteList(String value) {
		log.info("StockService - getAutocompleteList()");
		
		return mapper.selectAutocompleteList(value);
	}

}
