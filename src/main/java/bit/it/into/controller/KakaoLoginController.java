package bit.it.into.controller;

import java.util.Collections;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
import com.fasterxml.jackson.databind.JsonNode;

import bit.it.into.dto.MemberDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.security.CustomUserDetailsService;
import bit.it.into.service.KakaoService;
import bit.it.into.service.LoginService;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class KakaoLoginController {
	
	@Inject
	protected CustomUserDetailsService userDetailsService;
	
	private String secret = "KAKAOD8FJEK31O777A000SECRET";
	
	
	@Autowired
	KakaoService kakaoService;
	@Autowired
	LoginService loginService;
	
	
	@RequestMapping(value = "/kakaoLogin", produces = "application/json", method = { RequestMethod.GET, RequestMethod.POST })
	public String kakaoLogin(@RequestParam("code") String code, Model model, HttpServletRequest request) {
		
		JsonNode node = kakaoService.getAccessToken(code);
		JsonNode access_token = node.get("access_token");
		JsonNode userInfo = kakaoService.getUserInfo(access_token);
		JsonNode properties = userInfo.path("properties");
		JsonNode kakao_account = userInfo.path("kakao_account");
		
		MemberDTO dto = new MemberDTO();
		dto.setId("kakao_"+userInfo.path("id").asText());
		dto.setEmail(kakao_account.path("email").asText());
		dto.setName(properties.path("nickname").asText());
		dto.setSns_type("kakao");
		dto.setSns_token(access_token.asText());
		
		MemberDTO user = loginService.kakaoIdCheck(dto.getId(), "kakao");
		
		if (user==null) {
			
			model.addAttribute("dto", dto);
			return "login/kakaoAddInfo";
		
		}else {
			
			CustomUser userDetails = (CustomUser)userDetailsService.loadUserByUsername(user.getId());
		    Authentication authentication = new UsernamePasswordAuthenticationToken(userDetails, secret, Collections
				    .singletonList(new SimpleGrantedAuthority(userDetails.getDto().getAuthoritiesDTO().getAuthority())));

		    SecurityContext securityContext = SecurityContextHolder.getContext();
		    securityContext.setAuthentication(authentication);
		    HttpSession session = request.getSession(true);
		    session.setAttribute("SPRING_SECURITY_CONTEXT", securityContext);
		   
		    return "redirect:/";
		}
		
	}
	
	
	@PostMapping("/addKakaoUser")
	public String addKakaoUser(MemberDTO memberDTO, Model model) {				
		
		if(loginService.hasUserByNickname(memberDTO.getNickname())) {
			model.addAttribute("valid_nickname", "닉네임이 중복 되었습니다.");
			
			return "login/kakaoAddInfo";
		}
					
		memberDTO.setPw(secret);
		loginService.addKakaoUser(memberDTO);
		
		return "login/resistration_SNS_Clear";
	}
}
