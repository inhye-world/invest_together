package bit.it.into.page;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class BoardCriteria {
	
	private int page_num; 
	private int amount = 10;
	
	public BoardCriteria() {
		this.page_num = 1;
	}
	

}
