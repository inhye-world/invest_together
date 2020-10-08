package bit.it.into.page;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@ToString
@Getter
@Setter
public class RankCriteria {
	
	private String league;
	private int page;
	private int amount = 50;
	
	public RankCriteria() {
		this.league = "whale";
		this.page = 1;
	}
		
}
