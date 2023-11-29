<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/loadingHead.jsp" />

<style type="text/css">
.pointer {
	cursor: pointer;
}

td {
	white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
    text-overflow: ellipsis; /* 넘치는 부분을 "..."으로 표시 */
}
</style>

<script type="text/javascript">
$(function() {
	
	initDatePicker();
	initEvents();
	getSubVoList();
})

function initEvents() {
	
	// datePicker 유효성 검사.
	$('#dateStar, #dateEnd').change(function() {
		
		let dateStar = $('#dateStar').val();
		let dateEnd = $('#dateEnd').val();
		
		if (new Date(dateStar) > new Date(dateEnd)) {
			
			alert('종료일이 시작일보다 빨라서는 안됩니다.');
			$('#dateEnd').val(dateStar);
		}
	})
	
	// 엔터키 인식
	$('#searchKeyword').keyup(function(e) {
		
		if (e.keyCode == 13)
			getSubVoList();
	})
}

function initDatePicker() {
	
    $('input[id^="dateStar"]').datepicker();
    $('input[id^="dateEnd"]').datepicker();
    
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

function getSubVoList(pageIndex) {
	
	if (!pageIndex) pageIndex = 1;
	
	let pageUnit = $('#pageUnit').val();
	let searchKeyword = $('#searchKeyword').val();
	let dateStar = $('#dateStar').val();
	let dateEnd = $('#dateEnd').val();
	let searchColumn = $('#searchColumn').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&pageUnit=' + pageUnit;
	queryString += '&searchKeyword=' + searchKeyword;
	queryString += '&dateStar=' + dateStar;
	queryString += '&dateEnd=' + dateEnd;
	queryString += '&searchColumn=' + searchColumn;
	
	fetch('/getSubVoList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		let paginationInfo = data.paginationInfo;
		
		// 내용 구현 시작
		let subVos = data.subVos;
    	let html = '';
    	
    	if (subVos.length <= 0) {
    		
    		let length = $('#table_thead tr').find('th').length;
    		
    		html += '<tr>';
    		html += '<td colspan="' + length + '">조회된 데이터가 없습니다.</td>';
    		html += '</tr>';
    	}
    	
    	$.each(subVos, function(index, subVo) {
    		
    		html += '<tr>';
    		html += '<td class="checkboL"><ul><li><div class="checkboX">';
    		html += '<input id="subVo_' + subVo.subId + '" name="subVoCheckBox" type="checkbox" value="' + subVo.subId + '">';
    		html += '<label for="subVo_' + subVo.subId + '"></label>';
    		html += '</div></li></ul></td>';
    		html += '<td title="' + subVo.subId + '">' + subVo.subId + '</td>';
    		html += '<td title="' + subVo.taskName + '">' + subVo.taskName + '</td>';
    		html += '<td title="' + subVo.researchTaskName + '">' + subVo.researchTaskName + '</td>';
    		html += '<td title="' + subVo.subDate + '">' + subVo.subDate + '</td>';
    		html += '<td title="' + subVo.subStartTime + '">' + subVo.subStartTime + '</td>';
    		html += '<td title="' + subVo.subEndTime + '">' + subVo.subEndTime + '</td>';
    		html += '<td title="' + subVo.subResearchGroup + '">' + subVo.subResearchGroup + '</td>';
    		html += '<td title="' + subVo.subResearchMembers + '">' + subVo.subResearchMembers + '</td>';
    		html += '<td title="' + subVo.subWeather + '">' + subVo.subWeather + '</td>';
    		html += '<td title="' + subVo.subTemperature + '">' + subVo.subTemperature + '</td>';
    		html += '<td title="' + subVo.subResearchLocation + '">' + subVo.subResearchLocation + '</td>';
    		html += '<td title="' + subVo.subGpsN + '">' + subVo.subGpsN + '</td>';
    		html += '<td title="' + subVo.subGpsE + '">' + subVo.subGpsE + '</td>';
    		html += '<td title="' + subVo.subAltitude + '">' + subVo.subAltitude + '</td>';
    		html += '<td title="' + subVo.subLocationCategory + '">' + subVo.subLocationCategory + '</td>';
    		html += '<td title="' + subVo.subOccurrenceStatus + '">' + subVo.subOccurrenceStatus + '</td>';
    		html += '<td title="' + subVo.subInsectName + '">' + subVo.subInsectName + '</td>';
    		html += '<td title="' + subVo.subInsectStatus + '">' + subVo.subInsectStatus + '</td>';
    		html += '<td title="' + subVo.subNum + '">' + subVo.subNum + '</td>';
    		html += '<td title="' + subVo.subPlantName + '">' + subVo.subPlantName + '</td>';
    		html += '<td title="' + subVo.subOccurrenceDegree + '">' + subVo.subOccurrenceDegree + '</td>';
    		html += '<td title="' + subVo.subOccurrenceLocationInPlant + '">' + subVo.subOccurrenceLocationInPlant + '</td>';
    		html += '<td title="' + subVo.subEtcPlant + '">' + subVo.subEtcPlant + '</td>';
    		html += '<td title="' + subVo.subEtcLocation + '">' + subVo.subEtcLocation + '</td>';
    		html += '<td title="' + subVo.subDistanceFromRoad + '">' + subVo.subDistanceFromRoad + '</td>';
    		html += '<td title="' + subVo.subRoadCategory + '">' + subVo.subRoadCategory + '</td>';
    		html += '</tr>';
    	});
    	
    	$('#table_tbody').html(html);
    	// 내용 구현 끝
    	
    	// 버튼 구현 시작
    	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
		let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));
    	let pagingHtml = '';

    	pagingHtml += '<button type="button" class="btn_page_prev" onclick="getSubVoList(' + prev + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_l_arrow.png" alt="이전 페이지">';
    	pagingHtml += '</button>';
    	
    	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
    		
			if (i == paginationInfo.currentPageNo) {
			 
				pagingHtml += '<a class="current" title="현재 ' + i + '페이지" onclick="getSubVoList(' + i + '); return false;">' + i + '</a> ';
			
			} else {
			 
				pagingHtml += '<a title="' + i + '페이지" onclick="getSubVoList(' + i + '); return false;">' + i + '</a> ';
			}
    	}
    	
    	pagingHtml += '<button type="button" class="btn_page_next" onclick="getSubVoList(' + next + '); return false;">';
    	pagingHtml += '<img src="/css/general/images/i_r_arrow.png" alt="다음 페이지">';
    	pagingHtml += '</button>';

    	$('#pagingWrap').html(pagingHtml);
    	// 버튼 구현 끝
	})
	.catch(error => { 
		
		console.error(error); 
	})
}

