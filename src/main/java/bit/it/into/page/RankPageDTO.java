package bit.it.into.page;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
public class RankPageDTO {

	private int startPage;
	private int endPage;
	private boolean prev, next;
	private int total;
	private RankCriteria cri;
	
	public RankPageDTO(RankCriteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage = (int)(Math.ceil(cri.getPage() / 10.0)) * 10;
		this.startPage = this.endPage - 9;
		
		int realEnd = (int) (Math.ceil((total * 1.0) / cri.getAmount()));
		if(realEnd <= this.endPage) {
			this.endPage = realEnd;
		}
		
		this.prev = this.startPage > 1;
		this.next = this.endPage < realEnd;
	
	}
	
	public String makeQuery(String league, int page) {
		UriComponents uriComponentsBuilder = UriComponentsBuilder.newInstance().queryParam("league", league) // league=whale
				.queryParam("page", page) // league=whale&page=1
				.build(); // ?league=whale&page=1
		return uriComponentsBuilder.toUriString(); // ?league=whale&page=1 리턴 
	}
}
