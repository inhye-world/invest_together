package bit.it.into.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.SubscribeDTO;

public interface SubscribeMapper {

	public int selectMerchantUidSeq();

	public Integer selectSetPrice(int member_num);

	public int insertSubscribe(SubscribeDTO subscribeDTO);

	public Integer selectCountSubscribe(@Param("member_num")int member_num, @Param("seller_num")int seller_num);

	public SubscribeDTO selectSubscribeByMerchantUid(String merchant_uid);

	public List<SubscribeDTO> selectSubscribeListByMemberNum(int member_num);

	public String selectNicknameByMemberNum(int member_num);

	public void updateSetPrice(Map<Integer, Integer> user);

}
