package bit.it.into.dto;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@NoArgsConstructor
public class BondDto {
	
	private String bond_symbols;
	private String member_num;
	private String total_interest;
	private String bond_company;
	private String bond_price;
	private String bond_date;
	private String coupon_interest_rate;
	private String discount_rate;
	private String gross_price;
	private String maturity_date;
	private String grade;
	
	public String getBond_symbols() {
		return bond_symbols;
	}
	public void setBond_symbols(String bond_symbols) {
		this.bond_symbols = bond_symbols;
	}
	public String getMember_num() {
		return member_num;
	}
	public void setMember_num(String member_num) {
		this.member_num = member_num;
	}
	public String getTotal_interest() {
		return total_interest;
	}
	public void setTotal_interest(String total_interest) {
		this.total_interest = total_interest;
	}
	public String getBond_company() {
		return bond_company;
	}
	public void setBond_company(String bond_company) {
		this.bond_company = bond_company;
	}
	public String getBond_price() {
		return bond_price;
	}
	public void setBond_price(String bond_price) {
		this.bond_price = bond_price;
	}
	public String getBond_date() {
		return bond_date;
	}
	public void setBond_date(String bond_date) {
		this.bond_date = bond_date;
	}
	public String getCoupon_interest_rate() {
		return coupon_interest_rate;
	}
	public void setCoupon_interest_rate(String coupon_interest_rate) {
		this.coupon_interest_rate = coupon_interest_rate;
	}
	public String getDiscount_rate() {
		return discount_rate;
	}
	public void setDiscount_rate(String discount_rate) {
		this.discount_rate = discount_rate;
	}
	public String getGross_price() {
		return gross_price;
	}
	public void setGross_price(String gross_price) {
		this.gross_price = gross_price;
	}
	public String getMaturity_date() {
		return maturity_date;
	}
	public void setMaturity_date(String maturity_date) {
		this.maturity_date = maturity_date;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	

	
}
