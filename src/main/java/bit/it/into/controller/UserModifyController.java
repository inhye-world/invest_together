package bit.it.into.controller;

import java.io.IOException;
import javax.inject.Inject;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.dto.MemberDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class UserModifyController {
	
	@Inject
	private BCryptPasswordEncoder passEncoder;
	
	private UserService service;

	@RequestMapping("/modify")
	public String modify(Model model) {
		log.info("UserController - modify()");
				
		return "user/userModify";
	}
	
	@RequestMapping("/userModify")
	public String userModify(MemberDTO memberDTO, Authentication authentication, Model model) throws IOException {
		log.info("UserController - userModify()");
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String encodedPw = user.getDto().getPw();
		String rawPw = memberDTO.getPw();
				    
		if(passEncoder.matches(rawPw, encodedPw)) {
			return "user/userModifyInfo";
			
		} else {
			model.addAttribute("pw_error", "비밀번호를 다시 입력해주세요.");
					
			return "user/userModify";
		}
	}
	
	@RequestMapping("/alterNickname")
	public String alterNickname(MemberDTO memberDTO, Authentication authentication) {
		log.info("UserController - alterNickname()");
				
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		user.getDto().setNickname(memberDTO.getNickname());
		
		service.alterNickname(user.getDto());
		
		return "user/userModifyInfo";
	}
	
	@RequestMapping("/alterPhone")
	public String alterPhone(MemberDTO memberDTO, Authentication authentication) {
		log.info("UserController - alterPhone()");
				
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		user.getDto().setPhone(memberDTO.getPhone());
		
		service.alterPhone(user.getDto());
		
		return "user/userModifyInfo";
	}
	
	@RequestMapping("/alterId")
	public String alterId(MemberDTO memberDTO, Authentication authentication) {
		log.info("UserController - alterId()");
				
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		user.getDto().setId(memberDTO.getId());
		
		service.alterId(user.getDto());
		
		return "user/userModifyInfo";
	}
}
