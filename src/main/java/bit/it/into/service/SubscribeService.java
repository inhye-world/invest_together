package bit.it.into.service;

import java.util.List;

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

	public boolean isSubscribe(int member_num, int seller_num) {
		log.info("SubscribeService - isSubscribe()");
		
		Integer count = mapper.selectCountSubscribe(member_num, seller_num);
		
		if(count==0) {
			return false;
		}
		
		return true;
	}

	public SubscribeDTO getSubscribe(String merchant_uid) {
		log.info("SubscribeService - getSubscribe()");
		
		return mapper.selectSubscribeByMerchantUid(merchant_uid);
	}

	public List<SubscribeDTO> getSubscribeList(int member_num) {
		log.info("SubscribeService - getSubscribeList()");
		
		return mapper.selectSubscribeListByMemberNum(member_num);
	}

	public String getNicknameByMemberNum(int member_num) {
		log.info("SubscribeService -getNicknameByMemberNum()");
		
		return mapper.selectNicknameByMemberNum(member_num);
	}

	
}
