package bit.it.into.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.AccountBalanceDTO;
import bit.it.into.dto.AccountDTO;
import bit.it.into.mapper.BankMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class BankService {

	@Inject
	private BankMapper mapper;
	
	public List<AccountDTO> getAccountList(int member_num) {
		log.info("BankService - getAccountList()");
		
		return mapper.selectAccountList(member_num);
	}

}
