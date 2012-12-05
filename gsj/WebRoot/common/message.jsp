<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<base target='_self' />
		<style>
div {
	line-height: 160%;
}
</style>
	</head>
	<body leftmargin='0' topmargin='0'>
		<center>
			<script>
			function doRetUrl(url){
				window.location.href=url;
			 }			 
document.write("<br /><div style='width:450px;padding:0px;border:1px solid #D1DDAA;'><div style='padding:6px;font-size:12px;border-bottom:1px solid #D1DDAA;background:#DBEEBD url(/plus/img/wbg.gif)';'><b>友情提醒</b></div>");
document.write("<div style='height:130px;font-size:10pt;background:#ffffff'><br />");
document.write("${glb_message }");

//document.write("");
</script>
			<c:choose>
				<c:when test="${not empty GLB_BACK_YES}">
					<br />
					<a href='#nogo' onclick='javascript:history.go(-1)'>请点击这里返回...</a>
					<br />
				</c:when>
				<c:when test="${not empty GLB_RETURN_URL}">

					<br />
					<a href='#nogo' onclick="doRetUrl('${GLB_RETURN_URL}');">请点击这里返回...</a>
					<br />

				</c:when>
				<c:otherwise>
					<br />
					<a href='#nogo' onclick='javascript:history.go(-1)'>请点击这里返回...</a>
					<br />
				</c:otherwise>
			</c:choose>
			</div>
		</center>
	</body>
</html>

