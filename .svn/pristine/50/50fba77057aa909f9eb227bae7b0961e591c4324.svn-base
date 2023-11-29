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
<jsp:include page="../common/loadingHead.jsp" />

<script type="text/javascript">
function doChangePassword() {
	
	
	let originPassword = $('#originPassword').val();
	let changePassword = $('#changePassword').val();
	
	if (originPassword == '') {
		
		alert('기존 비밀번호를 입력해주세요');
		return;
	}
	
	if (changePassword == '') {
		
		alert('변경할 비밀번호를 입력해주세요');
		return;
	}
	
	let sendData = {
		"originPassword": originPassword
		, "changePassword": changePassword
	};
	
	showLoadingOverlay();
	
	fetch('/user/changePassword.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json',
			'${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error('네트워크 에러');
	})
	.then(data => {
		
		switch (data.result) {
			  
			case 'not_matched':
				alert('입력한 비밀번호가 기존 비밀번호와 일치하지않습니다. 다시 입력해주세요.');
				break;
				
			case 'success':
				alert('비밀번호 변경에 성공하였습니다. 다시 로그인해주세요.');
				location.href='/logout.do';
				break;
			  
			default:
				alert('비밀번호 변경에 실패하였습니다. 다시 시도해주세요.');
				break;
		}
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('오류가 발생했습니다. 관리자에게 문의해주세요.');
	})
	.finally(() => {
		
		$('#originPassword').val('');
		$('#changePassword').val('');
		hideLoadingOverlay();
	});
}

function goList() {
	
	location.href='/user/mainPage.do';
}
</script>

</head>

<body>
	<div class="wrap">

		<jsp:include page="../common/header.jsp" />

		<!-- 조사자 정보시작 -->
        <div class="profile_box">
            <div class="profile_inner">
                <div class="profile_img mt20">
                    <img src="/css/user/mobile/images/log_human.png" alt="사용자사진">
                </div>
                <div class="profile_info">
                    <p class="f_03 mt10 mb20"><%= ((UserDetailVo) authentication.getDetails()).getUserName() %>님</p>
                </div>
            </div>
        </div>
        <!-- 조사자 정보끝 -->

		<!-- 나의 정보 시작 -->
		<div class="con_box">
			<p class="con_title">계정정보</p>
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
							<th>소속</th>
							<td colspan="3">${userDetailVo.userName}</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td colspan="3">${userDetailVo.userId}</td>
						</tr>
						<tr>
							<th>기존 비밀번호</th>
							<td colspan="3" class="t_list_box">
								<input type="password" id="originPassword" class="form wp60 mt5" placeholder="비밀번호를 변경하려면 먼저 현재 비밀번호를 입력해주세요.">
								<!--  
								<button class="btn_a_src_02 wp25 mt5" title="비밀번호 확인" onclick="matchPassword()">
									<span>확인</span>
								</button>
								-->
							</td>
						</tr>
						<tr>
							<th>변경할 비밀번호</th>
							<td colspan="3" class="t_list_box">
								<input type="password" id="changePassword" class="form wp60 mt5">
								<button onclick="doChangePassword();" class="btn_a_src_02 wp25 mt5" title="비밀번호 변경">
									<span>변경</span>
								</button>
							</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td colspan="3">${userDetailVo.userPhone}</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- 목록버튼 시작 -->
			<div class="end_btn mt20">
				<button onclick="goList();" class="btn_a_src_03_1 wp20" title="목록">
					<span>목록</span>
				</button>
			</div>
			<!-- 목록버튼 끝 -->
		</div>
		<!-- 나의 정보 끝 -->
	</div>

<jsp:include page="../common/loadingBody.jsp" />
</body>
</html>