package bit.it.into.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AccountSalaryDTO {
	AccountSalaryDTO accountSalaryDTO;
	private String fintech_use_num;
	private String account_alias;
	private String bank_name;
	//private String product_name;
	private String balance_amt;
	private String category;
	private float interest;
	private Timestamp maturity;
	private String strMaturity;
	private String expected_amt;
	//private String tran_amt;
	
	public void setStrMaturity(String strMaturity) {
		this.strMaturity = strMaturity;
		this.maturity =  Timestamp.valueOf(strMaturity+" 00:00:00.0");
	}
	
	public void setMaturity(Timestamp maturity) {
		this.maturity = maturity;
		
		SimpleDateFormat dateformat = new SimpleDateFormat("dd-MM-yyyy");
		this.strMaturity = dateformat.format(maturity);
	}
	
}
