<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
	
<script type="text/javascript">
var isIdDuplicated = true;

$(function() {
	
	initEvents();
})

function initEvents() {
	
}

function checkId() {
	
	let userId = $('#userId').val();
	
	if (userId == '') {
		
		alert('아이디를 입력해주세요.');
		return;
	}
	
	let sendData = {
		"userId": userId	
	};
	
	fetch('/admin/checkId.do', {
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
		
			case 'not_exists':
				isIdDuplicated = false;
				alert('사용가능한 이이디입니다.');
			  	break;
			  
			default:
				isIdDuplicated = true;
				alert('이미 등록된 아이디입니다.');
			  	break;
		}
		
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('로그인에 실패하였습니다. 잠시후 다시 시도해주세요.');
	});
}

function doRegistUser() {
	
	let userId = $('#userId').val();
	let userPw = $('#userPw').val();
	let userName = $('#userName').val();
	let authorityId = $('#authorityId input[name="authorityId"]:checked').val();
	let userPhone = $('#userPhone').val();
	let researchAreaCode = $('#researchAreaCode').val();
	let userNote = $('#userNote').val();
	
	if (isIdDuplicated) {
		
		alert('아이디 중복검사를 먼저 해주세요.');
		return;
	}
	
	if (authorityId == undefined) {
		
		alert('구분을 선택해주세요.');
		return;
	}
	
	let sendData = {
		"userId": userId
		, "userPw": userPw
		, "userName": userName
		, "authorityId": authorityId
		, "userPhone": userPhone
		, "researchAreaCode": researchAreaCode
		, "userNote": userNote
	}
	
	fetch('/admin/registUser.do', {
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
		
			case 'success':
				alert('정상적으로 등록되었습니다.');
				location.href='/admin/userListPage.do';
				break;
			  
			default:
				alert('등록에 실패하였습니다. 잠시후 다시 시도해주세요.');
				break;
		}
		
	})
	.catch(error => { 
		
		console.error('fetch에러 => ', error); 
		alert('등록에 실패하였습니다. 잠시후 다시 시도해주세요.');
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
                    <li><span>사용자관리</span></li>
                    <li class="ro_last"><span>사용자등록</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>사용자등록</span></div>
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
                                <col style="width:15%;">
                                <col style="width:50%;">
                            </colgroup>
                            <tbody>
                                <tr>
                                    <th scope="col">아이디</th>
                                    <td>
                                        <input id="userId" type="text" class="form wp55 ">
                                        <button onclick="checkId();" type="button" class="btn_A"><span>중복검사</span></button>
                                    </td>
                                    <th scope="col">패스워드</th>
                                    <td>
                                        <input id="userPw" type="password" class="form wp55 ">
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">이름</th>
                                    <td>
                                        <input id="userName" type="text" class="form wp55 ">
                                    </td>
                                    <th scope="col">구분</th>
                                    <td>
                                        <ul id="authorityId" class="radio">
                                            <c:forEach items="${authorityVos}" var="authorityVo" varStatus="loop">
                                            	<li>
													<input type="radio" value="${authorityVo.authorityId}" name="authorityId" id="date_area${loop.index + 1}">
													<label for="date_area${loop.index + 1}"><span>${authorityVo.authorityName}</span></label>
												</li>
                                            </c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">연락처</th>
                                    <td>
                                        <input id="userPhone" type="text" class="form wp55 ">
                                    </td>
                                    <th scope="col">조사원활동지역</th>
                                    <td>
                                        <select id="researchAreaCode" title="1" class="form wp55">
                                            <c:forEach items="${researchAreaVos}" var="researchAreaVo" varStatus="loop">
                                            	<option value="${researchAreaVo.researchAreaCode}">${researchAreaVo.researchAreaName}</option>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">비고</th>
                                    <td colspan="3">
                                        <input id="userNote" type="text" class="form wp100 ">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <div style="text-align: right; margin-right: 10px;">
	                    <a onclick="doRegistUser();" class="btn_list_src" title="등록" style="cursor: pointer;"><span>등록</span></a>
	                    <a href="/admin/userListPage.do" class="btn_list_src" title="취소" style="cursor: pointer;"><span>취소</span></a>
                    </div>
                </article>
            </section>
            <!-- E: main_menu2 -->	
        </main>
        <!-- E: main -->
    </div>
    <!-- E:.wrap -->
</body>
</html>