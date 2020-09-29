package bit.it.into.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import bit.it.into.dto.BondDTO;
import bit.it.into.dto.StockDTO;

public interface StockMapper {

	public List<StockDTO> selectStockList(int member_num);

	public List<BondDTO> selectBondList(int member_num);

	public Integer selectStockCount(StockDTO stockDTO);
	
	public Integer selectStockCountByMemberNum(Integer member_num);
	
	public int insertStock(StockDTO stockDTO);

	public StockDTO selectStock(StockDTO stockDTO);

	public int updateAddStock(StockDTO stockDTO);

	public int updateRemoveStock(StockDTO stockDTO);

	public int deleteStock(@Param("member_num")int member_num, @Param("stockinfo_symbols")String stockinfo_symbols);

	public List<String> selectAutocompleteList(String value);

	public Integer selectStockInfoBySymbol(@Param("stockinfo_symbols")String symbol);

}
