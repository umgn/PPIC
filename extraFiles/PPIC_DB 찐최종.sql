-----------------삭제------------------
-- 해당 계정의 모든 트리거 삭제
BEGIN
FOR C IN (SELECT * FROM USER_TRIGGERS) LOOP
  EXECUTE IMMEDIATE 'DROP TRIGGER '||C.TRIGGER_NAME;
END LOOP;
END;
/
--해당 계정의 모든테이블 및 제약조건 삭제
BEGIN
    FOR C IN (SELECT * FROM USER_TABLES) LOOP
    EXECUTE IMMEDIATE ('DROP TABLE "'||C.TABLE_NAME||'" CASCADE CONSTRAINTS');
    END LOOP;
END;
/
--해당 계정의 모든 시퀀스 삭제
BEGIN
FOR C IN (SELECT * FROM USER_SEQUENCES) LOOP
  EXECUTE IMMEDIATE 'DROP SEQUENCE '||C.SEQUENCE_NAME;
END LOOP;
END;
/
--해당 계정의 모든 뷰 삭제
BEGIN
FOR C IN (SELECT * FROM USER_VIEWS) LOOP
  EXECUTE IMMEDIATE 'DROP VIEW '||C.VIEW_NAME;
END LOOP;
END;
/
---------------------------------------

CREATE TABLE "DEPT" (
	"DEPARTMENT_NO"	NUMBER		NOT NULL,
	"DEPARTMENT_NAME"	VARCHAR2(10)		NOT NULL
);

CREATE TABLE "MEMBER" (
	"USER_NO"	NUMBER		NOT NULL,
	"USER_ID"	VARCHAR2(30)		NOT NULL,
	"USER_PWD"	VARCHAR2(100)		NOT NULL,
	"USER_NAME"	VARCHAR2(15)		NOT NULL,
	"MAIL"	VARCHAR2(40)		NOT NULL,
	"PHONE"	VARCHAR2(11)		NULL,
	"ADDRESS"	VARCHAR2(100)		NULL,
	"COMPANY"	VARCHAR2(30)	DEFAULT '삑카츄'	NOT NULL,
	"POSITION"	NUMBER		NOT NULL,
	"DEPARTMENT"	NUMBER		NOT NULL,
	"EMPLOYEE_NO"	VARCHAR2(10)		NULL,
	"PROFILE_IMG"	VARCHAR2(200)		NULL,
	"HIRE_DATE"	DATE		NULL,
	"RESIGN_DATE"	DATE		NULL,
	"STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NOT NULL,
	"AUTHORITY_NO"	NUMBER		NULL,
	"MEMBER_SIGN"	VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	"CONN_STA"	VARCHAR2(1)		NULL
);

COMMENT ON COLUMN "MEMBER"."CONN_STA" IS '접속상태(0온라인/1오프라인/2부재중)';

CREATE TABLE "APPROVAL" (
	"APPROVAL_NO"	NUMBER		NULL,
	"COMPLETE_NO"	VARCHAR2(20)		NULL,
	"USER_NO"	NUMBER		NULL,
	"DEPARTMENT_NO"	NUMBER		NULL,
	"POSITION_NO"	NUMBER		NULL,
	"FORM"	VARCHAR2(30)		NOT NULL,
	"TITLE"	VARCHAR2(100)		NOT NULL,
	"CREATE_DATE"	VARCHAR2(20)	DEFAULT SYSDATE	NULL,
	"COMPLETE_DATE"	VARCHAR2(20)		NULL,
	"CURRENT_ORDER"	NUMBER	DEFAULT 0	NULL,
	"FINAL_ORDER"	NUMBER		NOT NULL,
	"APPROVAL_STATUS"	VARCHAR2(20)	DEFAULT '대기'	NULL,
	"STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL
);

COMMENT ON COLUMN "APPROVAL"."APPROVAL_NO" IS '전자결재번호';

COMMENT ON COLUMN "APPROVAL"."COMPLETE_NO" IS '문서번호';

COMMENT ON COLUMN "APPROVAL"."USER_NO" IS '회원번호';

COMMENT ON COLUMN "APPROVAL"."DEPARTMENT_NO" IS '부서번호';

COMMENT ON COLUMN "APPROVAL"."POSITION_NO" IS '직급번호';

COMMENT ON COLUMN "APPROVAL"."FORM" IS '문서양식';

COMMENT ON COLUMN "APPROVAL"."TITLE" IS '제목';

COMMENT ON COLUMN "APPROVAL"."CREATE_DATE" IS '작성일';

COMMENT ON COLUMN "APPROVAL"."COMPLETE_DATE" IS '완료일';

COMMENT ON COLUMN "APPROVAL"."CURRENT_ORDER" IS '진행순서';

COMMENT ON COLUMN "APPROVAL"."FINAL_ORDER" IS '최종순서';

COMMENT ON COLUMN "APPROVAL"."APPROVAL_STATUS" IS '결재상태';

COMMENT ON COLUMN "APPROVAL"."STATUS" IS '상태';

CREATE TABLE "FORM_DRAFT" (
	"FORM_NO"	NUMBER		NULL,
	"APPROVAL_NO"	NUMBER		NULL,
	"EFFECTIVE_DATE"	VARCHAR2(20)		NOT NULL,
	"DEPARTMENT_NO"	NUMBER		NULL,
	"CONTENT"	VARCHAR2(4000)		NOT NULL
);

COMMENT ON COLUMN "FORM_TRANSFER"."FORM_NO" IS '양식번호';

COMMENT ON COLUMN "FORM_DRAFT"."APPROVAL_NO" IS '전자결재번호';

COMMENT ON COLUMN "FORM_DRAFT"."EFFECTIVE_DATE" IS '시행일자';

COMMENT ON COLUMN "FORM_DRAFT"."DEPARTMENT_NO" IS '협조부서';

COMMENT ON COLUMN "FORM_DRAFT"."CONTENT" IS '내용';

CREATE TABLE "FORM_TRANSFER" (
	"FORM_NO"	NUMBER		NULL,
	"APPROVAL_NO"	NUMBER		NULL,
	"EFFECTIVE_DATE"	VARCHAR2(20)		NOT NULL,
	"USER_NAME"	VARCHAR2(20)		NOT NULL,
	"DEPARTMENT_NAME"	VARCHAR2(20)		NOT NULL,
	"CURRENT_POSITION"	VARCHAR2(20)		NOT NULL,
	"PROMOTE_POSITION"	VARCHAR2(20)		NOT NULL,
	"REMARK"	VARCHAR2(200)		NULL
);

COMMENT ON COLUMN "FORM_TRANSFER"."FORM_NO" IS '양식번호';

COMMENT ON COLUMN "FORM_TRANSFER"."APPROVAL_NO" IS '전자결재번호';

COMMENT ON COLUMN "FORM_TRANSFER"."EFFECTIVE_DATE" IS '시행일자';

COMMENT ON COLUMN "FORM_TRANSFER"."USER_NAME" IS '이름';

COMMENT ON COLUMN "FORM_TRANSFER"."DEPARTMENT_NAME" IS '부서명';

COMMENT ON COLUMN "FORM_TRANSFER"."CURRENT_POSITION" IS '현직급';

COMMENT ON COLUMN "FORM_TRANSFER"."PROMOTE_POSITION" IS '승진직급';

