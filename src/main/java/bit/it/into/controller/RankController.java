package bit.it.into.controller;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import bit.it.into.dto.RankDetailsDTO;
import bit.it.into.dto.RankingDTO;
import bit.it.into.page.RankCriteria;
import bit.it.into.page.RankPageDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.RankService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import net.sf.json.JSONArray;

@Controller
@AllArgsConstructor
@Log4j
public class RankController {
	
	private RankService service;
	
	@RequestMapping("/leaderboards")
	public String ranking(RankCriteria cri, Model model) {
		log.info("RankController - ranking()");
		
		int total = service.getLeagueTotal(cri);

		model.addAttribute("list", service.getLeagueList(cri));
		model.addAttribute("pageMaker", new RankPageDTO(cri, total));
		
		
		return "rank/leaderboards";
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
	
	@ResponseBody
	@RequestMapping(value="/rest/getRankDetails", produces="application/text; charset=utf8")
	public String getRankDetails(HttpServletRequest request, Authentication authentication) {
		log.info("RankController - getRankDetails()");
		
		String nickname = request.getParameter("nickname");
		
		
		RankingDTO rankingDTO = null;
		
		List<RankingDTO> whaleReagueList = service.getWhaleReagueList();
		for(RankingDTO dto : whaleReagueList) {
			if(nickname.equals(dto.getNickname())) {
				String percentile = String.format( "%.2f", (dto.getPlace()*1.0)/whaleReagueList.size()*100 );
				dto.setPercentile(percentile);
				dto.setLeague("whale");
				
				rankingDTO = dto;
			}
		}
		
		if(rankingDTO==null) {
			List<RankingDTO> mackerelReagueList = service.getMackerelReagueList();
			for(RankingDTO dto : mackerelReagueList) {
				if(nickname.equals(dto.getNickname())) {
					String percentile = String.format( "%.2f", (dto.getPlace()*1.0)/mackerelReagueList.size()*100 );
					dto.setPercentile(percentile);
					dto.setLeague("mackerel");
					
					rankingDTO = dto;
				}
			}
		}
		
		if(rankingDTO==null) {
			List<RankingDTO> shrimpReagueList = service.getShrimpReagueList();
			for(RankingDTO dto : shrimpReagueList) {
				if(nickname.equals(dto.getNickname())) {
					String percentile = String.format( "%.2f", (dto.getPlace()*1.0)/shrimpReagueList.size()*100 );
					dto.setPercentile(percentile);
					dto.setLeague("shrimp");
					
					rankingDTO = dto;
				}
			}
		}
		
		if(rankingDTO==null) {
			rankingDTO = new RankingDTO();
			rankingDTO.setLeague("empty");
			
			JSONObject result = new JSONObject();
			JSONObject ranking = new JSONObject(rankingDTO);
			result.put("ranking", ranking);
			
			return result.toString();
		}
		
		int member_num = rankingDTO.getMember_num();
		List<RankDetailsDTO> rankDetailsList = service.getRankDetails(member_num);
		
		
		JSONObject result = new JSONObject();
		
		JSONObject ranking = new JSONObject(rankingDTO);
		
		double[] ratioArr = new double[rankDetailsList.size()];
		int count = 0;
		
		JSONArray rankDetailsArr = new JSONArray();
		for(RankDetailsDTO dto : rankDetailsList) {
			LocalDate localDate = dto.getRank_date().toLocalDateTime().toLocalDate();
			int month = localDate.getMonthValue();
			int day = localDate.getDayOfMonth();
			
			JSONObject object = new JSONObject();
			object.put("date", month+"월 "+day+"일");
			object.put("net_profit_ratio", dto.getNet_profit_ratio());
			object.put("net_profit", dto.getNet_profit());
			
			rankDetailsArr.add(object.toMap());
			
			ratioArr[count] = dto.getNet_profit_ratio();
			count++;
		}
		
		result.put("ranking", ranking);
		result.put("labels", rankDetailsArr);
		result.put("data", ratioArr);
		
		
		JSONObject valid = new JSONObject();
		
		if(authentication==null) {
			valid.put("isLogin", false);
			result.put("valid", valid);
			
			return result.toString();
		}
		valid.put("isLogin", true);
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		if(rankingDTO.getMember_num() == user.getDto().getMember_num()) {
			valid.put("isMe", true);
		}else {
			valid.put("isMe", false);
		}
		
		////// boolean isSubscribe *************
		
		Integer setPrice = service.getSetPrice(rankingDTO.getMember_num());
		if(setPrice == null) {
			valid.put("hasSetPrice", false);
		}else {
			valid.put("hasSetPrice", true);
			valid.put("setPrice", setPrice);
		}
		
		result.put("valid", valid);
		
		
		return result.toString();
		
	}
}
