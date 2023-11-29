<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
<jsp:include page="../common/loadingHead.jsp" />

<style type="text/css">
.pointer {
	cursor: pointer;
}
</style>

<script type="text/javascript">
$(function() {
	
	initEvents();
	//getTaskList();
})

function initEvents() {
	
	// 파일 업로드 이벤트 시작
	$('#pngFile').change(function() {
		
		let name = $('#pngFile')[0].files[0].name;
		
		if (name.slice(-4) != '.png') {
			
			alert('png 확장자 파일을 업로드해주세요.');
			$('#pngFile').val('');
			$('#pngFileName').val('');
			return;
		}
		
		$('#pngFileName').val(name);
	})
	
	$('#pdfFile').change(function() {
		
		let name = $('#pdfFile')[0].files[0].name;
		
		if (name.slice(-4) != '.pdf') {
			
			alert('pdf 확장자 파일을 업로드해주세요.');
			$('#pdfFile').val('');
			$('#pdfFileName').val('');
			return;
		}
		
		$('#pdfFileName').val(name);
	})
	
	$('#tifFile').change(function() {
		
		let name = $('#tifFile')[0].files[0].name;
		
		if (name.slice(-4) != '.tif') {
			
			alert('tif 확장자 파일을 업로드해주세요.');
			$('#tifFile').val('');
			$('#tifFileName').val('');
			return;
		}
		
		$('#tifFileName').val(name);
	})
	
	$('#jpgFile').change(function() {
		
		let name = $('#jpgFile')[0].files[0].name;
		
		if (name.slice(-4) != '.jpg') {
			
			alert('jpg 확장자 파일을 업로드해주세요.');
			$('#jpgFile').val('');
			$('#jpgFileName').val('');
			return;
		}
		
		$('#jpgFileName').val(name);
	})
	
	$('#programFile').change(function() {
		
		let name = $('#programFile')[0].files[0].name;
		$('#programFileName').val(name);
	})
	
	$('#menualFile').change(function() {
		
		let name = $('#menualFile')[0].files[0].name;
		$('#menualFileName').val(name);
	})
	// 파일 업로드 이벤트 끝
}

function getTaskList() {
	
	fetch('/getAllTaskList.do')
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + '에러발생');
	})
	.then(taskVos => {
		
		let html = '';
		
		$.each(taskVos, function(i, taskVo) {
			
			html += '<option value="' + taskVo.taskId + '">' + taskVo.taskName + '</option>'
		})
		
		$('#selectTask').html(html);
	})
	.catch(error => {
		
		console.log(error);
	})
}

function validateFile() {
	
	let forecastName = $('#forecastName').val();
	let forecastInsect = $('#forecastInsect').val();
	let pngFile = $('#pngFile')[0].files;
	let pdfFile = $('#pdfFile')[0].files;
	let tifFile = $('#tifFile')[0].files;
	let jpgFile = $('#jpgFile')[0].files;
	let programFile = $('#programFile')[0].files;
	let menualFile = $('#menualFile')[0].files;
	
	if (!forecastName) {
		
		alert('제목을 입력해주세요.');
		$('#forecastName').focus();
		return false;
	}
	
	if (!forecastInsect) {
		
		alert('해충명을 입력해주세요.');
		$('#forecastInsect').focus();
		return false;
	}
	
	if (jpgFile.length <= 0) {
		
		alert('jpg 파일을 업로드해주세요.');
		$('#jpgFile').focus();
		return false;
	}
	
	if (pngFile.length <= 0) {
		
		alert('png 파일을 업로드해주세요.');
		$('#pngFile').focus();
		return false;
	}
	
	if (pdfFile.length <= 0) {
		
		alert('pdf 파일을 업로드해주세요.');
		$('#pdfFile').focus();
		return false;
	}
	
	if (tifFile.length <= 0) {
		
		alert('tif 파일을 업로드해주세요.');
		$('#tifFile').focus();
		return false;
	}
	
	if (programFile.length <= 0) {
		
		alert('곤충분포예측프로그램을 업로드해주세요.');
		$('#programFile').focus();
		return false;
	}
	
	if (menualFile.length <= 0) {
		
		alert('곤충분포예측프로그램매뉴얼을 업로드해주세요.');
		$('#menualFile').focus();
		return false;
	}
	
	let fileNames = [pngFile[0].name, pdfFile[0].name, tifFile[0].name, 
					 jpgFile[0].name, programFile[0].name, menualFile[0].name];
	
	for (let i = 0; i < fileNames.length; i++) {
		
		for (let j = i + 1; j < fileNames.length; j++) {
			
			if (fileNames[i] == fileNames[j]) {
				
				alert('파일이름이 중복되지않게 해주세요.');
				return false;
			}
		}
	}
	
	return true;
}

