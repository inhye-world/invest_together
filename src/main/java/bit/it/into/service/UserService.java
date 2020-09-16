package bit.it.into.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bit.it.into.dto.AccountDTO;
import bit.it.into.mapper.UserMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserService {
	
	@Inject
	private UserMapper mapper;
	
	@Transactional
	public void addUserAccountInfo(AccountDTO accountDTO, int member_num, String access_token, String refresh_token, String user_seq_no) {
		log.info("UserService - addUserAccountInfo()");
		
		int updateUserTokenCount = mapper.updateUserToken(member_num, access_token, refresh_token, user_seq_no);
		if(updateUserTokenCount != 1) {
			log.info("updateUserTokenCount 오류");
		}
		
		int insertAccountCount = mapper.insertAccount(accountDTO);
		if(insertAccountCount != 1) {
			log.info("insertAccountCount 오류");
		}
	
	}
	
}
