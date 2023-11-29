<%@page import="org.springframework.security.core.GrantedAuthority"%>
<%@page import="java.util.List"%>
<%@page import="egovframework.ksdmWeb.security.UserDetailVo"%>
<%@page import="org.springframework.security.authentication.AnonymousAuthenticationToken"%>
<%@page import="org.springframework.security.core.Authentication"%>
<%@page import="org.springframework.security.core.context.SecurityContextHolder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
%>

<!-- S: .menu_box -->
<div class="menu_box">
    <!-- S: .main_menu -->
    <div class="main_menu">
        <!-- S: .sub_menu -->
        <div class="sub_menu">
            <ul class="sub_menu_inner">
            	<%if (authentication == null || authentication instanceof AnonymousAuthenticationToken) {%>
                <li><a href="/loginPage.do"><img src="/css/general/images/icon_log-in.png" alt="로그인">로그인</a></li>
                <%} else if (((List<GrantedAuthority>) authentication.getAuthorities()).get(0).getAuthority() == "ROLE_ADMIN") {%>
                <li><a><img src="/css/general/images/icon_log-in.png" alt="회원명"><%= ((UserDetailVo) authentication.getDetails()).getUserName() %></a></li>
                <li><a href="/admin/main.do"><img src="/css/general/images/icon_log-in.png" alt="회원정보">관리자 화면</a></li>
                <!-- <li><a href="#none"><img src="/css/general/images/icon_log-in.png" alt="회원정보">회원정보</a></li> -->
                <li><a href="/logout.do"><img src="/css/general/images/icon_log-out.png" alt="로그아웃">로그아웃</a></li>
                <%} else {%>
                <li><a><img src="/css/general/images/icon_log-in.png" alt="회원명"><%= ((UserDetailVo) authentication.getDetails()).getUserName() %></a></li>
                <!-- <li><a href="#none"><img src="/css/general/images/icon_log-in.png" alt="회원정보">회원정보</a></li> -->
                <li><a href="/logout.do"><img src="/css/general/images/icon_log-out.png" alt="로그아웃">로그아웃</a></li>
                <%}%>
            </ul>
        </div>
        <!-- E: .sub_menu -->
        <!-- S: .gnb -->
        <div class="gnb">
            <h1>
                <a href="/main.do" title="logo" class="logo"><img src="/css/general/images/top_logo.png" alt="K-SDM로고"></a>
            </h1>
            <ul class="dep1">
                <li>
                	<a title="K-SDM소개">K-SDM소개</a>
                    <ul class="dep2">
                        <li><a href="/visionAndGoalsPage.do" title="비전 및 목표">비전 및 목표</a></li>
                        <li><a href="/organizationalChartPage.do" title="조직도">조직도</a></li>
                        <li><a href="/affiliatedOrganizationPage.do" title="소속참여기관">소속참여기관</a></li>
                    </ul>
                </li>
                <li>
                	<a title="외래산림해충정보">외래산림해충정보</a>
                    <ul class="dep2">
                        <li><a href="/insectWordPage.do" title="외래곤충 용어">외래산림해충 용어</a></li>
                        <li><a href="/insectSearchPage.do" title="외래곤충 검색">외래산림해충 검색</a></li>
                    </ul>
                </li>
                <li>
               		<a title="외래산림해충분포">외래산림해충분포</a>
                    <ul class="dep2">
                        <!-- <li><a href="/researchStatisticsPage.do" title="조사통계">조사통계</a></li> -->
                        <li><a href="/currentDistributionPage.do" title="현재분포">현재분포</a></li>
                    </ul>
                </li>
                <li>
                	<a title="외래산림해충예측">외래산림해충예측</a>
                    <ul class="dep2">
                        <li><a href="/insectForecastPage.do"  title="예상분포">예상분포</a></li>
                    </ul>
                </li>
                <li>
                	<a title="정보마당">정보마당</a>
                    <ul class="dep2">
                        <li><a href="/boardListPage.do?boardDiv=1000" title="공지사항">공지사항</a></li>
                        <li><a href="/boardListPage.do?boardDiv=2000" title="보도자료">보도자료</a></li>
                        <li><a href="/boardListPage.do?boardDiv=3000" title="자료실">자료실</a></li>
                    </ul>
                </li>
                <li>
                	<a title="조사등록">조사등록</a>
                    <ul class="dep2">
                        <li><a href="/user/mainPage.do" title="조사자료등록">조사자료등록</a></li>
                    </ul>
                </li>
            </ul>
            <div class="box_bg"></div>
        </div>
        <!-- E: .gnb -->
    </div>
    <!-- E: .main_menu -->
</div>
<!-- E: .menu_box -->
