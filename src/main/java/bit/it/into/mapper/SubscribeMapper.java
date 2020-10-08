package bit.it.into.mapper;

import bit.it.into.dto.SubscribeDTO;

public interface SubscribeMapper {

	public int selectMerchantUidSeq();

	public Integer selectSetPrice(int member_num);

	public int insertSubscribe(SubscribeDTO subscribeDTO);

}
