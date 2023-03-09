<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PPIC</title>
<style>
	<!-- 카테고리 css -->
	
	.workcategory{
	    width: 100%;
	    margin-bottom: 30px;
	}
	.workcategory>a{
	    font-size: 20px;
	    font-weight: bold;
	    margin-right: 20px;
	    color: lightgray;
	    text-decoration:none;
	}
	
	.workcategory>a:link {color:lightgray; text-decoration:none;}
    .workcategory>a:visited {color:lightgray; text-decoration:none;}
	.workcategory>a:hover{color: black; text-decoration:none;}
	
	
	.workyear{
		font-size: 18px;
	    font-weight: bold;
        float:right; 
        margin: 30px 0px 0px 0px;
        width:90%;
        height: 50px;
       
	}
	
    table{width:90%;}
	.holiinfo{
	    border:2px solid darkgray;
	    border-radius: 3px;
	    margin: 30px ;
	    margin-left:100px;
	    width:90%;
	    height: 150px;
	}
	
    .holilist{
		width:90%;
		margin-left:100px;
    }
	
</style>
</head>
<body>
	
	<jsp:include page="../common/menubar.jsp" />	
	
	<div class="outer">


        <div id="content" style=" " >

            <div onclick="workback();">
				<h2 style="font-weight:bold">근무</h2>
				    <br>
			</div>
			
			<script>
				function workback(){
					location.href="workMain.wo"
				}
			</script>
           
			<div class="workcategory" style="float:left;" >
                <a href="workList.wo" >출퇴근기록</a>
                <a href="workInfo.wo" >올해근무정보</a>
				<a href="holiInfo.ho" style="color:black;">휴가현황</a>
                <a href="holiApply.ho">휴가신청</a>
                
                
                <!-- 관리자만 보이게 할거임 -->
                <a href="memberWork.wo">구성원근무</a>
                <a href="memberHoli.ho">전사원휴가현황</a>
                <a href="holiGive.ho">휴가지급|회수</a>
                <a href="holiApprove.ho">휴가승인</a>
                
                <br>
            </div>
			
			<br>
	
			<div class="workyear" align="right">
                <a>
                	<img src="resources/icons/left-arrow.png" style="width:20px; margin:1px 3px 3px 3px;">
                </a> 
                2023년 
                <a>
                	<img src="resources/icons/right-arrow.png" style="width:20px; margin:1px 3px 3px 3px;">
                </a>
            </div>
			
			<div class="holiinfo" style="float:left" align="center">
                <table  >
                    <tr height="80px" align="center" >
                        <th width="200px">지급연차</th>
                        <th width="200px">사용연차</th>
                        <th width="200px">남은연차</th>
                    </tr>
                    <tr height="50px" align="center">
                        <td>00일</td>
                        <td>00일</td>
                        <td>00일</td>
                    </tr>
                </table>
            </div>
            
            <div class="holilist" align="center">
                <table border="1" >
                    <tr height="50px" align="center" >
                        <th width="180px">날짜</th>
                        <th width="180px">지급</th>
                        <th width="180px">사용</th>
                        <th width="180px">잔여</th>
                    </tr>
                    <tr height="50px" align="center">
                        <td>2022-02-03</td>
                        <td>00일</td>
                        <td>00일</td>
                        <td>00일</td>
                    </tr>
                    <tr height="50px" align="center">
                        <td>2022-02-03</td>
                        <td>00일</td>
                        <td>00일</td>
                        <td>00일</td>
                    </tr>
                    <tr height="50px" align="center">
                        <td>2022-02-03</td>
                        <td>00일</td>
                        <td>00일</td>
                        <td>00일</td>
                    </tr>
                </table>
            </div>
			 
			
			  

        </div>
    </div>	

</body>
</html>