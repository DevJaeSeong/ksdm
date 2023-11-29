<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="../common/head.jsp" />

<style type="text/css">
.pointer {
	cursor: pointer;
}

.red {
	color: red;
}
</style>

<script type="text/javascript">
var userList = [];

$(function () {
    
	initDatePicker();
    init_events();
    getGps();
});

function getGps() {
	
	//웹브라우저 정책으로 https가 아닐경우 작동안함 (로컬은 작동)
	navigator.geolocation.watchPosition(function(pos) {
		
		$('#subjectPosX').val(pos.coords.latitude)
		$('#subjectPosY').val(pos.coords.longitude)
	})
}

function initDatePicker() {
	
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

function init_events() {
	
	$('#selectedUserWrap').css('display', 'none');
	
	$('#userInput').keyup(function(e) {
		
		if (e.keyCode == 13)
			addUser();
	})
}

function inputHandler() {
	
	let searchKeyword = $('#searchInsectInput').val(); 
  			
  	if (searchKeyword == ''){
  		
  		$('#searchInsectWrap').css('display', 'none');
  		
  	} else {
  		
  		$('#searchInsectWrap').css('display', 'block');
  		searchInsect(searchKeyword);
  	}
}

function searchInsect(searchKeyword) {
	
	fetch('/searchInsect.do?searchKeyword=' + searchKeyword)
	
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + '에러 발생');
	})
	.then(data => {
		
		showSearchInsectList(data);
	})
	.catch(error => { 
		
		console.error(error); 
	});
}

function showSearchInsectList(data) {
	
	let html = '<ul>';
	data = data.researchVos;
	
	for (let i = 0; i < data.length; i++) {
		
		let insectNum = data[i].insectNum;
		let korSpecificName = data[i].korSpecificName;
           
   		html += '<li>';
   		html += '<a class="pointer" onclick="selectInsect(\'' + korSpecificName + '\');">' + korSpecificName + '</a>';
   		html += '</li>';
    }
	
	html += '</ul>';
	
	$('#searchInsectWrap').html(html);
}

function selectInsect(korSpecificName) {
	
	$('#searchInsectInput').val(korSpecificName);
	$('#searchInsectWrap').css('display', 'none');
}



function addUser() {
	let inputUser =  $('#userInput').val();
	
	if(inputUser == ''){
		alert('조사자 이름을 입력하세요.');
	} else {
		
		userList.push(inputUser);
		
		let html = '<button onclick="deleteUser(this);">';
		html += '<span class="mr5">' + inputUser + '</span>';
		html += '<img src="/../css/user/mobile/images/cancel_c.png" alt="닫기 이미지">';
		html += '</button>'
		
		$('#selectedUserWrap').css('display', 'block');
		$('#selectedUserWrap').append(html);
		
		$('#userInput').val('');
	}
}

function deleteUser(element) {
	
	let selectedUser = $(element).find('span').text();
	
	// userList 배열에서 삭제할 조사자의 이름을 가진 인덱스번호를 추출해 배열에서 제거함
	let index = userList.indexOf(selectedUser);
	if (index !== -1) {
	  userList.splice(index, 1);
	}
	
	$(element).remove();
}

function inputsValidate() {
	
	if (!$('#datepickers').val()) {
		
		alert('조사일시를 선택해주세요');
		$('#datepickers').focus();
		return false;
	}
	
	if (!$('#researchStartTime').val()) {
		
		alert('시작시간을 선택해주세요.');
		$('#researchStartTime').focus();
		return false;
	}
	
	if (!$('#researchEndTime').val()) {
		
		alert('종료시간을 선택해주세요.');
		$('#researchEndTime').focus();
		return false;
	}
	
	if (!userList.length) {
		
		alert('조사자를 추가해주세요.');
		$('#userInput').focus();
		return false;
	}
	
	if (!$('#subjectPlace').val()) {
		
		alert('조사장소를 추가해주세요.');
		$('#subjectPlace').focus();
		return false;
	}
	
	if (!$('#subjectPosX').val()) {
		
		alert('GPS(위도)를 입력해주세요.');
		$('#subjectPosX').focus();
		return false;
	}
	
	if (!$('#subjectPosY').val()) {
		
		alert('GPS(경도)를 입력해주세요.');
		$('#subjectPosY').focus();
		return false;
	}
	
	if (!$('#searchInsectInput').val()) {
		
		alert('해충명을 입력해주세요.');
		$('#searchInsectInput').focus();
		return false;
	}
	
	if (!$('#subjectName').val()) {
		
		alert('기주식물명을 입력해주세요.');
		$('#subjectName').focus();
		return false;
	}
	
	return true;
}

