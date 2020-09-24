package bit.it.into.service;

import java.util.List;
import java.util.Map;

import org.springframework.validation.Errors;

import bit.it.into.dto.BondDTO;

public interface BondService {
	
	public List<BondDTO> getList() throws Exception;

	public void writeBond(BondDTO bondDTO);

	public void remove(String bond_num);

	public void update(BondDTO bondDTO) throws Exception;

	public Map<String, String> validateHandling(Errors errors);
	
}
