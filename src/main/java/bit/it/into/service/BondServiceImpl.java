package bit.it.into.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;
import org.springframework.validation.Errors;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;

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

	@Override
	public Map<String, String> validateHandling(Errors errors) {
		log.info("BondService - validateHandling()");
		
		Map<String, String> validatorResult = new HashMap<>();

        for (FieldError error : errors.getFieldErrors()) {
            String validKeyName = String.format("valid_%s", error.getField());
            validatorResult.put(validKeyName, error.getDefaultMessage());
        }

        return validatorResult;
	}

	
	
}
