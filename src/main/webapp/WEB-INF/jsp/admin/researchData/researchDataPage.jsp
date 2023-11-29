<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
	
<script type="text/javascript">

$(function() {
	
	setDatePicker();
	getResearchData();
})

function setDatePicker() {
	
	$('input[id^="dateStar"]').datepicker();
	$('input[id^="dateEnd"]').datepicker();
	$('input[id^="datepickers"]').datepicker();
	$.datepicker.setDefaults({
	    dateFormat: 'yy-mm-dd',
	    prevText: '이전 달',
	    nextText: '다음 달',
	    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    monthNamesShort: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
	    dayNames: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesShort: ['일', '월', '화', '수', '목', '금', '토'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear: true,
	    changeYear: true, //콤보박스에서 년 선택 가능  
	    changeMonth: true, //콤보박스에서 월 선택 가능  
	    //yearSuffix: '년',
	});
}

function getResearchData(pageIndex) {
	
	if (pageIndex == undefined || pageIndex == '' || pageIndex == 0) pageIndex = 1;
	
	let dateStar = $('#dateStar').val();
	let dateEnd = $('#dateEnd').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + '10';
	queryString += '&dateStar=' + dateStar;
	queryString += '&dateEnd=' + dateEnd;
	
	fetch('/admin/getResearchData.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		let paginationInfo = data.paginationInfo;
		
		// 내용 구현 시작
		let researchDataVos = data.researchDataVos;
    	let html = '';
    	
    	$.each(researchDataVos, function(index, researchDataVo) {
    		
    		let subjectActive;
    		let pestInfestationLevel;
    		
    		switch (researchDataVo.subjectActive) {
    		
				case 'O':
					subjectActive = '발생';
					break;
					
				case 'X':
					subjectActive = '미발생';
					break;
	
				default:
					break;
			}
    		
    		switch (researchDataVo.pestInfestationLevel) {
    		
				case 'L':
					pestInfestationLevel = '경';
					break;
					
				case 'M':
					pestInfestationLevel = '중';
					break;
					
				case 'H':
					pestInfestationLevel = '심';
					break;
	
				default:
					break;
			}
    		
    		html += '<tr>';
    		html += '<td>' + researchDataVo.subjectNum + '</td>';
    		html += '<td>' + researchDataVo.userName + '</td>';
    		html += '<td>' + researchDataVo.researchDate + '</td>';
    		html += '<td>' + researchDataVo.researchStartTime + '</td>';
    		html += '<td>' + researchDataVo.researchEndTime + '</td>';
    		html += '<td>' + researchDataVo.researchUsers + '</td>';
    		html += '<td>' + researchDataVo.subjectWeatherName + '</td>';
    		html += '<td>' + researchDataVo.subjectTemp + '</td>';
    		html += '<td>' + researchDataVo.subjectPlace + '</td>';
    		html += '<td>' + researchDataVo.subjectPosX + '</td>';
    		html += '<td>' + researchDataVo.subjectPosY + '</td>';
    		html += '<td>' + researchDataVo.subjectAltitude + '</td>';
    		html += '<td>' + researchDataVo.subjectPlaceType + '</td>';
    		html += '<td>' + subjectActive + '</td>';
    		html += '<td>' + researchDataVo.korSpecificName + '</td>';
    		html += '<td>' + researchDataVo.subjectStatus + '</td>';
    		html += '<td>' + researchDataVo.subjectName + '</td>';
    		html += '<td>' + pestInfestationLevel + '</td>';
    		html += '<td>' + researchDataVo.pestExistencePosition + '</td>';
    		html += '<td>' + researchDataVo.plantInarea + '</td>';
    		html += '<td>' + researchDataVo.subjectNote + '</td>';
			html += '<td>' + researchDataVo.distFromroad + '</td>';
			html += '<td>' + researchDataVo.roadType + '</td>';
			html += '</tr>';
    	});
    	
    	$('#table_tbody').empty();
    	$('#table_tbody').html(html);
    	// 내용 구현 끝
    	
    	// 버튼 구현 시작
    	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
		let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));
    	let pagingHtml = '';

    	pagingHtml += '<button type="button" class="btn_page_prev" onclick="getResearchData(' + prev + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_l_arrow.png" alt="이전 페이지">';
    	pagingHtml += '</button>';
    	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
    		
			if (i == paginationInfo.currentPageNo) {
			 
				pagingHtml += '<a class="current" title="현재 ' + i + '페이지" onclick="getResearchData(' + i + '); return false;">' + i + '</a> ';
			
			} else {
			 
				pagingHtml += '<a title="' + i + '페이지" onclick="getResearchData(' + i + '); return false;">' + i + '</a> ';
			}
    	}
    	pagingHtml += '<button type="button" class="btn_page_next" onclick="getResearchData(' + next + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_r_arrow.png" alt="다음 페이지">';
    	pagingHtml += '</button>';

    	$('#pagingBtnArea').empty();
    	$('#pagingBtnArea').html(pagingHtml);
    	// 버튼 구현 끝
	})
	.catch(error => { console.error('fetch에러 => ', error); });
}

