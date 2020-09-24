package bit.it.into.dto;

import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Pattern;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class PwdVaildDTO {
	
	@NotEmpty
	@Pattern(regexp="(?=.*[0-9])(?=.*[a-zA-Z]).{8,32}", message="8자 이상 32자 이내의 하나의 영문이 포함된 비밀번호를 입력해 주세요.")
	private String pw;	
	
	private String id;
}
