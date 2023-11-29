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

<style type="text/css">
.pointer {
	cursor: pointer;
}

#searchInsectInput {
	padding: 10px;
	font-size: 15px;
}

#searchInsectInput::placeholder {
	padding: 10px;
	font-size: 15px;
	background-color: white;
}

#searchInsectWrap {
	border: 1px solid #ccc;
	max-height: 150px;
	overflow-y: auto;
	display: none;
}

#searchDiv ul li a {
	padding: 5px;
	cursor: pointer;
	font-size: 14px;
}

#searchDiv li:hover {
	background-color: #f2f2f2;
}
</style>

<script type="text/javascript">
$(function() {
	
	getDistributionData();
})

function getDistributionData() {
	
	let queryString = '';
	queryString += '?dateStar=' + $('#dateStar').val();
	queryString += '&searchKeyword=' + $('#searchInsectInput').val();
	
	fetch('/getDistributionData.do' + queryString)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		let insectDistributionVo = data.insectDistributionVo
		
		if (!insectDistributionVo) {
			
			insectDistributionVo = { ggd: 0 , gwd: 0 , cnd: 0 , cbd: 0
									 , gbd: 0 , gnd: 0 , jbd: 0 , jnd: 0 , jjd: 0 }
		}
		
		$('#GGDp').text(insectDistributionVo.ggd);
		$('#GGD').text(insectDistributionVo.ggd);
		
		$('#GWDp').text(insectDistributionVo.gwd);
		$('#GWD').text(insectDistributionVo.gwd);
		
		$('#CNDp').text(insectDistributionVo.cnd);
		$('#CND').text(insectDistributionVo.cnd);
		
		$('#CBDp').text(insectDistributionVo.cbd);
		$('#CBD').text(insectDistributionVo.cbd);
		
		$('#GBDp').text(insectDistributionVo.gbd);
		$('#GBD').text(insectDistributionVo.gbd);
		
		$('#GNDp').text(insectDistributionVo.gnd);
		$('#GND').text(insectDistributionVo.gnd);
		
		$('#JBDp').text(insectDistributionVo.jbd);
		$('#JBD').text(insectDistributionVo.jbd);
		
		$('#JNDp').text(insectDistributionVo.jnd);
		$('#JND').text(insectDistributionVo.jnd);
		
		$('#JJDp').text(insectDistributionVo.jjd);
		$('#JJD').text(insectDistributionVo.jjd);
	})
	.catch(error => {
		
		//alert('분포현황을 불러올 수 없습니다. 잠시후 다시 시도해주세요.')
		console.error(error);
	})
}

function inputHandler() {
	
	getDistributionData();
	
	let searchKeyword = $('#searchInsectInput').val(); 
  			
  	if (!searchKeyword){
  		
  		$('#searchInsectWrap').css('display', 'none');
  		
  	} else {
  		
  		$('#searchInsectWrap').css('display', 'block');
  		searchInsect(searchKeyword);
  	}
}

function searchInsect(searchKeyword) {
	
	fetch('/searchInsect.do?searchKeyword=' + searchKeyword)
	.then(response => {
		
		if (response.ok) return response.json();
		else throw new Error(response.status + ' 에러');
	})
	.then(data => {
		
		data = data.researchVos;
		let html = '<ul>';
		
		for (let i = 0; i < data.length; i++) {
			
			let insectNum = data[i].insectNum;
			let korSpecificName = data[i].korSpecificName;
	           
	   		html += '<li>';
	   		html += '<a class="pointer" onclick="selectInsect(\'' + korSpecificName + '\');">' + korSpecificName + '</a>';
	   		html += '</li>';
	    }
		
		html += '</ul>';
		
		$('#searchInsectWrap').html(html);
	})
	.catch(error => { 
		
		console.error(error); 
	});
}

function selectInsect(korSpecificName) {
	
	$('#searchInsectInput').val(korSpecificName);
	$('#searchInsectWrap').css('display', 'none');
	
	getDistributionData();
}
</script>
</head>

