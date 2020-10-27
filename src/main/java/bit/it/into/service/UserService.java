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
import bit.it.into.page.PurchaseCriteria;
import bit.it.into.security.CustomUser;
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
	
	public List<Integer> readAllMemberNum() {
		log.info("UserService -  readAllUserNum()");
		
		return mapper.selectAllMemberNum();
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

	public Integer nameCheck(Map<String, String> info) {
		log.info("UserService - nameCheck()");
			
		return mapper.selectIdEmail(info);
	}

	public List<MemberDTO> idInfo(MemberDTO memberDTO) {
		log.info("UserService - idInfo()");
		
		String email = memberDTO.getEmail();
		
		return mapper.selectIdInfo(email);
				
	}

	public void alterNickname(MemberDTO dto) {
		log.info("UserService - alterNickname()");
		
		mapper.updateNickname(dto);
	}

	public void alterPhone(MemberDTO dto) {
		log.info("UserService - alterPhone()");
		
		mapper.updatePhone(dto);
	}

	public void alterId(MemberDTO dto) {
		log.info("UserService - alterId()");
		
		mapper.updateId(dto);
		
	}
	
	public void changeEmail(MemberDTO dto) {
		log.info("UserService - changeEmail()");
		
		mapper.updateEmail(dto);
	}
	
	public void alterPw(MemberDTO dto) {
		log.info("UserService - alterPw()");
	
		String encode = passEncoder.encode(dto.getPw());
		
		dto.setPw(encode);
		
		mapper.updatePw(dto);
	}
	
	@Transactional
	public void secession(int member_num) {
		log.info("UserService - secession()");
		
		mapper.deleteAuthorities(member_num);
		mapper.deleteStock(member_num);
		mapper.deleteCalculator(member_num);
		mapper.deleteBond(member_num);
		mapper.deleteRank(member_num);
		mapper.deleteSalaryAccount(member_num);
		mapper.deleteAccount(member_num);
		mapper.deleteSubsribe(member_num);
		mapper.deleteMember(member_num);
	}

}
