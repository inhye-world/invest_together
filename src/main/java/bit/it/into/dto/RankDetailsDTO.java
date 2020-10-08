package bit.it.into.dto;


import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class RankDetailsDTO {
	private Timestamp rank_date;
	private int member_num;
	private int net_profit;
	private double net_profit_ratio;
}
