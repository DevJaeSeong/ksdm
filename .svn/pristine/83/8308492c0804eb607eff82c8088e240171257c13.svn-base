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
		
	}
	
	function addInputArea() {
		
		let html = '';
		
		html += '<div class="bor_p10">';
		html += '<div class="x_box"><a href="#none" title="닫기" onclick="deleteInputBox(this)"></a></div>';
		html += '<div class="table_reset mt20 mb20">';
		html +=	'<table class="board_date02">';
		html +=	'<colgroup>';
		html +=	'<col style="width:15%;">';
		html +=	'<col style="width:50%;">';
		html +=	'</colgroup>';
		html +=	'<tbody>';
		html +=	'<tr>';
		html +=	'<th scope="col">조사 업무 명칭</th>';
		html +=	'<td colspan="3" class="txt_lh">';
		html +=	'<input type="text" class="form wp60" placeholder="서울특별시 강남구 역삼동">';
		html +=	'<span>입력예시 : 시/도 + 군/구 + 읍/면/동</span>';
		html +=	'</td>';
		html +=	'</tr>';
		html +=	'</tbody>';
		html +=	'</table>';
		html +=	'</div>';
		html +=	'</div>';
				
		$("#inputAreaWrap").append(html);
	}
	
	function deleteInputBox(element) {
		
		let inputBox = element.parentNode.parentNode;
		
		inputBox.remove();
	}
	
	function registTask() {
		
		let articleCount = $("#inputAreaWrap table").length;
		let taskId = $("#selectTask").val();
		
		if(confirm('등록 하시겠습니까?')){
			
			let researchTaskList = [];
			
			for (let i = 0; i < articleCount; i++) {
				 
				let researchTaskName = $("#inputAreaWrap input:eq(" + i + ")").val();
				
				researchTaskList.push({'taskId' : taskId, 'researchTaskName' : researchTaskName})
				
			}
				
			console.log(researchTaskList);
			
			jsonResearchTaskList = JSON.stringify(researchTaskList);
			
			fetch('/admin/taskAndResearch/researchTaskRegistConfirm.do', {
				
				  method: 'POST',
				  headers: {
					  'Content-Type': 'application/json',
					  '${_csrf.headerName}': '${_csrf.token}'
				  },
				  
				  body: jsonResearchTaskList
				  
				})
				
				.then(response => response)
				
				.then(data => {
					
					if(data =='success'){
						alert('등록이 완료되었습니다.');
					}
					
					location.href = '/admin/taskAndResearch/researchTaskListPage.do';
					
				  console.log('서버 응답:', data);
				})
				
				.catch(error => {
					
				  console.error('에러 발생:', error);
				  
				});
				
		} else {
			
			return false;
		}
		
		
		
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
                    <li><span>과제및조사업무관리</span></li>
                    <li class="ro_last"><span>과제 및 조사업무 등록</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>과제및조사업무등록</span></div>
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
                        <div class="x_box"><a href="#none" title="닫기" onclick="deleteInputBox(this)"></a></div>
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
                                            <input type="text" class="form wp60" placeholder="서울특별시 강남구 역삼동">
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
                    <a href="#none" class="btn_list_src mr10" title="추가버튼" onclick="addInputArea()"><span>추가</span></a>
                    <a href="#none" class="btn_list_src" title="등록버튼" onclick="registTask()"><span>등록</span></a>
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