<%@page import="egovframework.ksdmWeb.security.UserDetailVo"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@page import="egovframework.ksdmWeb.security.UserDetailVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>

<% Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); %>
<jsp:include page="../common/head.jsp" />

<style type="text/css">
.pointer {
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function() {
	
	getSubjectList(1);
})

// 현재 페이지의 조사 식별번호 showSubjectList() 에서 재할당
let participatedResearchId = 0;

function getSubjectList(pageIndex) {
	
	let searchKeyword = $('#searchInput').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&participatedResearchId=' + ${participatedResearchId};
	
	fetch('/user/research/getSubjectList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		showSubjectList(data);
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('데이터를 가져오지 못했습니다. 잠시후 다시 시도해주세요.');
	});
}

function showSubjectList(data){
	
	let subVos = data.subVos;
	let html = '';
	
	$.each(subVos, function(index, subVo) {
		
		let queryString = '';
		queryString += '?participatedResearchId=' + ${participatedResearchId};
		queryString += '&researchTaskId=' + ${researchTaskId};
		queryString += '&subjectNum=' + subVo.subNum;
		
		html += '<tr>';
		html += '<td>' + subVo.subNum + '</td>';
		html += '<td><a class="under" href="/user/research/subjectDetailPage.do' + queryString + '">' + subVo.subPlantName + '</a></td>';
		html += '<td><span class="under">' + subVo.subInsectName + '</span></td>';
		html += '<td>' + subVo.subOccurrenceStatus + '</td>';
		html += '</tr>';
	});
	
	$('#table_tbody').html(html);
	
	let paginationInfo = data.paginationInfo;
	
	if (paginationInfo.totalRecordCount > 0) {
		
		$('#totalCnt').text(paginationInfo.totalRecordCount + '건');
		
	} else {
		
		$('#totalCnt').text('0건');
	}
	
	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
	let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));

	$('#pagingWrap').empty();
      
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_prev\" title=\"이전 페이지\" onclick=\"getSubjectList(' + prev + '); return false;\">이전</button>');

	$('#pagingWrap').append('<ul>');
	
	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
         
        if (i == paginationInfo.currentPageNo) {
           
          $('#pagingWrap').append('<li class="current">' + i + '</li>');
          
        } else {
           
          $('#pagingWrap').append('<li onclick="getSubjectList(' + i + ')">' + i + '</li>');
        }
      }    
	
	$('#pagingWrap').append('</ul>');
	
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_next\" title=\"다음 페이지\" onclick=\"getSubjectList(' + next + '); return false;\">다음</button>');
	
	updateStatusBtnHandler(paginationInfo.totalRecordCount);
}

function changeActiveCodeToKor(subjectActive) {
	
	switch (subjectActive) {
	
    case 'O':
    	subjectActive = '발생';
        break;
    
    case 'o':
    	subjectActive = '발생';
        break;
        
    case 'X':
    	subjectActive = '미발생';
        break;
        
    case 'x':
    	subjectActive = '미발생';
        break;
	}
	
	return subjectActive;
}

function updateStatusBtnHandler(totalRecordCount) {
	
	let researchStatusCode = '${researchStatusCode}';
	
	if ((researchStatusCode == '1001' || researchStatusCode == '2002') && totalRecordCount > 0) {
		
		$('#updateStatusBtn').css('display', 'bolck');
		
	} else {
		
		$('#updateStatusBtn').css('display', 'none');
	}
}

function registSubject() {
	
	let queryString = '';
	queryString += '?participatedResearchId=' + ${participatedResearchId};
	queryString += '&researchTaskId=' + ${researchTaskId};
	
	location.href = '/user/research/subjectRegistPage.do' + queryString;
}

function updateStatus() {
	
	let sendData = {
		'participatedResearchId': ${participatedResearchId}
		, 'researchTaskId': ${researchTaskId}
		, 'researchStatusCode': '1002'
	};
	
	fetch('/user/research/updateResearchStatus.do', {
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
				alert('정상적으로 신청되었습니다.');
				goList();
				break;
			  
			default:
				alert('신청에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
		
	})
	.catch(error => { 
		
		console.error(error); 
		alert('신청에 실패하였습니다. 잠시후 다시 시도해주세요.');
	})
}

function goList() {
	
	location.href = '/user/research/participatedRresearchListPage.do';
}
</script>
	
</head>

<body>
    <div class="wrap">
    
		<jsp:include page="../common/header.jsp" />
		
        <!-- 조사자 정보시작 -->
        <div class="profile_box">
            <div class="profile_inner">
                <div class="profile_img mt10">
                    <img src="/css/user/mobile/images/log_human.png" alt="사용자사진">
                </div>
                <div class="profile_info">
                    <p class="f_03 mt10 mb15"><%= ((UserDetailVo) authentication.getDetails()).getUserName() %>님</p>
                    <p class="f_01"><span class="st02" id="totalCnt"></span>의 과제가 있습니다.</p>
                </div>
            </div>
        </div>
        <!-- 조사자 정보끝 -->
        <!-- S: . con_title -->
        <p class="con_title ml20" style="width: 100%;">과제내역 - ${taskName} / ${researchTaskName}</p>
        <!-- E: . con_title -->
        <!-- 과제내역 시작 -->
        <div class="project_box">
            <div class="table_typA">
                <table class="contTbl txtC">
                    <colgroup>
                        <col style="width:15%;">
                        <col style="width:35%;">
                        <col style="width:35%;">
                        <col style="width:15%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>기주번호</th>
                            <th>기주식물명</th>
                            <th>해충명</th>
                            <th>발생여부</th>
                        </tr>
                    </thead>
                    <tbody id="table_tbody">
                        <!-- 
                        <tr>
                            <td>
                                <div class="checkboX">
                                <input type="checkbox" value="1" id="2" name="" checked>
                                </div>
                            </td>
                            <td>0101010</td>
                            <td><a class="under" href="#none">감나무</a></td>
                            <td><span class="under" href="#none">사슴벌레</span></td>
                            <td>발생</td>
                        </tr> 
                        -->
                    </tbody>
                </table>
            </div>
             <!-- 검색버튼 시작 -->
            <div class="end_btn mt10 mb30">
            	<button class="btn_a_src_03_1 bd04_1 mr10 wp20" title="심사신청" onclick="updateStatus()" id="updateStatusBtn"><span>심사신청</span></button>
                <button class="btn_a_src_03_1 wp20 mr10" title="추가" onclick="registSubject()"><span>추가</span></button>
                <button class="btn_a_src_03_1 wp20" title="추가" onclick="goList()"><span>목록</span></button>
            </div>
            <!-- 검색버튼 끝 -->
            <!-- 페이징 시작 -->
            <div class="paging_wrap mb15" id="pagingWrap">
                <button type="button" id="btn_page_first" class="btn_page_first current" title="맨앞 페이지">맨 처음</button>
                <button type="button" id="btn_page_prev" class="btn_page_prev" title="이전 페이지">이전</button>
                <ul><li class="current">1</li><li>2</li><li>3</li><li>4</li></ul>
                <button type="button" id="btn_page_next" class="btn_page_next" title="다음 페이지">다음</button>
                <button type="button" id="btn_page_last" class="btn_page_last" title="맨 마지막">맨 마지막</button>
            </div>
            <!-- 페이징 끝 -->
        </div>
        <!-- 과제내역 끝 -->
    </div>
</body>
</html>