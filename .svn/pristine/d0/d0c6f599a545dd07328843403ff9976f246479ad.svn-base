<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />

<style type="text/css">
#uploadedFile, .pointer {
	cursor: pointer;
}

.pointer:hover {
	color: #005fb1;
}
	
#uploadedFile:hover {
	color: #005fb1;
}
</style>

<script type="text/javascript">
function deleteFileInput() {
	
	if (!confirm('파일을 삭제하시겠습니까?')) return;
	
	let html = '';
	html += '<div id="fileBoxArea" class="filebox">';
	html += '<input id="fileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">';
	html += '<input id="fileInput" name="file" onchange="setFileName();" type="file" class="form wp50 ">';
	html += '<label for="fileInput">파일찾기</label>';
	html += '</div>';
	
	$('#fileArea').html(html);
	$('#attachFilenm').val('${boardVo.attachFilenm}');
}

function setFileName() {
	
	let fileName = $('#fileInput')[0].files[0].name;
	$('#fileName').val(fileName);	
	$('#uploadFileName').val(fileName);
}

function boardModifyConfirm() {
	
	let formData = new FormData($('#boardForm')[0]);
	
	fetch('/admin/boardModifyConfirm.do', {
		method: 'POST',
		headers: {
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: formData
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 수정되었습니다.');
				location.href='/admin/boardListPage.do?boardDiv=${boardDiv}';
				break;
			  
			default:
				alert('수정에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
	})
	.catch(error => { 
		
		console.error(error); 
		alert('수정에 실패하였습니다. 잠시후 다시 시도해주세요.');
	})
}
</script>
</head>

<body>
    <!-- S: .wrap -->
    <div class="wrap">
        <jsp:include page="../common/header_nav.jsp" />
        <!-- S: main -->
        <main id="mainArea">
		<!-- S: .rocate -->
		<div class="rocate">
		    <ul>
		        <li><a href="#none"><img src="/css/admin/images/home.png" alt="home"></a></li>
		        <li><span>관리자페이지</span></li>
		        <li><span>게시판관리</span></li>
		        <c:choose>
			        <c:when test="${boardVo.boardDiv == 1000}">
			        	<li class="ro_last"><span>공지사항 수정</span></li>
			        </c:when>
			        <c:when test="${boardVo.boardDiv == 2000}">
			        	<li class="ro_last"><span>보도자료 수정</span></li>
			        </c:when>
			        <c:when test="${boardVo.boardDiv == 3000}">
			        	<li class="ro_last"><span>자료실 수정</span></li>
			        </c:when>		        
		        </c:choose>
		    </ul>
		</div>
		<!-- E: .rocate -->
		<!-- S: .search -->
		<section class="search">
			<c:choose>
		        <c:when test="${boardVo.boardDiv == 1000}">
			    	<div class="search_txt"><span>공지사항 수정</span></div>
		        </c:when>
		        <c:when test="${boardVo.boardDiv == 2000}">
			    	<div class="search_txt"><span>보도자료 수정</span></div>
		        </c:when>
		        <c:when test="${boardVo.boardDiv == 3000}">
			    	<div class="search_txt"><span>자료실 수정</span></div>
		        </c:when>
			</c:choose>
		</section>
		<!-- S: .search -->
		<!-- S: main_menu2 -->
		<section class="main_menu2 mt20">
		    <article class="main_project_02" tabindex="0">
		        <!-- S: .table_reset -->
		        <div class="table_reset mt20 mb20">
		        	<form id="boardForm">
			        	<input id="boardNum" name="boardNum" type="hidden" value="${boardNum}">
			        	<input id="attachFilenm" name="attachFilenm" type="hidden" value="">
			            <table class="board_date02">
			                <colgroup>
			                    <col style="width:15%;">
			                    <col style="width:50%;">
			                </colgroup>
			                <tbody>
			                    <tr>
			                        <th scope="col">제목</th>
			                        <td colspan="3"> 
			                            <input id="boardSubject" name="boardSubject" type="text" class="form wp100 " value="${boardVo.boardSubject}">
			                        </td>
			                    </tr>
			                    <tr >
			                        <th scope="col">본문내용</th>
			                        <td colspan="3">
			                            <textarea id="boardContents" name="boardContents" class="wgm_mng_area" name="" rows="8" cols="80" style="height:250px">${boardVo.boardContents}</textarea>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th scope="col">파일첨부</th>
			                        <td id="fileArea" colspan="3">
		                        		<c:if test="${not empty boardVo.attachFilenm}">
				                            <a id="uploadedFile" href="/fileDownload.do?fileName=${boardVo.attachFilenm}" download="${boardVo.attachement}">${boardVo.attachement}</a>
				                        	&nbsp;&nbsp;<a onclick="deleteFileInput();" class="pointer">X</a>
		                        		</c:if>
		                        		<c:if test="${empty boardVo.attachFilenm}">
				                        	<div id="fileBoxArea" class="filebox">
			                                    <input id="fileName" class="upload-name" value="첨부파일" placeholder="첨부파일" disabled="disabled">
				                            	<input id="fileInput" name="file" onchange="setFileName();" type="file" class="form wp50 ">
			                                    <label for="fileInput">파일찾기</label>
		                                    </div>
	                                    </c:if>
			                        </td>
			                    </tr>
			                </tbody>
			            </table>
		            </form>
		        </div>
		        <!-- E: .table_reset -->
		    </article>
		    <!-- S: .btn_r -->
		    <div class="mt20 mb30 mr14 btn_r">
		        <a onclick="boardModifyConfirm();" class="btn_list_src pointer" title="수정버튼"><span>수정</span></a>
				<c:choose>
					<c:when test="${boardVo.boardDiv == 1000}">
			        	<a href="/admin/boardListPage.do?boardDiv=1000" class="btn_list_src" title="취소버튼"><span>취소</span></a>
			        </c:when>		    
					<c:when test="${boardVo.boardDiv == 2000}">
			        	<a href="/admin/boardListPage.do?boardDiv=2000" class="btn_list_src" title="취소버튼"><span>취소</span></a>
			        </c:when>		    
					<c:when test="${boardVo.boardDiv == 3000}">
			        	<a href="/admin/boardListPage.do?boardDiv=3000" class="btn_list_src" title="취소버튼"><span>취소</span></a>
			        </c:when>	
				</c:choose>
		    </div>
		    <!-- E: .btn_r -->
		</section>
		<!-- E: main_menu2 -->
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
</body>
</html>