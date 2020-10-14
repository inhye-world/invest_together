package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.BoardDTO;
import bit.it.into.dto.CommentsDTO;
import bit.it.into.page.BoardCriteria;
import bit.it.into.page.CommentsCriteria;

public interface BoardMapper {

	public List<BoardDTO> getList();

	public BoardDTO read(int board_num);
	
	public int boardDelete(int board_num);

	public void insertBoard(BoardDTO boardDTO);

	public void modify(BoardDTO boardDTO);

	public int getTotalCount(BoardCriteria cri);

	public List<BoardDTO> getListWithPaging(BoardCriteria cri);

	public void updateHit(int board_num);

	public void insertComment(CommentsDTO commentsDTO);

	public List<CommentsDTO> getCommnetsList(CommentsCriteria cri);

	public int getCommentsTotalCount(CommentsCriteria cri);

	public void commentsDelete(int board_num);

	public void modifyComments(CommentsDTO commentsDTO);

	public void deleteComments(CommentsDTO commentsDTO);

}