function uploadFiles() {
	
	if (!validateFile()) return;
	
	let form = new FormData($('#filesForm')[0]);
	
	showLoadingOverlay();
	
	fetch('/admin/forecast/uploadFiles.do', {
		method: 'POST',
		headers: {
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: form
	})
	.then(response => {
		
		if (response.ok) 
			return response.json();
		else 
			throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 저장되었습니다.');
				location.href='/admin/forecast/forecastUploadPage.do';
				break;
				
			case 'already_exist':
				alert('해당 과제는 이미 업로드된 글이 있습니다.');
				break;

			default:
				alert('저장에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
	})
	.catch(error => { 
		
		console.error(error); 
		alert('업로드에 실패하였습니다. 잠시후 다시 시도해주세요.');
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
                    <li><a href="#none"><img src="/css/admin/images/home.png" alt="home"></a></li>
                    <li><span>관리자페이지</span></li>
                    <li><span>예상분포</span></li>
                    <li><span>예상분포업로드</span></li>
                    <li class="ro_last"><span>글쓰기</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>글쓰기</span></div>
            </section>
            <!-- S: .search -->
            <!-- S: main_menu2 -->
            <section class="main_menu2 mt20">
                <article class="main_project_02" tabindex="0">
                    <!-- S: .table_reset -->
                    <div class="table_reset mt20 mb20">
                    	<form id="filesForm">
                        <table class="board_date02">
                            <colgroup>
                                <col style="width:15%;">
                                <col style="width:50%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="col">제목</th>
                                    <td colspan="3">
                                        <input id="forecastName" name="forecastName" type="text" class="form wp50" title="제목" placeholder="제목을 입력하세요.">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">해충명</th>
                                    <td colspan="3">
                                        <input id="forecastInsect" name="forecastInsect" type="text" class="form wp50" title="제목" placeholder="해충명을 입력하세요.">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">업로드 이미지 (jpg)</th>
                                    <td colspan="3">
                                        <div class="filebox">
                                            <input id="jpgFileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
                                            <label for="jpgFile">파일찾기</label>
                                            <input type="file" id="jpgFile" name="jpgFile" accept=".jpg">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">다운로드 파일1 (png)</th>
                                    <td colspan="3">
                                        <div class="filebox">
                                            <input id="pngFileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
                                            <label for="pngFile">파일찾기</label>
                                            <input type="file" id="pngFile" name="pngFile" accept=".png">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">다운로드 파일2 (pdf)</th>
                                    <td colspan="3">
                                        <div class="filebox">
                                            <input id="pdfFileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
                                            <label for="pdfFile">파일찾기</label>
                                            <input type="file" id="pdfFile" name="pdfFile" accept=".pdf">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">다운로드 파일3 (tif)</th>
                                    <td colspan="3">
                                        <div class="filebox">
                                            <input id="tifFileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
                                            <label for="tifFile">파일찾기</label>
                                            <input type="file" id="tifFile" name="tifFile" accept=".tif">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">곤충분포예측프로그램</th>
                                    <td colspan="3">
                                        <div class="filebox">
                                            <input id="programFileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
                                            <label for="programFile">파일찾기</label>
                                            <input type="file" id="programFile" name="programFile">
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">곤충분포예측프로그램매뉴얼</th>
                                    <td colspan="3">
                                        <div class="filebox">
                                            <input id="menualFileName" class="upload-name" value="첨부파일" placeholder="첨부파일" readonly="readonly">
                                            <label for="menualFile">파일찾기</label>
                                            <input type="file" id="menualFile" name="menualFile" >
                                        </div>
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
                    <a onclick="uploadFiles();" class="btn_list_src mr10 pointer" title="업로드버튼"><span>업로드</span></a>
                    <a href="/admin/forecast/forecastUploadPage.do" class="btn_list_src c_red pointer" title="업로드버튼"><span>취소</span></a>
                </div>
                <!-- E: .btn_r -->
            </section>
            <!-- E: main_menu2 -->
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
    <jsp:include page="../common/loadingBody.jsp" />
</body>
</html>