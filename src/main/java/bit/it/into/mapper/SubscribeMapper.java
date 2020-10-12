package bit.it.into.mapper;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.SubscribeDTO;

public interface SubscribeMapper {

	public int selectMerchantUidSeq();

	public Integer selectSetPrice(int member_num);

	public int insertSubscribe(SubscribeDTO subscribeDTO);

	public Integer selectCountSubscribe(@Param("member_num")int member_num, @Param("seller_num")int seller_num);

}
