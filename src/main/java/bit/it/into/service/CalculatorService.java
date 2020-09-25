package bit.it.into.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.CalculatorDTO;
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
		mapper.writeCalculator(calculatorDTO);
	}

}
