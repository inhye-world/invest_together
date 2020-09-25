package bit.it.into.dto;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.PositiveOrZero;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BondDto {
	
	private String bond_num;
	
	@NotEmpty
	//@Pattern(regexp="(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[가-핳])")
	private String bond_symbols;
	
	//@NotEmpty
	//@Pattern(regexp="^[0-9]*$")
	private String member_num;
	
	@NotEmpty
	@Pattern(regexp="^[+]?(0|[1-9][0-9]*)(\\.[0-9]+)?$")
	private String total_interest;
	
	@NotEmpty
	//@Pattern(regexp="(?=.*[A-Z])(?=.*[가-핳])")
	private String bond_company;
	
	@NotEmpty
	@Pattern(regexp="^[0-9]*$")
	private String bond_price;
	
	@NotEmpty
	private String bond_date;
	
	@NotEmpty
	@Pattern(regexp="^[+]?(0|[1-9][0-9]*)(\\.[0-9]+)?$")
	private String coupon_interest_rate;
	
	@NotEmpty
	@Pattern(regexp="^[+]?(0|[1-9][0-9]*)(\\.[0-9]+)?$")
	private String discount_rate;
	
	@NotEmpty
	@Pattern(regexp="^[0-9]*$")
	private String gross_price;
	
	@NotEmpty
	private String maturity_date;
	
	@NotEmpty
	//@Pattern(regexp="(?=.*[A-C]){1,3}$")
	private String grade;

}
