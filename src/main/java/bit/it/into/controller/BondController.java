package bit.it.into.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.it.into.dto.BondDto;
import bit.it.into.service.BondService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class BondController {


	@Inject
	BondService bondService;
	
	@GetMapping("/bond")
	public String list(Model model) throws Exception {	
		log.info("////////////////////list/////////////////////");
		model.addAttribute("list", bondService.getList());
		return "bond/list";
	}

	@PostMapping("/writeBond")
	public String write(@Valid BondDto bondDto, BindingResult result) throws Exception {
		log.info("////////////////////write///////////////////////");
		
		if( result.hasErrors() ) {
			List<ObjectError> list = result.getAllErrors();
			for( ObjectError error : list ) {
				System.out.println(error);
			}
			return "redirect:bond";
		}

		bondService.writeBond(bondDto);
		
		return "redirect:bond";
	}

	@ResponseBody
	@PostMapping("/deleteBond")
	public int delete(@RequestParam(value = "checkRow[]") List<String> checkArr){
		log.info("////////////////////delete///////////////////////");

		int result = 1;
		
		 for(String i : checkArr) {
			  System.out.println(i);
			   bondService.remove(i);
		 }   
		 
		 return result;  
	}
	

	@PostMapping("/modifyBond")
    private String modify(@Valid BondDto bondDto, BindingResult result) throws Exception{
		log.info("////////////////////modify///////////////////////");
		
		if( result.hasErrors() ) {
			List<ObjectError> list = result.getAllErrors();
			for( ObjectError error : list ) {
				System.out.println(error);
			}
			return "redirect:bond";
		}
		
		bondService.update(bondDto);
        
		return "redirect:bond";
    }


	
	
}
