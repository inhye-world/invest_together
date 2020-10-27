package bit.it.into.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.it.into.dto.MemberDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.LoginService;
import bit.it.into.service.MailSendService;
import bit.it.into.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class UserModifyController {
	
	@Inject
	private BCryptPasswordEncoder passEncoder;
	
	@Inject
	private MailSendService mailSendService;
	
	private UserService userService;
	private LoginService loginService;
	
	@RequestMapping("/modify")
	public String modify(Authentication authentication) {
		log.info("UserModifyController - modify()");
				
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String snsType = user.getDto().getSns_type();
		
		if(snsType.equals("normal")) {
			
			return "user/userModify";	
			
		} else {
			
			return "user/snsUserModify";
		}
	}
		
	
	@RequestMapping("/userModify")
	public String userModify(MemberDTO memberDTO, Authentication authentication, Model model) throws IOException {
		log.info("UserModifyController - userModify()");
		
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
	
	@RequestMapping("/checkNickname")
	public void checkNickname(MemberDTO memberDTO, Model model, HttpServletResponse response) throws Exception {
		log.info("UserModifyController - checkNickname()");
	
		PrintWriter out = response.getWriter();
		
		if(loginService.hasUserByNickname(memberDTO.getNickname())) {			
			out.print(false);
			
		} else
			out.print(true);
	}
	
	@RequestMapping("/alterNickname")
	public String alterNickname(Authentication authentication, MemberDTO memberDTO, Model model) {
		log.info("UserModifyController - alterNickname()");
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String snsType = user.getDto().getSns_type();
		
		if(snsType.equals("normal")) {
			
			user.getDto().setNickname(memberDTO.getNickname());
			
			userService.alterNickname(user.getDto());	
			
		} else {
			
			user.getDto().setNickname(memberDTO.getNickname());
			
			userService.alterNickname(user.getDto());
			
			return "user/snsUserModify";
		}
		
		return "user/userModifyInfo";
	}
	
	@RequestMapping("/checkPhone")
	public void checkPhone(MemberDTO memberDTO, HttpServletResponse response) throws Exception {
		log.info("UserModifyController - checkPhone()");
	
		PrintWriter out = response.getWriter();
		
		if(loginService.hasUserByPhone(memberDTO.getPhone())) {			
			out.print(false);
			
		} else
			out.print(true);
	}
	
	@RequestMapping("/alterPhone")
	public String alterPhone(MemberDTO memberDTO, Authentication authentication, Model model) {
		log.info("UserModifyController - alterPhone()");
					
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String snsType = user.getDto().getSns_type();
		
		if(snsType.equals("normal")) {
			
			user.getDto().setPhone(memberDTO.getPhone());
			
			userService.alterPhone(user.getDto());
			
		} else {
			
			user.getDto().setPhone(memberDTO.getPhone());
			
			userService.alterPhone(user.getDto());
			
			return "user/snsUserModify";
		}

		return "user/userModifyInfo";
	}
	
	@RequestMapping("/checkId")
	public void checkId(MemberDTO memberDTO, HttpServletResponse response) throws Exception {
		log.info("UserModifyController - checkId()");
	
		PrintWriter out = response.getWriter();
		
		if(loginService.hasUserById(memberDTO.getId())) {			
			out.print(false);
			
		} else
			out.print(true);
	}
	
	
	@RequestMapping("/alterId")
	public String alterId(MemberDTO memberDTO, Authentication authentication) {
		log.info("UserModifyController - alterId()");
					
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		user.getDto().setId(memberDTO.getId());
		
		userService.alterId(user.getDto());
		
		return "user/userModifyInfo";
	}
	
	@ResponseBody
	@RequestMapping("rest/emailChange")
	public String emailChange(HttpServletRequest request) throws Exception {
		log.info("UserModifyController - emailChange()");
		
		JSONObject object = new JSONObject();
		
        if(loginService.hasUserByEmail(request.getParameter("email"))) {    
            object.put("hasEmail", false);
            
        } else {
            mailSendService.emailChangeMail(request.getParameter("email"));        
            object.put("hasEmail", true);
        }
		
		return object.toString();
	}
	
	@RequestMapping("/checkEmail")
	public void checkEmail(MemberDTO memberDTO, HttpServletResponse response) throws Exception {
		log.info("UserModifyController - checkEmail()");
	
		PrintWriter out = response.getWriter();
		
		if(loginService.hasUserByEmail(memberDTO.getEmail())) {			
			out.print(false);
			
		} else
			out.print(true);
	}
	
	@RequestMapping("/alterEmail")
	public String alterEmail(MemberDTO memberDTO, Authentication authentication) throws Exception {
		log.info("UserModifyController - emailChange()");
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		user.getDto().setEmail(memberDTO.getEmail());
		
		userService.changeEmail(user.getDto().getEmail());
			
		return "user/alterEmail";
	}

	@RequestMapping("/alterPw")
	public String alterPw(MemberDTO memberDTO, Authentication authentication) {
		log.info("UserModifyController - alterPw()");
					
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		user.getDto().setPw(memberDTO.getPw());
		
		userService.alterPw(user.getDto());
		
		return "user/userModifyInfo";
	}
	
	@RequestMapping("/secession")
	public String secession(Authentication authentication, HttpSession session) {
		log.info("UserModifyController - secession()");
		
		if(authentication==null) {
			return "login/login_require";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		session.invalidate();
		
		userService.secession(user.getDto().getMember_num());
				
		return "redirect:/";
	}
}