function excelDownload() {
	
	let dateStar = $('#dateStar').val();
	let dateEnd = $('#dateEnd').val();
	let searchKeyword = $('#searchKeyword').val();
	
	let queryString = '';
	queryString += '?dateStar=' + dateStar;
	queryString += '&dateEnd=' + dateEnd;
	queryString += '&searchKeyword=' + searchKeyword;
	
	showLoadingOverlay();
	
	fetch('/admin/taskAndResearch/getSubListDataToExcel.do' + queryString)
	.then(response => {
		
		if (response.ok) 
			return response.blob();
		else
			throw new Error('네트워크 에러 (' + response.status + ')');
	})
	.then(blobData  => {
		
	    const url = window.URL.createObjectURL(blobData);
	    const a = document.createElement('a');
	    a.href = url;
	    a.download = '외래산림해충_조사자료.xlsx'; // 다운로드할 파일 이름
	    document.body.appendChild(a);
	    a.click();
	    document.body.removeChild(a);
	})
	.catch(error => { 
		
		console.error(error);
		alert('엑셀 다운로드중 문제가 생겼습니다. 잠시후 다시 시도해주세요.');
	})
	.finally(() => {
		
		hideLoadingOverlay();
	});	
}

function deleteSubVo() {
	
	let checkedSubVos = $('input[name="subVoCheckBox"]:checked');
	let checkedSubVoIds = [];
	
	$.each(checkedSubVos, (index, checkedSubVo) => {
		
		checkedSubVoIds.push(checkedSubVo.value);
	});
	
	if (checkedSubVoIds.length <= 0) {
		
		alert('하나 이상 선택하여야 합니다.');
		return;
	}
	
	doDeleteSubVo(checkedSubVoIds);
}

