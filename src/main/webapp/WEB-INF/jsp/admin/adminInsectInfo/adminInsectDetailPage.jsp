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
</style>

<script type="text/javascript">
$(function() {
	
	getInsectDetail();
})

function getInsectDetail() {
	
	fetch('/getInsectByinsectNum.do?insectNum=' + ${insectNum})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
		
	})
	.then(insectVo => {
		
		showInsectDetail(insectVo);
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('데이터를 가져오지 못했습니다. 잠시후 다시 시도해주세요.');
	});
}

function showInsectDetail(insectVo){
	
	let html = '';
	
	let insectStatusVos = insectVo.insectStatusVos;
		
	let status = '';
		
	$.each(insectStatusVos, function(index, insectStatusVo) {
		
		status += insectStatusVo.insectStatusName + ', ';
	})
	status = status.slice(0, -2);

	// 내용 구현 시작
	html += '<tr>';
	html += '<th scope="col">곤충순번</th>';
	html += '<td colspan="3">' + insectVo.insectNum + '</th>';
	html += '</tr>';
	html += '<tr>';
	html += '<th scope="col">한글명</th>';
	html += '<td colspan="3">' + insectVo.korSpecificName + '</th>';
	html += '</tr>';
	html += '<tr>';
	html += '<th scope="col">영문명</th>';
	html += '<td colspan="3">' + insectVo.engSpecificName + '</th>';
	html += '</tr>';
	html += '<tr>';
	html += '<th scope="col">분류군</th>';
	html += '<td>' + insectVo.taxon + '</th>';
	html += '<th scope="col">관리현황</th>';
	html += '<td>' + status + '</th>';
	html += '</tr>';
	html += '<tr>';
	html += '<th scope="col">이미지</th>';
	html += '<td colspan="3"><a href="/fileDownload.do?fileName=' + insectVo.savedFileName + '" download="' + insectVo.oriFileName + '">' + insectVo.oriFileName + '</a></th>';
	html += '</tr>';
	html += '<tr>';
	html += '<th scope="col">상세설명</th>';
	html += '<td colspan="3" class="t_ex_inner">';
	html += '<p>' + insectVo.description + '</p>';
	html += '<td>';
	html += '</tr>';
	
	$('#table_tbody').html(html);
}

function modifyInsectInfo() {
	
	location.href = '/admin/insectInfo/adminInsectModifylPage.do?insectNum=' + ${insectNum};
}
function deleteInsectInfo() {
	
	if(!confirm('삭제하시겠습니까?')) return;
	
	let sendData = {
		'insectNum': ${insectNum}
	};
	
	fetch('/admin/insectInfo/deleteInsectInfo.do', {
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
				location.href='/admin/insectInfo/adminInsectListPage.do';
				break;
			  
			default:
				alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
		
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('삭제에 실패하였습니다. 잠시후 다시 시도해주세요.');
	})
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
					<li><span>데이터관리</span></li>
					<li class="ro_last"><span>곤충상세</span></li>
				</ul>
			</div>
			<!-- E: .rocate -->
			<!-- S: .search -->
			<section class="search">
				<div class="search_txt">
					<span>곤충상세</span>
				</div>
			</section>
			<!-- E: .search -->
			<!-- S: main_menu2 -->
			<section class="main_menu2 mt20">
                <article class="main_project_02" tabindex="0">
                    <!-- S: .table_reset -->
                    <div class="table_reset mt20 mb20">
                        <table class="board_date02">
                            <colgroup>
                                <col style="width:15%;">
                                <col style="width:50%;">
                                <col style="width:15%;">
                                <col style="width:50%;">
                            </colgroup>
                            <tbody id="table_tbody">
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .btn_center -->
                    <div class="btn_r" style="margin-top: 30px;">
                        <a href="/admin/insectInfo/adminInsectListPage.do" class="btn_list_src mr10 pointer" title="목록버튼"><span>목록</span></a>
                        <a class="btn_list_src mr10 pointer" title="승인버튼" onclick="modifyInsectInfo()"><span>수정</span></a>
                        <a class="btn_list_src c_red pointer" title="삭제버튼" onclick="deleteInsectInfo()"><span>삭제</span></a>
                    </div>
                    <!-- E: .btn_center -->
                </article>
            </section>
		</main>
		<!-- E: main -->
	</div>
	<!-- E:.wrap -->
</body>
</html>