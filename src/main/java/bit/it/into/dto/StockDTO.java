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
	
	public StockDTO(StockBuyDTO stockBuyDTO) {
		this.stockinfo_symbols = stockBuyDTO.getBuy_stockinfo_symbols();
		this.company = stockBuyDTO.getBuy_company();
		this.purchase_price = stockBuyDTO.getBuy_purchase_price();
		this.quantity = stockBuyDTO.getBuy_quantity();
	}

	public StockDTO(StockSellDTO stockSellDTO) {
		this.stockinfo_symbols = stockSellDTO.getSell_stockinfo_symbols();
		this.quantity = stockSellDTO.getSell_quantity();
	}

}
