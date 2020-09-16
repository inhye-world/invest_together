package bit.it.into.mapper;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.AccountDTO;

public interface UserMapper {

	int updateUserToken(@Param("member_num")int member_num, @Param("access_token")String access_token, @Param("refresh_token")String refresh_token, @Param("user_seq_no")String user_seq_no);

	int insertAccount(AccountDTO accountDTO);

}
