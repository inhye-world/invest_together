package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.NoticeDTO;

public interface NoticeMapper {

	public List<NoticeDTO> getList();

	public NoticeDTO read(int notice_num);
	
	public int noticeDelete(int notice_num);

	public void insertNotice(NoticeDTO noticeDTO);

	public void modify(NoticeDTO noticeDTO);

	public void updateHit(int notice_num);

}
