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
	
	/* content */
	.holydaycotegory>a{
	    font-size: 18px;
	    font-weight: bold;
	    margin-right: 20px;
	    color: lightgray;
	    text-decoration:none;
	}
	
	.holydaycotegory>a:link {color:lightgray; text-decoration:none;}
    .holydaycotegory>a:visited {color:lightgray; text-decoration:none;}
	.holydaycotegory>a:hover{color: black; text-decoration:none;}
        
	.pro{
        width: 50px;
        height: 50px;
        background: rgb(111, 80, 248);
        color: white;
        border: none;
        border-radius: 10px;
        padding-top: 13px;
        margin-left:5px
    }
    
    .proname{
    	float:left; 
    	margin-top: 10px; 
    	margin-left: 10px; 
    	font-size: 20px; 
    	font-weight: bold;"
    }
	
	.holyin{ margin: 50px 50px 50px 50px;}
    .holyday thead th{ font-size: 18px;}
    
    #holyday {overflow:auto; height:400px;}
    #holyday::-webkit-scrollbar { width: 8px; }
	#holyday::-webkit-scrollbar-thumb {background: lightgray; border-radius: 10px;}
	
	#holyday td {font-size: 20px;}
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
					location.href="workMain.wo?no="+${loginUser.userNo }
				}
			</script>
           
            <div class="workcategory" style="float:left;" >
                <a href="workList.wo?no=${loginUser.userNo }" >출퇴근기록</a>
				<a href="holiInfo.ho?no=${loginUser.userNo }" >휴가현황</a>
                <a href="holiApply.ho?no=${loginUser.userNo }">휴가신청</a>
                
                
                <br>
            </div>
			<div class="workcategory mworkcategory">
				<!-- 관리자만 보이게 할거임 -->
				<a href="memberWork.wo">구성원근무</a>
				<a href="memberHoli.ho" style="color:black;">전사원휴가현황</a>
				<a href="holiGive.ho">휴가지급|회수</a>
				<a href="holiApprove.ho">휴가승인</a>
			</div> 
            
            
            <script>
				$(function(){
	        		
	        		$(".mworkcategory").hide();
	        		
	        		var a = "${loginUser.authorityNo}";
	        		
	
	        		if (a.includes('2') || a.includes('0')) {
	        			$(".mworkcategory").show();
	       			} else {
	       				
	       			}
	        	})
			</script>
			
			<br>
			<br><br>
	
			<div class="holydayList">
			
				<div class="holydaycotegory">
                    <a href="memberHoli.ho" style="color:black" >휴가보유현황</a>
                    <a href="memberHoliUse.ho">휴가사용내역</a>
                    
                    
                </div>

                
                
                <div class="holyin">
                    <div>
                    	<table style="width:100%;">
	                        <thead>
	                            <tr align="center" style="font-size:18px; width:100%;">
	                                <th width="15%" align="left">이름</th>
	                                <th width="20%">기본지급</th>
	                                <th width="20%">추가지급</th>
	                                <th width="20%">차감</th>
	                                <th width="20%">잔여</th>
	                            </tr>
	                        </thead>
                    	</table>
                    </div>
                    <hr>
                    <div id="holyday" >
                    	<table  style="width:100%;">
	                        <tbody>
	                            <c:forEach var="h" items="${ list }" >
		                            <tr id="holyday" style="height :60px;" align="center">
			                                <td width="15%" >
												<div class="bno" style="display:none;">${ h.userNo}</div>
												<div class="pro" style="float:left; font-size:15px;" >${ h.userName }</div>
												<div class="proname" >${ h.userName }</div>
			                                </td>
			                                <td width="20%">+${ h.giveDay }</td>
			                                <td width="20%">${ h.addDay }</td>
			                                <td width="20%">${ h.useDay }</td>
			                                <td width="20%">${ h.giveDay + h.addDay + h.useDay }</td>
	                            	</tr>
	                            </c:forEach>
	                        </tbody>   
                    </table>
                    </div>
            
                </div>
				
			</div>
			
			
			  

        </div>
    </div>	
	
</body>
</html>