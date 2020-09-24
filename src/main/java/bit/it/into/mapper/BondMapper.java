package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.BondDTO;

public interface BondMapper {
	
	public List<BondDTO> getList() throws Exception;

	public void writeBond(BondDTO bondDTO);

	public void delete(String bond_num);
	
	public void update(BondDTO bondDTO) throws Exception;

}
