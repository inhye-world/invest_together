package bit.it.into.mapper;

import bit.it.into.dto.CalculatorDTO;

public interface CalculatorMapper {

	public void insert(CalculatorDTO calculatorDTO);

	public void update(CalculatorDTO calculatorDTO);

	public int checkSymbols(CalculatorDTO calculatorDTO);

}
