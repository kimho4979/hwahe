<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<div class="top_all">
<div class="top">
			<ul>
				<li><a href="/">화훼유통정보 홈페이지 바로가기</a></li>
				<li><a href="#">접속자 :<c:out value="${CONNECTION_USER_IDENTITY_ABCDEFGHIJKLMN}"/></a></li>
				<li><a href="/login/adminLogOut.do">로그아웃</a></li>
				<!-- <li><a href="#">Home</a></li> -->
			</ul>	
		</div>
</div>