package bit.it.into.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.RankDTO;
import bit.it.into.dto.RankingDTO;
import bit.it.into.mapper.RankMapper;
import bit.it.into.page.RankCriteria;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class RankService {
	
	@Inject
	private RankMapper mapper;
	
	
	public void rankEnabled(RankDTO rankDTO) {
		log.info("RankService - rankEnabled()");
		
		int count = mapper.updateRankEnabled(rankDTO);
		
		if(count != 1) {
			log.info("유저 랭크 UPDATE ENABLED 오류");
		}
	}
	
	public void rankDisabled(Integer member_num) {
		log.info("RankService - rankDisable()");
		
		int count = mapper.updateRankDisabled(member_num);
		
		if(count != 1) {
			log.info("유저 랭크 UPDATE DISABLED 오류");
		}
	}
	
	public List<RankingDTO> getWhaleReagueList() {
		log.info("RankService - getWhaleReagueList()");
		
		return mapper.selectWhaleReagueList();
	}
	
	public List<RankingDTO> getMackerelReagueList() {
		log.info("RankService - getMackerelReagueList()");
		
		return mapper.selectMackerelReagueList();
	}
	
	public List<RankingDTO> getShrimpReagueList() {
		log.info("RankService - getShrimpReagueList()");
		
		return mapper.selectShrimpReagueList();
	}

	public int getLeagueTotal(RankCriteria cri) {
		log.info("RankService - getShrimpReagueList()");
		
		if(cri.getLeague().equals("shrimp")) {
			return mapper.getShrimpLeagueTotalCount();
		}
		if(cri.getLeague().equals("mackerel")) {
			return mapper.getMackerelLeagueTotalCount();
		}
		
		return mapper.getWhaleLeagueTotalCount();	
	}

	public List<RankingDTO> getLeagueList(RankCriteria cri) {
		log.info("RankService - getShrimpReagueList()");

		if(cri.getLeague().equals("shrimp")) {
			return mapper.getShrimpLeaguePageList(cri);
		}
		if(cri.getLeague().equals("mackerel")) {
			return mapper.getMackerelLeaguePageList(cri);
		}
		
		return mapper.getWhaleLeaguePageList(cri);	
	}
	
}