COMMENT ON COLUMN "FORM_TRANSFER"."REMARK" IS '비고';

CREATE TABLE "FORM_CONSUME" (
	"FORM_NO"	NUMBER		NULL,
	"APPROVAL_NO"	NUMBER		NULL,
	"NAME"	VARCHAR2(50)		NOT NULL,
	"REASON"	VARCHAR2(200)		NOT NULL,
	"UNIT"	VARCHAR2(50)		NOT NULL,
	"COUNT"	NUMBER		NOT NULL,
	"PRICE"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "FORM_CONSUME"."FORM_NO" IS '양식번호';

COMMENT ON COLUMN "FORM_CONSUME"."APPROVAL_NO" IS '전자결재번호';

COMMENT ON COLUMN "FORM_CONSUME"."NAME" IS '품명';

COMMENT ON COLUMN "FORM_CONSUME"."REASON" IS '사유';

COMMENT ON COLUMN "FORM_CONSUME"."UNIT" IS '단위';

COMMENT ON COLUMN "FORM_CONSUME"."COUNT" IS '수량';

COMMENT ON COLUMN "FORM_CONSUME"."PRICE" IS '단가';

CREATE TABLE "POSITION" (
	"POSITION_NO"	NUMBER		NOT NULL,
	"POSITION_NAME"	VARCHAR2(10)		NOT NULL
);

CREATE TABLE "FORM_CASH" (
	"FORM_NO"	NUMBER		NULL,
	"APPROVAL_NO"	NUMBER		NULL,
	"ACCOUNT"	VARCHAR2(20)		NOT NULL,
	"USER_HISTORY"	VARCHAR2(200)		NOT NULL,
	"PRICE"	NUMBER		NOT NULL,
	"VAT"	NUMBER	DEFAULT 0	NULL
);

COMMENT ON COLUMN "FORM_CASH"."FORM_NO" IS '양식번호';

COMMENT ON COLUMN "FORM_CASH"."APPROVAL_NO" IS '전자결재번호';

COMMENT ON COLUMN "FORM_CASH"."ACCOUNT" IS '거래처';

COMMENT ON COLUMN "FORM_CASH"."USER_HISTORY" IS '사용내역';

COMMENT ON COLUMN "FORM_CASH"."PRICE" IS '금액';

COMMENT ON COLUMN "FORM_CASH"."VAT" IS '부가가치세';

CREATE TABLE "APP_CHANGE" (
	"CHANGE_NO"	NUMBER		NULL,
	"APPROVAL_NO"	NUMBER		NULL,
	"USER_NO"	NUMBER		NULL,
	"CONTENT"	VARCHAR2(500)		NOT NULL,
	"CREATE_DATE"	VARCHAR2(20)	DEFAULT SYSDATE	NULL,
	"ROLE"	VARCHAR2(10)		NOT NULL,
	"STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL
);

COMMENT ON COLUMN "APP_CHANGE"."CHANGE_NO" IS '변경사항번호';

COMMENT ON COLUMN "APP_CHANGE"."APPROVAL_NO" IS '전자결재번호';

COMMENT ON COLUMN "APP_CHANGE"."USER_NO" IS '회원번호';

COMMENT ON COLUMN "APP_CHANGE"."CONTENT" IS '내용';

COMMENT ON COLUMN "APP_CHANGE"."CREATE_DATE" IS '등록일';

COMMENT ON COLUMN "APP_CHANGE"."ROLE" IS '역할';

COMMENT ON COLUMN "APP_CHANGE"."STATUS" IS '상태';

CREATE TABLE "APP_PROCESS" (
	"APPROVAL_NO"	NUMBER		NULL,
	"USER_NO"	NUMBER		NULL,
	"ORDER"	NUMBER		NOT NULL,
	"APPROVAL_ROLE"	VARCHAR2(10)		NOT NULL,
	"STATUS"	VARCHAR2(10)		NULL,
	"APPROVAL_DATE"	VARCHAR2(20)		NULL,
	"BOOKMARK"	VARCHAR2(1)	DEFAULT 'N'	NULL
);

COMMENT ON COLUMN "APP_PROCESS"."APPROVAL_NO" IS '전자결재번호';

COMMENT ON COLUMN "APP_PROCESS"."USER_NO" IS '회원번호';

COMMENT ON COLUMN "APP_PROCESS"."ORDER" IS '순서';

COMMENT ON COLUMN "APP_PROCESS"."APPROVAL_ROLE" IS '결재역할';

COMMENT ON COLUMN "APP_PROCESS"."STATUS" IS '상태';

COMMENT ON COLUMN "APP_PROCESS"."APPROVAL_DATE" IS '결재일';

COMMENT ON COLUMN "APP_PROCESS"."BOOKMARK" IS '중요';

CREATE TABLE "ATTACHMENT" (
	"ATTACHMENT_NO"	number		NULL,
	"ORIGIN_NAME"	varchar2(50)		NOT NULL,
	"CHANGE_NAME"	varchar2(50)		NOT NULL,
	"CATEGORY_NO"	number		NOT NULL,
	"REF_NO"	number		NOT NULL
);

COMMENT ON COLUMN "ATTACHMENT"."ATTACHMENT_NO" IS '첨부파일번호';

COMMENT ON COLUMN "ATTACHMENT"."ORIGIN_NAME" IS '원본명';

COMMENT ON COLUMN "ATTACHMENT"."CHANGE_NAME" IS '수정명';

COMMENT ON COLUMN "ATTACHMENT"."CATEGORY_NO" IS '첨부파일유형';

COMMENT ON COLUMN "ATTACHMENT"."REF_NO" IS '참조게시글번호';

CREATE TABLE "DOCUMENT" (
	"DOC_NO"	number		NOT NULL,
	"DOC_TYPE"	number		NOT NULL,
	"DOC_NAME"	varchar2(500)		NOT NULL,
	"SAVE_PATH"	varchar2(1000)		NULL,
	"ORIGIN_NAME"	varchar2(500)		NULL,
	"CREATE_USER"	number		NOT NULL,
	"CREATE_DATE"	date	DEFAULT sysdate	NOT NULL,
	"MODIFY_DATE"	date	DEFAULT sysdate	NOT NULL,
	"DELETE_STATUS"	varchar2(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "DOCUMENT"."DOC_NO" IS '문서번호';

COMMENT ON COLUMN "DOCUMENT"."DOC_TYPE" IS '문서타입(1:회사문서/2:개인문서)';

COMMENT ON COLUMN "DOCUMENT"."DOC_NAME" IS '문서명';

COMMENT ON COLUMN "DOCUMENT"."SAVE_PATH" IS '첨부파일경로';

COMMENT ON COLUMN "DOCUMENT"."ORIGIN_NAME" IS '첨부파일원본명';

COMMENT ON COLUMN "DOCUMENT"."CREATE_USER" IS '등록유저번호';

COMMENT ON COLUMN "DOCUMENT"."CREATE_DATE" IS '등록일';

COMMENT ON COLUMN "DOCUMENT"."MODIFY_DATE" IS '수정일';

COMMENT ON COLUMN "DOCUMENT"."DELETE_STATUS" IS '삭제여부(Y: 삭제, N: 삭제X)';

CREATE TABLE "HOLIDAY_APPLY" (
	"HOLIDAY_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"H_TYPE"	VARCHAR2(5)		NOT NULL,
	"H_SORT"	VARCHAR2(5)		NULL,
	"H_START"	VARCHAR2(30)		NOT NULL,
	"H_FINISH"	VARCHAR2(30)		NOT NULL,
	"H_DATE"	VARCHAR2(30)		NULL,
	"H_REASON"	VARCHAR2(2000)		NOT NULL,
	"STATUS"	VARCHAR2(20)	DEFAULT '승인대기'	NOT NULL
);

COMMENT ON COLUMN "HOLIDAY_APPLY"."H_TYPE" IS '연차 | 반차';

COMMENT ON COLUMN "HOLIDAY_APPLY"."H_SORT" IS '오전 | 오후';

COMMENT ON COLUMN "HOLIDAY_APPLY"."STATUS" IS '승인|거절|승인대기';

CREATE TABLE "ROOM" (
	"ROOM_NO"	number		NOT NULL,
	"ROOM_NAME"	varchar2(500)		NOT NULL,
	"CREATE_DATE"	date	DEFAULT sysdate	NOT NULL,
	"MODIFY_DATE"	date	DEFAULT sysdate	NOT NULL,
	"CREATE_USER"	number		NOT NULL,
	"DELETE_STATUS"	varchar2(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "ROOM"."ROOM_NO" IS '회의실번호';

COMMENT ON COLUMN "ROOM"."ROOM_NAME" IS '회의실명';

COMMENT ON COLUMN "ROOM"."CREATE_DATE" IS '등록일';

COMMENT ON COLUMN "ROOM"."MODIFY_DATE" IS '수정일';

COMMENT ON COLUMN "ROOM"."CREATE_USER" IS '등록유저';

COMMENT ON COLUMN "ROOM"."DELETE_STATUS" IS '삭제여부(Y: 삭제, N: 삭제X)';

CREATE TABLE "WORK" (
	"WORK_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"WORK_DATE"	VARCHAR2(30)		NOT NULL,
	"WORK_IN"	VARCHAR2(30)	DEFAULT SYSDATE	NULL,
	"WORK_OUT"	VARCHAR2(30)	DEFAULT SYSDATE	NULL,
	"WORK_TIME"	VARCHAR2(30)	DEFAULT SYSDATE	NULL,
	"STATUS"	VARCHAR2(10)		NOT NULL
);

COMMENT ON COLUMN "WORK"."WORK_TIME" IS '하루 몇시간';

COMMENT ON COLUMN "WORK"."STATUS" IS '정상 | 지각 | 조퇴 | 결근 | 휴가';

CREATE TABLE "CAR" (
	"CAR_CODE"	number		NOT NULL,
	"CAR_NAME"	varchar2(300)		NOT NULL,
	"CAR_NUMBER"	varchar2(100)		NOT NULL,
	"CREATE_DATE"	date	DEFAULT sysdate	NOT NULL,
	"MODIFY_DATE"	date	DEFAULT sysdate	NOT NULL,
	"CREATE_USER"	number		NOT NULL,
	"DELETE_STATUS"	varchar2(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "CAR"."CAR_CODE" IS '차량코드';

COMMENT ON COLUMN "CAR"."CAR_NAME" IS '법인차량명';

COMMENT ON COLUMN "CAR"."CAR_NUMBER" IS '법인차량번호';

COMMENT ON COLUMN "CAR"."CREATE_DATE" IS '등록일';

COMMENT ON COLUMN "CAR"."MODIFY_DATE" IS '수정일';

COMMENT ON COLUMN "CAR"."CREATE_USER" IS '등록유저';

COMMENT ON COLUMN "CAR"."DELETE_STATUS" IS '삭제여부(Y: 삭제, N: 삭제X)';

CREATE TABLE "RES_ROOM" (
	"RES_NO"	number		NOT NULL,
	"RES_DATE"	varchar2(100)		NOT NULL,
	"START_TIME"	varchar2(100)		NOT NULL,
	"END_TIME"	varchar2(100)		NOT NULL,
	"SUBJECT"	varchar2(1000)		NOT NULL,
	"ROOM_NO"	number		NOT NULL,
	"RES_USER"	number		NOT NULL,
	"CREATE_DATE"	date	DEFAULT sysdate	NOT NULL,
	"MODIFY_DATE"	date	DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN "RES_ROOM"."RES_NO" IS '예약번호';

COMMENT ON COLUMN "RES_ROOM"."RES_DATE" IS '예약날짜';

COMMENT ON COLUMN "RES_ROOM"."START_TIME" IS '예약시작시간';

COMMENT ON COLUMN "RES_ROOM"."END_TIME" IS '예약종료시간';

COMMENT ON COLUMN "RES_ROOM"."SUBJECT" IS '회의명';

COMMENT ON COLUMN "RES_ROOM"."ROOM_NO" IS '예약회의실번호';

COMMENT ON COLUMN "RES_ROOM"."RES_USER" IS '예약자';

COMMENT ON COLUMN "RES_ROOM"."CREATE_DATE" IS '예약생성일';

COMMENT ON COLUMN "RES_ROOM"."MODIFY_DATE" IS '예약수정일';

CREATE TABLE "RES_CAR" (
	"RES_NO"	number		NOT NULL,
	"RENTAL_DATE"	varchar2(100)		NOT NULL,
	"RENTAL_TIME"	varchar2(100)		NOT NULL,
	"RETURN_DATE"	varchar2(100)		NOT NULL,
	"RETURN_TIME"	varchar2(100)		NOT NULL,
	"USAGE"	varchar2(1000)		NOT NULL,
	"CAR_CODE"	number		NOT NULL,
	"RES_USER"	number		NOT NULL,
	"CREATE_DATE"	date	DEFAULT sysdate	NOT NULL,
	"MODIFY_DATE"	date	DEFAULT sysdate	NOT NULL
);

COMMENT ON COLUMN "RES_CAR"."RES_NO" IS '예약번호';

COMMENT ON COLUMN "RES_CAR"."RENTAL_DATE" IS '대여일';

COMMENT ON COLUMN "RES_CAR"."RENTAL_TIME" IS '대여시간';

COMMENT ON COLUMN "RES_CAR"."RETURN_DATE" IS '반납일';

COMMENT ON COLUMN "RES_CAR"."RETURN_TIME" IS '반납시간';

COMMENT ON COLUMN "RES_CAR"."USAGE" IS '사용용도';

COMMENT ON COLUMN "RES_CAR"."CAR_CODE" IS '대여차량코드';

COMMENT ON COLUMN "RES_CAR"."RES_USER" IS '예약자번호';

COMMENT ON COLUMN "RES_CAR"."CREATE_DATE" IS '예약생성일';

COMMENT ON COLUMN "RES_CAR"."MODIFY_DATE" IS '예약수정일';

CREATE TABLE "PROJECT" (
	"PROJECT_NO"	number		NOT NULL,
	"PROJECT_MANAGER"	number		NOT NULL,
	"PROJECT_NAME"	varchar2(500)		NOT NULL,
	"START_DATE"	varchar2(100)		NOT NULL,
	"END_DATE"	varchar2(100)		NOT NULL,
	"DETAIL"	varchar2(4000)		NOT NULL,
	"CREATE_DATE"	date	DEFAULT sysdate	NOT NULL,
	"MODIFY_DATE"	date	DEFAULT sysdate	NOT NULL,
	"DELETE_STATUS"	varchar2(1)		NOT NULL
);

COMMENT ON COLUMN "PROJECT"."PROJECT_NO" IS '프로젝트번호';

COMMENT ON COLUMN "PROJECT"."PROJECT_MANAGER" IS 'PM유저번호(프로젝트생성자)';

COMMENT ON COLUMN "PROJECT"."PROJECT_NAME" IS '프로젝트명';

COMMENT ON COLUMN "PROJECT"."START_DATE" IS '시작일';

COMMENT ON COLUMN "PROJECT"."END_DATE" IS '종료일';

COMMENT ON COLUMN "PROJECT"."DETAIL" IS '프로젝트 상세내용';

COMMENT ON COLUMN "PROJECT"."CREATE_DATE" IS '프로젝트생성일';

COMMENT ON COLUMN "PROJECT"."MODIFY_DATE" IS '프로젝트수정일';

COMMENT ON COLUMN "PROJECT"."DELETE_STATUS" IS '삭제여부(Y: 삭제, N: 삭제X)';

CREATE TABLE "MAIL_ATTACHMENT" (
	"FILE_NO"	NUMBER		NOT NULL,
	"MAIL_NO"	NUMBER		NOT NULL,
	"ORIGIN_NAME"	VARCHAR2(100)		NOT NULL,
	"CHANE_NAME"	VARCHAR2(200)		NOT NULL
);

CREATE TABLE "TASK" (
	"TASK_NO"	number		NOT NULL,
	"PROJECT_NO"	number		NOT NULL,
	"ASSIGN_USER"	number		NOT NULL,
	"TASK_NAME"	varchar2(500)		NOT NULL,
	"TASK_CONTENT"	varchar2(4000)		NOT NULL,
	"FILE_PATH"	varchar2(1000)		NULL,
	"FILE_ORIGIN_NAME"	varchar2(500)		NULL,
	"TASK_STATUS"	varchar2(50)		NOT NULL,
	"CREATE_DATE"	date	DEFAULT sysdate	NOT NULL,
	"MODIFY_DATE"	date	DEFAULT sysdate	NOT NULL,
	"DELETE_STATUS"	varchar2(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "TASK"."TASK_NO" IS '작업번호';

COMMENT ON COLUMN "TASK"."PROJECT_NO" IS '프로젝트번호';

COMMENT ON COLUMN "TASK"."ASSIGN_USER" IS '담당자(작업생성자)';

COMMENT ON COLUMN "TASK"."TASK_NAME" IS '작업명';

COMMENT ON COLUMN "TASK"."TASK_CONTENT" IS '작업내용';

COMMENT ON COLUMN "TASK"."FILE_PATH" IS '첨부파일경로';

COMMENT ON COLUMN "TASK"."FILE_ORIGIN_NAME" IS '첨부파일원본명';

COMMENT ON COLUMN "TASK"."TASK_STATUS" IS '작업상태(1:대기, 2:진행중, 3:완료, 4:보류)';

COMMENT ON COLUMN "TASK"."CREATE_DATE" IS '작업생성일';

COMMENT ON COLUMN "TASK"."MODIFY_DATE" IS '작업수정일';

COMMENT ON COLUMN "TASK"."DELETE_STATUS" IS '삭제여부(Y:삭제, N:삭제X)';

CREATE TABLE "ADDRESS_LIKE" (
	"USER_NO"	NUMBER		NOT NULL,
	"LIKE_USER"	NUMBER		NOT NULL
);

CREATE TABLE "NOTICE" (
	"NOTICE_NO"	NUMBER		NOT NULL,
	"NOTICE_WRITER"	NUMBER		NOT NULL,
	"NOTICE_TITLE"	VARCHAR2(200)		NOT NULL,
	"NOTICE_CONTENT"	CLOB		NOT NULL,
	"COUNT"	NUMBER	DEFAULT 0	NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"MODIFY_DATE"	DATE		NULL,
	"STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL,
	"IMPORTANT"	VARCHAR2(1)	DEFAULT 'N'	NULL
);

COMMENT ON COLUMN "NOTICE"."NOTICE_NO" IS '공지사항번호';

COMMENT ON COLUMN "NOTICE"."NOTICE_WRITER" IS '작성자회원번호';

COMMENT ON COLUMN "NOTICE"."NOTICE_TITLE" IS '공지사항제목';

COMMENT ON COLUMN "NOTICE"."NOTICE_CONTENT" IS '공지사항내용';

COMMENT ON COLUMN "NOTICE"."COUNT" IS '조회수';

COMMENT ON COLUMN "NOTICE"."CREATE_DATE" IS '공지사항작성일';

COMMENT ON COLUMN "NOTICE"."MODIFY_DATE" IS '공지사항수정일';

COMMENT ON COLUMN "NOTICE"."STATUS" IS '공지사항등록상태';

COMMENT ON COLUMN "NOTICE"."IMPORTANT" IS '중요공지사항여부';

CREATE TABLE "BOARD" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"BOARD_WRITER"	NUMBER		NOT NULL,
	"BOARD_TITLE"	VARCHAR2(200)		NOT NULL,
	"BOARD_CONTENT"	VARCHAR2(4000)		NOT NULL,
	"COUNT"	NUMBER	DEFAULT 0	NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"MODIFY_DATE"	DATE		NULL,
	"STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL,
	"BLIND_STA"	VARCHAR2(1)	DEFAULT 'N'	NULL
);

COMMENT ON COLUMN "BOARD"."BOARD_NO" IS '게시글번호';

COMMENT ON COLUMN "BOARD"."BOARD_WRITER" IS '작성자회원번호';

COMMENT ON COLUMN "BOARD"."BOARD_TITLE" IS '익명게시판제목';

COMMENT ON COLUMN "BOARD"."BOARD_CONTENT" IS '익명게시판내용';

COMMENT ON COLUMN "BOARD"."COUNT" IS '조회수';

COMMENT ON COLUMN "BOARD"."CREATE_DATE" IS '익명게시판작성일';

COMMENT ON COLUMN "BOARD"."MODIFY_DATE" IS '익명게시판수정일';

COMMENT ON COLUMN "BOARD"."STATUS" IS '익명게시판등록상태';

COMMENT ON COLUMN "BOARD"."BLIND_STA" IS '블라인드여부';

CREATE TABLE "CHAT" (
	"CHAT_NO"	NUMBER		NOT NULL,
	"ROOM_NO"	NUMBER		NOT NULL,
	"SEND_NO"	NUMBER		NOT NULL,
	"CHAT_CONTENT"	VARCHAR2(3000)		NOT NULL,
	"SEND_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"NOT_READ"	NUMBER		NULL
);

COMMENT ON COLUMN "CHAT"."CHAT_NO" IS '채팅번호';

COMMENT ON COLUMN "CHAT"."ROOM_NO" IS '채팅방번호';

COMMENT ON COLUMN "CHAT"."SEND_NO" IS '발신자회원번호';

COMMENT ON COLUMN "CHAT"."CHAT_CONTENT" IS '채팅내용';

COMMENT ON COLUMN "CHAT"."SEND_DATE" IS '채팅전송시간';

COMMENT ON COLUMN "CHAT"."NOT_READ" IS '읽지않은회원수';

CREATE TABLE "NOTIFICATION" (
	"NF_NO"	NUMBER		NOT NULL,
	"SEND_NO"	NUMBER		NOT NULL,
	"RECEIVE_NO"	NUMBER		NOT NULL,
	"CAT_NO"	NUMBER		NOT NULL,
	"DCAT_NO"	NUMBER		NOT NULL,
	"NF_CONTENT"	VARCHAR2(2000)		NULL,
	"NF_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"CHECK_STA"	VARCHAR2(1)	DEFAULT 'N'	NULL,
	"DELETE_STA"	VARCHAR2(1)	DEFAULT 'N'	NULL
);

COMMENT ON COLUMN "NOTIFICATION"."NF_NO" IS '알림번호';

COMMENT ON COLUMN "NOTIFICATION"."SEND_NO" IS '발신자회원번호';

COMMENT ON COLUMN "NOTIFICATION"."RECEIVE_NO" IS '수신자회원번호(1,2,3...)';

COMMENT ON COLUMN "NOTIFICATION"."CAT_NO" IS '카테고리번호';

COMMENT ON COLUMN "NOTIFICATION"."DCAT_NO" IS '세부카테고리번호';

COMMENT ON COLUMN "NOTIFICATION"."NF_CONTENT" IS '알림내용';

COMMENT ON COLUMN "NOTIFICATION"."NF_DATE" IS '알림시간';

COMMENT ON COLUMN "NOTIFICATION"."CHECK_STA" IS '조회여부';

COMMENT ON COLUMN "NOTIFICATION"."DELETE_STA" IS '삭제여부';

CREATE TABLE "LIKEHATE" (
	"BOARD_NO"	NUMBER		NOT NULL,
	"MEM_NO"	NUMBER		NOT NULL,
	"STATUS"	VARCHAR2(1)		NOT NULL
);

COMMENT ON COLUMN "LIKEHATE"."BOARD_NO" IS '게시글번호';

COMMENT ON COLUMN "LIKEHATE"."MEM_NO" IS '회원번호';

COMMENT ON COLUMN "LIKEHATE"."STATUS" IS '좋아요(0)/싫어요(1)';

CREATE TABLE "REPORT" (
	"REPORT_BNO"	NUMBER		NOT NULL,
	"REPORT_MNO"	NUMBER		NOT NULL,
	"REPORT_KIND"	VARCHAR2(100)		NOT NULL,
	"REPORT_CONTENT"	VARCHAR2(2000)		NOT NULL,
	"REPORT_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"MODIFY_DATE"	DATE		NULL,
	"REPORT_STA"	VARCHAR2(1)	DEFAULT 0	NULL,
	"STATUS"	VARCHAR2(1)	DEFAULT 'Y'	NULL
);

COMMENT ON COLUMN "REPORT"."REPORT_BNO" IS '신고게시글번호';

COMMENT ON COLUMN "REPORT"."REPORT_MNO" IS '신고자회원번호';

COMMENT ON COLUMN "REPORT"."REPORT_KIND" IS '신고구분';

COMMENT ON COLUMN "REPORT"."REPORT_CONTENT" IS '신고내용';

COMMENT ON COLUMN "REPORT"."REPORT_DATE" IS '신고일';

COMMENT ON COLUMN "REPORT"."MODIFY_DATE" IS '처리일';

COMMENT ON COLUMN "REPORT"."REPORT_STA" IS '처리상태';

COMMENT ON COLUMN "REPORT"."STATUS" IS '등록상태';

CREATE TABLE "CHATROOM" (
	"ROOM_NO"	NUMBER		NOT NULL,
	"ROOM_NAME"	VARCHAR2(1000)		NULL,
	"LAST_CHAT"	VARCHAR2(3000)		NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"MODIFY_DATE"	DATE		NULL
);

COMMENT ON COLUMN "CHATROOM"."ROOM_NO" IS '채팅방번호';

COMMENT ON COLUMN "CHATROOM"."ROOM_NAME" IS '채팅방이름';

COMMENT ON COLUMN "CHATROOM"."LAST_CHAT" IS '마지막채팅';

COMMENT ON COLUMN "CHATROOM"."CREATE_DATE" IS '채팅방생성일';

COMMENT ON COLUMN "CHATROOM"."MODIFY_DATE" IS '채팅방수정일';

CREATE TABLE "AUTHORITY" (
	"AUTHORITY_NO"	NUMBER		NOT NULL,
	"AUTHORITY_NAME"	VARCHAR2(10)		NULL
);

CREATE TABLE "PARTICIPANT" (
	"ROOM_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"NOTREAD_CHAT"	NUMBER		NULL,
	"LASTREAD_CHAT"	NUMBER		NULL,
	"CREATE_DATE"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "PARTICIPANT"."ROOM_NO" IS '채팅방번호';

COMMENT ON COLUMN "PARTICIPANT"."USER_NO" IS '회원번호';

COMMENT ON COLUMN "PARTICIPANT"."NOTREAD_CHAT" IS '읽지않은채팅수';

COMMENT ON COLUMN "PARTICIPANT"."LASTREAD_CHAT" IS '마지막으로읽은채팅번호';

COMMENT ON COLUMN "PARTICIPANT"."CREATE_DATE" IS '생성일자';

CREATE TABLE "MAIL" (
	"MAIL_NO"	NUMBER		NOT NULL,
	"SENDER"	NUMBER		NOT NULL,
	"SENDER_EMAIL"	VARCHAR2(40)		NOT NULL,
	"RECIPIENT_MAIL"	VARCHAR2(40)		NULL,
	"REFERENCE_MAIL"	VARCHAR2(40)		NULL,
	"HIDDEN_REFERENCE_MAIL"	VARCHAR2(40)		NULL,
	"MAIL_TITLE"	VARCHAR2(100)	DEFAULT '제목없음'	NULL,
	"MAIL_CONTENT"	CLOB		NULL,
	"SENT_DATE"	DATE	DEFAULT SYSDATE	NULL,
	"TEMP_DATE"	VARCHAR2(1)	DEFAULT 'N'	NOT NULL
);

COMMENT ON COLUMN "MAIL"."RECIPIENT_MAIL" IS '이메일,이메일,이메일..';

COMMENT ON COLUMN "MAIL"."REFERENCE_MAIL" IS '이메일,이메일,이메일..';

COMMENT ON COLUMN "MAIL"."HIDDEN_REFERENCE_MAIL" IS '이메일,이메일,이메일..';

CREATE TABLE "MAIL_STATUS" (
	"MAIL_NO"	NUMBER		NOT NULL,
	"SENDER_MAIL"	VARCHAR2(40)		NOT NULL,
	"RECIPIENT_MAIL"	VARCHAR2(40)		NULL,
	"MAIL_TYPE"	NUMBER		NULL,
	"READ_DATE"	DATE		NULL,
	"BIN_STATUS"	VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	"IMPORTANT_STATUS"	VARCHAR2(1)	DEFAULT 'N'	NOT NULL,
	"DELETE_DATE"	DATE		NULL
);

COMMENT ON COLUMN "MAIL_STATUS"."RECIPIENT_MAIL" IS '보낸메일일 경우 NULL';

COMMENT ON COLUMN "MAIL_STATUS"."MAIL_TYPE" IS '1받은메일/2보낸메일/3참조메일/4숨은참조메일';

COMMENT ON COLUMN "MAIL_STATUS"."READ_DATE" IS '이걸로 읽음여부는 판단가능';

COMMENT ON COLUMN "MAIL_STATUS"."DELETE_DATE" IS '스케줄링을 위해서 필요';

CREATE TABLE "HOLIDAY" (
	"HOLI_NO"	NUMBER		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL,
	"H_GIVE"	number		NULL,
	"H_DATE"	varchar2(30)	DEFAULT sysdate	NULL,
	"H_CAUSE"	varchar2(300)		NULL,
	"H_REMAIN"	varchar2(30)		NULL
);

CREATE TABLE "R_PARTICIPANT" (
	"RES_NO"	number		NOT NULL,
	"USER_NO"	NUMBER		NOT NULL
);

COMMENT ON COLUMN "R_PARTICIPANT"."RES_NO" IS '예약번호';

CREATE TABLE "P_PARTICIPANT" (
	"PROJECT_NO"	number		NULL,
	"TASK_NO"	number		NULL,
	"DEPARTMENT_NO"	NUMBER		NOT NULL,
	"USER_NO"	number		NOT NULL
);

COMMENT ON COLUMN "P_PARTICIPANT"."PROJECT_NO" IS '프로젝트번호';

COMMENT ON COLUMN "P_PARTICIPANT"."TASK_NO" IS '작업번호';

COMMENT ON COLUMN "P_PARTICIPANT"."DEPARTMENT_NO" IS '프로젝트참여부서';

COMMENT ON COLUMN "P_PARTICIPANT"."USER_NO" IS '작업자/참조자';

CREATE TABLE "CHAT_LIKE" (
	"MYUSER_NO"	NUMBER		NOT NULL,
	"LIKEUSER_NO"	NUMBER		NOT NULL,
	"LIKE_DATE"	DATE	DEFAULT SYSDATE	NULL
);

COMMENT ON COLUMN "CHAT_LIKE"."MYUSER_NO" IS '기준회원번호';

COMMENT ON COLUMN "CHAT_LIKE"."LIKEUSER_NO" IS '즐겨찾는회원번호';

COMMENT ON COLUMN "CHAT_LIKE"."LIKE_DATE" IS '즐겨찾기추가일';

CREATE TABLE "COMPANY_SCH" (
	"SCH_NO"	NUMBER		NOT NULL,
	"SCH_KIND"	VARCHAR2(1)		NOT NULL,
	"RESTDAY_KIND"	VARCHAR2(1)		NULL,
	"SCH_NAME"	VARCHAR2(500)		NOT NULL,
	"SCH_CONTENT"	VARCHAR2(2000)		NULL,
	"SCH_LOCATION"	VARCHAR2(1000)		NULL,
	"LUNAR_SOLAR"	VARCHAR2(1)		NULL,
	"START_DATE"	VARCHAR2(100)		NULL,
	"END_DATE"	VARCHAR2(100)		NULL,
	"ANNUAL"	VARCHAR2(1)		NULL,
	"START_TIME"	VARCHAR2(100)		NULL,
	"END_TIME"	VARCHAR2(100)		NULL,
	"ALLDAY"	VARCHAR2(1)		NULL,
	"LEGALHOLLIDAY"	VARCHAR2(1)		NULL
);

COMMENT ON COLUMN "COMPANY_SCH"."SCH_NO" IS '일정번호';

COMMENT ON COLUMN "COMPANY_SCH"."SCH_KIND" IS '일정종류(0:쉬는날,1:회사일정)';

COMMENT ON COLUMN "COMPANY_SCH"."RESTDAY_KIND" IS '쉬는날종류(0:휴일,1:기념일)';

COMMENT ON COLUMN "COMPANY_SCH"."SCH_NAME" IS '이름';

COMMENT ON COLUMN "COMPANY_SCH"."SCH_CONTENT" IS '내용';

COMMENT ON COLUMN "COMPANY_SCH"."SCH_LOCATION" IS '장소';

COMMENT ON COLUMN "COMPANY_SCH"."LUNAR_SOLAR" IS '양음력(0:양력,1:음력)';

COMMENT ON COLUMN "COMPANY_SCH"."START_DATE" IS '시작날짜';

COMMENT ON COLUMN "COMPANY_SCH"."END_DATE" IS '종료날짜';

COMMENT ON COLUMN "COMPANY_SCH"."ANNUAL" IS '매년반복여부';

COMMENT ON COLUMN "COMPANY_SCH"."START_TIME" IS '시작시간';

COMMENT ON COLUMN "COMPANY_SCH"."END_TIME" IS '종료시간';

COMMENT ON COLUMN "COMPANY_SCH"."ALLDAY" IS '종일여부';

COMMENT ON COLUMN "COMPANY_SCH"."LEGALHOLLIDAY" IS '법정공휴일여부';

ALTER TABLE "DEPT" ADD CONSTRAINT "PK_DEPT" PRIMARY KEY (
	"DEPARTMENT_NO"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "PK_MEMBER" PRIMARY KEY (
	"USER_NO"
);

ALTER TABLE "APPROVAL" ADD CONSTRAINT "PK_APPROVAL" PRIMARY KEY (
	"APPROVAL_NO"
);

ALTER TABLE "FORM_DRAFT" ADD CONSTRAINT "PK_FORM_DRAFT" PRIMARY KEY (
	"FORM_NO"
);

ALTER TABLE "FORM_TRANSFER" ADD CONSTRAINT "PK_FORM_TRANSFER" PRIMARY KEY (
	"FORM_NO"
);

ALTER TABLE "FORM_CONSUME" ADD CONSTRAINT "PK_FORM_CONSUME" PRIMARY KEY (
	"FORM_NO"
);

ALTER TABLE "POSITION" ADD CONSTRAINT "PK_POSITION" PRIMARY KEY (
	"POSITION_NO"
);

ALTER TABLE "FORM_CASH" ADD CONSTRAINT "PK_FORM_CASH" PRIMARY KEY (
	"FORM_NO"
);

ALTER TABLE "APP_CHANGE" ADD CONSTRAINT "PK_APP_CHANGE" PRIMARY KEY (
	"CHANGE_NO"
);

ALTER TABLE "ATTACHMENT" ADD CONSTRAINT "PK_ATTACHMENT" PRIMARY KEY (
	"ATTACHMENT_NO"
);

ALTER TABLE "DOCUMENT" ADD CONSTRAINT "PK_DOCUMENT" PRIMARY KEY (
	"DOC_NO"
);

ALTER TABLE "HOLIDAY_APPLY" ADD CONSTRAINT "PK_HOLIDAY_APPLY" PRIMARY KEY (
	"HOLIDAY_NO",
	"USER_NO"
);

ALTER TABLE "ROOM" ADD CONSTRAINT "PK_ROOM" PRIMARY KEY (
	"ROOM_NO"
);

ALTER TABLE "WORK" ADD CONSTRAINT "PK_WORK" PRIMARY KEY (
	"WORK_NO"
);

ALTER TABLE "CAR" ADD CONSTRAINT "PK_CAR" PRIMARY KEY (
	"CAR_CODE"
);

ALTER TABLE "RES_ROOM" ADD CONSTRAINT "PK_RES_ROOM" PRIMARY KEY (
	"RES_NO"
);

ALTER TABLE "RES_CAR" ADD CONSTRAINT "PK_RES_CAR" PRIMARY KEY (
	"RES_NO"
);

ALTER TABLE "PROJECT" ADD CONSTRAINT "PK_PROJECT" PRIMARY KEY (
	"PROJECT_NO"
);

ALTER TABLE "MAIL_ATTACHMENT" ADD CONSTRAINT "PK_MAIL_ATTACHMENT" PRIMARY KEY (
	"FILE_NO"
);

ALTER TABLE "TASK" ADD CONSTRAINT "PK_TASK" PRIMARY KEY (
	"TASK_NO"
);

ALTER TABLE "NOTICE" ADD CONSTRAINT "PK_NOTICE" PRIMARY KEY (
	"NOTICE_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "PK_BOARD" PRIMARY KEY (
	"BOARD_NO"
);

ALTER TABLE "CHAT" ADD CONSTRAINT "PK_CHAT" PRIMARY KEY (
	"CHAT_NO"
);

ALTER TABLE "NOTIFICATION" ADD CONSTRAINT "PK_NOTIFICATION" PRIMARY KEY (
	"NF_NO"
);

ALTER TABLE "LIKEHATE" ADD CONSTRAINT "PK_LIKEHATE" PRIMARY KEY (
	"BOARD_NO",
	"MEM_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "PK_REPORT" PRIMARY KEY (
	"REPORT_BNO",
	"REPORT_MNO"
);

ALTER TABLE "CHATROOM" ADD CONSTRAINT "PK_CHATROOM" PRIMARY KEY (
	"ROOM_NO"
);

ALTER TABLE "AUTHORITY" ADD CONSTRAINT "PK_AUTHORITY" PRIMARY KEY (
	"AUTHORITY_NO"
);

ALTER TABLE "PARTICIPANT" ADD CONSTRAINT "PK_PARTICIPANT" PRIMARY KEY (
	"ROOM_NO",
	"USER_NO"
);

ALTER TABLE "MAIL" ADD CONSTRAINT "PK_MAIL" PRIMARY KEY (
	"MAIL_NO"
);

ALTER TABLE "HOLIDAY" ADD CONSTRAINT "PK_HOLIDAY" PRIMARY KEY (
	"HOLI_NO"
);

ALTER TABLE "COMPANY_SCH" ADD CONSTRAINT "PK_COMPANY_SCH" PRIMARY KEY (
	"SCH_NO"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "FK_POSITION_TO_MEMBER_1" FOREIGN KEY (
	"POSITION"
)
REFERENCES "POSITION" (
	"POSITION_NO"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "FK_DEPT_TO_MEMBER_1" FOREIGN KEY (
	"DEPARTMENT"
)
REFERENCES "DEPT" (
	"DEPARTMENT_NO"
);

ALTER TABLE "MEMBER" ADD CONSTRAINT "FK_AUTHORITY_TO_MEMBER_1" FOREIGN KEY (
	"AUTHORITY_NO"
)
REFERENCES "AUTHORITY" (
	"AUTHORITY_NO"
);

ALTER TABLE "APPROVAL" ADD CONSTRAINT "FK_MEMBER_TO_APPROVAL_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "APPROVAL" ADD CONSTRAINT "FK_DEPT_TO_APPROVAL_1" FOREIGN KEY (
	"DEPARTMENT_NO"
)
REFERENCES "DEPT" (
	"DEPARTMENT_NO"
);

ALTER TABLE "APPROVAL" ADD CONSTRAINT "FK_POSITION_TO_APPROVAL_1" FOREIGN KEY (
	"POSITION_NO"
)
REFERENCES "POSITION" (
	"POSITION_NO"
);

ALTER TABLE "FORM_DRAFT" ADD CONSTRAINT "FK_APPROVAL_TO_FORM_DRAFT_1" FOREIGN KEY (
	"APPROVAL_NO"
)
REFERENCES "APPROVAL" (
	"APPROVAL_NO"
);

ALTER TABLE "FORM_DRAFT" ADD CONSTRAINT "FK_DEPT_TO_FORM_DRAFT_1" FOREIGN KEY (
	"DEPARTMENT_NO"
)
REFERENCES "DEPT" (
	"DEPARTMENT_NO"
);

ALTER TABLE "FORM_TRANSFER" ADD CONSTRAINT "FK_APPROVAL_TO_FORM_TRANSFER_1" FOREIGN KEY (
	"APPROVAL_NO"
)
REFERENCES "APPROVAL" (
	"APPROVAL_NO"
);

ALTER TABLE "FORM_CONSUME" ADD CONSTRAINT "FK_APPROVAL_TO_FORM_CONSUME_1" FOREIGN KEY (
	"APPROVAL_NO"
)
REFERENCES "APPROVAL" (
	"APPROVAL_NO"
);

ALTER TABLE "FORM_CASH" ADD CONSTRAINT "FK_APPROVAL_TO_FORM_CASH_1" FOREIGN KEY (
	"APPROVAL_NO"
)
REFERENCES "APPROVAL" (
	"APPROVAL_NO"
);

ALTER TABLE "APP_CHANGE" ADD CONSTRAINT "FK_APPROVAL_TO_APP_CHANGE_1" FOREIGN KEY (
	"APPROVAL_NO"
)
REFERENCES "APPROVAL" (
	"APPROVAL_NO"
);

ALTER TABLE "APP_CHANGE" ADD CONSTRAINT "FK_MEMBER_TO_APP_CHANGE_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "APP_PROCESS" ADD CONSTRAINT "FK_APPROVAL_TO_APP_PROCESS_1" FOREIGN KEY (
	"APPROVAL_NO"
)
REFERENCES "APPROVAL" (
	"APPROVAL_NO"
);

ALTER TABLE "APP_PROCESS" ADD CONSTRAINT "FK_MEMBER_TO_APP_PROCESS_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "DOCUMENT" ADD CONSTRAINT "FK_MEMBER_TO_DOCUMENT_1" FOREIGN KEY (
	"CREATE_USER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "HOLIDAY_APPLY" ADD CONSTRAINT "FK_MEMBER_TO_HOLIDAY_APPLY_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "ROOM" ADD CONSTRAINT "FK_MEMBER_TO_ROOM_1" FOREIGN KEY (
	"CREATE_USER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "WORK" ADD CONSTRAINT "FK_MEMBER_TO_WORK_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "CAR" ADD CONSTRAINT "FK_MEMBER_TO_CAR_1" FOREIGN KEY (
	"CREATE_USER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "RES_ROOM" ADD CONSTRAINT "FK_ROOM_TO_RES_ROOM_1" FOREIGN KEY (
	"ROOM_NO"
)
REFERENCES "ROOM" (
	"ROOM_NO"
);

ALTER TABLE "RES_ROOM" ADD CONSTRAINT "FK_MEMBER_TO_RES_ROOM_1" FOREIGN KEY (
	"RES_USER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "RES_CAR" ADD CONSTRAINT "FK_CAR_TO_RES_CAR_1" FOREIGN KEY (
	"CAR_CODE"
)
REFERENCES "CAR" (
	"CAR_CODE"
);

ALTER TABLE "RES_CAR" ADD CONSTRAINT "FK_MEMBER_TO_RES_CAR_1" FOREIGN KEY (
	"RES_USER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "PROJECT" ADD CONSTRAINT "FK_MEMBER_TO_PROJECT_1" FOREIGN KEY (
	"PROJECT_MANAGER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "MAIL_ATTACHMENT" ADD CONSTRAINT "FK_MAIL_TO_MAIL_ATTACHMENT_1" FOREIGN KEY (
	"MAIL_NO"
)
REFERENCES "MAIL" (
	"MAIL_NO"
);

ALTER TABLE "TASK" ADD CONSTRAINT "FK_PROJECT_TO_TASK_1" FOREIGN KEY (
	"PROJECT_NO"
)
REFERENCES "PROJECT" (
	"PROJECT_NO"
);

ALTER TABLE "TASK" ADD CONSTRAINT "FK_MEMBER_TO_TASK_1" FOREIGN KEY (
	"ASSIGN_USER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "ADDRESS_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_ADDRESS_LIKE_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "NOTICE" ADD CONSTRAINT "FK_MEMBER_TO_NOTICE_1" FOREIGN KEY (
	"NOTICE_WRITER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "BOARD" ADD CONSTRAINT "FK_MEMBER_TO_BOARD_1" FOREIGN KEY (
	"BOARD_WRITER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "CHAT" ADD CONSTRAINT "FK_CHATROOM_TO_CHAT_1" FOREIGN KEY (
	"ROOM_NO"
)
REFERENCES "CHATROOM" (
	"ROOM_NO"
);

ALTER TABLE "CHAT" ADD CONSTRAINT "FK_MEMBER_TO_CHAT_1" FOREIGN KEY (
	"SEND_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "NOTIFICATION" ADD CONSTRAINT "FK_MEMBER_TO_NOTIFICATION_1" FOREIGN KEY (
	"SEND_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "LIKEHATE" ADD CONSTRAINT "FK_BOARD_TO_LIKEHATE_1" FOREIGN KEY (
	"BOARD_NO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "LIKEHATE" ADD CONSTRAINT "FK_MEMBER_TO_LIKEHATE_1" FOREIGN KEY (
	"MEM_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_BOARD_TO_REPORT_1" FOREIGN KEY (
	"REPORT_BNO"
)
REFERENCES "BOARD" (
	"BOARD_NO"
);

ALTER TABLE "REPORT" ADD CONSTRAINT "FK_MEMBER_TO_REPORT_1" FOREIGN KEY (
	"REPORT_MNO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "PARTICIPANT" ADD CONSTRAINT "FK_CHATROOM_TO_PARTICIPANT_1" FOREIGN KEY (
	"ROOM_NO"
)
REFERENCES "CHATROOM" (
	"ROOM_NO"
);

ALTER TABLE "PARTICIPANT" ADD CONSTRAINT "FK_MEMBER_TO_PARTICIPANT_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "MAIL" ADD CONSTRAINT "FK_MEMBER_TO_MAIL_1" FOREIGN KEY (
	"SENDER"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "MAIL_STATUS" ADD CONSTRAINT "FK_MAIL_TO_MAIL_STATUS_1" FOREIGN KEY (
	"MAIL_NO"
)
REFERENCES "MAIL" (
	"MAIL_NO"
);

ALTER TABLE "HOLIDAY" ADD CONSTRAINT "FK_MEMBER_TO_HOLIDAY_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "R_PARTICIPANT" ADD CONSTRAINT "FK_RES_ROOM_TO_R_PARTICIPANT_1" FOREIGN KEY (
	"RES_NO"
)
REFERENCES "RES_ROOM" (
	"RES_NO"
);

ALTER TABLE "R_PARTICIPANT" ADD CONSTRAINT "FK_MEMBER_TO_R_PARTICIPANT_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "P_PARTICIPANT" ADD CONSTRAINT "FK_PROJECT_TO_P_PARTICIPANT_1" FOREIGN KEY (
	"PROJECT_NO"
)
REFERENCES "PROJECT" (
	"PROJECT_NO"
);

ALTER TABLE "P_PARTICIPANT" ADD CONSTRAINT "FK_TASK_TO_P_PARTICIPANT_1" FOREIGN KEY (
	"TASK_NO"
)
REFERENCES "TASK" (
	"TASK_NO"
);

ALTER TABLE "P_PARTICIPANT" ADD CONSTRAINT "FK_DEPT_TO_P_PARTICIPANT_1" FOREIGN KEY (
	"DEPARTMENT_NO"
)
REFERENCES "DEPT" (
	"DEPARTMENT_NO"
);

ALTER TABLE "P_PARTICIPANT" ADD CONSTRAINT "FK_MEMBER_TO_P_PARTICIPANT_1" FOREIGN KEY (
	"USER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "CHAT_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_CHAT_LIKE_1" FOREIGN KEY (
	"MYUSER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

ALTER TABLE "CHAT_LIKE" ADD CONSTRAINT "FK_MEMBER_TO_CHAT_LIKE_2" FOREIGN KEY (
	"LIKEUSER_NO"
)
REFERENCES "MEMBER" (
	"USER_NO"
);

-- 시퀀스
CREATE SEQUENCE SEQ_CHATROOMNO
NOCACHE; -- 채팅방

CREATE SEQUENCE SEQ_CHATNO
NOCACHE; -- 채팅

CREATE SEQUENCE SEQ_NOTNO
NOCACHE; -- 알림

CREATE SEQUENCE SEQ_BNO
NOCACHE; -- 익명게시판

CREATE SEQUENCE SEQ_NNO
NOCACHE; -- 공지사항

CREATE SEQUENCE SEQ_SCHNO
NOCACHE; -- 회사일정

create sequence seq_atno
NOCACHE; -- 첨부파일(전자결재/공지)

CREATE SEQUENCE SEQ_APNO
NOCACHE; -- 전자결재

CREATE SEQUENCE SEQ_CONO
NOCACHE; -- 결재문서

CREATE SEQUENCE SEQ_CHNO
NOCACHE; -- 변경사항

CREATE SEQUENCE SEQ_FONO
NOCACHE; -- 양식

CREATE SEQUENCE SEQ_MAILNO
NOCACHE; -- 메일

CREATE SEQUENCE SEQ_MAILATCNO
NOCACHE; -- 메일첨부파일

CREATE SEQUENCE SEQ_MEMNO
NOCACHE; -- 멤버

CREATE SEQUENCE SEQ_DEPTNO
NOCACHE; -- 부서

CREATE SEQUENCE SEQ_POSNO
NOCACHE; -- 직급

create sequence seq_hano
NOCACHE; -- 휴가

create sequence seq_hno
NOCACHE; -- 휴가

create sequence seq_wno
NOCACHE; -- 근태
    
create sequence seq_auno
NOCACHE; -- 권한

create sequence seq_pjno
NOCACHE; -- 프로젝트

create sequence seq_tkno
NOCACHE; -- 작업

create sequence seq_rmno
NOCACHE; -- 회의실

create sequence seq_rsrmno
NOCACHE; -- 회의실예약

create sequence seq_carno
NOCACHE; -- 차량코드

create sequence seq_rscno
NOCACHE; -- 차량예약

create sequence seq_docno
NOCACHE; -- 문서번호