package bit.it.into.controller;

import javax.inject.Inject;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import bit.it.into.dto.BoardDTO;
import bit.it.into.dto.CommentsDTO;
import bit.it.into.page.BoardCriteria;
import bit.it.into.page.BoardPageDTO;
import bit.it.into.page.CommentsCriteria;
import bit.it.into.page.CommentsPageDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.BoardService;
import bit.it.into.service.NoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class BoardCotroller {
	
	@Inject
	BoardService boardService;
	
	@Inject
	NoticeService noticeService;
	
	 @RequestMapping("/boardList")
	 public String list(BoardCriteria cri, Model model, Authentication authentication) {	
		 log.info("list");
		 
		if(authentication == null) {
			return "redirect:/loginForm";
		}	
		
		model.addAttribute("list", boardService.getList(cri));
		model.addAttribute("nlist", noticeService.getList());
		 
		int total = boardService.getTotal(cri);
		log.info("total" + total);
		 
		BoardPageDTO dto = new BoardPageDTO(cri,total);
		 
		model.addAttribute("pageMaker", dto);
		 
		return "board/list";	
	 }
	
	 	@RequestMapping("/content_view")
		public String content_view(BoardDTO boardDTO, CommentsCriteria cri, Model model, Authentication authentication) {
			log.info("content_view()");
			
			if(authentication == null) {
				return "redirect:/loginForm";
			}
						
			CustomUser user = (CustomUser)authentication.getPrincipal();
						
			model.addAttribute("dto", user);
			
			model.addAttribute("content_view", boardService.get(boardDTO.getBoard_num()));
			
			model.addAttribute("comments", boardService.getComment(cri));
			
			int total = boardService.getCommnetsTotal(cri);
			
			CommentsPageDTO dto = new CommentsPageDTO(cri,total,boardDTO.getBoard_num());
			
			model.addAttribute("pageMaker", dto);
			
			model.addAttribute("total", total);
		
			return "board/content_view";
		} 	
	
	 	@RequestMapping("/boardDelete")
		public String delete(BoardDTO boardDTO) {
			log.info("BoardDelete()");
			
			boardService.remove(boardDTO.getBoard_num());
			
			return "redirect:boardList";	
		}
		
		@RequestMapping("/write_view")
		public String write_view(Model model, Authentication authentication) {
			log.info("write_view()");
			
			CustomUser user = (CustomUser)authentication.getPrincipal();
			
			model.addAttribute("dto", user);
			
			return "board/write_view";	
		}
		
		@RequestMapping("/boardWrite")
		public String write(BoardDTO boardDTO) throws Exception{
			log.info("write()");
			
			boardService.writeBoard(boardDTO);
			
			return "redirect:boardList";	
		}
		
		@RequestMapping("/boardModify")
		public String boardModify(BoardDTO boardDTO) throws Exception{
			log.info("boardModify()");
			
			boardService.modifyBoard(boardDTO);
			
			return "redirect:boardList";	
		}
		
		@RequestMapping("/modify_view")
		public String modify_view(BoardDTO boardDTO, Model model, Authentication authentication) throws Exception{
			log.info("modify_view()");
			
			CustomUser user = (CustomUser)authentication.getPrincipal();
			
			model.addAttribute("dto", user);
			
			model.addAttribute("modify_view", boardService.get(boardDTO.getBoard_num()));
			
			return "board/modify_view";	
		}
			
		@RequestMapping("/writeComment")
		public String writeComment(CommentsDTO commentsDTO, Model model) throws Exception{
			log.info("writeComment()");
			
			boardService.writeComment(commentsDTO);
			
			return "forward:/content_view";	
		}
		
		@RequestMapping("/modify_comments")
		public String modify_comments(CommentsDTO commentsDTO) throws Exception{
			log.info("modify_comments()");
			
			boardService.modifyComments(commentsDTO);
			
			return "forward:/content_view";	
		}
		
		@RequestMapping("/delete_comments")
		public String delete_comments(CommentsDTO commentsDTO) throws Exception{
			log.info("delete_comments()");
			
			boardService.deleteComments(commentsDTO);
			
			return "forward:/content_view";	
		}
		
}
