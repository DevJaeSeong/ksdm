<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/loadingHead.jsp" />

<script type="text/javascript">
$(function() {
	
	initEvents();
})

function initEvents() {
	
	$('#file').change(function() {
		
		let fileName = $('#file').prop('files')[0].name;
		$('#fileName').val(fileName);
	})
}

function excelUpload() {
	
	let files = $('#file').prop('files');
	
	if (files.length <= 0) {
		
		alert('업로드할 엑셀을 첨부해주세요.');
		return;
	}
	
	let formData = new FormData();
	formData.append('file', files[0]);
	
	showLoadingOverlay();
	
	fetch('/admin/excelUpload/excelUpload.do', {
		method: 'POST',
		headers: {
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: formData
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 저장되었습니다.');
			  	break;
			  
			case 'wrongExcel':
				alert('유효한 엑셀이 아닙니다. 확인 후 다시 시도해주세요.');
			  	break;
			  
			default:
				alert('저장에 실패하였습니다. 잠시후 다시 시도해주세요.');
			  	break;
		}
	})
	.catch(error => {
		
		console.error('fetch에러 => ', error);
		alert('에러가 발생하였습니다. 잠시후 다시 시도해주세요.');
	})
	.finally(() => {
		
		hideLoadingOverlay();
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
                    <li><a href="/main"><img src="/css/admin/images/home.png" alt="home"></a></li>
                    <li><span>관리자페이지</span></li>
                    <li><span>엑셀업로드</span></li>
                    <li class="ro_last"><span>조사내용 엑셀업로드</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>조사내용 엑셀업로드</span></div>
            </section>
            <!-- S: .search -->
            <!-- S: main_menu2 -->
            <section class="main_menu2 mt20">
                <article class="main_project_02" tabindex="0">
                    <!-- S: .table_reset -->
                    <div class="table_reset mt20">
                        <table class="board_date01">
                            <colgroup>
                                <col style="width:10%;">
                                <col style="width:50%;">
                                <col style="width:50%;">
                            </colgroup>
                            <thead>
                            	<!--  
                                <tr>
                                    <th scope="col">항목</th>
                                    <th scope="col">과제명 선택</th>
                                    <th scope="col">조사업무명 선택</th>
                                </tr>
                                -->
                            </thead>
                            <tbody>
                            	<!--  
                                <tr>
                                    <td>1</td>
                                    <td>
                                        <select title="1" class="form wp100">
                                            <option value="01">과제명 선택 1</option>
                                            <option value="02">과제명 선택 2</option>
                                            <option value="03">과제명 선택 3</option>
                                            <option value="04">과제명 선택 4</option>
                                        </select>
                                    </td>
                                    <td>
                                        <div class="searchbox">
                                            <input type="text" class="form wp90" placeholder="검색어 입력">
                                            <button class="searchbtn">검색</button>
                                        </div>
                                    </td>
                                </tr>
                                -->
                                <tr>
                                    <td colspan="3">
                                        <div class="filebox">
                                            <input id="fileName" class="upload-name" value="첨부파일" placeholder="첨부파일" disabled="disabled">
                                            <label for="file">파일찾기</label>
                                            <input type="file" id="file">
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .btn_r -->
                    <div class="btn_r mt20">
                        <a href="javascript:;" onclick="excelUpload();" class="btn_list_src mr10" title="업로드버튼"><span>업로드</span></a>
                    </div>
                    <!-- E: .btn_r -->
                    <!-- S: .paging_wrap -->
                    <!--  
                    <div class="paging_wrap">
                        <button type="button" class="btn_page_prev" title="이전 페이지">이전</button>
                        <a href="#" class="current" title="현재 1페이지">1</a>
                        <a href="#" title="2페이지">2</a>
                        <a href="#" title="3페이지">3</a>
                        <a href="#" title="4페이지">4</a>
                        <a href="#" title="5페이지">5</a>
                        <button type="button" class="btn_page_next" title="다음 페이지">다음</button>
                    </div>
                    -->
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