package bit.it.into.dto;



import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class MemberDTO {
	
	private int member_num;
	private String id;
	private String pw;
	private String name;
	private String nickname;
	private String email;
	private String phone;
	private String access_token;
	private String refresh_token;
	private String user_seq_no;
	private int set_price;
	private String sns_type;
	private String sns_token;
	private String authkey;
	
	private AuthoritiesDTO authoritiesDTO;
	
	private RankDTO rankDTO;
	
	public MemberDTO(ValidMemberDTO dto) {
		this.id = dto.getId();
		this.pw = dto.getPw();
		this.name = dto.getName();
		this.nickname = dto.getNickname();
		this.email = dto.getEmail();
		this.phone = dto.getPhone();
		
	}
	
}
