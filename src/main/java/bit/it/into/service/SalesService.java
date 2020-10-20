package bit.it.into.service;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import bit.it.into.mapper.SalesMapper;
import lombok.extern.log4j.Log4j;

@Service
@Log4j
public class SalesService {
	
	@Inject
	private SalesMapper mapper;
	
	@Transactional
	public void updateDailySales() {
		log.info("SalesService -updateDailySales()");
		
		int dailySaleSum = mapper.selectSubPriceDay();
		int dailySaleCount = mapper.selectCountSubPriceDay();
		
		int count =  mapper.insertDailySales(dailySaleSum, dailySaleCount);
		
		if(count != 1) {
			log.info("insertDailySales 오류");
		}
	}
}
