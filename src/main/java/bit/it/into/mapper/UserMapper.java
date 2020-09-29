package bit.it.into.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.AccountDTO;
import bit.it.into.dto.MemberDTO;
import bit.it.into.security.CustomUser;

public interface UserMapper {

	public int updateUserToken(@Param("member_num")int member_num, @Param("access_token")String access_token, @Param("refresh_token")String refresh_token, @Param("user_seq_no")String user_seq_no);

	public int insertAccount(AccountDTO accountDTO);

	String selectPwdEmail(String id);

	void updatePwd(Map<String, String> userInfo);

	String selectIdEmail(String name);

	List<MemberDTO> selectIdInfo(String email);

	public void updateNickname(MemberDTO dto);

	public void updatePhone(MemberDTO dto);

	public void updateId(MemberDTO dto);


}
