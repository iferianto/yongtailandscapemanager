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
function doRetUrl(){
	window.parent.parent.parent.location.href="${ctx}/";
}
document.write("<br /><div style='width:450px;padding:0px;border:1px solid #D1DDAA;'><div style='padding:6px;font-size:12px;border-bottom:1px solid #D1DDAA;background:#DBEEBD url(/plus/img/wbg.gif)';'><b>超时提醒</b></div>");
document.write("<div style='height:130px;font-size:10pt;background:#ffffff'><br />");
document.write("您太长时间没有登陆了，请重新登陆！");
document.write("<br /><a href='#nogo'onclick='doRetUrl()'>请点击这里进入登陆页面...</a><br/></div>");
</script>
		</center>
	</body>
</html>

