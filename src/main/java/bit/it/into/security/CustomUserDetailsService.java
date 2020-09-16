package bit.it.into.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import bit.it.into.dto.MemberDTO;
import bit.it.into.mapper.LoginMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class CustomUserDetailsService implements UserDetailsService {
	
	@Setter(onMethod_=@Autowired)
	private LoginMapper mapper;
	
	@Override
	public UserDetails loadUserByUsername(String id) throws UsernameNotFoundException {
		
		log.warn("Load User By id : " + id);
		
		MemberDTO dto = mapper.readUser(id);
		
		log.warn("queried by mapper : " + dto);
		
		
		return dto == null ? null : new CustomUser(dto);
	}
 
}
