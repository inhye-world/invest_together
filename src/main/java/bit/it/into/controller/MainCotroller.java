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
		return "main/index";
	}
	
	@RequestMapping("/accessDenied")
	public String accessDenied() {
		log.info("MainController - accessDenied()");
		
		return "error/accessDenied";
	}
	
	@RequestMapping("/testmain")
	public String testmain() {
		return "include/testmain";
	}
	
	@RequestMapping("/element")
	public String element() {
		return "main/elements";
	}
}
