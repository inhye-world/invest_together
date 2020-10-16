package bit.it.into.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
public class NoticeDTO {
	
	private int notice_num;
	private String notice_name;
	private String notice_title;
	private String notice_content;
	private Timestamp notice_date;
	private int notice_hit;
	private int notice_group;
	private int notice_step;
	private int notice_indent;	
}
