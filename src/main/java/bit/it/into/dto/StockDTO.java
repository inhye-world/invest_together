package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class StockDTO {
	
	private int member_num;
	private String stockinfo_symbols;
	private String company;
	private int purchase_price;
	private int quantity;
	private int target_price;
	private int net_profit;
	
	private StockInfoDTO stockInfoDTO;
	
}
