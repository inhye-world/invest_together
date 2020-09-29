package bit.it.into.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.service.RankService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class RankController {
	
	private RankService service;
	
	@RequestMapping("/ranking")
	public String ranking() {
		log.info("RankController - ranking()");
		
		
		return "rank/table";
	}
}
