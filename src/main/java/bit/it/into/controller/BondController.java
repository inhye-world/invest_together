package bit.it.into.controller;

import java.util.List;

import javax.inject.Inject;
import javax.validation.Valid;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.it.into.dto.BondDTO;
import bit.it.into.security.CustomUser;
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
	public String list(Model model, Authentication authentication) throws Exception {	
		log.info("////////////////////list/////////////////////");
		
		if(authentication == null) {
			return "login/login_require";
		}
		
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		
		model.addAttribute("list", bondService.getList(user_num));
		
		return "bond/list";
	}

	@PostMapping("/writeBond")
	public String write(@Valid BondDTO bondDTO, BindingResult result, Authentication authentication) throws Exception {
		log.info("////////////////////write///////////////////////");
		
		if(authentication == null) {
			return "login/login_require";
		}
		
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		int user_num = user.getDto().getMember_num();
		
		if( result.hasErrors() ) {
			List<ObjectError> list = result.getAllErrors();
			for( ObjectError error : list ) {
				System.out.println(error);
			}
			return "redirect:bond";
		}
		
		bondDTO.setMember_num(user_num);
		bondService.writeBond(bondDTO);
		
		return "redirect:bond";
	}

	@ResponseBody
	@PostMapping("/deleteBond")
	public int delete(@RequestParam(value = "checkRow[]") List<String> checkArr, Authentication authentication){
		log.info("////////////////////delete///////////////////////");
		
		int result = 1;
		
		 for(String i : checkArr) {
			  System.out.println(i);
			  bondService.remove(i);
		 }   
		 
		 return result;  
	}
	

	@PostMapping("/modifyBond")
    private String modify(@Valid BondDTO bondDTO, BindingResult result, Authentication authentication) throws Exception{
		log.info("////////////////////modify///////////////////////");
		
		if( result.hasErrors() ) {
			List<ObjectError> list = result.getAllErrors();
			for( ObjectError error : list ) {
				System.out.println(error);
			}
			return "redirect:bond";
		}
		
		bondService.update(bondDTO);
        
		return "redirect:bond";
    }

}
