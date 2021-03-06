<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html lang="zxx">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<title>SINSA</title>
<style type="text/css">
.shoping__cart__table tr:first-child, .checkout__form .borderTop {
	border-top: 1.5px solid #7FAD39;
}
.checkout__form .borderTop {
	padding-top: 30px;
}
.shoping__cart__table .tableHead h5, .checkout__form h5 {
	line-height: 36.8px;
}
.checkout__form .row label span {
	color: #dd2222;
}
.checkout__form .row label {
	line-height: 46px;
}
.checkout__form .checkout__order {
	position: -webkit-sticky;
	position: sticky;
	top: 20px;
	font-family: adihaus;
}
.checkout__input input[type="radio"] {
	width: 20px;
	height: 20px; vertical-align : middle;
	margin-top: -3px;
	border-radius: 10px;
	background: none;
	border: 0;
	box-shadow: inset 0 0 0 1px #9F9F9F;
	box-shadow: inset 0 0 0 1.5px #9F9F9F;
	appearance: none;
	padding: 0;
	margin: 0;
	transition: box-shadow 150ms cubic-bezier(0.95, 0.15, 0.5, 1.25);
	pointer-events: none;
	vertical-align: middle;
}
.checkout__input input[type="radio"]:focus {
	outline: none;
}
.checkout__input input[type="radio"]:checked {
	box-shadow: inset 0 0 0 6px #7fad39;
}
.checkout__input input[type="radio"] ~ span {
	color: #111111;
	display: inline-block;
	line-height: 20px;
	padding: 0 8px;
}
.checkout__input .radioLabel {
	padding: 6px;
	border-radius: 50px;
	display: inline-flex;
	cursor: pointer;
	transition: background 0.2s ease;
	margin: 8px 0;
	-webkit-tap-highlight-color: transparent;
}
.checkout__input .radioLabel:hover, .checkout__input .radioLabel:focus-within
{
	background: rgba(159, 159, 159, 0.1);
}
button[onclick="findAddr()"]{
	height: 38px;
	font-size:14px;
}
input:read-only{
	background-color: #F7F7F7;
}
.checkout__order .points {
	position: relative;
}
.checkout__order .points input {
	width: 120px;
	height: 38px;
	padding-right: 22px;
	position: absolute;
	color: #6f6f6f;
	right: 0;
	border: 1px solid #d5d5d5;
	font-size: 16px;
	color: #b2b2b2;
	border-radius:4px;
}
.checkout__order .points input ~ span {
	position: absolute;
	right: 10px;
}
.avPoint{
	color: #dd2222;
}
.shoping__cart__price .discntNum{
	text-decoration: line-through;
	color: #999;
	font-family: adihaus;
}
.numFont{
	font-family: adihaus;
}
.shoping__cart__item img{
	width: 120px;
	height: 120px;
}
/* Chrome, Safari, Edge, Opera */
input::-webkit-outer-spin-button,
input::-webkit-inner-spin-button{
  -webkit-appearance: none;
  margin: 0;
}
/* Firefox */
input[type=number] {
  -moz-appearance: textfield;
}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<!-- IamPort -->
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<jsp:include page="../header.jsp" />
	<!-- Checkout Section Begin -->
	<section class="checkout spad">
		<div class="container">
			<h4 class="mb-5 font-weight-bold">??????/??????</h4>
			<div class="row">
				<div class="col-lg-12 shoping__cart__table">
					<table id="itemList" class="mx-auto px-0">
						<thead>
							<span class="tableHead row mx-auto px-0 mb-2">
								<h5>???????????????</h5>						
								<button id="editOrder" onclick="location.href='/product/prdCode=${prdInfo[0].PRD_CODE}';"
								class="ml-auto p-2 primary-btn cart-btn cart-btn-right">???????????? ??????</button>
							</span>
						</thead>
						<tbody>
						
						<c:if test="${not empty prdInfo}">
						    <c:forEach items="${prdInfo}" var="lists">
						    <tr class="prdItem">
								<td class="shoping__cart__item"><span
									class="row mx-auto px-0"> <span> <img
											src="${pageContext.request.contextPath}/upload\prdImg/${lists.PRD_CODE}.png"
											alt="${lists.PRD_NAME}_image">
									</span> 
									<span class="my-auto"> 
										<b class="mb-1 ORDER_PRDNAME">${lists.PRD_NAME}<small class="pl-1 prdCode">${lists.PRD_CODE}</small></b>
										<p class="mb-0">${lists.PRD_BRAND}</p>
										<p class="mb-0"><span class="qty-size">${lists.ORDER_PRDSIZE}</span> / ${lists.PRD_COLOR}</p>
									</span>
								</span></td>
								<td class="shoping__cart__price">
									<c:set var="orgPrice" value="${lists.PRD_PRICE}"/>
									<c:if test="${lists.PRD_DISRATE == 0}">
										<c:set var="finalPrice" value="${lists.PRD_PRICE}"/>
										<span class="digits orgPrice" data-orgPrice ="${lists.PRD_PRICE}" >${finalPrice}???</span>
									</c:if>
									
									<c:if test="${lists.PRD_DISRATE != 0}">
										<c:set var="finalPriceOrg" 
										value="${lists.PRD_PRICE-(lists.PRD_PRICE*(lists.PRD_DISRATE/100))}"/>
			  							<c:set var="finalPrice" value="${fn:substringBefore(finalPriceOrg, '.')}" />
			  							<span class="mb-0 digits orgPrice discntNum numFont" data-orgPrice ="${lists.PRD_PRICE}">${lists.PRD_PRICE}???</span>
										<span class="mb-0 font-weight-bold digits numFont discntNumCk">${finalPrice}???</span>
									</c:if>
								</td>
								<td class="shoping__cart__quantity">
									<p class="mb-1">
										??????:<span class="amountNum amount">${lists.ORDER_AMOUNT}</span>
									</p> <b class="mb-0">????????????</b>
								</td>
								<td class="shoping__cart__total numFont digits" data-value="ORDER_PRICE">${finalPrice*lists.ORDER_AMOUNT}???</td>
							</tr>
							</c:forEach>
						</c:if>
						</tbody>
					</table>
				</div>
			</div>
			<div class="checkout__form">
				<form action="/direct/checkout">
					<div class="row mx-auto px-0">
						<div class="col-lg-8 col-md-6">
							<h5 class="mb-2">???????????????</h5>
							<div class="row borderTop">
								<label for="CUS_NAME" class="col-lg-3">??????<span
									class="inpReq">*</span></label>
								<div class="checkout__input col-lg-6">
									<span><input id="CUS_NAME" name="CUS_NAME" type="text"
										maxlength="49" required="required" value="${cusInfo.CUS_NAME}" readonly/></span>
								</div>
							</div>
							<div class="row">
								<label for="CUS_TEL" class="col-lg-3 telNum">????????? ??????<span
									class="inpReq">*</span></label>
								<div class="checkout__input col-lg-6">
									<span><input id="CUS_TEL" name="CUS_TEL" type="tel"
										maxlength="11" required="required" value="${cusInfo.CUS_TEL}" readonly/></span>
								</div>
							</div>
							<div class="row">
								<label for="CUS_EMAIL" class="col-lg-3">?????????<span
									class="inpReq">*</span></label>
								<div class="checkout__input col-lg-6">
									<span><input id="CUS_EMAIL" name="CUS_EMAIL"
										type="email" maxlength="100" required="required" value="${cusInfo.CUS_EMAIL}" readonly/></span>
								</div>
							</div>
							<h5 class="my-2">??????????????????</h5>
							<div class="row borderTop">
								<label for="CUS_DELIV_ADDR" class="col-lg-3">????????? ??????<span
									class="inpReq">*</span></label>
								<div class="checkout__input col-lg-6">
									<label for="defaultDeliv" class="radioLabel"> <input
										type="radio" id="defaultDeliv" name="delivAddr"
										value="default" checked> <span>???????????? ??????</span>
									</label> <label for="newDeliv" class="radioLabel"> <input
										type="radio" id="newDeliv" name="delivAddr" value="new" /> <span>????????????</span>
									</label>
								</div>
							</div>
							<div class="row">
								<label for="ORDER_RECEIVER" class="col-lg-3">??????<span
									class="inpReq">*</span></label>
								<div class="checkout__input col-lg-6">
									<span><input id="ORDER_RECEIVER" class="newDelivInput" name="ORDER_RECEIVER"
										type="text" maxlength="49" required="required" value="${cusInfo.CUS_NAME}" readonly/></span>
								</div>
							</div>
							<div class="row">
								<label for="ORDER_TEL" class="col-lg-3">????????? ??????<span
									class="inpReq">*</span></label>
								<div class="checkout__input col-lg-6">
									<span><input id="ORDER_TEL" class="newDelivInput" name="ORDER_TEL" type="tel"
										maxlength="11" required="required" value="${cusInfo.CUS_TEL}" readonly/></span>
								</div>
							</div>
							<input type="hidden" id="isCart" value="${isCart}"/>
							<c:set var="getAddr" value="${fn:split(cusInfo.CUS_ADDR, '|')}" />
							<c:set var="delivAddrExtra" value="${getAddr[fn:length(getAddr)-1]}" />
							<c:set var="delivAddrJibun" value="${getAddr[fn:length(getAddr)-2]}" />
							<c:set var="delivAddrRoad" value="${getAddr[fn:length(getAddr)-3]}" />
							<c:set var="zip" value="${getAddr[fn:length(getAddr)-4]}" />
							<c:set var="zip" value="${fn:replace(zip, '(', '')}" />
							<c:set var="delivAddrZip" value="${fn:replace(zip, ')', '')}" />
							<div class="row">
								<label for="delivAddrZip" class="col-lg-3">??????<span
									class="inpReq">*</span></label>
								<div class="checkout__input col-lg-3">
									<span><input type="text" id="delivAddrZip" class="newDelivInput"
										placeholder="????????????" title="????????????" required="required" data-zip="${delivAddrZip}" value="${delivAddrZip}" readonly/></span>
								</div>
								<button type="button" class="col-lg-2 text-center btn btn-secondary" onclick="findAddr()">???????????? ??????</button>
							</div>
							<div class="row">
								<div class="checkout__input col-lg-9 offset-lg-3">
									<span><input type="text" id="delivAddrRoad" class="newDelivInput"
										placeholder="" title="????????????" required="required" data-road="${delivAddrRoad}" value="${delivAddrRoad}" readonly/></span>
								</div>
							</div>
							<div class="row">
								<div class="checkout__input col-lg-9 offset-lg-3">
									<span>
										<input type="hidden" id="delivAddrJibun" class="newDelivInput" data-jibun="${delivAddrJibun}" value="${delivAddrJibun}"/>
										<input type="text" id="delivAddrExtra" class="newDelivInput" data-extra="${delivAddrExtra}" value="${delivAddrExtra}" title="????????????" placeholder="??????????????? ??????????????????."/>
									</span>
									<span id="guide" style="color:#999;display:none"></span>
								</div>
							</div>
							<div class="row">
								<label for="ORDER_MEMO" class="col-lg-3">????????? ????????????
								</label>
								<div class="checkout__input wrapper col-lg-9">
									<select id="delivMemo" data-display="select" class="mb-2 wide" title="????????? ????????????">
										<option selected="selected" disabled>?????? ??? ???????????????
											??????????????????.</option>
										<option value="opt01">????????? ???????????? ???????????????.</option>
										<option value="opt02">????????? ????????? ???????????????.</option>
										<option value="opt03">???????????? ???????????????.</option>
										<option value="opt04">?????? ?????? ???????????????.</option>
										<option value="write">????????????</option>
									</select>
									<span>
										<input id="ORDER_MEMO" name="ORDER_MEMO"
										type="text" maxlength="40" placeholder="??????????????? 40??? ????????? ??????????????????."
										 readonly="readonly" autocomplete="off"/>
									</span>
								</div>
							</div>
						</div>
						<div class="col-lg-4 col-md-6">
							<div class="checkout__order">
								<h4>????????????</h4>
								<ul>
									<li>??? ?????? ??????<span>???</span><span class="totalOrgPrice digits">-</span></li>
									<li>??????<span>???</span><span class="totalDiscnt digits">-</span></li>
									<li class="points">????????? ?????? <input type="number" placeholder="0" class="text-right usePoint" name="ORDER_USEPOINT"></input><span>P</span>
									<p class="mb-1"><small>??????????????? ?????????: <span>P</span><span class="avPoint digits hasPoint" data-hasPoint = "${cusInfo.CUS_POINT}">${cusInfo.CUS_POINT}</span></small></p>
									</li>
									<li>????????? <span>??????</span></li>
								</ul>
								<div class="checkout__order__total my-2 pb-0 pt-3">
									??? ????????????
									<span class="text-right">
										<span class="totalPriceCon-num float-left digits">-</span>
										<span>???</span>
									</span>
								</div>
								<small class="float-right mb-4">?????? ????????? <span class="avPoint savePoint digits">-</span>P ????????????</small>
								<button type="button" id="chckoutBtn" class="site-btn">????????????</button>
								<script type="text/javascript">
								$("#chckoutBtn").click(function () {
									<%if(session.getAttribute("user") == null){%>
										var result = alert("?????? ????????? ?????????????????????. ?????? ??????????????????.");
										window.history.back();
										return false;
									<%}%>
									var isCart = $("#isCart").val();
									var ORDER_NUM = new Date().getTime();
									var ORDER_PRDCODE = $(".prdCode").map(function() {
									    return $(this).text();
									}).get();
									var ORDER_PRDSIZE = $(".qty-size").map(function() {
									    return $(this).text();
									}).get();
									var ORDER_AMOUNT = $('.amount').map(function() {
									    return $(this).text();
									}).get();
									var ORDER_TEL = $("input[name=ORDER_TEL]").val();
									var ORDER_MEMO = $("input[name=ORDER_MEMO]").val();
									if(ORDER_MEMO == ""){
										ORDER_MEMO = null;
									}
									var ORDER_RECEIVER = $("input[name=ORDER_RECEIVER]").val();
									var ORDER_USEPOINT = $("input[name=ORDER_USEPOINT]").val();
									if(ORDER_USEPOINT == "") ORDER_USEPOINT = 0;
									var ORDER_ADDR = $("#delivAddrZip").val() + "|" +$("#delivAddrRoad").val() + "|" + $("#delivAddrJibun").val() +"|"+$("#delivAddrExtra").val();
									var IMP = window.IMP; // ????????????
							        IMP.init('imp39263192');
							        var msg;
							        var finalPrice = $(".totalPriceCon-num").text().replace(',', '');
							        var data = {};
									var itemList = [];
									for(var i=0; i<ORDER_AMOUNT.length; i++){
										data = {};
										data["ORDER_PRDCODE"] = ORDER_PRDCODE[i];
										data["ORDER_PRDSIZE"] = ORDER_PRDSIZE[i];
										data["ORDER_AMOUNT"] = ORDER_AMOUNT[i];
										
										data["ORDER_NUM"] = ORDER_NUM;
										data["ORDER_MEMO"] = ORDER_MEMO;
										data["ORDER_TEL"] = ORDER_TEL;
										data["ORDER_RECEIVER"] = ORDER_RECEIVER;
										data["ORDER_USEPOINT"] = ORDER_USEPOINT;
										data["ORDER_ADDR"] = ORDER_ADDR;
										data["isCart"] = isCart;
										itemList.unshift(data);
									}
							        IMP.request_pay({
							        	pg : 'inicis',
							            pay_method : 'card',
							            merchant_uid : ORDER_NUM,
							            name : '[SINSA ?????? ?????? ]',
							            amount : finalPrice,
							            buyer_email : '${cusInfo.CUS_EMAIL}',
							            buyer_name : '${cusInfo.CUS_NAME}',
							            buyer_tel : '${cusInfo.CUS_TEL}',
							            buyer_addr : "${fn:substringAfter(cusInfo.CUS_ADDR, '|')}",
							            buyer_postcode : "${fn:substringBefore(cusInfo.CUS_ADDR, '|')}",
							            m_redirect_url: "/checkout/complete"
							        }, function(rsp) {
							            if (rsp.success){
							            	$.ajax({
							            		url: "/checkout/process",
							            		type: 'POST',
							            		data: JSON.stringify(itemList),
							            		headers: {
												      'Accept': 'application/json',
												      'Content-Type': 'application/json'

												}
							            	}).done(function(data) {
							            			msg = '????????? ?????????????????????.';
							                        msg += '\n??????ID : ' + rsp.imp_uid;
							                        msg += '\n?????? ??????ID : ' + rsp.merchant_uid;
							                        msg += '\?????? ?????? : ' + rsp.paid_amount;
							                        msg += '?????? ???????????? : ' + rsp.apply_num;
							                        msg += '????????? : ' + rsp.buyer_email;
							                        msg += '?????? : ' + rsp.buyer_name;
							                        msg += '???????????? : ' + rsp.buyer_tel;
							                        msg += '?????? : ' + rsp.buyer_addr + rsp.buyer_postcode;
							       					//alert(msg);
							            	});
											location.href="/checkout/complete/orderNo="+ORDER_NUM;
							            } else {
							            	msg = '????????? ?????????????????????.';
							                msg += '???????????? : ' + rsp.error_msg;
							                alert(msg);
							            }
						        	});
								});
								</script>
							</div>
						</div>
					</div>
				</form>
			</div>
		</div>
	</section>
	<!-- Checkout Section End -->

	<!-- Footer Section Begin -->
	<jsp:include page="../footer.jsp" />
	<!-- Footer Section End -->
	<script
		src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function() {
		var isCart = $("#isCart").val();
		if(isCart === "true"){
			$("#editOrder").click(function(){
			  document.location.href = "/cart.do";
			});
		}
		$('#delivMemo').niceSelect();
		var selected = $("#delivMemo").val();
		$('#delivMemo').on('change', function() {
			selected = $("#delivMemo").val();
			$("#ORDER_MEMO").val($("#delivMemo option:selected").text());
			if(selected == "write"){
				$("#ORDER_MEMO").val('');
				$("#ORDER_MEMO").removeAttr('readonly');
			}	
		});
		function numberWithDigits() {
			$(".digits").each(function() {
				$(this).text( $(this).text().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
			});
		}
		function noDigits() {
			$(".digits").each(function() {
				$(this).text( $(this).text().replaceAll(',', ''));
			});
		}
			// ??? ?????? ??????
			var totalPriceNoDiscnt = 0 
			$('.orgPrice').each(function (index, item) {
				totalPriceNoDiscnt += parseInt($(this).text())*parseInt($(this).parents("tr").find(".amountNum").text());
			});
			$(".totalOrgPrice").text(totalPriceNoDiscnt);
			
			//??? ?????? ??????
			var totalPriceCon_num = 0;
			$('.orgPrice').each(function (index, item) {
				if($(this).siblings("span").hasClass("discntNumCk")){
					totalPriceCon_num += parseInt($(this).siblings($("span.discntNumCk")).text())*parseInt($(this).parents("tr").find(".amountNum").text());
				}
				else{
					totalPriceCon_num += parseInt($(this).text())*parseInt($(this).parents("tr").find(".amountNum").text());
				}
			});
			$(".totalPriceCon-num").text(totalPriceCon_num);
			
			//??????
			var totalDiscnt = 0;
			totalDiscnt = totalPriceNoDiscnt - totalPriceCon_num;
			$(".totalDiscnt").text(totalDiscnt);
			
			//???????????? init
 			$(".savePoint").text(parseInt(((totalPriceCon_num*0.03)/10),10)*10);
			
			$(".usePoint").on("propertychange change keyup paste input",function() {
				//???????????????
				usePoint = $(".usePoint").val();
				//?????? Point?????? ??? ????????? alert
				if(parseInt($(".hasPoint").attr("data-hasPoint")) < parseInt(usePoint)){
					alert("??????????????? ???????????? ?????????????????????.");
					$(".usePoint").val('');
					return false;
				}
				//??? ????????????
				totalPriceCon_num = $(".totalOrgPrice").text().replaceAll(',', '') - $(".totalDiscnt").text().replaceAll(',', '') - usePoint ;
				//?????? ???????????? ??? ?????????????????? ?????? ??? alert
				if(parseInt(totalPriceCon_num) < parseInt(usePoint)){
					alert("????????? ???????????? ?????? ????????? ?????????????????????.");
					$(".usePoint").val('');
					totalPriceCon_num = $(".totalOrgPrice").text().replaceAll(',', '') - $(".totalDiscnt").text().replaceAll(',', '')
				}
				$(".totalPriceCon-num").text(totalPriceCon_num);
				numberWithDigits();
			});
		
		$(".usePoint").on("keydown",function(e) {
			if (!((e.keyCode > 95 && e.keyCode < 106)
					|| (e.keyCode > 47 && e.keyCode < 58) || e.keyCode == 8)) {
				return false;
			}
		});
		
		numberWithDigits();
		
		//????????????
		$(".totalPriceCon-num").on('DOMSubtreeModified', function () {
			$(".savePoint").text(parseInt(((totalPriceCon_num*0.03)/10),10)*10);
		});
		
		$('input[type=radio]').on('change', function() {
			var chckdRadio = $('input[type=radio]:checked').val();
			if(chckdRadio == "default"){
				$('#ORDER_RECEIVER, #ORDER_TEL').prop('readonly', true);
				$("#ORDER_RECEIVER").val($("#CUS_NAME").val());
				$("#ORDER_TEL").val($("#CUS_TEL").val());
				$("#delivAddrZip").val($("#delivAddrZip").data("zip"));
				$("#delivAddrRoad").val($("#delivAddrRoad").data("road"));
				$("#delivAddrJibun").val($("#delivAddrJibun").data("jibun"));
				$("#delivAddrExtra").val($("#delivAddrExtra").data("extra"));
			} else if(chckdRadio == "new"){
				$('input.newDelivInput').val('');
				$('#ORDER_RECEIVER, #ORDER_TEL').removeAttr('readonly');
			}
	 	});
	});
		
	function findAddr() {
		new daum.Postcode(
				{
					oncomplete : function(data) {
						var roadAddr = data.roadAddress; // ????????? ?????? ??????
						var extraRoadAddr = ''; // ?????? ?????? ??????

						// ??????????????? ?????? ?????? ????????????. (???????????? ??????)
						// ???????????? ?????? ????????? ????????? "???/???/???"??? ?????????.
						if (data.bname !== '' && /[???|???|???]$/g.test(data.bname)) {
							extraRoadAddr += data.bname;
						}
						// ???????????? ??????, ??????????????? ?????? ????????????.
						if (data.buildingName !== '' && data.apartment === 'Y') {
							extraRoadAddr += (extraRoadAddr !== '' ? ', '
									+ data.buildingName : data.buildingName);
						}
						// ????????? ??????????????? ?????? ??????, ???????????? ????????? ?????? ???????????? ?????????.
						if (extraRoadAddr !== '') {
							extraRoadAddr = ' (' + extraRoadAddr + ')';
						}

						// ??????????????? ?????? ????????? ?????? ????????? ?????????.
						document.getElementById('delivAddrZip').value = data.zonecode;
						document.getElementById("delivAddrRoad").value = roadAddr;
						document.getElementById("delivAddrJibun").value = data.jibunAddress;

						// ???????????? ???????????? ?????? ?????? ?????? ????????? ?????????.
						if (roadAddr !== '') {
							document.getElementById("delivAddrExtra").value = extraRoadAddr;
						} else {
							document.getElementById("delivAddrExtra").value = '';
						}

						var guideTextBox = document.getElementById("guide");
						// ???????????? '?????? ??????'??? ????????? ??????, ?????? ???????????? ????????? ?????????.
						if (data.autoRoadAddress) {
							var expRoadAddr = data.autoRoadAddress
									+ extraRoadAddr;
							guideTextBox.innerHTML = '(?????? ????????? ?????? : '
									+ expRoadAddr + ')';
							guideTextBox.style.display = 'none';

						} else if (data.autoJibunAddress) {
							var expJibunAddr = data.autoJibunAddress;
							guideTextBox.innerHTML = '(?????? ?????? ?????? : '
									+ expJibunAddr + ')';
							guideTextBox.style.display = 'none';
						} else {
							guideTextBox.innerHTML = '';
							guideTextBox.style.display = 'none';
						}
					}
				}).open();
	}
	</script>
</body>

</html>