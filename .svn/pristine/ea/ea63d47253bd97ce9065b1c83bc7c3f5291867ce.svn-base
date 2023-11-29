<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />

<script type="text/javascript">
$(function() {
	initEvents();
})

function initEvents() {
	$('#nameInput').val('${taskAndResearchVo.researchTaskName}');
	$('#selectTask').val('${taskAndResearchVo.taskId}');
}

function deleteTask() {
	
	if (!confirm ('삭제하시겠습니까?')) return;
 
	let sendData = {
		'researchTaskId': '${taskAndResearchVo.researchTaskId}'
	};
	
	fetch('/admin/taskAndResearch/researchTaskDeleteConfirm.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 삭제되었습니다.');
				location.href = '/admin/taskAndResearch/researchTaskListPage.do';
				break;
			
			default:
				alert('삭제하지 못했습니다. 잠시후 다시 시도해주세요.');
				break;
		}
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('삭제하지 못했습니다. 잠시후 다시 시도해주세요.');
	});
}

function modifyTask() {
	
	let taskId = $("#selectTask").val();
	
	if(!confirm('수정 하시겠습니까?')) return;
	
	let sendData = {
		'researchTaskName': $('#nameInput').val(),
		'taskId': $('#selectTask').val(),
		'researchTaskId' : ${taskAndResearchVo.researchTaskId}
	};
	
	fetch('/admin/taskAndResearch/researchTaskModifyConfirm.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => {
		
		if (response.ok) return response;
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		alert('수정이 완료되었습니다.');
		location.href = '/admin/taskAndResearch/researchTaskListPage.do';
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('상태변경에 실패하였습니다. 잠시후 다시 시도해주세요.');
	});	
}
</script>
</head>

<body>
    <!-- S: .wrap -->
    <div class="wrap">
        <jsp:include page="../common/header_nav.jsp" />
        <!-- S: main -->
        <main>
            <!-- S: .rocate -->
            <div class="rocate">
                <ul>
                    <li><a href="#none"><img src="/css/admin/images/home.png" alt="home"></a></li>
                    <li><span>관리자페이지</span></li>
                    <li><span>조사자용</span></li>
                    <li class="ro_last"><span>조사업무수정</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>조사업무수정</span></div>
            </section>
            <!-- S: .search -->
            <!-- S: .page_A -->
            <div class="page_A ml25 mb10" data-label="년도별 항목">
                <select title="년도별 항목" class="select_01" id="selectTask">
                <c:forEach items="${taskAndResearchVos}" var="taskAndResearchVo">
                	<option value="${taskAndResearchVo.taskId}">${taskAndResearchVo.taskName}</option>
                </c:forEach>
                </select>
            </div>
            <!-- E: .page_A -->
            <!-- S: .main_menu2 -->
            <section class="main_menu2 mt20" id="">
            
            
                <!-- S: .main_project_02 -->
                <article class="main_project_02 mb20 pt10" tabindex="0" id="inputAreaWrap">
                    <!-- S:.bor_p10 -->
                    <div class="bor_p10">
                        <!-- S: .table_reset -->
                        <div class="table_reset mt20 mb20">
                            <table class="board_date02">
                                <colgroup>
                                    <col style="width:15%;">
                                    <col style="width:50%;">
                                </colgroup>
                                <tbody>
                                    <tr>
                                        <th scope="col">조사 업무 명칭</th>
                                        <td colspan="3" class="txt_lh">
                                            <input type="text" class="form wp60" placeholder="서울특별시 강남구 역삼동" id="nameInput">
                                            <span>입력예시 : 시/도 + 군/구 + 읍/면/동</span>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <!-- E: .table_reset -->
                    </div>
                    <!-- E:.bor_p10 -->
                </article>
                
                
                <!-- E: .main_project_02 -->
                <!-- S: .btn_r -->
                <div class="mt20 mb30 mr14 btn_r">
                    <a href="#none" class="btn_list_src" title="등록버튼" onclick="modifyTask()"><span>수정</span></a>
                    <a href="#none" class="btn_list_src c_red" title="삭제버튼" onclick="deleteTask()"><span>삭제</span></a>
                </div>
                <!-- E: .btn_r -->
            </section>
            <!-- E: main_menu2 -->
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
</body>

</html>