function submit() {
	
	if (!inputsValidate()) return;
	
	let subjectName = $('#subjectName').val();
	let researchUsers = $('#userInput').val();
	let subjectActive = $('input[name="subjectActive"]:checked').val();
	
	userList = userList.join(', ');
	$('#userInput').val(userList);
	
	let sendData = {
			
		'subDate': 							$('#datepickers').val()
		, 'subStartTime': 					$('#researchStartTime').val()
		, 'subEndTime': 					$('#researchEndTime').val()
		, 'subResearchGroup': 				$('#userName').val()
		, 'subResearchMembers': 			$('#userInput').val()
		, 'subWeather': 					$('#subjectWeather').val()
		, 'subTemperature': 				$('#subjectTemp').val()
		, 'subResearchLocation': 			$('#subjectPlace').val()
		, 'subGpsN': 						$('#subjectPosX').val()
		, 'subGpsE': 						$('#subjectPosY').val()
		, 'subAltitude': 					$('#subjectAltitude').val()
		, 'subLocationCategory': 			$('#subjectPlaceType').val()
		, 'subOccurrenceStatus': 			$('input[name="subjectActive"]:checked').val()
		, 'subInsectName': 					$('#searchInsectInput').val()
		, 'subInsectStatus': 				$('#subjectStatus').val()
		, 'subNum': 						$('#subjectNum').val()
		, 'subPlantName': 					$('#subjectName').val()
		, 'subOccurrenceDegree': 			$('#pestInfestationLevel').val()
		, 'subOccurrenceLocationInPlant': 	$('#pestExistencePosition').val()
		, 'subEtcPlant': 					$('#plantInarea').val()
		, 'subEtcLocation': 				$('#subjectNote').val()
		, 'subDistanceFromRoad': 			$('#distFromroad').val()
		, 'subRoadCategory': 				$('#roadType').val()
		, 'participatedResearchId': 		'${participatedResearchId}'
		, 'researchTaskName': 				'${researchTaskName}'
		, 'taskName': 						'${taskName}'
	}

	console.log(sendData);
	
	fetch('/user/research/subjectRegistConfirm.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + '에러발생');
	})
	.then(data => {
		
		switch(data.result) {
		
			case 'success':
				alert('정상적으로 저장되었습니다.');
				
				let queryString = '';
				queryString += '?participatedResearchId=' + ${participatedResearchId};
				queryString += '&researchTaskId=' + ${researchTaskId};
				
				location.href = '/user/research/subjectListPage.do' + queryString;
				break;
				
			default:
				alert('저장에 실패하였습니다. 다시 시도해주세요.');
				break;
		}
	})
	.catch(error => { 
		
		console.error(error); 
		alert('입력에 실패하였습니다. 잠시후 다시 시도해주세요.');
	});
}
function searchAddr() {
	
	new daum.Postcode({ 
		oncomplete: function(data) {
		
			$("#subjectPlace").val(data.roadAddress); 
		} 
	})
	.open();
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
							<th><span class="red">*&nbsp;</span>조사기관</th>
							<td><input type="text" id="userName" class="form wp90" placeholder="${userName}" value="${userName}" disabled>
							</td>
							<th><span class="red">*&nbsp;</span>기주번호</th>
							<td><input type="text" id="subjectNum" class="form wp90" placeholder="${subjectNum}" value="${subjectNum}" disabled></td>
						</tr>
						<tr>
							<th><span class="red">*&nbsp;</span>조사일시</th>
							<td colspan="3">
							<input type="text" id="datepickers" placeholder="조사일시" class="inp_date wp95" title="시작년월일을 입력합니다. YYYY-MM-DD형식으로 입력하세요." readonly="readonly">
							</td>
						</tr>
						<tr>
							<th><span class="red">*&nbsp;</span>시작시간</th>
							<td><input type="time" id="researchStartTime" class="form wp95" placeholder="시작시간"></td>
							<th><span class="red">*&nbsp;</span>종료시간</th>
							<td><input type="time" id="researchEndTime" class="form wp95" placeholder="종료시간"></td>
						</tr>
						<tr>
							<th><span class="red">*&nbsp;</span>조사자</th>
							<td colspan="3" class="t_list_box">
								<div id="selectedUserWrap">
									<!-- 
										<button>
											<span class="mr5">admin1</span>
											<img src="/../css/user/mobile/images/cancel_c.png" alt="닫기 이미지">
										</button>
										 -->
								</div> 
								<input type="text" id="userInput" class="form wp60 mt5">
								<button class="btn_a_src_02 wp25 mt5" title="추가" onclick="addUser();">
									<span>추가</span>
								</button>
							</td>
						</tr>
						<tr>
							<th>날씨</th>
							<td>
								<select id="subjectWeather" title="날씨선택" class="form wp95">
										<option value="">선택</option>
										<option value="맑음">맑음</option>
										<option value="흐림">흐림</option>
										<option value="비">비</option>
										<option value="눈">눈</option>
										<option value="태풍">태풍</option>
										<option value="안개">안개</option>
								</select>
							</td>
							<th>온도</th>
							<td><input type="text" id="subjectTemp" class="form wp95"></td>
						</tr>
						<tr>
							<th><span class="red">*&nbsp;</span>조사장소</th>
							<td colspan="3">
							<input type="text" id="subjectPlace" class="form wp95" onclick="searchAddr()"></td>
						</tr>
						<tr>
							<th><span class="red">*&nbsp;</span>GPS</th>
							<td colspan="3">
								<input type="text" id="subjectPosX" class="form wp45" placeholder="위도"> 
								<input type="text" id="subjectPosY" class="form wp45" placeholder="경도">
							</td>
						</tr>
						<tr>
							<th>고도</th>
							<td><input type="text" id="subjectAltitude" class="form wp95"></td>
							<th>장소유형</th>
							<td colspan="3"><input type="text" id="subjectPlaceType" class="form wp95"></td>
						</tr>
						<tr>
							<th><span class="red">*&nbsp;</span>해충명</th>
							<td colspan="3" class="t_list_box">
								<input type="text" id="searchInsectInput" class="form wp60" onkeyup="inputHandler()"> 
								<div class="t_search_box wp60" id="searchInsectWrap" style="display: none;">
									<!-- 검색된 곤충 표기구간 -->
								</div>
							</td>
						</tr>
						<tr>
							<th>발생여부</th>
							<td colspan="3">
								<ul class="checkboL ml10">
									<li>
										<div class="checkboX">
											<input class="pointer" type="radio" value="O" id="01-01" name="subjectActive" checked="checked"> 
											<label for="01-01" class="mr5">발생</label>
										</div>
									</li>
									<li>
										<div class="checkboX ">
											<input class="pointer" type="radio" value="X" id="02-02" name="subjectActive">
											<label for="02-02">미발생</label>
										</div>
									</li>
								</ul>
							</td>
						</tr>
						<tr>
							<th>상태</th>
							<td colspan="3"><input type="text" id="subjectStatus" class="form wp95"></td>
						</tr>
						<tr>
							<th><span class="red">*&nbsp;</span>기주식물명</th>
							<td colspan="3"><input type="text" id="subjectName" class="form wp95"></td>
						</tr>
						<tr>
							<th>해충발생정도</th>
							<td colspan="3">
							<input id="pestInfestationLevel" type="text" class="form wp95">
							</td>
						</tr>
						<tr>
							<th>식물 내 발생 위치</th>
							<td colspan="3"><input type="text" id="pestExistencePosition" class="form wp95"></td>
						</tr>
						<tr>
							<th>기타 조사지 내 식물군</th>
							<td colspan="3"><input type="text" id="plantInarea" class="form wp95"></td>
						</tr>
						<tr>
							<th>기타 특이사항 및 환경</th>
							<td colspan="3"><input type="text" id="subjectNote" class="form wp95"></td>
						</tr>
						<tr>
							<th>도로 가장자리와의 거리</th>
							<td colspan="3"><input type="text" id="distFromroad" class="form wp95"></td>
						</tr>
						<tr>
							<th>도로종류</th>
							<td colspan="3"><input type="text" id="roadType" class="form wp95"></td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 저장버튼 시작 -->
			<div class="end_btn mt20">
				<button class="btn_a_src_03_1 wp20" title="저장" onclick="submit();">
					<span>저장</span>
				</button>
			</div>
			<!-- 저장버튼 끝 -->
		</div>
		<!-- 조사등록 끝 -->
	</div>
</body>
</html>