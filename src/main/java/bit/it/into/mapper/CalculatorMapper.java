package bit.it.into.mapper;

import java.util.ArrayList;
import java.util.List;

import bit.it.into.dto.CalculatorDTO;
import bit.it.into.dto.StockInfoDTO;

public interface CalculatorMapper {

	public void insert(CalculatorDTO calculatorDTO);

	public void update(CalculatorDTO calculatorDTO);

	public int checkSymbols(CalculatorDTO calculatorDTO);

	public List<CalculatorDTO> getSymbolsList(int i);
	
	public CalculatorDTO getList(CalculatorDTO calculatorDTO);

	public List<StockInfoDTO> getStockinfo();
	

}