<body>
    <div class="wrap">
		<header class="header sub_hd">
			<jsp:include page="../common/headerDetail.jsp" />
		</header>
        <!-- S:.banner_info -->
        <div class="banner_info banner_04">
            <div class="tit_box">
                <p>분포현황</p>
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
                    <li><span>외래곤충분포</span></li>
                    <li class="ro_last"><span>분포현황</span></li>
                </ul>
            </div>
            <!-- E: .rocate -->

            <!-- S: .section -->
            <div class="section">
                <!-- S: .title -->
                <div class="title mt20">
                    <p>지역별 외래산림해충 분포 현황</p>
                </div>
                <!-- E: .title -->
                <!-- S: .page_A -->
                <div class="page_A mt50">
                    <div class="page_inner02" id="searchDiv">
						<input type="text" id="searchInsectInput" class="form wp60" onkeyup="inputHandler();" placeholder="곤충명 입력"> 
						<div class="t_search_box wp60" id="searchInsectWrap" style="display: none;">
							<!-- 검색된 곤충 표기구간 -->
						</div>
                    </div>
                    <div class="page_inner02">
                        <select id="dateStar" onchange="getDistributionData();" title="최신등록순" class="select_01 mr20">
                            <option value="3">최근 3개월</option>
                            <option value="6">최근 6개월</option>
                            <option value="12">최근 1년</option>
                            <option value="60">최근 5년</option>
                            <option value="120">최근 10년</option>
                        </select>
                    </div>
                </div>
                <!-- E: .page_A -->
                <!-- S: .content_01 -->
                <div class="content_01">
                    <div class="cont_inner mt10">
                        <div class="cont_in_img standard">
                            <div class="map_01 map_img_02" title="경기도"><span id="GGDp"></span></div>
                            <div class="map_02 map_img_02" title="강원도"><span id="GWDp"></span></div>
                            <div class="map_03 map_img_02" title="충정남도"><span id="CNDp"></span></div>
                            <div class="map_04 map_img_02" title="충청북도"><span id="CBDp"></span></div>
                            <div class="map_05 map_img_02" title="전라북도"><span id="JBDp"></span></div>
                            <div class="map_06 map_img_02" title="전라남도"><span id="JNDp"></span></div>
                            <div class="map_07 map_img_02" title="경상북도"><span id="GBDp"></span></div>
                            <div class="map_08 map_img_02" title="경상남도"><span id="GNDp"></span></div>
                            <div class="map_09 map_img_02" title="제주도"><span id="JJDp"></span></div>
                        </div>
                        <div class="cont_in_img">
                            <!-- S : table_A -->
                            <div class="table_A">
                                <table class="contTbl_02 txtC" summary="이 표는 목록입니다.">
                                    <colgroup>
                                        <col style="width:50%">
                                        <col style="width:50%">
                                    </colgroup>
                                    <thead>
                                        <tr>
                                            <th scope="col">지역</th>
                                            <th scope="col">분포종수</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <tr>
                                            <td>경기도</td>
                                            <td id="GGD"></td>
                                        </tr>
                                        <tr>
                                            <td>강원도</td>
                                            <td id="GWD"></td>
                                        </tr>
                                        <tr>
                                            <td>충청남도</td>
                                            <td id="CND"></td>
                                        </tr>
                                        <tr>
                                            <td>충청북도</td>
                                            <td id="CBD"></td>
                                        </tr>
                                        <tr>
                                            <td>전라남도</td>
                                            <td id="JND"></td>
                                        </tr>
                                        <tr>
                                            <td>전라북도</td>
                                            <td id="JBD"></td>
                                        </tr>
                                        <tr>
                                            <td>경상남도</td>
                                            <td id="GND"></td>
                                        </tr>
                                        <tr>
                                            <td>경상북도</td>
                                            <td id="GBD"></td>
                                        </tr>
                                        <tr>
                                            <td>제주도</td>
                                            <td id="JJD"></td>
                                        </tr>
                                        
                                    </tbody>
                                </table>
                            </div>
                            <!-- E : table_A -->

                        </div>
                    </div>
                    <!-- <div><a href="#none" class="down_btn">엑셀파일 다운로드</a></div> -->
                </div>
                <!-- E: .content_01 -->

            </div>
            <!-- E: .section -->
        </div>
        <!-- E: .main-->
        <footer class="foot_02">
			<jsp:include page="../common/footerDetail.jsp" />
        </footer>
    </div>
</body>
</html>