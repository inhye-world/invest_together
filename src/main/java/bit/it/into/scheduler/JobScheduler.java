package bit.it.into.scheduler;

import java.util.List;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import bit.it.into.dto.RankDTO;
import bit.it.into.dto.StockDTO;
import bit.it.into.service.RankService;
import bit.it.into.service.StockService;
import bit.it.into.service.UserService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Component
@Log4j
@AllArgsConstructor
public class JobScheduler {
	
	private UserService user;
	private StockService stock;
	private RankService rank;
	
	@Scheduled(cron="30 28 15 * * *")
	public void updateRanking() {
		log.info("============================ 랭킹 업데이트 ============================");
		
		List<Integer> memberNumList = user.readAllMemberNum();
		
		for(Integer member_num : memberNumList) {
			if(stock.hasStockByMemberNum(member_num)) {
				int investment_amount = 0;
				int net_profit = 0;
				
				List<StockDTO> stockList = stock.getStockList(member_num);
				
				for(StockDTO dto : stockList) {
					investment_amount += ( dto.getPurchase_price() * dto.getQuantity() );
					
					String strCode = String.format("%06d", dto.getStockInfoDTO().getCode()); 
					String stockInfoXml = stock.getStockInfoXml(strCode);
					JSONObject stockInfoJson = XML.toJSONObject(stockInfoXml);
					int curJuka = Integer.valueOf(stockInfoJson.getJSONObject("stockprice").getJSONObject("TBL_StockInfo").getString("CurJuka").replaceAll("\\,",""));
					
					net_profit += ( curJuka - dto.getPurchase_price() ) * dto.getQuantity();
				}
				
				double net_profit_ratio = Math.round(((net_profit*1.0) / investment_amount)*10000) / 100.0;
				
				RankDTO rankDTO = new RankDTO();
				rankDTO.setMember_num(member_num);
				rankDTO.setInvestment_amount(investment_amount);
				rankDTO.setNet_profit(net_profit);
				rankDTO.setNet_profit_ratio(net_profit_ratio);
				
				rank.rankEnabled(rankDTO);
				
			}else {
				rank.rankDisabled(member_num);
			}
		}
		
	}
	
}
