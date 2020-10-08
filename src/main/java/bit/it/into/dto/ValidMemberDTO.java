package bit.it.into.dto;

import javax.validation.constraints.Email;
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
   
	   @NotEmpty
	   @Size(min=4, max=12)
	   @Pattern(regexp = "^[a-z0-9]+$", message = "영문과 숫자만 입력가능합니다.")
	   private String id;

	   @NotEmpty
	   @Pattern(regexp="(?=.*[a-z])(?=.*[0-9])[0-9A-Za-z$&+,:;=?@#|'<>.^*()%!-]{8,32}$", message = "영문과 숫자가 포함된 비밀번호를 입력해 주세요. ")
	   private String pw;
	   
	   @NotEmpty
	   @Size(min=2, max=8)
	   @Pattern(regexp = "^[가-힣]+$", message = "한글만 입력가능합니다.")
	   private String name;
	   
	   @NotEmpty
	   @Size(min=2, max=8)
	   @Pattern(regexp = "^[가-힣a-zA-Z0-9]+$", message = "한글,영문,숫자만 입력가능합니다.")
	   private String nickname;
	   
	   @NotEmpty
	   @Email
	   private String email;
	   
	   @NotEmpty
	   @Pattern(regexp="^01(?:0|1|[6-9])(?:\\d{4})\\d{4}$", message = "형식에 맞지 않습니다.")
	   private String phone;

	}
