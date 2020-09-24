package bit.it.into.controller;

import java.io.IOException;
import java.text.ParseException;
import java.util.Collections;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.github.scribejava.core.model.OAuth2AccessToken;

import bit.it.into.dto.MemberDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.security.CustomUserDetailsService;
import bit.it.into.service.LoginService;
import bit.it.into.service.NaverService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class NaverLoginController {
	
	@Inject
	protected CustomUserDetailsService userDetailsService;
	
	private String secret = "NAVERO7S8D9S00098777A000SECRET";
		
	@Autowired
	NaverService naverService;
	@Autowired
	LoginService loginService;
	
	
	@RequestMapping(value = "/callback", method = { RequestMethod.GET, RequestMethod.POST })
	public String callback(Model model, @RequestParam String code, @RequestParam String state, HttpSession session, HttpServletRequest request)
			throws IOException, ParseException, org.json.simple.parser.ParseException {
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverService.getAccessToken(session, code, state);
		String apiResult = naverService.getUserProfile(oauthToken);
		JSONParser parser = new JSONParser();
		Object obj = null;
		obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response_obj = (JSONObject) jsonObj.get("response");
		
		MemberDTO dto = new MemberDTO();
		dto.setId("naver_"+((String) response_obj.get("id")));
		dto.setEmail((String) response_obj.get("email"));
		dto.setName((String) response_obj.get("name"));
		dto.setSns_type("naver");
		dto.setSns_token(oauthToken.getAccessToken());
		
		MemberDTO user = loginService.naverIdCheck(dto.getId(), "naver");
		
		if(user==null) {
			
			model.addAttribute("dto", dto);
			return "login/naverAddInfo";
		
		}else {
			CustomUser userDetails = (CustomUser)userDetailsService.loadUserByUsername(user.getId());
		    Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, secret, Collections
				    .singletonList(new SimpleGrantedAuthority(userDetails.getDto().getAutheritiesDTO().getAutherity())));

		    SecurityContext securityContext = SecurityContextHolder.getContext();
		    securityContext.setAuthentication(authentication);
		    HttpSession session2 = request.getSession(true);
		    session2.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
		   
		    return "redirect:/";
		}
		
	}	
	
	@PostMapping("/addNaverUser")
	public String addNaverUser(MemberDTO memberDTO, Model model) {
		
		if(loginService.hasUserByNickname(memberDTO.getNickname())) {
			model.addAttribute("valid_nickname", "닉네임이 중복 되었습니다.");
			
			return "login/naverAddInfo";
		}
		
		memberDTO.setPw(secret);
		loginService.addNaverUser(memberDTO);
		
		return "login/resistration_SNS_Clear";
	}
}
