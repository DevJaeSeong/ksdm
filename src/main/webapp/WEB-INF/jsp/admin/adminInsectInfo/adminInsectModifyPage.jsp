<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="ko">
<head>

<jsp:include page="../common/head.jsp" />

<script type="text/javascript">
$(function() {
	
	initEvents();
	getInsectDetail(${insectNum});
})

function initEvents() {
	
	// 파일 업로드 이벤트 시작
	$('#imgFile').change(function() {
		
		let name = $(this)[0].files[0].name;
		let extension = name.slice(-4);
		
		if (!(extension === '.png' || extension === '.jpg')) {
			
			alert('png 또는 jpg 확장자 파일을 업로드해주세요.');
			$('#imgFile').val('');
			$('#fileName').val('');
			return;
		}
		
		$('#fileName').val(name);
	})
	// 파일 업로드 이벤트 끝
}

function getInsectDetail(insectNum) {
	
	fetch('/getInsectByinsectNum.do?insectNum=' + insectNum)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(insectVo => {
		
		let insectStatusVos = insectVo.insectStatusVos;
   		let status = '';
   		
   		$.each(insectStatusVos, function(index, insectStatusVo) {
   			
   			$('input[name="insectStatus"][value="' + insectStatusVo.insectStatusCode + '"]').prop('checked', true);
   		})
		
		// 내용 구현 시작
    	$('#korSpecificName').val(insectVo.korSpecificName);
    	$('#engSpecificName').val(insectVo.engSpecificName);
    	$('#taxon').val(insectVo.taxon);
    	$('#oldSavedFileName').val(insectVo.savedFileName);
    	$('#fileName').val(insectVo.oriFileName);
    	$('#description').val(insectVo.description);
    	// 내용 구현 끝
	})
	.catch(error => { console.error('fetch에러 => ', error); });
}

function modifyInsectInfo() {
	
	let insectStatusList = [];
	
	$('input[type="checkbox"][name="insectStatus"]:checked').each(function() {
		
		insectStatusList.push($(this).val());
	});
	
	let korSpecificName = $('#korSpecificName').val();
	let engSpecificName = $('#engSpecificName').val();
	let taxon = $('#taxon').val();
	let oldSavedFileName = $('#oldSavedFileName').val();
	let description = $('#description').val();
	let files = $('#imgFile')[0].files;
	
	let formData = new FormData();
	formData.append('insectStatusList', insectStatusList);
	formData.append('korSpecificName', korSpecificName);
	formData.append('engSpecificName', engSpecificName);
	formData.append('taxon', taxon);
	formData.append('oldSavedFileName', oldSavedFileName);
	formData.append('description', description);
	formData.append('insectNum', ${insectNum});
	
	if (files.length > 0) formData.append('file', files[0]);
	
	fetch('/admin/insectInfo/insectModifyConfirm.do', {
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
				location.href='/admin/insectInfo/adminInsectListPage.do';
			  	break;
			  
			case 'uploadFail':
				alert('파일 업로드에 실패하였습니다.');
			  	break;
			  
			default:
				alert('저장에 실패하였습니다. 잠시 후 다시 시도해주세요.');
			  	break;
		}
	})
	.catch(error => { console.error('fetch에러 => ', error); });
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
					<li class="ro_last"><span>곤충수정</span></li>
				</ul>
			</div>
			<!-- E: .rocate -->
			<!-- S: .search -->
			<section class="search">
				<div class="search_txt">
					<span>곤충수정</span>
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
                                <tr>
                                    <th scope="col">한글명</th>
                                    <td colspan="3">
										<input type="text" class="form wp100" id="korSpecificName">
									</td>
                                </tr>
                                <tr>
                                    <th scope="col">영문명</th>
                                    <td colspan="3">
										 <input type="text" class="form wp100" id="engSpecificName">
									</td>
                                </tr>
                                <tr>
                                    <th scope="col">분류군</th>
                                    <td>
										<input type="text" class="form wp100" id="taxon">
									</td>
                                    <th scope="col">관리현황</th>
                                    <!-- S: .checkboL -->
                                    <td class="checkboL">
                                        <ul>
                                            <li>
                                                <div class="checkboX">
                                                    <input type="checkbox" value="1000" id="no02" name="insectStatus">
                                                    <label for="no02" class="mr10"><span>생태교란생물</span></label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="checkboX">
                                                    <input type="checkbox" value="2000" id="no03" name="insectStatus">
                                                    <label for="no03" class="mr10"><span>위해우려생물</span></label>
                                                </div>
                                            </li>
                                            <li>
                                                <div class="checkboX">
                                                    <input type="checkbox" value="3000" id="no04" name="insectStatus">
                                                    <label for="no04" class="mr10"><span>유입경계생물</span></label>
                                                </div>
                                            </li>
                                        </ul>
                                    </td>
                                    <!-- E: .checkboL -->
                                </tr>
								<tr>
									<th scope="col">이미지</th>
									<td colspan="3" class="t_ex_inner" id="imgSelectWrap">
										<div class="filebox">
											<input id="oldSavedFileName" type="hidden" value="">
											<input id="fileName" class="upload-name" disabled="disabled">
											<input id="imgFile" type="file" accept=".jpg, .png">
											<label for="imgFile">파일찾기</label>
										</div>
                                    </td>
								</tr>
								<tr>
                                    <th scope="col">상세설명</th>
                                    <td colspan="3" class="t_ex_inner">
                                        <textarea id="description" class="wgm_mng_area" name="" rows="8" cols="80" style="height:250px"></textarea>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <!-- S: .btn_center -->
                    <div class="mt20 mb30 btn_r">
                        <a href="#none" class="btn_list_src mr10" title="수정" onclick="modifyInsectInfo()"><span>등록</span></a>
                        <a href="/admin/insectInfo/adminInsectDetailPage.do?insectNum=${insectNum}" class="btn_list_src c_red" title="취소"><span>취소</span></a>
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