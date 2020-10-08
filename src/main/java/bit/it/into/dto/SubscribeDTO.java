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
public class SubscribeDTO {
	private String merchant_uid;
	private int member_num;
	private String name;
	private String phone;
	private int seller_num;
	private int sub_price;
	private Timestamp sub_date;
}
