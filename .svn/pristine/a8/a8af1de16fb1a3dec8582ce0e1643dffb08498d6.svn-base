<%@page import="egovframework.ksdmWeb.security.UserDetailVo"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<% Authentication authentication = SecurityContextHolder.getContext().getAuthentication(); %>

<jsp:include page="../common/head.jsp" />

<style type="text/css">
a.under {
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function() {
	getParticipatedResearchList(1);
})

function getParticipatedResearchList(pageIndex) {
	
	let searchKeyword = $('#searchInput').val();
	let researchStatusCode = $('#search_001').val();
	
	let queryString = '';
	queryString += '?pageIndex=' + pageIndex;
	queryString += '&searchKeyword=' + searchKeyword;
	queryString += '&researchStatusCode=' + researchStatusCode;
		
	fetch('/user/research/getParticipatedResearchList.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		showParticipatedResearchList(data);
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('데이터를 가져오지 못했습니다. 잠시후 다시 시도해주세요.');
	});
}

function showParticipatedResearchList(data){
	
	let researchVos = data.researchVos;
	
	let html = '';
	
	$.each(researchVos, function(index, researchVo) {
		
		let classValue = selectClassValue(researchVo.researchStatusName);
		let researchTaskId = researchVo.researchTaskId;
		let participatedResearchId = researchVo.participatedResearchId;
		
		let queryString = '';
		queryString += '?participatedResearchId=' + researchVo.participatedResearchId
		queryString += '&researchTaskId=' + researchVo.researchTaskId
		queryString += '&researchStatusCode=' + researchVo.researchStatusCode;
		
		html += '<tr>';
		html += '<td>' + researchVo.participatedResearchId + '</td>';
		html += '<td><span class="under">' + researchVo.taskName + '</span></td>';
		html += '<td><a class="under" href="/user/research/subjectListPage.do' + queryString + '">' + researchVo.researchTaskName + '</a></td>';
		html += '<td><span class="' + classValue + '">' + researchVo.researchStatusName + '</span></td>';
		html += '</tr>';
	});
	
	$('#table_tbody').html(html);
	
	let paginationInfo = data.paginationInfo;
	
	$('#totalCnt').text(paginationInfo.totalRecordCount + '건');
	
	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
	let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));

	$('#pagingWrap').empty();
      
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_first\" title=\"맨앞 페이지\" onclick=\"getParticipatedResearchList(1); return false;\">맨 처음</button>');
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_prev\" title=\"이전 페이지\" onclick=\"getParticipatedResearchList(' + prev + '); return false;\">이전</button>');

	$('#pagingWrap').append('<ul>');
	
	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
         
        if (i == paginationInfo.currentPageNo) {
           
          $('#pagingWrap').append('<li class="current">' + i + '</li>');
          
        } else {
           
          $('#pagingWrap').append('<li onclick="getParticipatedResearchList(' + i + ')">' + i + '</li>');
        }
      }    
	
	$('#pagingWrap').append('</ul>');
	
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_next\" title=\"다음 페이지\" onclick=\"getParticipatedResearchList(' + next + '); return false;\">다음</button>');
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_last\" title=\"맨 마지막\" onclick=\"getParticipatedResearchList(' + paginationInfo.lastPageNo + '); return false;\">맨 마지막</button>');
}

function selectClassValue(researchStatusName) {
	
	let classValue = '';
	
	switch (researchStatusName) {
	
    case '조사중':
    	classValue = 'b_r01 bg03';
        break;
        
    case '반려':
    	classValue = 'b_r01 bg04';
        break;
        
    case '심사중':
    	classValue = 'b_r01 bg02';
        break;
        
    case '접수중':
    	classValue = 'b_r01 bg05';
        break;
        
    case '완료':
    	classValue = 'b_r01 bg01';
    	break;
    	
    default:
    	
        break;
	}

	return classValue;
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
        <p class="con_title ml20">과제내역</p>
        <!-- E: . con_title -->
         <!-- 검색 박스 시작 -->
         <div class="con_box_02">
            <div class="table_typA st03">
                <table class="contTbl">
                    <colgroup>
                        <col style="width:20%;">
                        <col style="width:30%;">
                    </colgroup>
                    <tbody>
                        <tr>
                            <th>조사업무명</th>
                            <td colspan="3"><input type="text" id="searchInput" class="form wp95" title="제목"></td>
                        </tr>
                        <tr>
                            <th>진행상태</th>
                            <td colspan="3">
                                <select id="search_001" title="진행상태선택" class="form wp95">
                                    <option value=""></option>
                                    <option value="1001">조사중</option>
                                    <option value="1002">접수중</option>
                                    <option value="1003">심사중</option>
                                    <option value="2001">완료</option>
                                    <option value="2002">반려</option>
                                </select>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <!-- 검색버튼 시작 -->
            <div class="end_btn">
                <button class="btn_a_src_03_1 wp20" title="검색" onclick="javascript:getParticipatedResearchList(1)"><span>검색</span></button>
            </div>
            <!-- 검색버튼 끝 -->
        </div>
        <!-- 검색 박스 끝 -->

        <!-- 과제내역 시작 -->
        <div class="project_box">
            <div class="table_typA">
                <table class="contTbl txtC">
                    <colgroup>
                        <col style="width:10%;">
                        <col style="width:40%;">
                        <col style="width:40%;">
                        <col style="width:10%;">
                    </colgroup>
                    <thead>
                        <tr>
                            <th>NO</th>
                            <th>년도별조사업무</th>
                            <th>조사업무명</th>
                            <th>진행상태</th>
                        </tr>
                    </thead>
                    <tbody id="table_tbody">
                    </tbody>
                </table>
            </div>
            <!-- 페이징 시작 -->
            <div class="paging_wrap mb15" id="pagingWrap">
            </div>
            <!-- 페이징 끝 -->
        </div>
        <!-- 과제내역 끝 -->
    </div>
</body>
</html>