package bit.it.into.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@AllArgsConstructor
@Log4j
public class PurchaseDetailsController {
	
	@RequestMapping("/purchaseDetails")
	public String purchaseDetails(Model model) {
		log.info("PurchaseDetailsController - purchaseDetails()");
			
		return "user/purchaseDetails";
	}
	
}