function doDeleteSubVo(ids) {
	
	fetch('/admin/taskAndResearch/deleteSubVo.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(ids)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else 			 throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 삭제되었습니다.');
				getSubVoList();
				break;
			  
			default:
				alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
	})
	.catch(error => { 
		
		console.error(error); 
		alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
	})
}
</script>
</head>

<body>
    <!-- S: .wrap -->
    <div class="wrap">
		<jsp:include page="../common/header_nav.jsp" />
        <main>
            <!-- S: .rocate -->
            <div class="rocate">
                <ul>
                    <li><a href="/main.do"><img src="/css/admin/images/home.png" alt="home"></a></li>
                    <li><span>관리자페이지</span></li>
                    <li><span>과제및조사업무관리</span></li>
                    <li class="ro_last"><span>조사데이터현황</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>조사데이터현황</span></div>
            </section>
            <!-- E: .search -->
            <!-- S: .date_box -->
            <div class="date_box" style="left: 900px;">
                <input type="text" id="dateStar" placeholder="시작일" class="inp_date"
                    title="시작년월일을 입력합니다. YYYYMMDD형식으로 입력하세요." readonly="readonly">
                <span class="sim">&sim;</span>
                <input type="text" id="dateEnd" placeholder="종료일" class="inp_date"
                    title="시작년월일을 입력합니다. YYYYMMDD형식으로 입력하세요." readonly="readonly">
                <select title="년도별 항목" class="select_01" id="searchColumn">
                	<option value="년도별조사업무">년도별조사업무</option>
                	<option value="조사업무명">조사업무명</option>
                	<option value="조사기관" selected="selected">조사기관</option>
                	<option value="조사장소(주소)">조사장소(주소)</option>
                	<option value="장소유형">장소유형</option>
                	<option value="발생여부">발생여부</option>
                	<option value="해충명">해충명</option>
                	<option value="상태">상태</option>
                	<option value="기주식물명">기주식물명</option>
                	<option value="식물 내 발생 위치">식물 내 발생 위치</option>
                	<option value="기타 조사지 내 식물군">기타 조사지 내 식물군</option>
                	<option value="기타 특이사항 및 환경">기타 특이사항 및 환경</option>
                	<option value="도로종류">도로종류</option>
                </select>
            </div>
            <!-- E: .date_box -->
            <!-- S: .search_box_02 -->
            <div class="search_box_02">
                <input id="searchKeyword" type="text" title="검색어입력" value="" placeholder="한남대학교">
                <button onclick="getSubVoList();" type="button" class="search_click_02" title="검색">검색</button>
            </div>
            <!-- E: .search_box_02 -->
            <!-- S: main_menu2 -->
            <section class="main_menu2">
                <article class="main_project_02" tabindex="0">
                    <!-- S: .table_reset -->
                    <div class="table_reset scr_x mt10">
                        <table id="subVoTable" class="board_date01 wd200">
                            <colgroup>
								<col style="width:10%;">
								<col style="width:10%;">
								<col style="width:30%;"> <!-- 년도별조사업무 -->
								<col style="width:20%;"> <!-- 조사업무명 -->
								<col style="width:15%;"> <!-- 조사일시 -->
								<col style="width:15%;"> <!-- 조사시작시간 -->
								<col style="width:15%;"> <!-- 조사종료시간 -->
								<col style="width:15%;"> <!-- 조사기관 -->
								<col style="width:15%;"> <!-- 조사자 -->
								<col style="width:10%;"> <!-- 날씨 -->
								<col style="width:10%;"> <!-- 온도 -->
								<col style="width:30%;"> <!-- 조사장소(주소) -->
								<col style="width:18%;"> <!-- GPS(N) -->
								<col style="width:18%;"> <!-- GPS(E) -->
								<col style="width:10%;"> <!-- 고도 -->
								<col style="width:15%;"> <!-- 장소유형 -->
								<col style="width:10%;"> <!-- 발생여부 -->
								<col style="width:17%;"> <!-- 해충명 -->
								<col style="width:10%;"> <!-- 상태 -->
								<col style="width:15%;"> <!-- 조사기주번호 -->
								<col style="width:15%;"> <!-- 기주식물명 -->
								<col style="width:27%;"> <!-- 해충발생정도(부화 난각 수) -->
								<col style="width:17%;"> <!-- 식물 내 발생 위치 -->
								<col style="width:70%;"> <!-- 기타 조사지 내 식물군 -->
								<col style="width:25%;"> <!-- 기타 특이사항 및 환경 -->
								<col style="width:23%;"> <!-- 도로 가장자리와의 거리 -->
								<col style="width:10%;"> <!-- 도로종류 -->
                            </colgroup>
                            <thead id="table_thead">
                                <tr>
                                    <th scope="col">선택</th>
                                    <th scope="col">식별번호</th>
                                    <th scope="col">년도별조사업무</th>
                                    <th scope="col">조사업무명</th>
                                    <th scope="col">조사일시</th>
                                    <th scope="col">조사시작시간</th>
                                    <th scope="col">조사종료시간</th>
                                    <th scope="col">조사기관</th>
                                    <th scope="col">조사자</th>
                                    <th scope="col">날씨</th>
                                    <th scope="col">온도</th>
                                    <th scope="col">조사장소(주소)</th>
                                    <th scope="col">GPS(N)</th>
                                    <th scope="col">GPS(E)</th>
                                    <th scope="col">고도</th>
                                    <th scope="col">장소유형</th>
                                    <th scope="col">발생여부</th>
                                    <th scope="col">해충명</th>
                                    <th scope="col">상태</th>
                                    <th scope="col">조사기주번호</th>
                                    <th scope="col">기주식물명</th>
                                    <th scope="col">해충발생정도(부화 난각 수)</th>
                                    <th scope="col">식물 내 발생 위치</th>
                                    <th scope="col">기타 조사지 내 식물군</th>
                                    <th scope="col">기타 특이사항 및 환경</th>
                                    <th scope="col">도로 가장자리와의 거리</th>
                                    <th scope="col">도로종류</th>
                                </tr>
                            </thead>
                            <tbody id="table_tbody">
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .page_A -->
                    <div class="page_A" data-label="페이지당항목">
                        <span>페이지당항목</span>
                        <select id="pageUnit" onchange="getSubVoList();" title="페이지당항목" class="select_01">
                            <option value="10">10</option>
                            <option value="20">20</option>
                        </select>
                    </div>
                    <div class="btn_r">
	                    <a onclick="excelDownload()" class="btn_list_src mr10 pointer" title="엑셀다운로드"><span>엑셀다운로드</span></a>
                        <a onclick="deleteSubVo();" class="btn_list_src c_red pointer" title="삭제버튼"><span>삭제</span></a>
                    </div>
                    <!-- E: .page_A -->
                    <!-- S: .paging_wrap -->
                    <div class="paging_wrap" id="pagingWrap">
                    </div>
                    <!-- E: .paging_wrap -->
                </article>
            </section>
            <!-- E: main_menu2 -->
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
    <jsp:include page="../common/loadingBody.jsp" />
</body>
</html>