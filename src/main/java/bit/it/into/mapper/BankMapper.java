package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.AccountDTO;

public interface BankMapper {

	public List<AccountDTO> selectAccountList(int member_num);
}
