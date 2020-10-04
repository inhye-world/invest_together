package bit.it.into.mapper;

import java.util.List;

import bit.it.into.dto.RankDTO;
import bit.it.into.dto.RankingDTO;
import bit.it.into.page.RankCriteria;

public interface RankMapper {

	public int updateRankDisabled(Integer member_num);

	public int updateRankEnabled(RankDTO rankDTO);

	public List<RankingDTO> selectWhaleReagueList();

	public List<RankingDTO> selectMackerelReagueList();

	public List<RankingDTO> selectShrimpReagueList();

	public int getShrimpLeagueTotalCount();

	public int getMackerelLeagueTotalCount();

	public int getWhaleLeagueTotalCount();

	public List<RankingDTO> getShrimpLeaguePageList(RankCriteria cri);

	public List<RankingDTO> getMackerelLeaguePageList(RankCriteria cri);

	public List<RankingDTO> getWhaleLeaguePageList(RankCriteria cri);

}
