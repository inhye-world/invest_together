package bit.it.into.service;

import java.util.List;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import bit.it.into.dto.BondDto;
import bit.it.into.mapper.BondMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BondServiceImpl implements BondService {
	
	@Inject
	private BondMapper mapper;

	@Override
	public List<BondDto> getList() throws Exception {
		return mapper.getList();
	}

	@Override
	public void writeBond(BondDto bondDto) {
		mapper.writeBond(bondDto);
	}

	@Override
	public void remove(String bond_num) {
		mapper.delete(bond_num);
		
	}

	@Override
	public void update(BondDto bondDto) throws Exception{        
        mapper.update(bondDto);
    }

	
	
}
