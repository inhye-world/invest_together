package bit.it.into.service;

import java.util.List;

import bit.it.into.dto.BondDto;

public interface BondService {
	
	public List<BondDto> getList() throws Exception;

	public void writeBond(BondDto bondDto);

	public void remove(String bond_num);

	public void update(BondDto bondDto) throws Exception;
	
}
