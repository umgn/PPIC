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
			// 개인-참조 count
			document.getElementById("menu-area").innerHTML += "개인 &gt; 참조 <span style='color:#fdbaba;'>${pi.listCount}</span>";

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
		
		//  Ajax 중요 update
		function ajaxStar(bk){
			const el = window.event.target;
			const no = el.parentNode.parentNode.childNodes[1].value;
			$.ajax({
				url:"updateBook.ap",
				data:{
					approvalNo:no,
					bookmark:bk,
					userName:${loginUser.userNo}
				},
				success:function(result){
					if(result > 0){
						location.reload();
					}
				}, error:function(){
					console.log("중요용 ajax통신 실패");
				}
			});
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
                    <th width="130px">작성일</th>
                    <th width="130px">완료일</th>
                    <th width="180px">문서번호</th>
                    <th width="70px">중요</th>
                </tr>
            </thead>
            <tbody>
                
                <c:choose>
                	<c:when test="${ empty list }">
                		<tr>
                			<td colspan="9">참조 문서가 없습니다.</td>
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
			                    		<c:when test="${ a.approvalStatus eq '대기' }">
			                    			<span class="stt-gr">${ a.approvalStatus }</span>
			                    		</c:when>
			                    		<c:when test="${ a.approvalStatus eq '진행중' }">
			                    			<span class="stt-pp">${ a.approvalStatus } ${ a.currentOrder }/${ a.finalOrder }</span>
			                    		</c:when>
			                    		<c:when test="${ a.approvalStatus eq '승인' }">
			                    			<span class="stt-sb">${ a.approvalStatus }</span>
			                    		</c:when>
			                    		<c:when test="${ a.approvalStatus eq '반려' }">
			                    			<span class="stt-rd">${ a.approvalStatus }</span>
			                    		</c:when>
			                    	</c:choose>
			                    </td>
			                    <td>${ a.createDate }</td>
			                    <td>${ a.completeDate }</td>
			                    <td>${ a.completeNo }</td>
			                    <td>
			                    	<c:choose>
			                    		<c:when test="${ a.bookmark eq 'N' }">
			                    			<img src="resources/icons/star.png" height="20px" class="as" onclick="ajaxStar(0);">
			                    		</c:when>
			                    		<c:otherwise>
				                    		<img src="resources/icons/star-y.png" height="20px" class="as" onclick="ajaxStar(1);">
			                    		</c:otherwise>
			                    	</c:choose>
			                    </td>
			                </tr>
		                </c:forEach>
		            </c:otherwise>
                </c:choose>

            </tbody>
        </table>

        <br>

        <div align="center">
        	<c:if test="${ pi.currentPage ne 1 }">
            	<a href="list.ap?myr=1&cpage=${ pi.currentPage - 1 }" class="btnn-pp">이전</a>
            </c:if>
            
			<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
				<c:choose>
					<c:when test="${ p eq pi.currentPage }">
						<a href="list.ap?myr=1&cpage=${ p }" class="btnn-pp" style="background-color:#6F50F8; color:white;">${ p }</a>
					</c:when>
					<c:otherwise>
						<a href="list.ap?myr=1&cpage=${ p }" class="btnn-pp">${ p }</a>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<c:if test="${ pi.currentPage ne pi.maxPage and pi.maxPage ne 0 }">
            	<a href="list.ap?myr=1&cpage=${ pi.currentPage + 1 }" class="btnn-pp">다음</a>
            </c:if>
        </div>
    </div>
</div> <!-- div 닫는 구문 하나 더 있음 -->
</body>
</html>