package bit.it.into.controller;

import static org.junit.Assert.*;

import org.junit.Test;

import bit.it.into.security.CustomUser;

public class BankTest {
	
	@Test
	public void bankTrans() {
		BankController bc = new BankController();
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String access_token = user.getDto().getAccess_token();
		
		int user_num = user.getDto().getMember_num();
	}

}
