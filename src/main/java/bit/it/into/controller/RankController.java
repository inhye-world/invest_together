package bit.it.into.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import bit.it.into.dto.RankingDTO;
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
		
		service.getMackerelReagueList();
		service.getWhaleReagueList();
		service.getShrimpReagueList();
		
		return "rank/table";
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/findRanking", produces="application/text; charset=utf8")
	public String findRanking(HttpServletRequest request) throws JsonProcessingException {
		log.info("RankController - findRanking()");
		
		String nickname = request.getParameter("nickname");
		
		List<RankingDTO> whaleReagueList = service.getWhaleReagueList();
		for(RankingDTO dto : whaleReagueList) {
			if(nickname.equals(dto.getNickname())) {
				String percentile = String.format( "%.2f", (dto.getPlace()*1.0)/whaleReagueList.size()*100 );
				dto.setPercentile(percentile);
				dto.setLeague("whale");
				
				ObjectMapper objectMapper = new ObjectMapper();
				return objectMapper.writeValueAsString(dto);
			}
		}
		
		List<RankingDTO> mackerelReagueList = service.getMackerelReagueList();
		for(RankingDTO dto : mackerelReagueList) {
			if(nickname.equals(dto.getNickname())) {
				String percentile = String.format( "%.2f", (dto.getPlace()*1.0)/mackerelReagueList.size()*100 );
				dto.setPercentile(percentile);
				dto.setLeague("mackerel");
				
				ObjectMapper objectMapper = new ObjectMapper();
				return objectMapper.writeValueAsString(dto);
			}
		}
		
		List<RankingDTO> shrimpReagueList = service.getShrimpReagueList();
		for(RankingDTO dto : shrimpReagueList) {
			if(nickname.equals(dto.getNickname())) {
				String percentile = String.format( "%.2f", (dto.getPlace()*1.0)/shrimpReagueList.size()*100 );
				dto.setPercentile(percentile);
				dto.setLeague("shrimp");
				
				ObjectMapper objectMapper = new ObjectMapper();
				return objectMapper.writeValueAsString(dto);
			}
		}
		
		RankingDTO dto = new RankingDTO();
		dto.setLeague("empty");
		
		ObjectMapper objectMapper = new ObjectMapper();
		return objectMapper.writeValueAsString(dto);
	}
}
