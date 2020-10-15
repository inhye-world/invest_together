package bit.it.into.service;

import java.util.List;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import bit.it.into.dto.BoardDTO;
import bit.it.into.dto.CommentsDTO;
import bit.it.into.mapper.BoardMapper;
import bit.it.into.page.BoardCriteria;
import bit.it.into.page.CommentsCriteria;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BoardService {
	
	@Inject
	private BoardMapper mapper;
	
	public List<BoardDTO> getList() {
		log.info("getList.........");
		
		return mapper.getList();
	}

	public BoardDTO get(int board_num) {
		log.info("get.........");
		
		mapper.updateHit(board_num);
		
		return mapper.read(board_num);
	}

	@Transactional
	public void remove(int board_num) {
		log.info("remove.........");
		
		mapper.commentsDelete(board_num);
		mapper.boardDelete(board_num);	
		
	}

	public void writeBoard(BoardDTO BoardDTO) {
		log.info("writeBoard.........");
		
		mapper.insertBoard(BoardDTO);
	}

	public void modifyBoard(BoardDTO BoardDTO) {
		log.info("modifyBoard.........");
		
		mapper.modify(BoardDTO);
	}
	
	public int getTotal(BoardCriteria cri) {
		log.info("get total count");
		return mapper.getTotalCount(cri);
	}

	public List<BoardDTO> getList(BoardCriteria cri) {
		log.info("get List with criteria"  + cri);
		return mapper.getListWithPaging(cri);
	}

	public void writeComment(CommentsDTO commentsDTO) {
		log.info("writeComment.........");
		
		mapper.insertComment(commentsDTO);
	}

	public List<CommentsDTO> getComment(CommentsCriteria cri) {
		log.info("get CommentsList with criteria"  + cri);
		
		return mapper.getCommnetsList(cri);
	}

	public int getCommnetsTotal(CommentsCriteria cri) {
		log.info("get total count");
		
		return mapper.getCommentsTotalCount(cri);
	}

	public void modifyComments(CommentsDTO commentsDTO) {
		log.info("modifyComments()");
		
		mapper.modifyComments(commentsDTO);
	}

	public void deleteComments(CommentsDTO commentsDTO) {
		log.info("deleteComments()");
		
		mapper.deleteComments(commentsDTO);
	}
	
}
