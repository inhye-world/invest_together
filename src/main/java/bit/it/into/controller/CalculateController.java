package bit.it.into.controller;


import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.dto.CalculatorDTO;
import bit.it.into.service.CalculatorService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class CalculateController {
	
	@Inject
	CalculatorService calculatorService;
	
	 @RequestMapping("/calculator")
	 public String targetPrice() {
		 return "calculator/targetPrice";
	 }
	 
	 @PostMapping("/writeCalculator")
		public String write(@Valid CalculatorDTO calculatorDTO, BindingResult result) throws Exception {
			log.info("////////////////////writeCalculator///////////////////////");
			
			if( result.hasErrors() ) {
				List<ObjectError> list = result.getAllErrors();
				for( ObjectError error : list ) {
					System.out.println(error);
				}
				return "redirect:calculator";
			}

			calculatorService.writeCalculator(calculatorDTO);
			
			return "redirect:calculator";
		}
	
}
