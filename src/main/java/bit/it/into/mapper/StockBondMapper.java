package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.BondDTO;
import bit.it.into.dto.StockDTO;

public interface StockBondMapper {

	List<StockDTO> selectStockList(int member_num);

	List<BondDTO> selectBondList(int member_num);

}
