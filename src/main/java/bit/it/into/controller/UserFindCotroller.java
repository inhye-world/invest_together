package bit.it.into.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import bit.it.into.dto.MemberDTO;
import bit.it.into.service.LoginService;
import bit.it.into.service.MailSendService;
import bit.it.into.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@AllArgsConstructor
public class UserFindCotroller {
	
	private LoginService loginService;
	private UserService userService;
	
	@Autowired
	private MailSendService mailSendService;
	
	//id찾기
	@RequestMapping("/idFind")
	public String idFind() {
		log.info("UserFindCotroller - idFind()");
		
		return "find/idFind";
	}
	
	//pw찾기
	@RequestMapping("/pwFind")
	public String pwFind() {
		log.info("UserFindCotroller - pwFind()");
		
		return "find/pwFind";
	}
	
	@ResponseBody
	@RequestMapping("rest/idEmailSend")
	public String idEmailSend(HttpServletRequest request) throws Exception {
		log.info("UserFindCotroller - idEmailSend()");
		
		Map<String, String> info = new HashMap<String, String>();
		
		info.put("name", request.getParameter("name"));
		info.put("email", request.getParameter("email"));
		
		Integer email = userService.nameCheck(info);
		
		JSONObject object = new JSONObject();
		
		if(email == 1) {
			
			String authKey = mailSendService.idsendFindMail(request.getParameter("email"));
			object.put("authKey", authKey);
			
			object.put("hasEmail", true);
			return object.toString();
		} 
		
		object.put("hasEmail", false);
		return object.toString();
	}
	
	@RequestMapping("/verifyId")
	public String verifyId(MemberDTO memberDTO, Model model) {
		log.info("UserFindCotroller - verifyId()");
		
		List<MemberDTO> id =  userService.idInfo(memberDTO);
		
		model.addAttribute("id", id);
		
		return "find/idInfo";
	}
	
	@ResponseBody
	@RequestMapping("rest/pwdEmailSend")
	public String pwdEmailSend(HttpServletRequest request) throws Exception {
		log.info("UserFindCotroller - pwdEmailSend()");

		String email = userService.idCheck(request.getParameter("id"));
		
		JSONObject object = new JSONObject();
		
		if(loginService.hasUserById(request.getParameter("id"))) {
			
			String authKey = mailSendService.pwsendFindMail(email);
			object.put("authKey", authKey);
			
			object.put("hasEmail", true);
			return object.toString();
		} 
		
		object.put("hasEmail", false);
		return object.toString();
	}
	
	
	@RequestMapping("/verifyPwd")
	public String verifyPwd(MemberDTO memberDTO, Model model) {
		log.info("UserFindCotroller - verifyPwd()");		
		
		model.addAttribute("id", memberDTO.getId());
		
		return "find/resetPwd";
	}
	
	//인증된 user 비밀번호 변경
	@RequestMapping("/resetPwd")
	public String resetPwd(MemberDTO memberDTO, Model model) throws Exception {
		log.info("UserFindCotroller - resetPwd()");
			
		Map<String, String> userInfo = new HashMap<>();
		
		userInfo.put("id", memberDTO.getId());
		userInfo.put("pw", memberDTO.getPw());
		
		userService.resetPwd(userInfo);
		
		return "redirect:/loginForm";
	}
	
}