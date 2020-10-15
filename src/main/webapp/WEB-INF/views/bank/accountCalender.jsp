<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
  <link href="https://fonts.googleapis.com/css?family=Roboto&display=swap" rel="stylesheet">
</head>
<Style>
	.content-wrap{
		width:704px;
		border: 1px solid #000;
		display:flex;
		height: 400px;
	}
	
	.content-left{
		width:350px;
		border: 1px solid #ddd;
	}
	
	.content-right{
		width:350px;
		border: 1px solid #ddd;
	}
	
</Style>

<script>
	var data=${data};
	var day = [];
	for(var i=0; i<data.length; i++){
		day.push(data[i].date);
	}
	
	var income = [];
	for(var i=0; i<data.length; i++){
		income.push(data[i].incomeAmt);
	}
	
	var expense = [];
	for(var i=0; i<data.length; i++){
		expense.push(data[i].expenseAmt);
	}
</script>

<body>
	<div class="main">
    <div class="content-wrap">
      <div class="content-left">
        <div class="main-wrap">
          <div id="main-day" class="main-day"></div>
          <div id="main-date" class="main-date"></div>
        </div>
        <div id="trans-wrap">
          <div class="trans-title">오늘의 내역</div>
          <div class="trans-wrap">
            <div id="income-list" class="income-list"></div>
            <div id="expense-list" class="expense-list"></div>
          </div>
        </div>
      </div>
      
      <div class="content-right">
        <table id="calendar" align="center">
          <thead>
            <tr class="yearMonth">
              <td>
                <label id="prev" onclick="prev()">
                    &#60;
                </label>
              </td>
              <td align="center" id="current-year-month" colspan="5"></td>
              <td>
                <label id="next" onclick="next()">
                    &#62;
                </label>
              </td>
            </tr>
            <tr>
                <td class = "sun" align="center">Sun</td>
                <td align="center">Mon</td>
                <td align="center">Tue</td>
                <td align="center">Wed</td>
                <td align="center">Thu</td>
                <td align="center">Fri</td>
                <td class= "sat" align="center">Sat</td>
              </tr>
          </thead>
          <tbody id="calendar-body" class="calendar-body"></tbody>
        </table>
      </div>
    </div>
  </div>
</body>

<script>
	var currentTitle = document.getElementById('current-year-month');
	var calendarBody = document.getElementById('calendar-body');
	var today = new Date();
	var first = new Date(today.getFullYear(), today.getMonth(),1);
	var dayList = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
	var monthList = ['January','February','March','April','May','June','July','August','September','October','November','December'];
	var leapYear=[31,29,31,30,31,30,31,31,30,31,30,31];
	var notLeapYear=[31,28,31,30,31,30,31,31,30,31,30,31];
	var pageFirst = first;
	var pageYear;
	
	var transList=${data};
	console.log(transList);
	
	if(first.getFullYear() % 4 === 0){
	    pageYear = leapYear;
	}else{
	    pageYear = notLeapYear;
	}
	
	function showCalendar(){
	    let monthCnt = 100;
	    let cnt = 1;
	    
	    for(var i = 0; i < 6; i++){
	        var $tr = document.createElement('tr');
	        $tr.setAttribute('id', monthCnt);   
	        for(var j = 0; j < 7; j++){
	            if((i === 0 && j < first.getDay()) || cnt > pageYear[first.getMonth()]){
	                var $td = document.createElement('td');
	                $tr.appendChild($td);     
	            }else{
	                var $td = document.createElement('td');
	                $td.textContent = cnt;
	                $td.setAttribute('id', cnt);                
	                $tr.appendChild($td);
	                
	                cnt++;
	            }
	            
	        }
	        monthCnt++;
	        calendarBody.appendChild($tr);
	    }
	}
	showCalendar();
	
	function removeCalendar(){
	    let catchTr = 100;
	    for(var i = 100; i< 106; i++){
	        var $tr = document.getElementById(catchTr);
	        $tr.remove();
	        catchTr++;
	    }
	}
</script>

