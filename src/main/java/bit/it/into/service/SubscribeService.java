package bit.it.into.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.SubscribeDTO;
import bit.it.into.mapper.SubscribeMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SubscribeService {
	
	@Inject
	private SubscribeMapper mapper;

	public int getMerchantSeq() {
		log.info("SubscribeService - getMerchantSeq()");
		
		return mapper.selectMerchantUidSeq();
	}

	public Integer getSetPrice(int member_num) {
		log.info("SubscribeService - getSetPrice()");
		
		return mapper.selectSetPrice(member_num);
	}

	public void successPayment(SubscribeDTO subscribeDTO) {
		log.info("SubscribeService - successPayment()");
		
		int count = mapper.insertSubscribe(subscribeDTO);
		
		if(count != 1) {
			log.info("insertSubscribe 오류");
		}
	}
}
