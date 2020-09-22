package bit.it.into.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.BondDto;
import bit.it.into.mapper.BondMapper;

public interface BondService {
	
	public List<BondDto> getList() throws Exception;

	public void writeBond(BondDto bondDto);

	public void remove(String bond_symbols);

	public void update(BondDto bondDto) throws Exception;
	
}
