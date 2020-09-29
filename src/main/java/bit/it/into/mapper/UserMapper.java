package bit.it.into.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.MemberDTO;

public interface UserMapper {

	public int updateUserToken(@Param("member_num")int member_num, @Param("access_token")String access_token, @Param("refresh_token")String refresh_token, @Param("user_seq_no")String user_seq_no);

	public int insertAccount(AccountDTO accountDTO);

	public List<Integer> selectAllMemberNum();
	
	public String selectPwdEmail(String id);

	public void updatePwd(Map<String, String> userInfo);

	public String selectIdEmail(String name);

	public List<MemberDTO> selectIdInfo(String email);

}
