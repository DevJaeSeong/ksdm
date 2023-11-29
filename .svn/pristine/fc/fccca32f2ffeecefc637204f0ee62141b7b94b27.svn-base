<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<jsp:include page="../common/head.jsp" />
	
<script type="text/javascript">

function userModify() {
	
	let userId = $('#userId').val();
	let userName = $('#userName').val();
	let authorityId = $('input[name="authorityId"]:checked').val();
	let userPhone = $('#userPhone').val();
	let researchAreaCode = $('#researchAreaCode').val();
	let userNote = $('#userNote').val();
	
	let sendData = {
		'userId': userId
		, 'userName': userName
		, 'authorityId': authorityId
		, 'userPhone': userPhone
		, 'researchAreaCode': researchAreaCode
		, 'userNote': userNote
	}
	
	console.log(sendData);
	
	fetch('/admin/userModify.do', {
		method: 'POST',
		headers: {
			'Content-Type': 'application/json'
			, '${_csrf.headerName}': '${_csrf.token}'
		},
		body: JSON.stringify(sendData)
	})
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		switch (data.result) {
		
			case 'success':
				alert('정상적으로 수정되었습니다.');
				location.href='/admin/userListPage.do';
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
                    <li><span>사용자 상세정보</span></li>
                    <li class="ro_last"><span>사용자 상세정보</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .search -->
            <section class="search">
                <div class="search_txt"><span>사용자 상세정보</span></div>
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
                                        <input id="userId" type="text" class="form wp55" value="${userDetailVo.userId}" disabled="disabled">
                                    </td>
                                    <th scope="col">패스워드</th>
                                    <td>
                                        <input id="userPw" type="password" class="form wp55" value="******" disabled="disabled">
                                    </td>
                                </tr>  
                                <tr>
                                    <th scope="col">이름</th>
                                    <td>
                                        <input id="userName" type="text" class="form wp55" value="${userDetailVo.userName}">
                                    </td>
                                    <th scope="col">구분</th>
                                    <td>
                                        <ul id="authorityId" class="radio">
                                            <c:forEach items="${authorityVos}" var="authorityVo" varStatus="loop">
                                            	<li>
	                                            	<c:choose>
	                                            		<c:when test="${userDetailVo.authorityId == authorityVo.authorityId}">
															<input type="radio" value="${authorityVo.authorityId}" name="authorityId" id="date_area${loop.index + 1}" checked="checked">
															<label for="date_area${loop.index + 1}"><span>${authorityVo.authorityName}</span></label>
	                                            		</c:when>
	                                            		<c:otherwise>
															<input type="radio" value="${authorityVo.authorityId}" name="authorityId" id="date_area${loop.index + 1}">
															<label for="date_area${loop.index + 1}"><span>${authorityVo.authorityName}</span></label>
	                                            		</c:otherwise>
	                                            	</c:choose>
												</li>
                                            </c:forEach>
                                        </ul>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">연락처</th>
                                    <td>
                                        <input id="userPhone" type="text" class="form wp55" value="${userDetailVo.userPhone}">
                                    </td>
                                    <th scope="col">조사원활동지역</th>
                                    <td>
                                        <select id="researchAreaCode" title="1" class="form wp55">
                                            <c:forEach items="${researchAreaVos}" var="researchAreaVo" varStatus="loop">
                                            	<c:choose>
                                            		<c:when test="${userDetailVo.researchAreaCode == researchAreaVo.researchAreaCode}">
		                                            	<option value="${researchAreaVo.researchAreaCode}" selected="selected">${researchAreaVo.researchAreaName}</option>
                                            		</c:when>
                                            		<c:otherwise>
		                                            	<option value="${researchAreaVo.researchAreaCode}">${researchAreaVo.researchAreaName}</option>
                                            		</c:otherwise>
                                            	</c:choose>
                                            </c:forEach>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="col">비고</th>
                                    <td colspan="3">
                                        <input id="userNote" type="text" class="form wp100" value="${userDetailVo.userNote}">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <!-- E: .table_reset -->
                    <div style="text-align: right; margin-right: 10px;">
	                    <a onclick="userModify();" class="btn_list_src" title="등록" style="cursor: pointer;"><span>수정</span></a>
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