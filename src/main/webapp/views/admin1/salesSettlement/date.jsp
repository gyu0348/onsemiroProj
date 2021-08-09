<%@page import="java.text.DecimalFormat"%>
<%@page import="aaa.vo.ReservationVO"%>
<%@page import="java.util.List"%>
<%@page import="aaa.controll.DateCast"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt"  uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<style>
	th,td{padding:10px; text-align:center;}
	div{width:100%;}
	table{width:50%;}
</style>
</head>
<body>
<c:set value="${date1 }" var="dt1"/>
<c:set value="${date2 }" var="dt2"/>


<jsp:include page="../../base/header.jsp" />

<div class="content_wrapper">


<a href="/admin1/sales/year">연 정산</a>
<a href="/admin1/sales/month">월 정산</a>
<a href="/admin1/sales/date">일 정산</a>

	<form  id="form1" method="get">
		<h2>일 정산</h2>
		<p>	
			
		    
		    <input type="text" id="datepicker1" name="date1" autocomplete="off" placeholder = "날짜선택를 선택해주세요." value=${dt1 }> -
	  		<input type="text" id="datepicker2" name="date2" autocomplete="off"  value=${dt2 }>
	   
		    
		    <button type="button" onclick="chkVal()">조회</button> 
		</p>
		
		<div>
			<c:choose>
				<c:when test="${xxx eq '1' }">
					<h3>날짜를 선택해주세요.</h3>
				</c:when>
				<c:otherwise>
					<h3>${date1 }일 ~ ${date2 }일</h3>
					<h4>매출정산</h4>
					
				<c:set var = "total" value = "0" />	
					<table border="">
						<tr>
							<th>일/지점</th>
							<th>서울</th>
							<th>강릉</th>
							<th>전주</th>
							<th>경주</th>
							<th>합계</th>
						</tr>
					
					<%
						List<ReservationVO> sulist = (List<ReservationVO>) request.getAttribute("서울");
						List<ReservationVO> grlist = (List<ReservationVO>) request.getAttribute("강릉");
						List<ReservationVO> jjlist = (List<ReservationVO>) request.getAttribute("전주");
						List<ReservationVO> gjlist = (List<ReservationVO>) request.getAttribute("경주");
						
						DecimalFormat df = new DecimalFormat("###,###");
						int rtotal = 0;
						int sutotal = 0;
						int grtotal = 0;
						int jjtotal = 0;
						int gjtotal = 0;
						
						for(int i=0; i<sulist.size();i++){
							
							int btotal = 
							sulist.get(i).getPrice()+grlist.get(i).getPrice()+jjlist.get(i).getPrice()+gjlist.get(i).getPrice();
							sutotal += sulist.get(i).getPrice();
							grtotal += grlist.get(i).getPrice();
							jjtotal += jjlist.get(i).getPrice();
							gjtotal += gjlist.get(i).getPrice();
											
				 	%>
						
					
						
						<tr>
							<td><%= sulist.get(i).getFirdate() %></td>
							<td><%= df.format(sulist.get(i).getPrice()) %>원</td>
							<td><%= df.format(grlist.get(i).getPrice()) %>원</td>
							<td><%= df.format(jjlist.get(i).getPrice()) %>원</td>
							<td><%= df.format(gjlist.get(i).getPrice()) %>원</td>
							<td><%= df.format(btotal) %>원</td>
						</tr>
						
					<%
						
						rtotal += btotal;
						}
					%>
						<tr>
							<td>합계</td>
							<td><%= df.format(sutotal) %>원</td>
							<td><%= df.format(grtotal) %>원</td>
							<td><%= df.format(jjtotal) %>원</td>
							<td><%= df.format(gjtotal) %>원</td>
							<td><%= df.format(rtotal) %>원</td>
						</tr>
					
					</table>
					
				</c:otherwise>
			</c:choose>
		</div>
	</form>
</div>	
<jsp:include page="../../base/footer.jsp" />

<script>
	$.datepicker.setDefaults({
	    dateFormat: 'yy-mm-dd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear: true,
	    yearSuffix: '년'
	});
	
	$(document).ready(function(){
		$("#datepicker1").datepicker({
			numberOfMonths: 1,
		onSelect: 
			function(selected) {
				$("#datepicker2").datepicker("option","minDate", selected)
			}
		});
	$("#datepicker2").datepicker({
		numberOfMonths: 1,
			onSelect: function(selected) {
				$("#datepicker1").datepicker("option","maxDate", selected)
			}
		});
	});
	function chkVal(){
		var rst1 = document.getElementById('datepicker1').value;
		var rst2 = document.getElementById('datepicker2').value;
		
		
		
		if(rst1 == ""){
			alert('날짜를 선택해주세요.');
		}else if(rst2 == ""){
			alert('날짜를 선택해주세요.');
		}else{
			document.getElementById("form1").submit();
		}
	}
	
</script>
</body>
</html>

