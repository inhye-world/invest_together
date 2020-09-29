package bit.it.into.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.RankDTO;
import bit.it.into.mapper.RankMapper;
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
	
	
	
}
