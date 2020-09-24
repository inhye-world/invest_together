package bit.it.into.dto;

import java.time.LocalDateTime;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AccountTransactionDTO {

	private LocalDateTime tran_date_time;
	private String inout_type;
	private String tran_type;
	private String print_content;
	private String tran_amt;
	private String branch_name;
	private String product_name;
	private int day;
}
