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
	.holidaycotegory>a{
	    font-size: 18px;
	    font-weight: bold;
	    margin-right: 20px;
	    color: lightgray;
	    text-decoration:none;
	}
	
	.holidaycotegory>a:link {color:lightgray; text-decoration:none;}
    .holidaycotegory>a:visited {color:lightgray; text-decoration:none;}
	.holidaycotegory>a:hover{color: black; text-decoration:none;}
        
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
	
	.holiin{
        margin: 50px 50px 50px 50px;
    }
        
    .holiday thead th{
        font-size: 18px;
    }
    
    #holiday {overflow:auto; height:400px;}
    #holiday::-webkit-scrollbar { width: 8px; }
	#holiday::-webkit-scrollbar-thumb {background: lightgray; border-radius: 10px;}
	
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
	
			<div class="holidayList">
			
				<div class="holidaycotegory">
                    <a href="memberHoli.ho">휴가보유현황</a>
                    <a href="memberHoliUse.ho" style="color:black">휴가사용내역</a>
                    
                    <div style="float:right; margin-right:20px;">
						
					</div>
			
					<div style="float:right; margin-right:10px;">
						
					</div>
                </div>

                
                
                <div class="holiin">
                    <div>
                    	<table style="width:100%;">
	                        <thead>
	                            <tr align="center" style="font-size:18px; width:100%;">
	                                <th width="15%" align="left">이름</th>
	                                <th width="20%">기간</th>
	                                <th width="20%">항목</th>
	                                <th width="20%">사용기간</th>
	                                <th width="20%">승인</th>
	                            </tr>
	                        </thead>
                    	</table>
                    </div>
                    <hr>
                    <div id="holiday" >
                    	<table  style="width:100%;">
	                        <tbody>
		                            <c:forEach var="h" items="${ list }" >
			                            <tr style="height :60px;" align="center">
			                                <td width="15%" >
												<div class="bno" style="display:none;">${ h.userNo }</div>
												<div class="pro" style="float:left" >${ h.userName }</div>
												<div class="proname" >${ h.userName }</div>
			                                </td>
			                                <td width="20%">${ h.start } - ${ h.finish }</td>
			                                <td width="20%">${ h.type }</td>
			                                <td width="20%">${ h.datea }</td>
			                                <td width="20%">${ h.status }</td>
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