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
public class BoardDTO {
	
	private int board_num;
	private String board_name;
	private String board_title;
	private String board_content;
	private Timestamp board_date;
	private int board_hit;
	private int board_group;
	private int board_step;
	private int board_indent;
	
}
