package bit.it.into.dto;

import javax.validation.constraints.NotEmpty;

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
	
	@NotEmpty
	private String stockinfo_symbols;
	
	//@NotEmpty
	private int member_num;
	
	@NotEmpty
	private String ev;
	
	@NotEmpty
	private String share_issued;
	
	@NotEmpty
	private String roe;
	
	@NotEmpty
	private String ke;
}