function fileUpload() {
	
	let files = $('#fileInput')[0].files;
	let file;
	
	if (files.length > 0) {
		
		file = files[0];
		
	} else {
		
		alert('조사자료 엑셀을 먼저 업로드 해주세요.');
		return;
	}
	
	let formData = new FormData();
	formData.append('file', file);
	
	fetch('/user/research/uploadResearchData.do', {
		method: 'POST',
		headers: {
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: formData
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 저장되었습니다.');
			  	break;
			  
			case 'uploadFail':
				alert('파일 업로드에 실패하였습니다.');
			  	break;
			  
			default:
				alert('저장에 실패하였습니다. 잠시후 다시 시도해주세요.');
			  	break;
		}
	})
	.catch(error => { console.error('fetch에러 => ', error); })
	.finally(() => { getResearchData(); });
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
                    <li><span>조사자료</span></li>
                    <li class="ro_last"><span>조사자료등록</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>조사자료등록</span></div>
            </section>
            <!-- S: .search -->
            <!-- S: main_menu2 -->
            <section class="main_menu2 mt20">
                <article class="main_project_02" tabindex="0">
                	<!-- S : datepicker -->
                	<div>
                		조사일시 선택: 
				    	<input onchange="getResearchData()" type="text" id="dateStar" placeholder="" class="inp_date wp95" title="시작년월일을 입력합니다. YYYY-MM-DD형식으로 입력하세요.">
						~				    	
				    	<input onchange="getResearchData()" type="text" id="dateEnd" placeholder="" class="inp_date wp95" title="시작년월일을 입력합니다. YYYY-MM-DD형식으로 입력하세요.">
                	</div>
                	<!-- E : datepicker -->
                    <!-- S: .table_reset -->
                    <div class="table_reset scr_x mt20">
                        <table class="board_date01 wd200">
                            <colgroup>
                                <col style="width:5%;">
                                <col style="width:8%;">
                                <col style="width:15%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:15%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:25%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:13%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:10%;">
                                <col style="width:15%;">
                                <col style="width:10%;">
                                <col style="width:13%;">
                                <col style="width:10%;">
                               
                            </colgroup>
                            <thead>
                                <tr>
                                    <th scope="col">기주번호</th>
                                    <th scope="col">조사기관</th>
                                    <th scope="col">조사일시</th>
                                    <th scope="col">시작시간</th>
                                    <th scope="col">종료시간</th>
                                    <th scope="col">조사자</th>
                                    <th scope="col">날씨</th>
                                    <th scope="col">온도</th>
                                    <th scope="col">조사장소</th>
                                    <th scope="col">GPS N</th>
                                    <th scope="col">GPS S</th>
                                    <th scope="col">고도</th>
                                    <th scope="col">장소유형</th>
                                    <th scope="col">발생여부</th>
                                    <th scope="col">해충명</th>
                                    <th scope="col">상태</th>
                                    <th scope="col">기주식물명</th>
                                    <th scope="col">해충발생정도</th>
                                    <th scope="col">식물발생위치</th>
                                    <th scope="col">기타조사지내식물군</th>
                                    <th scope="col">특이사항 및 환경</th>
                                    <th scope="col">도로 가장자리와의 거리</th>
                                    <th scope="col">도로종류</th>
                                </tr>
                            </thead>
                            <tbody id="table_tbody">
						   </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .paging_wrap -->
			        <div id="pagingBtnArea" class="paging_wrap">
			        </div>
			        <!-- E: .paging_wrap -->
                    <div class="btn_r" style="margin-top: 30px;">
                    	<input id="fileInput" type="file">
                        <a onclick="fileUpload();" href="#none" class="btn_list_src mr10" title="업로드"><span>업로드</span></a>
                        <!--  
                        <a href="#none" class="btn_list_src c_red" title="다운로드"><span>다운로드</span></a>
                    	-->
                    </div>
                </article>
            </section>
            <!-- E: main_menu2 -->
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
</body>
</html>