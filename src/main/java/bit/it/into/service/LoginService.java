package bit.it.into.service;

import java.util.HashMap;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;

import bit.it.into.dto.MemberDTO;
import bit.it.into.mapper.LoginMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class LoginService {
	
	@Inject
	private LoginMapper mapper;
	
	@Inject
	private BCryptPasswordEncoder passEncoder;
	
	
	@Transactional
	public void addUser(MemberDTO memberDTO) {
		log.info("LoginService - addUser()");
		
		String password = memberDTO.getPw();
		String encode = passEncoder.encode(password);
		
		memberDTO.setPw(encode);
		
		int countInsertUser = mapper.insertUser(memberDTO);
		int countInsertAuthorities = mapper.insertAuthorities(memberDTO);
		int countInsertRank = mapper.insertRank(memberDTO);
		
		if(countInsertUser != 1) {
			log.info("유저 INSERT 오류");
		}
		
		if(countInsertAuthorities != 1) {
			log.info("유저 권한 INSERT 오류");
		}
		
		if(countInsertRank != 1) {
			log.info("유저 랭크 INSERT 오류");
		}
	}

	
	public MemberDTO kakaoIdCheck(String id, String sns_type) {
		log.info("LoginService - kakaoIdCheck()");
		
		return mapper.selectUserByKakaoId(id, sns_type);
		
	}
	
	public MemberDTO naverIdCheck(String id, String sns_type) {
		log.info("LoginService - naverIdCheck()");
		
		return mapper.selectUserByNaverId(id, sns_type);
		
	}

	@Transactional
	public void addKakaoUser(MemberDTO memberDTO) {
		log.info("LoginService - addKakaoUser()");
		
		String password = memberDTO.getPw();
		String encode = passEncoder.encode(password);
		
		memberDTO.setPw(encode);
		
		
		int countInsertKakaoUser = mapper.insertKakaoUser(memberDTO);
		int countInsertAuthorities = mapper.insertAuthorities(memberDTO);
		int countInsertRank = mapper.insertRank(memberDTO);
		
		if(countInsertKakaoUser != 1) {
			log.info("카카오 유저 INSERT 오류");
		}
		
		if(countInsertAuthorities != 1) {
			log.info("유저 권한 INSERT 오류");
		}
		
		if(countInsertRank != 1) {
			log.info("유저 랭크 INSERT 오류");
		}
	}
	
	@Transactional
	public void addNaverUser(MemberDTO memberDTO) {
		log.info("LoginService - addNaverUser()");
		
		String password = memberDTO.getPw();
		String encode = passEncoder.encode(password);
		
		memberDTO.setPw(encode);
		
		
		int countInsertNaverUser = mapper.insertNaverUser(memberDTO);
		int countInsertAuthorities = mapper.insertAuthorities(memberDTO);
		int countInsertRank = mapper.insertRank(memberDTO);
		
		if(countInsertNaverUser != 1) {
			log.info("네이버 유저 INSERT 오류");
		}
		
		if(countInsertAuthorities != 1) {
			log.info("유저 권한 INSERT 오류");
		}

		if(countInsertRank != 1) {
			log.info("유저 랭크 INSERT 오류");
		}
	}


	public Map<String, String> validateHandling(Errors errors) {
		log.info("LoginService - validateHandling()");
		
		Map<String, String> validatorResult = new HashMap<>();

        for (FieldError error : errors.getFieldErrors()) {
            String validKeyName = String.format("valid_%s", error.getField());
            validatorResult.put(validKeyName, error.getDefaultMessage());
        }

        return validatorResult;
	}


	public boolean hasUserById(String id) {
		log.info("LoginService - hasUserById()");
		
		Integer count = mapper.selectUserById(id);
		
		if(count==0) {
			return false;
		}
		
		return true;
	}


	public boolean hasUserByNickname(String nickname) {
		log.info("LoginService - hasUserByNickname()");
				
		Integer count = mapper.selectUserByNickname(nickname);
		
		if(count==0) {
			return false;
		}
		
		return true;
	}


	public boolean hasUserByEmail(String email) {
		log.info("LoginService - hasUserByEmail()");
		
		Integer count = mapper.selectUserByEmail(email);
		
		if(count==0) {
			return false;
		}
		
		return true;
	}

	public void updateAuthKey(String email) {
		log.info("LoginService -updateAuthKey()");
		
		mapper.updateAuthKey(email);
	}

	public void updatePw(String id) {
		log.info("LoginService -updatePw()");
		
		mapper.updatePw(id);
	}
	
	
}
