package bit.it.into.controller;

import java.util.List;

import javax.inject.Inject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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
	final static Logger logger = LoggerFactory.getLogger(BondController.class);
	
	
	@Inject
	BondService bondService;
	
	@GetMapping("/bond")
	public String list(Model model) throws Exception {	
		logger.info("////////////////////list/////////////////////");
		model.addAttribute("list", bondService.getList());
		return "bond/list";
	}

	@PostMapping("/bond/write")
	public String write(BondDto bondDto) throws Exception {
		logger.info("////////////////////write///////////////////////");
		
		bondService.writeBond(bondDto);
		
		return "redirect:bond";
	}

	@ResponseBody
	@PostMapping("/bond/delete")
	public int delete(@RequestParam(value = "checkRow[]") List<String> checkArr){
		logger.info("////////////////////delete///////////////////////");

		int result = 1;
		
		 for(String i : checkArr) {
			  System.out.println(i);
			   bondService.remove(i);
		 }   
		 
		 return result;  
	}
	
	@PostMapping("/bond/modify")
    private String modify(BondDto bondDto) throws Exception{
		logger.info("////////////////////modify///////////////////////");
		
		bondService.update(bondDto);
        
		return "redirect:bond";
    }

	
	
}
