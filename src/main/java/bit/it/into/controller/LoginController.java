package bit.it.into.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.dto.MemberDTO;
import bit.it.into.dto.ValidMemberDTO;
import bit.it.into.service.KakaoService;
import bit.it.into.service.LoginService;
import bit.it.into.service.NaverService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class LoginController {
	
	private LoginService service;
	private KakaoService kakao;
	private NaverService naver;
	
	@RequestMapping("/loginForm")
	public String loginForm(HttpSession session, Model model) {
		log.info("LoginController - loginForm()");
		
		String kakaoUrl = kakao.getUrl(session);
		String naverUrl = naver.getUrl(session);
		
		model.addAttribute("kakao_url", kakaoUrl);
		model.addAttribute("naver_url", naverUrl);
		
		return "login/loginForm";
	}
	
	@RequestMapping("/registrationForm")
	public String registrationForm() {
		log.info("LoginController - registrationForm()");
		
		return "login/registrationForm";
	}
	
	@PostMapping("/registration")
	public String registration(@ModelAttribute("dto") @Valid ValidMemberDTO validMemberDTO, Errors errors, Model model) {
		log.info("LoginController - registration()");
		
		if (errors.hasErrors()) {
            
			Map<String, String> validatorResult = service.validateHandling(errors);
            for (String key : validatorResult.keySet()) {
                model.addAttribute(key, validatorResult.get(key));
            }

            return "login/registrationForm";
        }
		
		
		if(service.hasUserById(validMemberDTO.getId())) {
			model.addAttribute("valid_id", "아이디가 중복 되었습니다.");
			
			return "login/registrationForm";
		}
		
		if(service.hasUserByNickname(validMemberDTO.getNickname())) {
			model.addAttribute("valid_nickname", "닉네임이 중복 되었습니다.");
			
			return "login/registrationForm";
		}
		
		if(service.hasUserByEmail(validMemberDTO.getEmail())) {
			model.addAttribute("valid_email", "이메일이 중복 되었습니다.");
			
			return "login/registrationForm";
		}
		
		
		MemberDTO memberDTO = new MemberDTO(validMemberDTO);
		service.addUser(memberDTO);
		
		return "login/resistration_clear";
	}
	
}
