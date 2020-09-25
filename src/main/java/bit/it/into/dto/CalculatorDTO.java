package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class CalculatorDTO {
//	STOCKINFO_SYMBOLS	VARCHAR2(50 BYTE)
//	MEMBER_NUM	NUMBER(10,0)
//	TARGET_PRICE	NUMBER(10,0)
//	EV	NUMBER(10,0)
//	SHARE_ISSUED	NUMBER(10,0)
//	ROE	NUMBER(3,0)
//	KE	NUMBER(3,0)
	
	private String stockinfo_symbols;
	private int member_num;
	private int target_price;
	private int ev;
	private int share_issued;
	private double roe;
	private double ke;
}
