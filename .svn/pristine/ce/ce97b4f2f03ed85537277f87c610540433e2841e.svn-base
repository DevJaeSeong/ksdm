<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

	<jsp:include page="../common/head.jsp" />
	
	<script type="text/javascript">
	$(function() {
		getResearchTaskList(1);
	})
	
	function getResearchTaskList(pageIndex) {
		
		let pageUnit = $('#pageUnit').val();
		
		fetch('/admin/taskAndResearch/getResearchTaskList.do?pageIndex=' + pageIndex + '&pageUnit=' + pageUnit)
		
		.then(response => {
			
			if (response.ok) return response.json();
			else throw new Error('네트워크 에러');
			
		})
		.then(data => {
			
			console.log(data);
			
			showResearchTaskListhList(data);
		})
		.catch(error => { 
			
			console.error('fetch에러 => ', error); 
			alert('데이터를 가져오지 못했습니다. 잠시후 다시 시도해주세요.');
		});
		
	}
	
	function showResearchTaskListhList(data){
		let taskAndResearchVos = data.taskAndResearchVos;
		
		let html = '';
		
		$.each(taskAndResearchVos, function(index, taskAndResearchVo) {
			
			html += '<tr>';
			html += '<td>' + taskAndResearchVo.researchTaskId + '</td>';
			html += '<td><a href="#none" onclick="researchTaskModify(' + taskAndResearchVo.researchTaskId + ')" style="width: 180px !important;">' + taskAndResearchVo.researchTaskName + '</a></td>';
			html += '<td>' + taskAndResearchVo.taskName + '</td>';
			html += '</tr>';
		});
		
		$('#table_tbody').html(html);
		
		let paginationInfo = data.paginationInfo;
		
		$('#totalCnt').text(paginationInfo.totalRecordCount + '건');
		
		let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
		let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));

		$('#pagingWrap').empty();
	      
		$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_prev\" title=\"이전 페이지\" onclick=\"getResearchTaskList(' + prev + '); return false;\">이전</button>');

		for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
	         
	        if (i == paginationInfo.currentPageNo) {
	           
	          $('#pagingWrap').append('<a href="#" class="current" title="현재 1페이지">' + i + '</a>');
	          
	        } else {
	           
	          $('#pagingWrap').append('<a href="#" title="' + i + '페이지" onclick="getResearchTaskList(' + i + ');">' + i + '</a>');
	        }
	      }    
		
		$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_next\" title=\"다음 페이지\" onclick=\"getResearchTaskList(' + next + '); return false;\">다음</button>');
	}
	
	function researchTaskModify(researchTaskId) {
		
		location.href = '/admin/taskAndResearch/researchTaskModifyPage.do?researchTaskId=' + researchTaskId;
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
                    <li class="ro_last"><span>과제 및 조사업무 현황</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>과제및조사업무현황</span></div>
            </section>
            <!-- S: .search -->
            <!-- S: main_menu2 -->
            <section class="main_menu2 mt20">
                <article class="main_project_02" tabindex="0">
                    <!-- S: .table_reset -->
                    <div class="table_reset mt20">
                        <table class="board_date01">
                            <colgroup>
                                <col style="width:20%;">
                                <col style="width:40%;">
                                <col style="width:40%;">
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">NO</th>
                                    <th scope="col">조사 업무 명</th>
                                    <th scope="col">과제명</th>
                                </tr>
                            </thead>
                            <tbody id="table_tbody">
                                <tr>
                                    <td>1</td>
                                    <td>대전광역시 동구 용전동</td>
                                    <td>2023 외래곤충 조사</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .page_A -->
                    <div class="page_A" data-label="페이지당항목">
                        <span>페이지당항목</span>
                        <select title="페이지당항목" class="select_01" id="pageUnit" onchange="getResearchTaskList(1)">
                            <option value="5">5</option>
                            <option value="10">10</option>
                            <option value="30">30</option>
                            <option value="60">60</option>
                            <option value="100">100</option>
                        </select>
                    </div>
                    <!-- E: .page_A -->
                    <!-- S: .paging_wrap -->
                    <div class="paging_wrap" id="pagingWrap">
                        <button type="button" class="btn_page_prev" title="이전 페이지">이전</button>
                        <a href="#" class="current" title="현재 1페이지">1</a>
                        <a href="#" title="2페이지">2</a>
                        <a href="#" title="3페이지">3</a>
                        <a href="#" title="4페이지">4</a>
                        <a href="#" title="5페이지">5</a>
                        <button type="button" class="btn_page_next" title="다음 페이지">다음</button>
                    </div>
                    <!-- E: .paging_wrap -->
                </article>
            </section>
            <!-- E: main_menu2 -->
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
</body>
</html>