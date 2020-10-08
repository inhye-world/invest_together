package bit.it.into.service;


import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bit.it.into.dto.AccountSalaryDTO;
import bit.it.into.mapper.SalaryMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SalaryService {

	@Inject
	private SalaryMapper mapper;
	
	@Transactional
	public void modify(AccountSalaryDTO accountSalary) {
		if(mapper.check(accountSalary) == 1) {
			mapper.modify(accountSalary);
		}else {
			mapper.insert(accountSalary);
		}
	}

	public AccountSalaryDTO getSalaryList(String fintech_use_num) {
		return mapper.readAllSalary(fintech_use_num);
	}
	
	public boolean hasSalary(String fintech_use_num) {
		int count = mapper.hasSalary(fintech_use_num);
		
		if(count==0) {
			return false;
		} 
		
		return true;
	}
}