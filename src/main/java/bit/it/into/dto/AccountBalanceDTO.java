package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AccountBalanceDTO {
	private AccountDTO accountDTO;
	private String product_name;
	private String balance_amt;
}
