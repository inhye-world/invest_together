package bit.it.into.controller;

import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import bit.it.into.dto.CalculatorDTO;
import bit.it.into.security.CustomUser;
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
	 
	 @RequestMapping("/myCalculator")
	 public String myTargetPrice() {
		 return "calculator/myTargetPrice";
	 }
		 
	 
 	@PostMapping("/writeCalculator")
	public String write(@Valid CalculatorDTO calculatorDTO, BindingResult result, Authentication authentication) throws Exception {
		log.info("////////////////////writeCalculator///////////////////////");

		if( result.hasErrors() ) { 
			 List<ObjectError> list = result.getAllErrors(); 
			 
			 for( ObjectError error : list ) {
				 System.out.println(error); } 
			 
			 return "redirect:calculator"; }
		
		 if(authentication == null) {
			return "login/login_require";
	 	 }
		 
		 CustomUser user = (CustomUser)authentication.getPrincipal();
		 int user_num = user.getDto().getMember_num();
		 calculatorDTO.setMember_num(user_num);

		 int count = calculatorService.checkSymbols(calculatorDTO);
		 
		 if(count == 0) {
			 calculatorService.writeCalculator(calculatorDTO);
		 } else if (count > 0) {
			 calculatorService.updateCalculator(calculatorDTO);
		 }
		 
		 return "redirect:calculator";
	}
	
}
