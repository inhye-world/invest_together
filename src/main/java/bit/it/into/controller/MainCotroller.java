package bit.it.into.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class MainCotroller {
	
	@RequestMapping("/")
	public String home() {
		log.info("MainController - home()");
		return "index";
	}
	
	@RequestMapping("/accessDenied")
	public String accessDenied() {
		log.info("MainController - accessDenied()");
		
		return "error/accessDenied";
	}
	
	@RequestMapping("/header")
	public String header() {
		return "include/header";
	}
	
	@RequestMapping("/footer")
	public String footer() {
		return "include/footer";
	}
	
	@RequestMapping("/testmain")
	public String testmain() {
		return "include/testmain";
	}

}
