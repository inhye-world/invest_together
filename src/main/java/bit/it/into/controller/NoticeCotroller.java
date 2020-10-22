package bit.it.into.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import bit.it.into.dto.NoticeDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.NoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class NoticeCotroller {
	
	@Inject
	NoticeService noticeService;
		
		@RequestMapping("/write_notice")
		public String write_view(Model model, Authentication authentication) {
			log.info("write_notice()");
			
			if(authentication == null) {
				return "login/login_require";
			}
			
			CustomUser user = (CustomUser)authentication.getPrincipal();
			
			String authority = user.getDto().getAuthoritiesDTO().getAuthority();
			if(!authority.equals("ROLE_ADMIN")) {
				return "error/accessDenied";
			}
			
			model.addAttribute("dto", user);
			
			return "notice/write_notice";	
		}
		
		@RequestMapping("/noticeWrite")
		public String write(NoticeDTO noticeDTO) throws Exception{
			log.info("write()");
			
			noticeService.writeNotice(noticeDTO);
			
			return "redirect:boardList";	
		}
		
		@RequestMapping("/notice_view")
		public String notice_view(NoticeDTO noticeDTO, Model model, Authentication authentication) {
			log.info("notice_view()");
			
			if(authentication == null) {
				return "redirect:/loginForm";
			}
						
			CustomUser user = (CustomUser)authentication.getPrincipal();
						
			model.addAttribute("dto", user);			
			model.addAttribute("notice", noticeService.get(noticeDTO.getNotice_num()));
		
			return "notice/notice_view";
		} 
		
		@RequestMapping("/noticeModify")
		public String noticeModify(NoticeDTO noticeDTO) throws Exception{
			log.info("noticeModify()");
			
			noticeService.modifyNotice(noticeDTO);
			
			return "redirect:boardList";	
		}
		
		@RequestMapping("/modify_notice")
		public String modify_view(NoticeDTO noticeDTO, Model model, Authentication authentication) throws Exception{
			log.info("modify_notice()");
			
			if(authentication == null) {
				return "login/login_require";
			}
			
			CustomUser user = (CustomUser)authentication.getPrincipal();
			
			String authority = user.getDto().getAuthoritiesDTO().getAuthority();
			if(!authority.equals("ROLE_ADMIN")) {
				return "error/accessDenied";
			}
			
			model.addAttribute("dto", user);
			model.addAttribute("notice", noticeService.get(noticeDTO.getNotice_num()));
			
			return "notice/modify_notice";	
		}
		
		@RequestMapping("/noticeDelete")
		public String delete(NoticeDTO noticeDTO, Authentication authentication) {
			log.info("NoticeDelete()");
			
			if(authentication == null) {
				return "login/login_require";
			}
			
			CustomUser user = (CustomUser)authentication.getPrincipal();
			
			String authority = user.getDto().getAuthoritiesDTO().getAuthority();
			if(!authority.equals("ROLE_ADMIN")) {
				return "error/accessDenied";
			}
			
			noticeService.remove(noticeDTO.getNotice_num());
			
			return "redirect:boardList";	
		}
		
}
