<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PPIC</title>
</head>
<body>
	<jsp:include page="../common/menubar.jsp"/>
	
	<jsp:include page="appMenu.jsp"/>
	
	<script>
		window.onload = function(){
			// 부서-진행중 count
			//document.getElementById("").innerHTML += " <span style='color:#fdbaba;'>${pi.listCount}</span>";
			
			// 각 행
			const tr = document.getElementsByClassName("trOver");
			for(let i=0; i<tr.length; i++){
				// 상세 onclick
				tr[i].childNodes[7].addEventListener("click", function(){
					const no = this.parentNode.childNodes[1].value;
					const form = this.parentNode.childNodes[5].innerHTML;
					location.href="detail.ap?no=" + no + "&form=" + form;
				});
			}
		}
	</script>
	
	<div class="content-2">
        <table id="tb" class="table-hover">
            <thead>
                <tr class="purple">
                    <th width="100px">작성자</th>
                    <th width="200px">문서양식</th>
                    <th>제목</th>
                    <th width="70px">첨부</th>
                    <th width="150px">결재상태</th>
                    <th width="150px">작성일</th>
                </tr>
            </thead>
            <tbody>
                
                <c:choose>
                	<c:when test="${ empty list }">
                		<tr>
                			<td colspan="6">진행중인 문서가 없습니다.</td>
                		</tr>
                	</c:when>
                	<c:otherwise>
		                <c:forEach var="a" items="${ list }">
			                <tr class="trOver">
			                    <input type="hidden" name="approvalNo" value="${ a.approvalNo }">
			                    <td>${ a.userName }</td>
			                    <td>${ a.form }</td>
			                    <td class="titleTd">${ a.title }</td>
			                    <td>
			                    	<c:if test="${ not empty a.originName }">
			                    		<img src="resources/icons/clip.png" height="20px">
			                    	</c:if>
			                    </td>
			                    <td>
			                    	<c:choose>
			                    		<c:when test="${ a.currentOrder eq 0 }">
			                    			<span class="stt-gr">${ a.approvalStatus }</span>
			                    		</c:when>
			                    		<c:otherwise>
			                    			<span class="stt-pp">${ a.approvalStatus} ${ a.currentOrder }/${ a.finalOrder }</span>
			                    		</c:otherwise>
			                    	</c:choose>
			                    </td>
			                    <td>${ a.createDate }</td>
			                </tr>
		                </c:forEach>
		            </c:otherwise>
                </c:choose>

            </tbody>
        </table>
        
        <br>

        <div align="center">
        	<c:if test="${ pi.currentPage ne 1 }">
            	<a href="list.ap?dpi=1&cpage=${ pi.currentPage - 1 }" class="btnn-pp">이전</a>
            </c:if>
            
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:choose>
					<c:when test="${ p eq pi.currentPage }">
						<a href="list.ap?a=1&cpage=${ p }" class="btnn-pp" style="background-color:#6F50F8; color:white;">${ p }</a>
					</c:when>
					<c:otherwise>
						<a href="list.ap?a=1&cpage=${ p }" class="btnn-pp">${ p }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${ pi.currentPage ne pi.maxPage and pi.maxPage ne 0 }">
            	<a href="list.ap?dpi=1&cpage=${ pi.currentPage + 1 }" class="btnn-pp">다음</a>
            </c:if>
        </div>
    </div>
</div> <!-- div 닫는 구문 하나 더 있음 -->
</body>
</html>