package bit.it.into.security;

import java.util.Collection;
import java.util.Collections;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import bit.it.into.dto.MemberDTO;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;


@Getter
@Setter
public class CustomUser extends User{
	
	private MemberDTO dto;
	
	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
		
	public CustomUser(MemberDTO memberDTO) {	
		
		super(memberDTO.getId(), memberDTO.getPw(), Collections
				    .singletonList(new SimpleGrantedAuthority(memberDTO.getAutheritiesDTO().getAutherity())));

		this.dto = memberDTO;
	}
}
