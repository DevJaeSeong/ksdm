<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<jsp:include page="../common/head.jsp" />
	
    <link rel="stylesheet" href="/css/general/css/meyer_reset2.0.css">
    <link rel="stylesheet" href="/css/general/css/default.css">
    <link rel="stylesheet" href="/css/general/css/font.css">
    <link rel="stylesheet" href="/css/general/css/slick.css">
    <link rel="stylesheet" href="/css/general/css/slick-theme.css">
    <link rel="stylesheet" href="/css/general/css/common.css">
    <link rel="stylesheet" href="/css/general/css/main.css">
    <link rel="stylesheet" href="/css/general/css/content1.css">

    <script src="/css/general/js/3.6.0.js"></script>
    <script src="/css/general/js/slick.js"></script>
    <script src="/css/general/js/common.js"></script>
    
    <script type="text/javascript">
    </script>
</head>

<body>
    <div class="wrap">
		<header class="header sub_hd">
			<jsp:include page="../common/headerDetail.jsp" />
		</header>
         <!-- S:.banner_info -->
         <div class="banner_info">
            <div class="tit_box">
                <p>외래산림해충용어</p>
            </div>
        </div>
        <!-- E:.banner_info -->
        <!-- S: .main-->
        <div class="main">
            <div class="bor100"></div>
            <!-- S: .rocate -->
            <div class="rocate">
                <ul>
                    <li class="bor_l"><a href="#none"></a></li>
                    <li><span title="외래산림해충정보">외래산림해충정보</span></li>
                    <li class="ro_last"><span title="외래산림해충용어">외래산림해충용어</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->
            <!-- S: .content_01-->
            <div class="content_01 mt70">
                <!-- S: .txt_box-->
                <div class="txt_box pb50">
                    <div class="title_inner"><span class="deco">외래생물이란?</span></div>
                    <div class="txt_inner">
                        <span>생물다양성 보전 및 이용에 관한 법률 제2조(정의)에 의하면, "외래생물"이란 외국으로부터 인위적 또는 자연적으로 유입되어 그
                            본래의 원산지 또는 서식지를 벗어나 존재하게 된 생물을 말합니다.
                            즉 외국에서 들어온 생물종을 포함하여 원래는 국내의 토착종이나 특정 생태계에서 역사적으로 서식하지 않던 생물종이 자연적인 서식범위를 벗어나서 스스로 번식 혹은
                            경쟁력을 가지고 살아가는 생물종을 의미합니다
                        </span>
                    </div>
                </div>
                <!-- E: .txt_box-->
                <!-- S: .txt_box-->
                <div class="txt_box pb50">
                    <div class="title_inner"><span class="deco">생태계교란 생물이란?</span></div>
                    <div class="txt_inner">
                        <span>생물다양성 보전 및 이용에 관한 법률 제2조(정의)에 의하면, "생태계교란 생물"이란 다음 각 목의 어느 하나에 해당하는 생물로서 제21조의2제1항에 따른
                            위해성평가 결과 생태계 등에 미치는 위해가 큰 것으로 판단되어 환경부장관이 지정·고시하는 것을 말합니다.
                            <p>가. 유입주의 생물 및 외래생물 중 생태계의 균형을 교란하거나 교란할 우려가 있는 생물</p>
                            <p>
                                나. 유입주의 생물이나 외래생물에 해당하지 아니하는 생물 중 특정 지역에서 생태계의 균형을 교란하거나 교란할 우려가 있는 생물 즉 외국에서 유입되었거나 자생하는 생물
                                중에서 국내 생태계의 균형을 교란하거나 교란할 우려가 있는 생물을 의미합니다.
                                환경부고시 제2022-209호 생태계교란 생물 지정 고시에 의하면, 다음과 같은 공통 적용기준이 제시되어 있습니다.
                            </p>
                            <p>가. 포유류, 양서류·파충류, 어류, 갑각류, 곤충류 : 살아 있는 생물체와 그 알을 포함한다.</p>
                            <p>나. 식물: 살아 있는 생물체와 그 부속체(종자, 구근, 인경, 주아, 덩이줄기, 뿌리) 및 표본을 포함한다.</p>
                        </span>
                    </div>
                </div>
                <!-- E: .txt_box-->
                <!-- S: .txt_box-->
                <div class="txt_box">
                    <div class="title_inner"><span class="deco">생태계위해우려 생물이란?</span></div>
                    <div class="txt_inner">
                        <span>“생태계위해우려 생물”이란 다음 각 목의 어느 하나에 해당하는 생물로서 제21조의2제1항에 따른 위해성평가 결과 생태계 등에 유출될 경우 위해를 미칠 우려가 있어
                            관리가 필요하다고 판단되어 환경부장관이 지정·고시하는 것을 말합니다.
                            <p>
                                가. 「야생생물 보호 및 관리에 관한 법률」 제2조제2호에 따른 멸종위기 야생생물 등 특정 생물의 생존이나 「자연환경보전법」 제12조제1항에 따른 생태ㆍ경관보전지역
                                등 특정 지역의 생태계에 부정적 영향을 주거나 줄 우려가 있는 생물
                            </p>
                            <p>
                                나. 제8호(생태계교란 생물 지정 대상) 각 목의 어느 하나에 해당하는 생물 중 산업용으로 사용 중인 생물로서 다른 생물 등으로 대체가 곤란한 생물
                                환경부고시 제2021-177호 생태계위해우려 생물 지정 고시에 의하면, 다음과 같은 공통 적용기준이 제시되어 있습니다.
                            </p>
                            <p>가. 포유류, 어류, 양서류: 살아 있는 생물체와 그 알을 포함한다.</p>
                        </span>
                    </div>
                </div>
                <!-- E: .txt_box-->
            </div>
            <!-- E: .content_01-->
        </div>
        <!-- E: .main-->
        <footer class="foot_02">
			<jsp:include page="../common/footerDetail.jsp" />
        </footer>
    </div>
</body>
</html>