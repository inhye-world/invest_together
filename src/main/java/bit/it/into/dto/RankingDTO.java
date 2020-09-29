package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class RankingDTO {

	private int member_num;
	private String nickname;
	private String league;
	private int place;
	private double net_profit_ratio;
	private int net_profit;
	private int investment_amount;
	
	private double percentile;
}
