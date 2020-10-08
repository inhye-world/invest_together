package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.AccountSalaryDTO;

public interface SalaryMapper {
	
	void modify(AccountSalaryDTO accountSalary);
	void insert(AccountSalaryDTO accountSalary);
	int check(AccountSalaryDTO accountSalary);
	AccountSalaryDTO readAllSalary(String fintech_use_num);
}
