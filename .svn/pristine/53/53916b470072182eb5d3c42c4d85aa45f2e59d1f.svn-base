<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="../common/head.jsp" />
	<jsp:include page="../common/loadingHead.jsp" />
	
    <link rel="stylesheet" href="/css/user/mobile/css/fonts.css">
    <link rel="stylesheet" href="/css/user/mobile/css/reset.css">
    <link rel="stylesheet" href="/css/user/mobile/css/jquery-ui.css">
    <link rel="stylesheet" href="/css/user/mobile/css/default.css">
    <link rel="stylesheet" href="/css/user/mobile/css/m_common.css">
    <link rel="stylesheet" href="/css/user/mobile/css/m_content.css">
    
    <script src="/css/user/mobile/js/3.6.0.js"></script>
    <script src="/css/user/mobile/js/jquery-ui.js"></script>
    <script src="/css/user/mobile/js/jquery.bpopup.min.js"></script>
    <script src="/css/user/mobile/js/jquery.js"></script>
    <script src="/css/user/mobile/js/StickyOnTable.js"></script>
    <script src="/css/user/mobile/js/upload.js"></script>
    
<script type="text/javascript">
$(function() {
	
	init_events();
})

function init_events() {
	
	$('#login_btn').on('click', function() { 
		
		login_confirm(); 
	});
	
	$('#i_d, #p_w').keyup(function(event) { 
		
		if (event.keyCode == 13)
			login_confirm(); 
	});
}

function login_confirm() {
	
	showLoadingOverlay();
	
	let id = $('#i_d').val();
	let pw = $('#p_w').val();
	
	let sendData = {
		'userId': id,
		'userPw': pw
	};
	
	fetch('/loginConfirm.do', {
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
		
		if (data.result == 'success') {
			
			location.href='/main.do';
			
		} else {
			
			alert('아이디 또는 비밀번호가 잘못되었습니다. 다시입력해주세요.');
		}
		
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('로그인에 실패하였습니다. 잠시후 다시 시도해주세요.');
	})
	.finally(() => {
		
		hideLoadingOverlay();
	});
}
</script>
</head>

<body>
    <div class="wrap">
        <!-- 로그인 시작 -->
        <div class="log_box">
            <div class="log_box_inner">
                <p class="log_title">K-SDM</p>
                <!-- 아이디시작 -->
                <div class="lobin_box mt20">
                    <label for="i_d" class="mb5">아이디</label>
                    <input type="text" id="i_d" class="form" placeholder="아이디를 입력하세요" value="admin">
                </div>
                <!-- 아이디끝 -->
                <!-- 비밀번호시작 -->
                <div class="lobin_box mt20">
                    <label for="p_w" class="mb5">비밀번호</label>
                    <input type="password" id="p_w" class="form" placeholder="비밀번호를 입력하세요" value="1234">
                </div>
                <!-- 비밀번호끝 -->
                <!-- 로그인버튼 시작 -->
                <button id="login_btn" class="login_btn mt30" title="로그인"><span>로그인</span></button>
                <!-- 로그인버튼 끝 -->
            </div>
        </div>
        <!-- 로그인 끝 -->
    </div>
    <jsp:include page="../common/loadingBody.jsp" />
</body>
</html>