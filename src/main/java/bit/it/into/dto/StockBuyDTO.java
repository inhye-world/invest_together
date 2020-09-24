package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class StockBuyDTO {
	private String buy_stockinfo_symbols;
	private String buy_company;
	private int buy_purchase_price;
	private int buy_quantity;
}
