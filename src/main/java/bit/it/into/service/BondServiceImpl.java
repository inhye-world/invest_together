package bit.it.into.service;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import bit.it.into.dto.BondDTO;
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
	public List<BondDTO> getList(int member_num) {
		return mapper.getList(member_num);
	}

	@Override
	public void writeBond(BondDTO bondDTO) {
		mapper.writeBond(bondDTO);
	}

	@Override
	public void remove(String bond_num) {
		mapper.delete(bond_num);
		
	}

	@Override
	public void update(BondDTO bondDTO) {        
        mapper.update(bondDTO);
    }

}
