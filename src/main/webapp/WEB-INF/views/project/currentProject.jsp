<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업무</title>
 <!-- Link Swiper's CSS -->
 <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css"/>
<style>
/* 서브메뉴 */
  .sub-menu a{
      font-size:18px;
      color:rgb(143, 143, 143);
      text-decoration:none;
      margin-right:30px;
  }
  .sub-menu a.active, .sub-menu a:hover {
      color:rgb(0, 0, 0);
      font-weight:600;
  }

  #add-project{float:right;}

  /* swiper 슬라이드 */
  .swiper{
      width:100%;
      height:200px;
      margin-left:10px !important;
      z-index:0 !important;
  }
  .swiper-slide{
    text-align:center;
    font-size:18px;
    background:#ffffff;
    display:flex;
    justify-content:center;
    align-items:center;
    border:0.5px solid #ececee;
    width:320px;
    height:140px;
    box-shadow:12px 12px 15px -5px #dddddd;
  }
  .swiper-slide:hover{cursor:pointer;}
  .swiper-pagination, .swiper-button-next, .swiper-button-prev{z-index:1 !important;}

  /* 프로젝트 박스 */
  .project-box div{margin:5px; font-size:13px;}
  .project-title{font-size:16px !important; font-weight:700;}
  .swiper-slide.active{border:1px solid #6F50F8;}

  /* 진행률 */
  .progress {
    background:#f3f3f3;
    justify-content:flex-start;
    border-radius:100px !important;
    align-items:center;
    position:relative;
    padding:0 5px;
    display:flex;
    height:24px !important;
    width:100%;
  }
  .progress-bar {
    animation: load 2s normal forwards;
    box-shadow: 0 10px 30px -10px #6F50F8 !important;
    border-radius: 100px;
    background:linear-gradient(to right, #00b5d1 60%, #FFCECE);
    height: 16px;
  }
  .p-summary{font-size:13px;}
  #p-detail{line-height:20px;}
  
  /* 작업 추가 버튼 */
  #add-task{float:right;}
  /* 내 작업만 보기 필터 */
  .filter-mine{float:right;}
  #filter-check{margin-right:5px; width:17px; height:17px; cursor:pointer; position:relative; top:5px;}
  #filter-label{margin-right:15px; font-size:14px; position:relative; top:3px;}
  /* 상태 레이블 */
  .circle{display:inline-block; width:20px; height:20px; border-radius:20px; background:#ecd718; margin-right:10px;}
  /* 작업분류박스 */
  .column{
    border: 1px solid #e4e4e4;
    padding-top: 20px;
    padding-bottom: 10px;
    min-height: calc(70vh);
  }

  /* 작업 목록 */
  #task-category{font-size:14px; margin-bottom:15px;}
  .task-box{
    border:1px solid #e4e4e4;
    width:300px;
    font-size:14px;
    margin:auto;
    margin-bottom:12px;
    border-radius:3px;
    box-shadow: 10px 10px 10px -10px lightgray;
  }
  .task-box:hover{cursor:pointer;}
  .task-box div{margin:12px 15px;}
  .task-title{
    font-weight:800;
    text-overflow:ellipsis;
    overflow:hidden;
    word-break: break-word;
    display:-webkit-box;
    -webkit-line-clamp:2;
    -webkit-box-orient: vertical;
  }
  .profileImg{width:20px; height:20px; border-radius:20px; margin-right:7px;}
  .file{color:gray; margin-bottom:10px;}
  .file>img{width:13px; margin:0 5px;}
  .file>a{color:rgb(25, 25, 25);}
  #delete-file-btn{cursor:pointer;}
  .ref-people{display:inline-block; width:180px; text-align:right; font-size:12px;}
  .status{display:inline-block; color:white; width:50px; border-radius:5px; text-align:center; font-size:12px;}
  .tp-profileImg{width:20px; height:20px; border-radius:20px; margin-right:7px;}

  /* 상태 */
  .status-wait{background:#ecd718; }
  .status-working{background:#04b43f;}
  .status-done{background:#00b5d1;}
  .status-hold{background:lightgray;}

  /* 작업이동시 그림자 */
  .move-task{
    margin:0 1em 1em 0;
    height:50px;
    margin-left:auto;
    margin-right:auto;
    background-color: rgba(240, 240, 240, 0.671);
  }

  /* 업무 추가 모달 */
  .add-form{font-size:14px; width:100%;}
  .add-form tr{height:50px;}
  .add-form th{width:20%;}
  .add-form td{width:80%;}
  .add-form input, .add-form textarea{width:80%; border:0.5px solid lightgray; border-radius:4px;}
  #dept-select, #dept-select2{width:20%;}
  #emp-select, #emp-select2{width:30%;}
  .selected-area{
    width:80%;
    height:150px;
    border:0.5px solid lightgray;
    border-radius:4px;
    overflow:auto;
  }
  .select-user{
    display:inline-flex;
    align-items:center;
    margin:5px;
    background:rgb(240, 240, 240);
    border-radius:3px;
    width:100px;
    justify-content:center;
    cursor:pointer;
  }
  .select-user>img{
    width:12px;
    margin:3px;
  }
  .invalidMsg{
    font-size:12px;
    color:red;
    display:none;
  }
  .btn-outline-red{
    border:1px solid red;
    border-radius:5px;
    background:#ffffff;
    color:red;
    padding:2px 6px;
  }
  #deleteProjForm>button{
    float:right;
    font-size:12px;
    text-decoration:underline;
    background:white;
  }
</style>
</head>
<body>

	<jsp:include page="../common/menubar.jsp"/>
	
	<div id="content">
        <h2 class="title"><b>업무</b></h2>
        <br><br>
        <div class="sub-menu">
            <a href="list.pr?no=${loginUser.userNo}" class="active">프로젝트 현황</a>
            <!-- 관리자일 때만 보여야 함 
            <a href="#">프로젝트 관리</a> -->
        </div>
        <hr>
        <button id="add-project" class="btn-purple" data-toggle="modal" data-target="#add-project-modal">+ 프로젝트 생성</button>
        <br><br>
        
        <!-- Swiper -->
        <div class="swiper mySwiper">
          <div class="swiper-wrapper">
	          <c:forEach var="p" items="${pList}">
	            <div class="swiper-slide" onclick="clickProject(this);">
	              <div class="project-box">
                  <input type="hidden" name="projectNo" value="${p.projectNo}">
                  <input type="hidden" name="projectDetail" value="${p.detail}">
	                <div class="project-title">${p.projectName}</div>
	                <div class="project-manager">PM : ${p.projectManager} ${p.projectParticipants[0].positionName} (${p.projectParticipants[0].departmentName}) </div>
	                <div class="project-schedule">기간: ${p.startDate} ~ ${p.endDate}</div>
	              </div>
	            </div>
	          </c:forEach>
          </div>
          <div class="swiper-pagination"></div>
        </div>
        <br>
        <hr>
        
        <!-- Swiper JS -->
        <script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

        <!-- Initialize Swiper -->
        <script>
          $(function(){
            let option = {
                slidesPerView: 4,
                spaceBetween: 30,
                // slidesPerGroup: 4,
                // loopFillGroupWithBlank: true,
                freeMode: true,
                direction: 'horizontal',
                loop: true,
                autoplay: {
                  delay: 3500,
                  disableOnInteraction: false,
                },
                // If we need pagination
                pagination: {
                  el: ".swiper-pagination",
                  clickable: true,
                },
                // And if we need scrollbar
                scrollbar: {
                  el: '.swiper-scrollbar'
                }
            };

            if($(".swiper-slide").length <= 4){
              option.loop = false;
            }

            const swiper = new Swiper('.swiper', option)
          })
      </script>
      
      <!-- 프로젝트 클릭 -->
      <script>
        let firstSilde;
        
        // 프로젝트 관련
        let projectNo;
        let projectName;
        let projectDetail;
        let pm;
        let startDate;
        let endDate;

        // 프로젝트 디테일 정보
        // 프로젝트 참여자 리스트
        let ppList;
        // 업무리스트
        let tList;
        // 업무 참조자 리스트
        let tpList;
        let noneProfile = "resources/icons/none-profile.png";
        let noneOption = "<option value='none'>선택</option>";

        // 전체 부서
        let dList;
        // 전체 직원
        let mList;

        $(function(){
          firstSlide = $(".swiper-slide-active");
          clickProject(firstSlide);
        })

        function clickProject(e){
          
          // projectbox border
          $(e).addClass("active");
          $(e).siblings().removeClass("active");
          
          projectNo = $(e).find("input[name=projectNo]").val();
          
          $("#deleteProjForm input[name=projectNo]").val(projectNo);
          projectName = $(e).find(".project-title").text();
          $("#p-title").html("<b>" + projectName + "</b>");

          projectDetail = $(e).find("input[name=projectDetail]").val();
          $("#p-detail").text(projectDetail);

          let schedule = $(e).find(".project-schedule").text();
          startDate = schedule.substring(4, 14).replaceAll(".", "-");
          endDate = schedule.substring(17).replaceAll(".", "-");
          detailLoad(projectNo);
        }

        function detailLoad(projectNo){
          // task 전체 비우기
          $("#task-list .col").empty();
          // 내 작업만 보기 체크 해제
          $("#filter-check").prop("checked", false);
          $("#filter-check").change(function(){
            if($(this).prop("checked")){
              $(".task-box>input[name=assignUser]").each(function(){
                if($(this).val() != "${loginUser.userNo}"){
                  $(this).parent(".task-box").prop("style", "display:none");
                }
              })
            }else{
              $(".task-box").prop("style", "display:block");
            }
          })

            $.ajax({
              url:"detail.pr",
              data:{"projectNo":projectNo},
              success:function(obj){
                ppList = obj.ppList;
                tList = obj.tList;
                tpList = obj.tpList;

                // 참여자 정보 출력
                let member = "";
                pm = "";
                for(let i=0; i<ppList.length; i++){
                  if(ppList[i].pmStatus == "N"){
                    member += ppList[i].userName + " " + ppList[i].positionName + " (" + ppList[i].departmentName + "), ";
                  }else if(ppList[i].pmStatus == "Y"){
                    pm = "PM : " + ppList[i].userName + " " + ppList[i].positionName + " (" + ppList[i].departmentName + ")";
                  }
                }
                member = "참여자 : " + member.substring(0, member.lastIndexOf(","));
                $("#member-list").html(member);
                $("#pm").text(pm);

                // 작업 리스트 출력
                let task1 = "";
                let task2 = "";
                let task3 = "";
                let task4 = "";
                let taskValue = "";
                let taskNo = ""; 
                let taskRefList = [];

                for(let i=0; i<tList.length; i++){
                  
                  taskNo = tList[i].taskNo;
                  // popover할 요소 만들기
                  taskRefList[taskNo] = "";
                  for (let j=0; j<tpList.length; j++) {
                    for (let k=0; k<tpList[j].length; k++) {
                      if(tpList[j][k].taskNo == taskNo){
                        if(tpList[j][k].profileImg == null){
                          tpList[j][k].profileImg = noneProfile;
                        }
                          taskRefList[taskNo] += "<div><img class='tp-profileImg' src='"
                                             + tpList[j][k].profileImg + "'>"
                                             + tpList[j][k].userName + " "
                                             + tpList[j][k].positionName + "</div>";
                      }
                    }
                  }
                  
                  // 상태별 div .task-box 만들기
                  taskValue = "<div class='task-box' onclick='taskDetailLoad(this)'>"
                         + "<input type='hidden' name='taskNo' value='" + taskNo + "'>"
                         + "<div class='task-title'>" + tList[i].taskName + "</div>"
                         + "<input type='hidden' name='assignUser' value='" + tList[i].assignUser + "'>";
                  
                  if(tList[i].projectParticipants[0].profileImg == null) {
                    tList[i].projectParticipants[0].profileImg = noneProfile;
                  }
                  taskValue += "<div><img class='profileImg' src='" + tList[i].projectParticipants[0].profileImg + "'>" + tList[i].assignUserName + " " + tList[i].projectParticipants[0].positionName + "</div>";

                  if(tList[i].originName != null){
                    taskValue += "<div class='file'><img src='resources/icons/clip.png'>" + tList[i].originName + "</div>"; 
                  }

                  switch(tList[i].taskStatus){
                    case "1": task1 += taskValue + "<div class='status status-wait'>대기</div>"
                                     + "<div class='ref-people'>참조자 " + tpList[i].length + "명</div>"
                                     + "</div>";
                              taskValue = "";
                              break;
                    case "2": task2 += taskValue + "<div class='status status-working'>진행중</div>"
                                     + "<div class='ref-people'>참조자 " + tpList[i].length + "명</div>"
                                     + "</div>";
                              taskValue = "";
                              break;
                    case "3": task3 += taskValue + "<div class='status status-done'>완료</div>"
                                     + "<div class='ref-people'>참조자 " + tpList[i].length + "명</div>"
                                     + "</div>";
                              taskValue = "";
                              break;
                    case "4": task4 += taskValue + "<div class='status status-hold'>보류</div>"
                                     + "<div class='ref-people'>참조자 " + tpList[i].length + "명</div>"
                                     + "</div>";
                              taskValue = "";
                              break;
                  }
                  
                  
                }

                $("#task-list .wait-list").append(task1);
                $("#task-list .working-list").append(task2);
                $("#task-list .done-list").append(task3);
                $("#task-list .hold-list").append(task4);


                $(".ref-people").each(function() {
                  var popNo = $(this).siblings("input[name=taskNo]").val();
                  $(this).popover({
                    html: true,
                    content: taskRefList[popNo],
                    placement: "right",
                    trigger: "hover"
                  });
                });
                
                // 진행률 표시
                taskProgress();
                doneRatio();

              }, error:function(){
                console.log("정보 가져오기 실패");
              }
            })

        }
      </script>

      <h5 id="p-title"></h5>
      <form action="deleteProject.pr" method="get" id="deleteProjForm">
        <input type="hidden" name="projectNo">
        <c:if test="${fn:contains(loginUser.authorityNo, '0') || fn:contains(loginUser.authorityNo, '8')}">
          <button type="button" onclick="updateProjectForm();">프로젝트 수정</button>
          <button type="submit" onclick="return confirm('정말 삭제할까요?')">프로젝트 삭제</button>
        </c:if>
      </form>


      <div class="p-summary">
        <div id="p-detail"></div>
        <br>
        <div id="pm"></div>
        <div id="member-list"></div>
      </div>
      <br>
      <div id="progress-area">
        <div style="font-size:14px;"><b>진행률</b></div>
        <div id="task-ratio" style="font-size:13px;"></div>
        <br>
        <script>
          function doneRatio(){
            var doneNum = $(".done-list>.task-box").length;
            var allNum = $("#task-list .task-box").length;
            $("#task-ratio").text(doneNum + " / " + allNum + " (완료 / 전체)")
          }
        </script>

        <div class="progress">
          <div class="progress-bar" role="progressbar" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
        </div>
      </div>
      <br><br><br>

      <script>
        function taskProgress(){
          if($("#task-list .task-box").length != 0){
           
            var taskCompletion = Math.round($(".done-list>.task-box").length/$("#task-list .task-box").length*100);
          
            taskCompletion += "%";
          }else{
            taskCompletion = "0%";
          }
            // $(".progress-bar").css("width", taskCompletion);

            // 값 변경 시마다 애니매이션 재시작
            // keyframes 추가
            var keyframesName = "load-" + new Date().getTime();
            // 새로운 keyframes 규칙
            var keyframesRule = "@keyframes " + keyframesName + " { 0% { width: 0; } 100% { width: " + taskCompletion + "; } }";
            
            // style 추가
            $("<style>")
              .prop("type", "text/css")
              .html(keyframesRule)
              .appendTo("head");
            
            // 애니메이션 속성 변경하기
            $(".progress-bar").css({
              "animation-name": keyframesName,
              "animation-duration": "2s",
              "animation-fill-mode": "forwards"
            });
          
          $(".progress-bar").html(taskCompletion);
          
        }
      </script>

      <div id="task-area">
        <span style="font-size:16px;"><b>업무 현황</b></span>
        <button id="add-task" class="btn-purple" onclick="addTaskForm();">+ 업무 추가</button>
        <div class="filter-mine">
          <input type="checkbox" id="filter-check">
          <label for="filter-check" id="filter-label">내 작업만 보기</label>
        </div>
        <br><br>

        <script>
          $("#filter-check").change(function(){
            if($(this).prop("checked")){
              $("#task-list input[name=assignUsers]").each(function(){
                if($(this).val() != "${loginUser.userNo}"){
                  $(this).parent(".task-box").prop("style", "display:none");
                }
              })
            }else{
              $(".task-box").prop("style", "display:block");
            }
          })
        </script>
        <div class="row" id="task-category">
          <div class="col" id="wait"><div class="circle status-wait"></div>대기</div>
          <div class="col" id="working"><div class="circle status-working"></div>진행중</div>
          <div class="col" id="done"><div class="circle status-done"></div>완료</div>
          <div class="col" id="hold"><div class="circle status-hold"></div>보류</div>
        </div>
        <div class="row" id="task-list">
          
          <div class="col column wait-list">
          </div>
          
          <div class="col column working-list">
          </div>

          <div class="col column done-list">
          </div>
          
          <div class="col column hold-list">
          </div>

        </div>
      </div>
      <br><br><br>

      <!-- drag&drop sorting -->
      <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.min.js"></script>
      <script>
        $(function() {
          $(".column").sortable({
            // 그룹
            connectWith: ".column",
            // 움직일 요소
            handle: ".task-title",
            // 이동 시 배경
            placeholder: "move-task",
            // 옮긴 후
            stop: function(event, ui) {
              // 박스
              var taskBox = ui.item;
              // 업무번호
              var taskNo = taskBox.children("input[name=taskNo]").val();
              // 어느 상태 줄에 있는지
              var col = taskBox.parent();
              // 해당 줄에 클래스 이름
              var colClass = col.attr("class").split(" ")[2];
              // 변경된 status를 적용할 요소
              var statusEl = taskBox.find('.status');
              
              $.ajax({
                url:"updateStatus.tk",
                data:{"taskNo":taskNo, "taskStatus":colClass},
                success:function(result){
                  // 새로운 상태 클래스
                  var newStatusClass = "";
                  if (colClass == "wait-list") {
                    newStatusClass = "status-wait";
                  } else if (colClass == "working-list") {
                    newStatusClass = "status-working";
                  } else if (colClass == "done-list") {
                    newStatusClass = "status-done";
                  } else if (colClass == "hold-list") {
                    newStatusClass = "status-hold";
                  }

                  var statusVal = "";
                  switch(newStatusClass){
                    case "status-wait": statusVal = "대기"; break;
                    case "status-working": statusVal = "진행중"; break;
                    case "status-done": statusVal = "완료"; break;
                    case "status-hold": statusVal = "보류"; break;
                  }
                  
                  // 기존 상태 클래스 제거, 새로운 상태 클래스 추가
                  statusEl.removeClass().addClass("status " + newStatusClass);
                  statusEl.html(statusVal);

                  taskProgress();
                  doneRatio();
                }, error:function(){
                  console.log("상태 업데이트 실패");
                }
              })
            }
            
          });
        });
      </script>


      <!-- 프로젝트 추가 Modal -->
      <div class="modal" id="add-project-modal">
        <div class="modal-dialog">
          <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
              <h5 class="modal-title"><b>프로젝트 생성</b></h5>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <form action="addProject.pr" method="post">
              <!-- Modal body -->
              <div class="modal-body">
                <table class="add-form">
                  <tr>
                    <th width="100px;">* 프로젝트명 : </th>
                    <td><input type="text" class="task-title-inpt" name="projectName" placeholder="프로젝트명을 입력해주세요." required></td>
                  </tr>
                  <tr>
                    <th>* 상세내용 :</th>
                    <td><textarea name="detail" cols="30" rows="5" style="resize: none;" placeholder="프로젝트 상세내용을 입력해주세요." required></textarea></td>
                  </tr>
                  <tr>
                    <th>* 시작일 : </th>
                    <td><input type="date" name="startDate" required></td>
                  </tr>
                  <tr>
                    <th>* 종료일 : </th>
                    <td><input type="date" name="endDate" required></td>
                  </tr>
                  <tr>
                    <th>* PM :</th>
                    <td>
                      <select name="projectManagerDept" id="p-dept-select">
                        <option value="none">선택</option>
                        <c:forEach var="d" items="${dList}">
                          <option value="${d.departmentNo}">${d.departmentName}</option>
                        </c:forEach>
                      </select>
                      <select name="projectManager" id="p-mem-select">
                        <option value="none">선택</option>
                        <c:forEach var="m" items="${mList}">
                          <option value="${m.userNo}" value2="${m.departmentNo}" style="display:none;">${m.userName}</option>
                        </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th>참여자 :</th>
                    <td>
                      <select name="ppDeptSelect" id="p-dept-select2">
                        <option value="none">선택</option>
                        <c:forEach var="d" items="${dList}">
                          <option value="${d.departmentNo}">${d.departmentName}</option>
                        </c:forEach>
                      </select>
                      <select name="ppSelect" id="p-mem-select2">
                        <option value="none">선택</option>
                        <c:forEach var="m" items="${mList}">
                          <option value="${m.userNo}" value2="${m.departmentNo}" value3="${m.position}" style="display:none;">${m.userName}</option>
                        </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th><input type="hidden" name="userNo" id="taskUserNo"></th>
                    <td>
                      <div id="selected-area" class="selected-area"></div>
                      <div class="invalidMsg">이미 선택된 직원입니다.</div>
                    </td>
                  </tr>
                </table>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="submit" class="btn btn-purple" id="project-add-btn">프로젝트 생성</button>
            </div>
          </form>

          </div>
        </div>
      </div><!-- add-project-modal-->

      <!-- 프로젝트 생성 관련 -->
      <script>
        // PM select
        $("#p-dept-select").change(function(){
          var selectedDept = $("#p-dept-select option:selected").val();
          $("#p-mem-select option").each(function(){
              if($(this).attr("value2") == selectedDept){
               $(this).css("display", "block");
              }else{
                $(this).css("display", "none");
              }
            })
        })

        // participants select
        $("#p-dept-select2").change(function(){
          var selectedDept = $("#p-dept-select2 option:selected").val();
          $("#p-mem-select2 option").each(function(){
              if($(this).attr("value2") == selectedDept){
               $(this).css("display", "block");
              }else{
                $(this).css("display", "none");
              }
            })
        })

        // 선택한 정보 selected-area에 추가하기
        let selectedEl = ""; // 선택된 요소
        let projectUser = ""; // 추가할 요소
        let selectUserDept = ""; // 유저 부서번호
        let selectUserName = ""; // 유저명
        let selectUserNo = ""; // 유저번호
        let selectUserPs = ""; // 유저직위
        let selectUserAssign = "" ; // 작업담당여부
        $("#p-mem-select2").change(function(){
          $(".invalidMsg").css("display", "none");
          selectedEl = $("#p-mem-select2 option:selected");
          selectUserDept = selectedEl.attr("value2");
          selectUserName = selectedEl.text();
          selectUserNo = selectedEl.attr("value");
          selectUserPs = selectedEl.attr("value3");

          if($("#selected-area").text().includes(selectUserName)){
            $(".invalidMsg").css("display", "block");
          }else{
            projectUser = "<div class='select-user' onclick='deleteUser(this);'>" + selectUserName + " " + selectUserPs + "<img src='resources/icons/delete-red.png'>"
                        + "<input type='hidden' name='selectUserNo' value='" + selectUserNo + "'>"
                        + "<input type='hidden' name='selectUserDept' value='" + selectUserDept + "'>";
                        + "</div>";
            $("#selected-area").append(projectUser);
            $(".invalidMsg").css("display", "none");
          }
        })


        // 선택유저 삭제하기
        function deleteUser(e){
          if($(e).find("input[name=selectUserAssign]").val() == "Y"){
            alert("현재 담당하는 작업이 있습니다. 담당자 설정 해제 후 다시 시도해주세요.");
          }else{
            $(e).remove();
          }
        }

      </script>


      <!-- 프로젝트 수정 Modal -->
      <div class="modal" id="update-project-modal">
        <div class="modal-dialog">
          <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
              <h5 class="modal-title"><b>프로젝트 수정</b></h5>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <form action="updateProject.pr" method="post">
              <!-- Modal body -->
              <div class="modal-body">
                <table class="add-form">
                  <tr>
                    <th width="100px;">* 프로젝트명 : </th>
                    <td>
                      <input type="text" class="task-title-inpt" name="projectName" placeholder="프로젝트명을 입력해주세요." required>
                      <input type="hidden" name="projectNo">
                    </td>
                  </tr>
                  <tr>
                    <th>* 상세내용 :</th>
                    <td><textarea name="detail" cols="30" rows="5" style="resize: none;" placeholder="프로젝트 상세내용을 입력해주세요." required></textarea></td>
                  </tr>
                  <tr>
                    <th>* 시작일 : </th>
                    <td><input type="date" name="startDate" required></td>
                  </tr>
                  <tr>
                    <th>* 종료일 : </th>
                    <td><input type="date" name="endDate" required></td>
                  </tr>
                  <tr>
                    <th height="10px;">* PM :</th>
                    <td id="currentPM"></td>
                  </tr>
                  <tr>
                    <th>PM 변경 : </th>
                    <td>
                      <select name="projectManagerDept" id="p-dept-select3">
                        <option value="none">선택</option>
                        <c:forEach var="d" items="${dList}">
                          <option value="${d.departmentNo}">${d.departmentName}</option>
                        </c:forEach>
                      </select>
                      <select name="projectManager" id="p-mem-select3">
                        <option value="none">선택</option>
                        <c:forEach var="m" items="${mList}">
                          <option value="${m.userNo}" value2="${m.departmentNo}" style="display:none;">${m.userName}</option>
                        </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th>참여자 :</th>
                    <td>
                      <select name="ppDeptSelect" id="p-dept-select4">
                        <option value="none">선택</option>
                        <c:forEach var="d" items="${dList}">
                          <option value="${d.departmentNo}">${d.departmentName}</option>
                        </c:forEach>
                      </select>
                      <select name="ppSelect" id="p-mem-select4">
                        <option value="none">선택</option>
                        <c:forEach var="m" items="${mList}">
                          <option value="${m.userNo}" value2="${m.departmentNo}" value3="${m.position}" style="display:none;">${m.userName}</option>
                        </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th></th>
                    <td>
                      <div id="selected-area2" class="selected-area"></div>
                      <div class="invalidMsg">이미 선택된 직원입니다.</div>
                    </td>
                  </tr>
                </table>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="submit" class="btn btn-purple">프로젝트 수정</button>
            </div>
          </form>

          </div>
        </div>
      </div><!-- update-project-modal-->

      <!-- 프로젝트 수정 관련 -->
      <script>
        function updateProjectForm(){
          $("#update-project-modal input[name=projectName]").val(projectName);
          $("#update-project-modal input[name=projectNo]").val(projectNo);
          $("#update-project-modal textarea[name=detail]").val(projectDetail);
          $("#update-project-modal input[name=startDate]").val(startDate);
          $("#update-project-modal input[name=endDate]").val(endDate);

          let pmDeptNo = "";
          let pmNo = "";
          let pmName = "";
          
          $("#selected-area2").empty();
          projectUser = "";
          for(let i=0; i<ppList.length; i++){
              if(ppList[i].pmStatus == "Y"){
                  pmDeptNo = ppList[i].departmentNo;
                  pmNo = ppList[i].userNo;
                  pmName = ppList[i].userName + " " + ppList[i].positionName;
              }else if(ppList[i].taskAssign == null && !projectUser.includes(ppList[i].userName)){
                  projectUser += "<div class='select-user' onclick='deleteUser(this);'>" + ppList[i].userName + " " + ppList[i].positionName + "<img src='resources/icons/delete-red.png'>"
                              + "<input type='hidden' name='selectUserNo' value='" + ppList[i].userNo + "'>"
                              + "<input type='hidden' name='selectUserDept' value='" + ppList[i].departmentNo + "'>"
                              + "<input type='hidden' name='selectUserAssign' value='" + ppList[i].taskAssign + "'>"
                              + "</div>";
              }
          }
              
          $("#selected-area2").append(projectUser);
          
          $("#currentPM").empty();
          $("#currentPM").append(pmName);
        
          // PM 변경 셀렉트
          $("#p-dept-select3 option").each(function(){
            if($(this).val() == pmDeptNo){
              $(this).attr("selected", true);
              $("#p-mem-select3 option").each(function(){
                if($(this).attr("value2") == pmDeptNo){
                  $(this).css("display", "block");
                  if($(this).val() == pmNo){
                    $(this).attr("selected", true);
                  }
                }
              })
            }
          })

          
          $("#update-project-modal").modal("show");
        }


        $("#p-dept-select3").change(function(){
          var selectedDept = $("#p-dept-select3 option:selected").val();
          $("#p-mem-select3 option").each(function(){
              if($(this).attr("value2") == selectedDept){
                $(this).css("display", "block");
              }else{
                $(this).css("display", "none");
              }
            })
        })

        // participants select
        $("#p-dept-select4").change(function(){
          var selectedDept = $("#p-dept-select4 option:selected").val();
          $("#p-mem-select4 option").each(function(){
              if($(this).attr("value2") == selectedDept){
                $(this).css("display", "block");
              }else{
                $(this).css("display", "none");
              }
            })
        })


        $("#p-mem-select4").change(function(){
          $(".invalidMsg").css("display", "none");
          selectedEl = $("#p-mem-select4 option:selected");
          selectUserDept = selectedEl.attr("value2");
          selectUserName = selectedEl.text();
          selectUserNo = selectedEl.attr("value");
          selectUserPs = selectedEl.attr("value3");
          selectUserAssign = selectedEl.attr("value4")

          if($("#selected-area2").text().includes(selectUserName)){
            $(".invalidMsg").css("display", "block");
          }else{
            projectUser = "<div class='select-user' onclick='deleteUser(this);'>" + selectUserName + " " + selectUserPs + "<img src='resources/icons/delete-red.png'>"
                        + "<input type='hidden' name='selectUserNo' value='" + selectUserNo + "'>"
                        + "<input type='hidden' name='selectUserDept' value='" + selectUserDept + "'>"
                        + "<input type='hidden' name='selectUserAssign' value='" + selectUserAssign + "'>"
                        + "</div>";
            $("#selected-area2").append(projectUser);
            $(".invalidMsg").css("display", "none");
          }
        })

      </script>

      <!-- 업무 추가 Modal -->
      <div class="modal" id="add-task-modal">
        <div class="modal-dialog">
          <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
              <h5 class="modal-title"><b>업무 추가</b></h5>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <form action="addTask.tk" method="post" enctype="multipart/form-data">
              <!-- Modal body -->
              <div class="modal-body">
                <table class="add-form">
                  <tr>
                    <th width="100px;">* 업무명 : </th>
                    <td><input type="text" class="task-title-inpt" name="taskName" placeholder="업무명을 입력해주세요." required></td>
                  </tr>
                  <tr>
                    <th>* 업무상세 :</th>
                    <td><textarea name="taskContent" cols="30" rows="5" style="resize: none;" placeholder="업무 상세내용을 입력해주세요." required></textarea></td>
                  </tr>
                  <tr>
                    <th>첨부파일 :</th>
                    <td><input type="file" name="upfile"></td>
                  </tr>
                  <tr>
                    <th>담당자 :</th>
                    <td>
                      <input type="hidden" name="assignUser" value="${loginUser.userNo}">${loginUser.userName}
                      <input type="hidden" name="assignUserDept" value="${loginUser.departmentNo}">
                    </td>
                  </tr>
                  <tr>
                    <th>참조자 :</th>
                    <td>
                      <select name="userNo" id="emp-select1">
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th><input type="hidden" name="userNo" id="taskUserNo"></th>
                    <td>
                      <div id="selected-area3" class="selected-area"></div>
                      <div class="invalidMsg">이미 선택된 직원입니다.</div>
                    </td>
                  </tr>
                  <tr>
                    <th>상태</th>
                    <td>
                      <select name="taskStatus">
                        <option value="1">대기</option>
                        <option value="2">진행중</option>
                        <option value="3">완료</option>
                        <option value="4">보류</option>
                      </select>
                    </td>
                  </tr>
                </table>
                <input type="hidden" name="projectNo">
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="submit" class="btn btn-purple" id="add-btn">추가</button>
            </div>
          </form>
          
        </div>
      </div>
    </div><!-- add-task-modal-->
    
    <script>
      let empUserNo = [];
      let empList = "";
      
        function addTaskForm(){
          $("#emp-select1").html(noneOption);
          $(".invalidMsg").css("display", "none");

          $("#add-task-modal input[name=projectNo]").val(projectNo);

         
          // 셀렉트 정보 만들기
          for(let i=0; i<ppList.length; i++){
            if(empUserNo.indexOf(ppList[i].userNo) == -1){ // userNo가 이미 추가되었는지 확인
              empList += "<option value='" + ppList[i].userNo + "' value2='" + ppList[i].departmentNo +"' value3='" + ppList[i].positionName + "'>" + ppList[i].userName + "</option>";
              empUserNo.push(ppList[i].userNo);
            }
          }
          $("#emp-select1").append(empList);

          // 모달 출력
         $("#add-task-modal").modal("show");

        }

        $("#emp-select1").change(function(){
          $(".invalidMsg").css("display", "none");
          selectedEl = $("#emp-select1 option:selected");
          selectUserDept = selectedEl.attr("value2");
          selectUserName = selectedEl.text();
          selectUserNo = selectedEl.attr("value");
          selectUserPs = selectedEl.attr("value3");

          if($("#selected-area3").text().includes(selectUserName)){
            $(".invalidMsg").css("display", "block");
          }else{
            taskRefUser = "<div class='select-user' onclick='deleteUser(this);'>" + selectUserName + " " + selectUserPs + "<img src='resources/icons/delete-red.png'>"
                        + "<input type='hidden' name='selectUserNo' value='" + selectUserNo + "'>"
                        + "<input type='hidden' name='selectUserDept' value='" + selectUserDept + "'>"
                        + "</div>";
            $("#selected-area3").append(taskRefUser);
            $(".invalidMsg").css("display", "none");
          }
        })

      
      </script>

      

      <!-- 업무 수정(상세) Modal -->
      <div class="modal" id="update-task-modal">
        <div class="modal-dialog">
          <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
              <h5 class="modal-title"><b>업무 상세</b></h5>
              <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <form action="" method="post" enctype="multipart/form-data" id="taskUpdateForm">
              <!-- Modal body -->
              <div class="modal-body">
                <table class="add-form">
                  <tr>
                    <input type="hidden" name="taskNo">
                    <th width="100px;">* 업무명 : </th>
                    <td><input type="text" class="task-title-inpt" id="dTaskName" name="taskName" placeholder="업무명을 입력해주세요." required></td>
                  </tr>
                  <tr>
                    <th>* 업무상세 :</th>
                    <td><textarea id="dTaskContent" name="taskContent" cols="30" rows="5" style="resize: none;" placeholder="업무 상세내용을 입력해주세요." required></textarea></td>
                  </tr>
                  <tr>
                    <th>첨부파일 :</th>
                    <td>
                      <br>
                      <input type="file" id="reupfile" name="reupfile">
                      <div class="file" id="currentFile-area"></div>
                      <input type="hidden" id="currentFile" name="originName">
                      <input type="hidden" id="currientFilePath" name="filePath">
                    </td>
                  </tr>
                  <tr>
                    <th>담당자 :</th>
                    <td>
                      <select name="assignUser" id="dAssignUser">
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th>참조자 :</th>
                    <td>
                      <select name="userNo" id="emp-select2">
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <th><input type="hidden" name="userNo" id="dTaskUserNo"></th>
                    <td>
                      <div id="selected-area4" class="selected-area"></div>
                      <div class="invalidMsg">이미 선택된 직원입니다.</div>
                    </td>
                  </tr>
                  <tr>
                    <th>상태</th>
                    <td>
                      <select name="taskStatus">
                        <option value="1">대기</option>
                        <option value="2">진행중</option>
                        <option value="3">완료</option>
                        <option value="4">보류</option>
                      </select>
                    </td>
                  </tr>
                </table>
                <input type="hidden" name="projectNo">
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
              <button type="submit" class="btn-outline-red" onclick="confirm('삭제하시겠습니까?'); taskUpdateFormSubmit('deleteTask.tk')">삭제</button>
              <button type="submit" class="btn btn-purple" onclick="taskUpdateFormSubmit('updateTask.tk')">수정</button>
            </div>
          </form>

          </div>
        </div>
      </div><!-- update-task-modal-->
      
      
      <script>
        let userValue = "";
        let t; // task
        let tp; // task pp
        function taskDetailLoad(e){
          taskNo = $(e).children("input[name=taskNo]").val();
          $("#update-task-modal input[name=projectNo]").val(projectNo);

          for(let i=0; i<tList.length; i++){
            if(tList[i].taskNo == taskNo){
              t = tList[i];
            }
          }

          $("#currentFile-area").empty();
          
          // task detail
          $("#dTaskName").val(t.taskName);
          $("#dTaskContent").text(t.taskContent);
          
          
          // 담당자 select, 참조자 select 만들기
          // 담당자
          userValue = noneOption;
          // 참조자
          projectUser = noneOption;
          for (let i=0; i<ppList.length; i++) {
            if(ppList[i].taskAssign == null && !userValue.includes(ppList[i].userName)){
              userValue += "<option value='" + ppList[i].userNo + "' value2='" + ppList[i].departmentNo + "'>" + ppList[i].userName + "</option>";
              projectUser += "<option value='" + ppList[i].userNo + "' value2='" + ppList[i].departmentNo + "' value3='" + ppList[i].positionName + "''>" + ppList[i].userName + "</option>";
            }
          }
              

          $("#dAssignUser").empty();
          $("#dAssignUser").append(userValue);
          
          $("#dAssignUser>option").each(function(){
            if($(this).val() == t.assignUser){
              $(this).prop("selected", true);
            }
          });

          $("#emp-select2").empty();
          $("#emp-select2").append(projectUser);

          let fileValue = ""
          if(t.originName != null){
            fileValue = "<img src='resources/icons/clip.png'>"
                      + "<a id='currentFile' href='" + t.filePath + "' download='" + t.originName +"'>"
                      + t.originName + "</a>"
                      + "<img id='delete-file-btn' src='resources/icons/delete-red.png' onclick='deleteFile();'>";
                        
            $("#currentFile-area").html(fileValue);
            $("#currentFile").val(t.originName);
            $("#currientFilePath").val(t.filePath);
          }

          // task 참조자 셀렉트
          $("#selected-area4").empty();

          // 기존에 선택된 참조자 리스트 보여주기
          let selectedUserList = "";
          for (let i = 0; i < tpList.length; i++) {
            for (let j = 0; j < tpList[i].length; j++) {
              if (tpList[i][j].taskNo == taskNo) {
                tp = tpList[i];
                break;
              }
            }
          }

          if(tp != null){
            for(let i=0; i<tp.length; i++){
              selectedUserList += "<div class='select-user' onclick='deleteUser(this);'>" + tp[i].userName + " " + tp[i].positionName + "<img src='resources/icons/delete-red.png'>"
                                + "<input type='hidden' name='selectUser' value='" + tp[i].userNo + "'>"
                                + "<input type='hidden' name='selectUserDept' value='" + tp[i].departmentNo + "'>"
                                + "<input type='hidden' name='selectUserAssign' value='" + tp[i].taskAssign + "'>"
                                + "</div>";
            }
          }
          $("#selected-area4").html(selectedUserList);
          
          $("#emp-select2").change(function(){
            $(".invalidMsg").css("display", "none");
            selectUserDept = $("#emp-select2 option:selected").attr("value2");
            selectUserName = $("#emp-select2 option:selected").text();
            selectUserNo = $("#emp-select2 option:selected").val();
            selectUserPs = $("#emp-select2 option:selected").attr("value3");
            selectUserAssign = $("#emp-select2 option:selected").attr("value4");
            
            if(selectUserNo == $("#dAssignUser option:selected").val()){
              alert("업무 담당자는 참조자로 추가할 수 없습니다.");
              return false;
            }
            if($("#selected-area4").html().includes(selectUserName)){
              $(".invalidMsg").css("display", "block");
            }else if(selectUserName != "선택"){
              taskRefUser = "<div class='select-user' onclick='deleteUser(this);'>" + selectUserName + " " + selectUserPs + "<img src='resources/icons/delete-red.png'></div>"
                          + "<input type='hidden' name='selectUser' value='" + selectUserNo + "'>"
                          + "<input type='hidden' name='selectUserDept' value='" + selectUserDept + "'>"
                          + "<input type='hidden' name='selectUserAssign' value='" + selectUserAssign + "'>";
              $("#selected-area4").append(taskRefUser);
              $(".invalidMsg").css("display", "none");
            }
          })

          // 상태 선택
          $("select[name=taskStatus] option").each(function(){
              if ($(this).val() == t.taskStatus) {
                $(this).prop("selected", true);
              }
          }); 
          
          // taskNo 추가
          $("#update-task-modal input[name=taskNo]").val(taskNo);
          // 프로젝트 번호 추가
          $("#update-task-modal input[name=projectNo]").val(projectNo);

          $("#update-task-modal").modal("show");

          // 참조자 -> 담당자 순으로 선택 시 중복선택 막는 부분은 나중에...

        }
        
      
        function deleteFile(){
          $("#currentFile-area").empty();
          $("#currentFile").val("");
        }

        function taskUpdateFormSubmit(action){
          $("#taskUpdateForm").attr("action", action).submit();
        }
      </script>
   



    </div>
    </div>
    
    <script>
    	document.getElementById("add-btn").onclick = function(){
    		let taskAlarm = "";
    		for(let i = 0; i<$("#add-task-modal input[name=selectUserNo]").length; i++){
    			taskAlarm += "/" + $("#add-task-modal input[name=selectUserNo]").eq(i).val();
    		}
    		taskAlarm = taskAlarm.substring(1);
    		if(socket){
	          let socketMsg = "5,${loginUser.userNo},${loginUser.userName}," + taskAlarm + ",1," + document.getElementsByName("taskName")[0].value;
	          socket.send(socketMsg);
		  	}
    	}
    	document.getElementById("project-add-btn").onclick = function(){
    		let projectAlarm = $("select[name=projectManager]").val();
    		for(let i = 0; i<$("#add-project-modal input[name=selectUserNo]").length; i++){
    			projectAlarm += "/" + $("#add-project-modal input[name=selectUserNo]").eq(i).val()
    		}
    		if(socket){
	          let socketMsg = "4,${loginUser.userNo},${loginUser.userName}," + projectAlarm + ",1," + document.getElementsByName("projectName")[0].value;
	          socket.send(socketMsg);
		  	}
    	}
    </script>

</body>
</html>