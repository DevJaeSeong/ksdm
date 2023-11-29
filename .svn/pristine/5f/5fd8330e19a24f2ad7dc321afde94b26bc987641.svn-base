<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="../common/head.jsp" />

<style type="text/css">
.pointer {
	cursor: pointer;
}

td {
	white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>

<script type="text/javascript">
$(function() {
	getInsectList(1);
})

function getInsectList(pageIndex) {
	
	let pageUnit = $('#pageUnit').val();
	let searchKeyword = $('#searchKeyword').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
	queryString += '&sort=latestReg';
	
	fetch('/admin/insectInfo/getInsectList.do' + queryString)
	
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
		
	})
	.then(data => {
		
		console.log(data);
		
		showInsectList(data);
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('데이터를 가져오지 못했습니다. 잠시후 다시 시도해주세요.');
	});
	
}

function showInsectList(data){
	
	let insectVos = data.insectVos;
	
	let html = '';
	
	$.each(insectVos, function(index, insectVo) {
		
		let insectStatusVos = insectVo.insectStatusVos;
   		let status = '';
   		
   		$.each(insectStatusVos, function(index, insectStatusVo) {
   			
   			status += insectStatusVo.insectStatusName + ', ';
   		})
   		status = status.slice(0, -2);
		
		html += '<tr>';
		html += '<td title="' + insectVo.insectNum + '">' + insectVo.insectNum + '</td>';
		html += '<td title="' + insectVo.korSpecificName + '"><a class="pointer" onclick="insectDetail(' + insectVo.insectNum + ')" style="width: 180px !important;">' + insectVo.korSpecificName + '</a></td>';
		html += '<td title="' + insectVo.engSpecificName + '"><a class="pointer" onclick="insectDetail(' + insectVo.insectNum + ')" style="width: 180px !important;">' + insectVo.engSpecificName + '</a></td>';
		html += '<td title="' + insectVo.regId + '">' + insectVo.regId + '</td>';
		html += '<td title="' + insectVo.regDate + '">' + insectVo.regDate + '</td>';
		html += '<td title="' + insectVo.taxon + '">' + insectVo.taxon + '</td>';
		html += '<td title="' + status + '">' + status + '</td>';
		html += '</tr>';
	});
	
	$('#table_tbody').html(html);
	
	let paginationInfo = data.paginationInfo;
	
	$('#totalCnt').text(paginationInfo.totalRecordCount + '건');
	
	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
	let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));

	$('#pagingWrap').empty();
      
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_prev\" title=\"이전 페이지\" onclick=\"getInsectList(' + prev + '); return false;\">이전</button>');

	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
         
        if (i == paginationInfo.currentPageNo) {
           
          $('#pagingWrap').append('<a href="#" class="current" title="현재 1페이지">' + i + '</a>');
          
        } else {
           
          $('#pagingWrap').append('<a href="#" title="' + i + '페이지" onclick="getInsectList(' + i + ');">' + i + '</a>');
        }
      }    
	
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_next\" title=\"다음 페이지\" onclick=\"getInsectList(' + next + '); return false;\">다음</button>');
}

function insectDetail(insectNum) {
	
	location.href = '/admin/insectInfo/adminInsectDetailPage.do?insectNum=' + insectNum;
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
					<li><a href="#none"><img src="/css/admin/images/home.png"
							alt="home"></a></li>
					<li><span>관리자페이지</span></li>
					<li><span>데이터관리</span></li>
					<li class="ro_last"><span>곤충현황</span></li>
				</ul>
			</div>
			<!-- E: .rocate -->
			<!-- S: .search -->
			<section class="search">
				<div class="search_txt">
					<span>곤충현황</span>
				</div>
				<div class="search_box">
					<input type="text" title="검색어입력" value="" placeholder="검색" id="searchKeyword">
					<button type="button" class="search_click" title="검색" onclick="getInsectList(1)">
						<img src="/css/admin/images/search_go.gif" alt="검색 이미지">
					</button>
				</div>
			</section>
			<!-- E: .search -->
			<!-- S: main_menu2 -->
			<section class="main_menu2 mt20">
				<article class="main_project_02" tabindex="0">
					<!-- S: .table_reset -->
					<div class="table_reset mt20">
						<table class="board_date01">
							<colgroup>
								<col style="width: 5%;">
								<col style="width: 17%;">
								<col style="width: 25%;">
								<col style="width: 10%;">
								<col style="width: 13%;">
								<col style="width: 13%;">
								<col style="width: 16%;">
							</colgroup>
							<thead>
								<tr>
									<th scope="col">NO</th>
									<th scope="col">한글명</th>
									<th scope="col">영문명</th>
									<th scope="col">등록자</th>
									<th scope="col">등록일</th>
									<th scope="col">분류군</th>
									<th scope="col">관리현황</th>
								</tr>
							</thead>
							<tbody id="table_tbody">
								<tr>
									<td>1</td>
									<td>갈색날개매미충</td>
									<td>speculum</td>
									<td>시스템관리자</td>
									<td>2023-01-01</td>
									<td>곤충</td>
									<td>외래생물, 생태교란생물</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- E: .table_reset -->
					<!-- S: .page_A -->
					<div class="page_A" data-label="페이지당항목">
						<span>페이지당항목</span> 
						<select title="페이지당항목" class="select_01" id="pageUnit" onchange="getInsectList(1)">
							<option value="10">10</option>
							<option value="30">30</option>
							<option value="60">60</option>
							<option value="100">100</option>
							<option value="250">250</option>
						</select>
					</div>
					<!-- E: .page_A -->
					<!-- S: .paging_wrap -->
					<div class="paging_wrap" id="pagingWrap">
						<button type="button" class="btn_page_prev" title="이전 페이지">이전</button>
						<a href="#" class="current" title="현재 1페이지">1</a> <a href="#"
							title="2페이지">2</a> <a href="#" title="3페이지">3</a> <a href="#"
							title="4페이지">4</a> <a href="#" title="5페이지">5</a>
						<button type="button" class="btn_page_next" title="다음 페이지">다음</button>
					</div>
					<!-- E: .paging_wrap -->
				</article>
			</section>
		</main>
		<!-- E: main -->
	</div>
	<!-- E:.wrap -->
</body>
</html>