package bit.it.into.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class BoardCotroller {
	
	@RequestMapping("boardList")
	public String boardList() {
		log.info("BoardCotroller - boardList()");
	
		return "board/list";
	}
}
