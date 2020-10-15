package bit.it.into.page;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class CommentsCriteria {
	
	private int page_num; 
	private int amount = 5;
	private int board_num;
	
	public CommentsCriteria() {
		this.page_num = 1;
	}
	

}
