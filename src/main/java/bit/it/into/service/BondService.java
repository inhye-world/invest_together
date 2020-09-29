package bit.it.into.service;

import java.util.List;

import bit.it.into.dto.BondDTO;


public interface BondService {
	
	public List<BondDTO> getList(int member_num) throws Exception;

	public void writeBond(BondDTO bondDTO);

	public void remove(String bond_num);

	public void update(BondDTO bondDTO) throws Exception;
	
}
