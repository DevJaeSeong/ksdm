<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="../common/head.jsp" />

<style type="text/css">
td {
	white-space: nowrap; /* 텍스트 줄바꿈 방지 */
    overflow: hidden; /* 내용이 넘칠 경우 숨김 처리 */
    text-overflow: ellipsis; /* 넘치는 부분을 "..."으로 표시 */
}
</style>

<script type="text/javascript">
$(function() {
	
})

function changeStatusComplete() {
	if (confirm('승인하시겠습니까?')){
		changeStatus('2001');
	}
}

function changeStatusReturn() {
	
	if(confirm('반려하시겠습니까?')){
		
		changeStatus('2002');
		
	} else {
		
		return false;
	}
}

function changeStatus(researchStatusCode) {
	
	let participatedResearchId = ${subVos[0].participatedResearchId}
	
	let sendData = {
		'researchStatusCode': researchStatusCode,
		'participatedResearchId': participatedResearchId
	}
	
	if (researchStatusCode == '2002') {
		sendData.rejectReason = $('#reasonInput').val();
	}
	
	fetch('/admin/taskAndResearch/updateResearchStatus.do', {
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
		
		console.log(data.result);
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 처리되었습니다.');
				location.href = '/admin/taskAndResearch/participatedResearchListPage.do';
				break;
			
			default:
				alert('처리에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
	})
	.catch(error => { 
		
		console.error(error); 
		alert('처리에 실패하였습니다. 잠시후 다시 시도해주세요.');
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
                    <li class="ro_last"><span>조사업무현황</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>조사업무현황</span></div>
            </section>
            <!-- S: .search -->
            <!-- S: main_menu2 -->
            <section class="main_menu2 mt20">
                <article class="main_project_02" tabindex="0">
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
						    <c:forEach items="${subVos}" var="subVo">
						       <tr>
						           <td title="${subVo.subNum}">${subVo.subNum}</td>
						           <td title="${subVo.subResearchGroup}">${subVo.subResearchGroup}</td>
						           <td title="${subVo.subDate}">${subVo.subDate}</td>
						           <td title="${subVo.subStartTime}">${subVo.subStartTime}</td>
						           <td title="${subVo.subEndTime}">${subVo.subEndTime}</td>
						           <td title="${subVo.subResearchMembers}">${subVo.subResearchMembers}</td>
						           <td title="${subVo.subWeather}">${subVo.subWeather}</td>
						           <td title="${subVo.subTemperature}">${subVo.subTemperature}</td>
						           <td title="${subVo.subResearchLocation}">${subVo.subResearchLocation}</td>
						           <td title="${subVo.subGpsN}">${subVo.subGpsN}</td>
						           <td title="${subVo.subGpsE}">${subVo.subGpsE}</td>
						           <td title="${subVo.subAltitude}">${subVo.subAltitude}</td>
						           <td title="${subVo.subLocationCategory}">${subVo.subLocationCategory}</td>
						           <td title="${subVo.subOccurrenceStatus}">${subVo.subOccurrenceStatus}</td>
						           <td title="${subVo.subInsectName}">${subVo.subInsectName}</td>
						           <td title="${subVo.subInsectStatus}">${subVo.subInsectStatus}</td>
						           <td title="${subVo.subPlantName}">${subVo.subPlantName}</td>
						           <td title="${subVo.subOccurrenceDegree}">${subVo.subOccurrenceDegree}</td>
						           <td title="${subVo.subOccurrenceLocationInPlant}">${subVo.subOccurrenceLocationInPlant}</td>
						           <td title="${subVo.subEtcPlant}">${subVo.subEtcPlant}</td>
						           <td title="${subVo.subEtcLocation}">${subVo.subEtcLocation}</td>
						           <td title="${subVo.subDistanceFromRoad}">${subVo.subDistanceFromRoad}</td>
						           <td title="${subVo.subRoadCategory}">${subVo.subRoadCategory}</td>
						       </tr>
						   </c:forEach>
						   </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <div class="btn_r" style="margin-top: 30px;">
                        <a href="/admin/taskAndResearch/participatedResearchListPage.do" class="btn_list_src mr10" title="목록버튼"><span>목록</span></a>
                        <a href="#none" class="btn_list_src mr10" title="승인버튼" onclick="changeStatusComplete()"><span>승인</span></a>
                        <a href="#none" class="btn_list_src c_red" title="반려버튼" onclick="changeStatusReturn()"><span>반려</span></a>
                    </div>
                    <div id="inpurArea" style="text-align: right;">
						<input type="text" class="form " id="reasonInput" placeholder="반려시 사유를 입력하세요." style="width: 30%; margin-top: 10px;">                    
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