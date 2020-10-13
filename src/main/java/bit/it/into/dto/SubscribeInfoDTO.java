package bit.it.into.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class SubscribeInfoDTO {
	private String merchant_uid;
	private int member_num;
	private String name;
	private String phone;
	private int seller_num;
	private int sub_price;
	private Timestamp sub_date;
	private Timestamp sub_maturity_date;
	private String seller_nickname;
	
	public SubscribeInfoDTO(SubscribeDTO dto) {
		this.merchant_uid = dto.getMerchant_uid();
		this.member_num = dto.getMember_num();
		this.name = dto.getName();
		this.phone = dto.getPhone();
		this.seller_num = dto.getSeller_num();
		this.sub_price = dto.getSub_price();
		this.sub_date = dto.getSub_date();
		long month = 2592000000l;
		this.sub_maturity_date = new Timestamp(getSub_date().getTime()+month);
	}
}
