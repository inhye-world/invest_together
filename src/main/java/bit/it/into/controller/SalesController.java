package bit.it.into.controller;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import bit.it.into.dto.SalesDTO;
import bit.it.into.security.CustomUser;
import bit.it.into.service.SalesService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class SalesController {

	private SalesService service;
	
	@RequestMapping("/sales_manage")
	public String sales_manage(Authentication authentication) {
		log.info("SalesController - sales_manage()");
		
		if(authentication == null) {
			return "login/login_require";
		}
		
		CustomUser user = (CustomUser)authentication.getPrincipal();
		
		String authority = user.getDto().getAuthoritiesDTO().getAuthority();
		if(!authority.equals("ROLE_ADMIN")) {
			return "error/accessDenied";
		}
		
		
		return "admin/sales_manage";
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/salesInfo", method=RequestMethod.POST, produces="application/text; charset=utf8")
	public String salesInfo(HttpServletRequest request) {
		log.info("SalesController - salesInfo()");
		
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		
		JSONObject result = new JSONObject();
		
		List<SalesDTO> salesList = service.getSalesList(startDate, endDate);
		if(salesList.isEmpty()) {
			result.put("hasSales", false);
			
			return result.toString();
		}
		
		JSONArray sales_list = new JSONArray();
		int sales_count = salesList.size();
		int sales_sum = 0;
		
		String[] labels;
		int[] data1;
		int[] data2;
		int count;
		
		if(sales_count>30) {
			labels = new String[30];
			data1 = new int[30];
			data2 = new int[30];
			
			count = 29;
		}else {
			labels = new String[sales_count];
			data1 = new int[sales_count];
			data2 = new int[sales_count];
			
			count = sales_count-1;
		}
		
		for(SalesDTO dto : salesList) {
			sales_sum += dto.getDaily_sales();
			
			JSONObject object = new JSONObject(dto);
			sales_list.put(object);
			
			if(count>=0) {
				LocalDateTime label = dto.getSales_date().toLocalDateTime();
				labels[count] = label.getMonthValue()+"월 "+label.getDayOfMonth()+"일";
				data1[count] = dto.getDaily_sales();
				--count;
			}
		}
		
		int sum=0;
		for(int i=0; i<labels.length; ++i) {
			sum += data1[i];
			data2[i] = sum;
		}
		
		
		result.put("hasSales", true);
		result.put("sales_list", sales_list);
		result.put("sales_count", sales_count);
		result.put("sales_sum", sales_sum);
		result.put("labels", labels);
		result.put("data1", data1);
		result.put("data2", data2);
		
		
		return result.toString();
	}
	
	@ResponseBody
	@RequestMapping(value="/rest/monthlySalesInfo", method=RequestMethod.POST, produces="application/text; charset=utf8")
	public String getMonthlySalesInfo() {
		log.info("SalesController - monthlySalesInfo()");
		
		JSONObject result = new JSONObject();
		
		List<SalesDTO> salesList = service.getAllSalesList();
		if(salesList.isEmpty()) {
			result.put("hasMonthlySales", false);
			
			return result.toString();
		}
		
		ArrayList<String> labels = new ArrayList<>();
		ArrayList<Integer> data1 = new ArrayList<>();
		
		int monthlyCount = 0;
		
		for(SalesDTO dto : salesList) {
			LocalDateTime ldt = dto.getSales_date().toLocalDateTime();
			
			if(monthlyCount != ldt.getMonthValue()) {
				labels.add(ldt.getMonthValue()+"월");
				data1.add(dto.getDaily_sales());
			}else {
				data1.set(data1.size()-1, data1.get(data1.size()-1)+dto.getDaily_sales());
			}
			
			monthlyCount = ldt.getMonthValue();
		}
		
		int[] data2 = new int[labels.size()];
		
		int sum = 0;
		for(int i=0; i<labels.size(); ++i) {
			sum += data1.get(i);
			data2[i] = sum;
		}
		
		
		result.put("hasMonthlySales", true);
		result.put("labels", labels);
		result.put("data1", data1);
		result.put("data2", data2);
		
		
		return result.toString();
	}
	
}
