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
	
	@RequestMapping("/index")
	public String testmain() {
		return "main/index";
	}
	
	@RequestMapping("/blog_details")
	public String blog_details() {
		return "main/blog_details";
	}
	
	@RequestMapping("/blog")
	public String blog() {
		return "main/blog";
	}
	
	@RequestMapping("/contact")
	public String contact() {
		return "main/contact";
	}
	
	@RequestMapping("/elements")
	public String elements() {
		return "main/elements";
	}

	@RequestMapping("/program")
	public String program() {
		return "main/program";

	}
}
