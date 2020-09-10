package bit.it.into.mapper;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.MemberDTO;

public interface LoginMapper {
	
	public MemberDTO readUser(String id);

	public int insertUser(MemberDTO memberDTO);

	public int insertAuthorities(MemberDTO memberDTO);

	public MemberDTO selectUserByKakaoId(@Param("id")String id, @Param("sns_type")String sns_type);
	
	public MemberDTO selectUserByNaverId(@Param("id")String id, @Param("sns_type")String sns_type);

	public int insertKakaoUser(MemberDTO memberDTO); 
	
	public int insertNaverUser(MemberDTO memberDTO);

	public Integer selectUserById(String id);

	public Integer selectUserByNickname(String nickname);

	public Integer selectUserByEmail(String email); 
}
