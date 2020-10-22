package bit.it.into.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.SalesDTO;

public interface SalesMapper {
	
	public int selectSubPriceDay();

	public int selectCountSubPriceDay();
	
	public int insertDailySales(@Param("dailySaleSum")int dailySaleSum, @Param("dailySaleCount")int dailySaleCount);

	public List<SalesDTO> selectSalesList(@Param("startDate")String startDate, @Param("endDate")String endDate);

	public List<SalesDTO> selectAllSalesList();

}
