<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<title>Home</title>
	<style type="text/css">
		.row {
		  display: -ms-flexbox; /* IE10 */
		  display: flex;
		  -ms-flex-wrap: wrap; /* IE10 */
		  flex-wrap: wrap;
		  margin: 0 -16px;
		  float: left;
		}
		
		.col-25 {
		  -ms-flex: 25%; /* IE10 */
		  flex: 25%;
		}
		
		.col-50 {
		  -ms-flex: 50%; /* IE10 */
		  flex: 50%;
		}
		
		.col-75 {
		  -ms-flex: 75%; /* IE10 */
		  flex: 75%;
		}
		
		.col-25,
		.col-50,
		.col-75 {
		  padding: 0 16px;
		}
		
		.container {
		  padding: 5px 20px 15px 20px;
		  border: 1px solid lightgrey;
		  border-radius: 3px;
		}
		
	</style>
</head>

	<body>
	
		<div class="row">
 		<div class="col-75">
		<div class="container">
			
		<!-- 결제 예정 금액 -->
		<div class="row">
			<div class="title">
				<h3>결제 예정 금액</h3>
			</div>
			<div class="totalArea">
				<div class="summary">
					<table border="1" summary>
						<caption>총 주문 금액 및 결제 예정 금액</caption>

						<tbody>
							<tr>
								<td class="price">
									<div class="box">
										<strong id="total_order_price">62,500</strong>
										<strong class="tail">원</strong>
										<span id="total_order_price_ref" class="tail displaynone"></span>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		

		
			<!-- 결제수단 -->
			<div class="row">		
				<div class="col-50">		
					<div class="title">
						<h3>결제수단</h3>
						<span  class="txtEm gIndent20 displaynon">
							<input type="checkbox" id="save_paymethod" name="save_paymethod" value disabled>
							<label for="save_paymethod">지금 선택한 결제수단을 다음에도 사용</label>
						</span>
					
						<div class="payArea">
							<div class="payment">
								<div class="method">
									<span class="ec-base-label">
										<input id="addr_paymethod1" name="addr_paymethod" fw-filder="isFill" fw-label="결제방식"
										fw-msg value="card" type="radio">
										<label for="addr_paymethod1">카드 결제</label>
									</span>
								</div>
							</div>
						</div>
					</div>				
				</div>
				
				<div class="col-50">			
					<!-- 최종결제금액 -->
					<div class="total">
						<h4>
							<strong id="current_pay_name">카드 결제</strong>
							<span>최종결제 금액</span>
						</h4>
						<p class="price">
							<span></span>
							<input id="total_price" name="total_price" fw-filter="isFill" fw-label="결제금액"
							fw-msg class="inputTypeText" placeholder style="text-align:right;ime-mode:disabled;clear:non;
							border:0px;float:none;" size="10" readonly="1" value="59400" type=text>
							<strong>원</strong>
						</p>
						<p class="paymentAgree" id="chk_purchase_agreement" style="display: none;">
							<input id="chk_purchase_agreement0" name="chk_purchase_agreement" fw-filter
							fw-label="구매진행 동의" fw-msg value="T" type="checkbox" style="display: none;">
							<label for="chk_purchase_agreement0">결제정보를 확인하였으며, 구매진행에 동의합니다.
							</label>
						</p>
						<div class="button">
							<a href="#none">
								<img src="http://www.maybe-baby.co.kr/web/season2_skin/base/btn/btn_payment.png"
								onmouseover="this.src='http://www.maybe-baby.co.kr/web/season2_skin/base/btn/btn_payment_over.png'"
								onmouseout="this.src=http://www.maybe-baby.co.kr/web/season2_skin/base/btn/btn_payment.png"
								id="btn_payment" alt="결제하기" title>
							</a>
						</div>  
					</div>				
				</div>			
			</div>
		
		</div>
		</div>
		</div>
		
	</body>
</html>
