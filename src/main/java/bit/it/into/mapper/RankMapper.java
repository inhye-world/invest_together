package bit.it.into.mapper;

import bit.it.into.dto.RankDTO;

public interface RankMapper {

	public int updateRankDisabled(Integer member_num);

	public int updateRankEnabled(RankDTO rankDTO);

}
