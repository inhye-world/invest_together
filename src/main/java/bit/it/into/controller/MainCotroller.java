package bit.it.into.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.service.LoginService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class MainCotroller {
	
	private LoginService service;
	
	@RequestMapping("/")
	public String home(Model model) {
		log.info("MainController - home()");
		
		Integer total_mamber = service.totalMember();
		Integer total_account = service.totalAccount();
		Integer total_stock = service.totalStock();
		Integer total_subsribe = service.totalSubsribe();
		
		model.addAttribute("total_member", total_mamber);
		model.addAttribute("total_account", total_account);
		model.addAttribute("total_stock", total_stock);
		model.addAttribute("total_subsribe", total_subsribe);
		
		return "main/index";
	}
	
	@RequestMapping("/accessDenied")
	public String accessDenied() {
		log.info("MainController - accessDenied()");
		
		return "error/accessDenied";
	}
	
	@RequestMapping("/index")
	public String testmain() {
		return "main/index";
	}
	
}
