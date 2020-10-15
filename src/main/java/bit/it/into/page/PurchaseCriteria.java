package bit.it.into.page;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
public class PurchaseCriteria {
	
	private int page_num; 
	private int amount = 5;
	
	public PurchaseCriteria() {
		this.page_num = 1;
	}
	

}
