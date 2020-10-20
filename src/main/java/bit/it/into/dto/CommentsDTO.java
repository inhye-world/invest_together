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
public class CommentsDTO {
	
	private int comment_num;
	private String comment_name;
	private String comment_content;
	private Timestamp comment_date;
	private int comment_group;
	private int comment_step;
	private int comment_indent;
	private int board_num;
	
	public String getPhoto() {
		
		int num = (int)(Math.random()*6)+1;
		
		return "/resources/main/assets/img/blog/profile" + num + ".jpeg";
	}
	
}
