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
public class BondDTO {

	private int member_num;
	private String bond_symbols;
	private String bond_company;
	private long bond_price;
	private Timestamp bond_date;
	private double coupon_interest_rate;
	private double discount_rate;
	private int total_interest;
	private long gross_price;
	private Timestamp maturity_date;
	private String grade;
}
