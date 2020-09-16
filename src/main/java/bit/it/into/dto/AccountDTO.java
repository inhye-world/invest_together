package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AccountDTO {
	private int member_num;
	private String fintech_use_num;
	private String account_alias;
	private String bank_name;
}
