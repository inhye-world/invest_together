package bit.it.into.controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class RankController {
	
	 @RequestMapping("/test")
	 public String test() {
		 return "ranking/test";
	 }

	
}
