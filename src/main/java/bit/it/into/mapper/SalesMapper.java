package bit.it.into.mapper;

import org.apache.ibatis.annotations.Param;

public interface SalesMapper {
	
	public int selectSubPriceDay();

	public int selectCountSubPriceDay();
	
	public int insertDailySales(@Param("dailySaleSum")int dailySaleSum, @Param("dailySaleCount")int dailySaleCount);

}
