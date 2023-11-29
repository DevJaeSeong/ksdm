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
	
<script type="text/javascript">
$(function() {
	getResearchList(1);
})

function getResearchList(pageIndex) {
	
	let searchKeyword = $('#searchInput').val();
	
	fetch('/user/research/getResearchList.do?pageIndex=' + pageIndex + '&searchKeyword=' + searchKeyword)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		showResearchList(data);
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('데이터를 가져오지 못했습니다. 잠시후 다시 시도해주세요.');
	});
}

function showResearchList(data){
	let researchVos = data.researchVos;
	
	let html = '';
	
	$.each(researchVos, function(index, researchVo) {
		
		html += '<tr>';
		html += '<td>' + researchVo.researchTaskId + '</td>';
		html += '<td><a class="under" href="#none">' + researchVo.taskName + '</a></td>';
		html += '<td><span class="under" href="#none">' + researchVo.researchTaskName + '</span></td>';
		html += '<td><button class="btn_a_src_03_1 wp20" title="검색" onclick="javascript:researchRegist(' + researchVo.researchTaskId + ')">등록</button></td>';
		html += '</tr>';
	});
	
	$('#table_tbody').html(html);
	
	let paginationInfo = data.paginationInfo;
	
	if(paginationInfo.totalRecordCount > 0){
		$('#totalCnt').text(paginationInfo.totalRecordCount + '건');
	} else {
		$('#totalCnt').text('0건');
	}
	
	let prev = (paginationInfo.firstPageNoOnPageList == 1 ? 1 : (paginationInfo.currentPageNo - paginationInfo.pageSize < 1 ? 1 : paginationInfo.currentPageNo - paginationInfo.pageSize));
	let next = (paginationInfo.lastPageNoOnPageList == paginationInfo.lastPageNo ? paginationInfo.lastPageNo : (paginationInfo.currentPageNo + paginationInfo.pageSize > paginationInfo.lastPageNo ? paginationInfo.lastPageNo : paginationInfo.currentPageNo + paginationInfo.pageSize));

	$('#pagingWrap').empty();
      
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_first\" title=\"맨앞 페이지\" onclick=\"getResearchList(1); return false;\">맨 처음</button>');
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_prev\" title=\"이전 페이지\" onclick=\"getResearchList(' + prev + '); return false;\">이전</button>');

	$('#pagingWrap').append('<ul>');
	
	for (let i = paginationInfo.firstPageNoOnPageList; i <= paginationInfo.lastPageNoOnPageList; i++) {
         
        if (i == paginationInfo.currentPageNo) {
           
          $('#pagingWrap').append('<li class="current">' + i + '</li>');
          
        } else {
           
          $('#pagingWrap').append('<li onclick="getResearchList(' + i + ')">' + i + '</li>');
        }
      }    
	
	$('#pagingWrap').append('</ul>');
	
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_next\" title=\"다음 페이지\" onclick=\"getResearchList(' + next + '); return false;\">다음</button>');
	$('#pagingWrap').append('<button type=\"button\" class=\"btn_page_last\" title=\"맨 마지막\" onclick=\"getResearchList(' + paginationInfo.lastPageNo + '); return false;\">맨 마지막</button>');
}

function researchRegist(researchTaskId) {
	
	fetch('/user/research/researchRegist.do?researchTaskId=' + researchTaskId)
	
	.then(response => {
		
		if (response.ok) return response;
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		alert('등록이 완료되었습니다. 조사를 시작하세요.');
		
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('데이터를 가져오지 못했습니다. 잠시후 다시 시도해주세요.');
	});
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
                    </tbody>
                </table>
            </div>
            <!-- 검색버튼 시작 -->
            <div class="end_btn">
                <button class="btn_a_src_03_1 wp20" title="검색" onclick="javascript:getResearchList(1)"><span>검색</span></button>
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
                            <th>과제명</th>
                            <th>조사업무명</th>
                            <th>등록</th>
                        </tr>
                    </thead>
                    <tbody id="table_tbody">
                        <!-- 
                        <tr>
                            <td>1</td>
                            <td><a class="under" href="#none">[산림청]2021년 하반기 외래무척추의 확산 조사1</a></td>
                            <td><span class="under" href="#none">2021년 하반기 외래무척추의 확산 조사1</span></td>
                        </tr>
                         -->
                    </tbody>
                </table>
            </div>
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