package bit.it.into.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class ValidMemberDTO {
	
	@NotEmpty(message="다시 입력해 주세요.")
	@Size(min=4, max=12, message="다시 입력해 주세요.")
	@Pattern(regexp = "^[a-z0-9]+$", message="다시 입력해 주세요.")
	private String id;
	
	@NotEmpty(message = "다시 입력해 주세요.")
	@Pattern(regexp="(?=.*[0-9])(?=.*[a-zA-Z]).{8,32}", message="다시 입력해 주세요.")
	private String pw;
	
	@NotEmpty(message = "다시 입력해 주세요.")
	@Size(min=2, max=8, message="다시 입력해 주세요.")
	@Pattern(regexp = "^[가-힣]+$", message="다시 입력해 주세요.")
	private String name;
	
	@NotEmpty(message = "다시 입력해 주세요.")
	@Size(min=2, max=8, message="다시 입력해 주세요.")
	@Pattern(regexp = "^[가-힣a-zA-Z0-9]+$", message="다시 입력해 주세요.")
	private String nickname;
	
	@NotEmpty(message = "다시 입력해 주세요.")
	@Email(message = "다시 입력해 주세요.")
	private String email;
	
	@NotEmpty(message = "다시 입력해 주세요.")
	@Pattern(regexp="^01(?:0|1|[6-9])(?:\\d{3}|\\d{4})\\d{4}$", message = "다시 입력해 주세요.")
	private String phone;
}
