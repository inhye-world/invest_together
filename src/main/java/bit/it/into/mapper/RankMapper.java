package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.RankDTO;
import bit.it.into.dto.RankingDTO;

public interface RankMapper {

	public int updateRankDisabled(Integer member_num);

	public int updateRankEnabled(RankDTO rankDTO);

	public List<RankingDTO> selectWhaleReagueList();

	public List<RankingDTO> selectMackerelReagueList();

	public List<RankingDTO> selectShrimpReagueList();

}
