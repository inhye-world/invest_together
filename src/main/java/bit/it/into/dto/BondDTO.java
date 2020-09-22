package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BondDto {
	
	private String bond_symbols;
	private String member_num;
	private String total_interest;
	private String bond_company;
	private String bond_price;
	private String bond_date;
	private String coupon_interest_rate;
	private String discount_rate;
	private String gross_price;
	private String maturity_date;
	private String grade;

}
