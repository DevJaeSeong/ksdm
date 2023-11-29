<%@page import="egovframework.ksdmWeb.security.UserDetailVo"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="../common/head.jsp" />

<script type="text/javascript">
function deleteSubject() {
	
	if (!confirm("삭제 하시겠습니까?"))
		return;
	
	let sendData = {
		'participatedResearchId': '${subVo.participatedResearchId}'
		, 'researchTaskId': '${researchTaskId}'
		, 'subjectNum': '${subVo.subNum}'
	};
	
	fetch('/user/research/subjectDelete.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러발생');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 삭제되었습니다..');
				
				let queryString = '';
				queryString += '?participatedResearchId=' + ${subVo.participatedResearchId}
				queryString += '&researchTaskId=' + ${researchTaskId}
				
				location.href='/user/research/subjectListPage.do' + queryString;
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

function modifySubject() {
	
	let queryString = '';
	queryString += '?participatedResearchId=' + ${subVo.participatedResearchId};
	queryString += '&researchTaskId=' + ${researchTaskId};
	queryString += '&subjectNum=' + ${subVo.subNum};
	
	location.href = '/user/research/subjectModifyPage.do' + queryString;
}

function goList() {
	
	let queryString = '';
	queryString += '?participatedResearchId=' + ${subVo.participatedResearchId};
	queryString += '&researchTaskId=' + ${researchTaskId};
	queryString += '&subjectNum=' + ${subVo.subNum};
	
	location.href = '/user/research/subjectListPage.do' + queryString;
}
</script>

</head>

<body>
	<div class="wrap">

		<jsp:include page="../common/header.jsp" />

		<!-- 조사등록 시작 -->
		<div class="con_box">
			<p class="con_title">조사등록</p>
			<div class="table_typA st03">
				<table class="contTbl">
					<colgroup>
						<col style="width: 20%;">
						<col style="width: 30%;">
						<col style="width: 20%;">
						<col style="width: 30%;">
					</colgroup>
					<tbody>
                        <tr>
                            <th>조사기관</th>
                            <td>${subVo.subResearchGroup}</td>
                            <th>조사기주번호</th>
                            <td>${subVo.subNum}</td>
                        </tr>
                        <tr>
                            <th>조사일시</th>
                            <td colspan="3">${subVo.subDate}</td>
                        </tr>
                        <tr>
                            <th>시작시간</th>
                            <td>${subVo.subStartTime}</td>
                            <th>종료시간</th>
                            <td>${subVo.subEndTime}</td>
                        </tr>
                        <tr>
                            <th>조사자</th>
                            <td colspan="3">${subVo.subResearchMembers}</td>
                        </tr>
                        <tr>
                            <th>날씨</th>
                            <td>${subVo.subWeather}</td>
                            <th>온도</th>
                            <td>${subVo.subTemperature}&#176;C</td>
                        </tr>
                        <tr>
                            <th>조사장소(주소)</th>
                            <td colspan="3">${subVo.subResearchLocation}</td>
                        </tr>
                        <tr>
                            <th>GPS</th>
                            <td colspan="3">
                               N: ${subVo.subGpsN}
                               E: ${subVo.subGpsE}
                            </td>
                        </tr>
                        <tr>
                            <th>고도</th>
                            <td>${subVo.subAltitude}</td>
                            <th>장소유형</th>
                            <td>${subVo.subLocationCategory}</td>
                        </tr>
                        <tr>
                            <th>발생여부</th>
                            <td colspan="3">${subVo.subOccurrenceStatus}</td>
                        </tr>
                        <tr>
                            <th>해충명</th>
                            <td colspan="3"> ${subVo.subInsectName}</td>
                        </tr>
                        <tr>
                            <th>상태</th>
                            <td colspan="3">${subVo.subInsectStatus}</td>
                        </tr>
                        <tr>
                            <th>기주식물명</th>
                            <td colspan="3">${subVo.subPlantName}</td>
                        </tr>
                        <tr>
                            <th>해충발생정도</th>
                            <td colspan="3">${subVo.subOccurrenceDegree}</td>
                        </tr>
                        <tr>
                            <th>식물발생위치</th>
                            <td colspan="3">${subVo.subOccurrenceLocationInPlant}</td>
                        </tr>
                        <tr>
                            <th>기타조사지내식물군</th>
                            <td colspan="3">${subVo.subEtcPlant}</td>
                        </tr>
                        <tr>
                            <th>기타특이사항 및 환경</th>
                            <td colspan="3">${subVo.subEtcLocation}</td>
                        </tr>
                        <tr>
                            <th>도로가장자리와의거리</th>
                            <td colspan="3">${subVo.subDistanceFromRoad}<c:if test="${subVo.subDistanceFromRoad} != null">m</c:if></td>
                        </tr>
                        <tr>
                            <th>도로종류</th>
                            <td colspan="3">${subVo.subRoadCategory}</td>
                        </tr>
                    </tbody>
				</table>
			</div>
			 <!-- 수정, 삭제버튼 시작 -->
            <div class="end_btn mt20">
                <button class="btn_a_src_03_1 wp20 mr10" title="수정" onclick="modifySubject()"><span>수정</span></button>
                <button class="btn_a_src_03_1 wp20 mr100" title="목록" onclick="goList()"><span>목록</span></button>
                <button class="btn_a_src_03_1 bd04_1 wp20" title="삭제" onclick="deleteSubject()"><span>삭제</span></button>
            </div>
            <!-- 수정, 삭제버튼 끝 -->
		</div>
		<!-- 조사등록 끝 -->
	</div>
</body>
</html>