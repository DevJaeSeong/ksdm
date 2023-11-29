<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />

<script type="text/javascript">
function setFileName() {
	
	let name = $('#fileInput')[0].files[0].name;
	$('#fileName').val(name);
}

function boardRegistConfirm() {
	
	let boardDiv = '${boardDiv}';
	let boardSubject = $('#boardSubject').val();
	let boardContents = $('#boardContents').val();
	let files = $('#fileInput')[0].files;
	let file;
	
	if (files.length > 0) file = files[0];
	else file = null;
	
	let formData = new FormData();
	formData.append('boardDiv', boardDiv);
	formData.append('boardSubject', boardSubject);
	formData.append('boardContents', boardContents);
	formData.append('file', file);
	
	fetch('/admin/boardRegistConfirm.do', {
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
				alert('정상적으로 저장되었습니다.');
				location.href='/admin/boardListPage.do?boardDiv=${boardDiv}';
			  	break;
			  
			case 'uploadFail':
				alert('파일 업로드에 실패하였습니다.');
			  	break;
			  
			default:
				alert('저장에 실패하였습니다. 잠시후 다시 시도해주세요.');
			  	break;
		}
	})
	.catch(error => { 
		
		alert('저장에 실패하였습니다. 잠시후 다시 시도해주세요.');
		console.error('fetch에러 => ', error); 
	});
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
			        <c:when test="${boardDiv == 1000}">
			        	<li class="ro_last"><span>공지사항 글쓰기</span></li>
			        </c:when>
			        <c:when test="${boardDiv == 2000}">
			        	<li class="ro_last"><span>보도자료 글쓰기</span></li>
			        </c:when>
			        <c:when test="${boardDiv == 3000}">
			        	<li class="ro_last"><span>자료실 글쓰기</span></li>
			        </c:when>
		        </c:choose>
		    </ul>
		</div>
		<!-- E: .rocate -->
		<!-- S: .search -->
		<section class="search">
			<c:choose>
		        <c:when test="${boardDiv == 1000}">
			    	<div class="search_txt"><span>공지사항 글쓰기</span></div>
		        </c:when>
		        <c:when test="${boardDiv == 2000}">
			    	<div class="search_txt"><span>보도자료 글쓰기</span></div>
		        </c:when>
		        <c:when test="${boardDiv == 3000}">
			    	<div class="search_txt"><span>자료실 글쓰기</span></div>
		        </c:when>
			</c:choose>
		</section>
		<!-- S: .search -->
		<!-- S: main_menu2 -->
		<section class="main_menu2 mt20">
		    <article class="main_project_02" tabindex="0">
		        <!-- S: .table_reset -->
		        <div class="table_reset mt20 mb20">
		            <table class="board_date02">
		                <colgroup>
		                    <col style="width:15%;">
		                    <col style="width:50%;">
		                </colgroup>
		                <tbody>
		                	<!--  
		                    <tr>
		                        <th scope="col">항목</th>
		                        <td colspan="3">
		                            <ul class="radio">
		                                <li>
		                                    <input type="radio" value="1000" name="username" id="date_area1"checked>
		                                    <label for="date_area1"><span>공지사항</span></label>
		                                </li>
		                                <li>
		                                    <input type="radio" value="2000" name="username" id="date_area2">
		                                    <label for="date_area2"><span>보도자료</span></label>
		                                </li>
		                            </ul>
		                        </td>
		                    </tr>
		                    -->
		                    <tr>
		                        <th scope="col">제목</th>
		                        <td colspan="3"> 
		                            <input id="boardSubject" type="text" class="form wp100 ">
		                        </td>
		                    </tr>
		                    <tr >
		                        <th scope="col">본문내용</th>
		                        <td colspan="3">
		                            <textarea id="boardContents" class="wgm_mng_area" name="" rows="8" cols="80" style="height:250px"></textarea>
		                        </td>
		                    </tr>
		                    <tr>
		                        <th scope="col">파일첨부</th>
		                        <td colspan="3">
	                                <div class="filebox">
	                                    <input id="fileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
		                            	<input id="fileInput" onchange="setFileName();" type="file" class="form wp50 ">
	                                    <label for="fileInput">파일찾기</label>
                                    </div>
		                        </td>
		                    </tr>
		                </tbody>
		            </table>
		        </div>
		        <!-- E: .table_reset -->
		    </article>
		    <!-- S: .btn_r -->
		    <div class="mt20 mb30 mr14 btn_r">
		        <a href="javascript:void(0)" onclick="boardRegistConfirm();" class="btn_list_src" title="저장버튼"><span>저장</span></a>
				<c:choose>
					<c:when test="${boardDiv == 1000}">
			        	<a href="/admin/boardListPage.do?boardDiv=1000" class="btn_list_src" title="취소버튼"><span>취소</span></a>
			        </c:when>		    
					<c:when test="${boardDiv == 2000}">
			        	<a href="/admin/boardListPage.do?boardDiv=2000" class="btn_list_src" title="취소버튼"><span>취소</span></a>
			        </c:when>		    
					<c:when test="${boardDiv == 3000}">
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