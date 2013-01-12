<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<div class="main_left_tit3"></div>
<div class="info" id="info">
<c:if test="${not empty MEMBER_USER}">
	<div style="text-align: center; border-bottom: solid 1px;margin-top: 5px;margin-bottom: 10px;">
		欢迎您:
		<span style="color: red;">${MEMBER_USER.username }</span>
		<br />
		您是
		<c:if test="${MEMBER_USER.type==1}">个人会员</c:if>
		<c:if test="${MEMBER_USER.type==2}">单位会员</c:if>
		<br />
		我要
		<a style="color: red;" href="${ctx }/index!logout.action">退出</a>
	</div></c:if>
	<ul>

		<li>
			<a href="${ctx }/bbs">返回论坛首页</a>
		</li>
		<c:forEach var="item" items="${bbs}">

			<li style="text-align: left; padding-left: 40px">
				&nbsp;
				<a href="${ctx }/bbs!list.action?seqs=${item.id}">${item.name }</a>
			</li>

		</c:forEach>
	</ul>
	<div style="height: 6px; clear: both;"></div>
</div>