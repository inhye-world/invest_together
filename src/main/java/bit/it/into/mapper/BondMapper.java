package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.BondDto;

public interface BondMapper {
	
	public List<BondDto> getList() throws Exception;

	public void writeBond(BondDto bondDto);

	public void delete(String bond_symbols);
	
	public void update(BondDto bondDto) throws Exception;

}
