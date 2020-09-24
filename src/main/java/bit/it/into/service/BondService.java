package bit.it.into.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.ObjectError;

import bit.it.into.dto.BondDto;
import bit.it.into.mapper.BondMapper;

public interface BondService {
	
	public List<BondDto> getList() throws Exception;

	public void writeBond(BondDto bondDto);

	public void remove(String bond_num);

	public void update(BondDto bondDto) throws Exception;

	public Map<String, String> validateHandling(Errors errors);
	
}
