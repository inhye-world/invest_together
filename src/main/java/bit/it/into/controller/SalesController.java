package bit.it.into.controller;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.security.CustomUser;
import bit.it.into.service.SalesService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class SalesController {

	private SalesService service;
	
	@RequestMapping("/sales_manage")
	public String sales_manage(Authentication authentication) {
		log.info("SalesController - sales_manage()");
		
		if(authentication == null) {
			return "login/login_require";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String authority = user.getDto().getAuthoritiesDTO().getAuthority();
		if(!authority.equals("ROLE_ADMIN")) {
			return "error/accessDenied";
		}
		
		
		return "admin/sales_manage";
	}
}
