package bit.it.into.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.MemberDTO;
import bit.it.into.mapper.UserMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class UserService {
	
	@Inject
	private UserMapper mapper;
	
	@Inject
	private BCryptPasswordEncoder passEncoder;
	
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
	
	public String idCheck(String id) {
		log.info("UserService - idCheck()");
		
		return mapper.selectPwdEmail(id);
		
	}
	
	@Transactional
	public void resetPwd(Map<String, String> userInfo) {
		
		String encode = passEncoder.encode(userInfo.get("pw"));
		
		userInfo.put("pw", encode);
		
		mapper.updatePwd(userInfo);
		
	}

	public String nameCheck(String name) {
		log.info("UserService - nameCheck()");
			
		return mapper.selectIdEmail(name);
	}

	public List<MemberDTO> idInfo(MemberDTO memberDTO) {
		log.info("UserService - idInfo()");
		
		String email = memberDTO.getEmail();
		
		return mapper.selectIdInfo(email);
				
	}
	
}
