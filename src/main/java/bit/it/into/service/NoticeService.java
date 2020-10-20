package bit.it.into.service;

import java.util.List;

import javax.inject.Inject;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import bit.it.into.dto.NoticeDTO;
import bit.it.into.mapper.NoticeMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class NoticeService {
	
	@Inject
	private NoticeMapper mapper;
	
	public List<NoticeDTO> getList() {
		log.info("getList.........");
		
		return mapper.getList();
	}

	public NoticeDTO get(int notice_num) {
		log.info("get.........");
		
		mapper.updateHit(notice_num);
		
		return mapper.read(notice_num);
	}

	@Transactional
	public void remove(int notice_num) {
		log.info("remove.........");
		
		mapper.noticeDelete(notice_num);	
		
	}

	public void writeNotice(NoticeDTO noticeDTO) {
		log.info("writeNotice.........");
		
		mapper.insertNotice(noticeDTO);
	}

	public void modifyNotice(NoticeDTO noticeDTO) {
		log.info("modifyNotice.........");
		
		mapper.modify(noticeDTO);
	}

	
}