<script>
	function showMain(){
		var mainTodayDay = document.getElementById("main-day");
		var mainTodayDate = document.getElementById("main-date");
	    mainTodayDay.innerHTML = dayList[today.getDay()];
	    mainTodayDate.innerHTML = today.getDate();
	    
	    for(var i=0; i<data.length; i++){
	    	if(today.getDate() == data[i].date){
	    		var todayIn = document.getElementById("income-list");
	    		todayIn.innerHTML = "수입: ";
	    		todayIn.innerHTML += data[i].incomeAmt;
	    		todayIn.innerHTML += "원";
	    		
	    		var todayOut = document.getElementById("expense-list");
	    		todayOut.innerHTML = "지출: ";
	    		todayOut.innerHTML += data[i].expenseAmt;
	    		todayOut.innerHTML += "원";
	    	}
	    }	
	}
	
	var clickedDate1 = document.getElementById(today.getDate());
	clickedDate1.classList.add('active');
	var prevBtn = document.getElementById('prev');
	var nextBtn = document.getElementById('next');
	prevBtn.addEventListener('click',prev);
	nextBtn.addEventListener('click',next);
	var tdGroup = [];
	function clickStart(){
	    for(let i = 1; i <= pageYear[first.getMonth()]; i++){
	        tdGroup[i] = document.getElementById(i);
	        tdGroup[i].addEventListener('click',changeToday);
	    }
	}
	function changeToday(e){
	    for(let i = 1; i <= pageYear[first.getMonth()]; i++){
	        if(tdGroup[i].classList.contains('active')){
	            tdGroup[i].classList.remove('active');
	        }
	    }
	    clickedDate1 = e.currentTarget;
	    clickedDate1.classList.add('active');
	    today = new Date(today.getFullYear(), today.getMonth(), clickedDate1.id);
	    showMain();
	    keyValue = today.getFullYear() + '' + today.getMonth()+ '' + today.getDate();
	}
</script>

<script>
	function prev(){
	    const $divs = document.querySelectorAll('#input-list > div');
	    $divs.forEach(function(e){
	      e.remove();
	    });
	    const $btns = document.querySelectorAll('#input-list > button');
	    $btns.forEach(function(e1){
	      e1.remove();
	    });
	    if(pageFirst.getMonth() === 1){
	        pageFirst = new Date(first.getFullYear()-1, 12, 1);
	        first = pageFirst;
	        if(first.getFullYear() % 4 === 0){
	            pageYear = leapYear;
	        }else{
	            pageYear = notLeapYear;
	        }
	    }else{
	        pageFirst = new Date(first.getFullYear(), first.getMonth()-1, 1);
	        first = pageFirst;
	    }
	    today = new Date(today.getFullYear(), today.getMonth()-1, today.getDate());
	    currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;'+ first.getFullYear();
	    removeCalendar();
	    showCalendar();
	    showMain();
	    clickedDate1 = document.getElementById(today.getDate());
	    clickedDate1.classList.add('active');
	    clickStart();
	}
	
	function next(){
	    const $divs = document.querySelectorAll('#input-list > div');
	    $divs.forEach(function(e){
	      e.remove();
	    });
	    const $btns = document.querySelectorAll('#input-list > button');
	    $btns.forEach(function(e1){
	      e1.remove();
	    });
	    if(pageFirst.getMonth() === 12){
	        pageFirst = new Date(first.getFullYear()+1, 1, 1);
	        first = pageFirst;
	        if(first.getFullYear() % 4 === 0){
	            pageYear = leapYear;
	        }else{
	            pageYear = notLeapYear;
	        }
	    }else{
	        pageFirst = new Date(first.getFullYear(), first.getMonth()+1, 1);
	        first = pageFirst;
	    }
	    today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
	    currentTitle.innerHTML = monthList[first.getMonth()] + '&nbsp;&nbsp;&nbsp;&nbsp;'+ first.getFullYear();
	    removeCalendar();
	    showCalendar(); 
	    showMain();
	    clickedDate1 = document.getElementById(today.getDate());
	    clickedDate1.classList.add('active');  
	    clickStart();
	}
</script>

</body>
</html>