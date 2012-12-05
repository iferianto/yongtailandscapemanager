<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx}/js/jquery-1.4.js"></script>
	<script type="text/javascript" src="${ctx}/js/framework.js"></script>
	<script type="text/javascript" src="${ctx}/js/attention/messager.js"></script>
	<link href="${ctx}/css/import_basic.css" rel="stylesheet"
		type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=request.getContextPath()%>/" />
	<!--框架必需end-->

	<!--让ie6支持透明png图片start-->
	<script type="text/javascript"
		src="${ctx}/js/method/pngFix/supersleight.js"></script>
	<!--让ie6支持透明png图片end-->
	<style>
table {
	font-size: ${	c_font_size};
}
</style> 
	<body>

		<div id="scrollContent">
			<div class="box2" panelTitle="通知公告" roller="false" showStatus="false"
				panelWidth="50%" panelHeight="200" statusText="更多>>"
				panelUrl="#nogo" style="float: left">
				<div class="sgList">
					<ul>
						<li class="listArr" >最多二十四字*八行</li> 					
					</ul>
				</div>
			</div>
			<div class="box2" panelTitle="内部邮件" roller="false" showStatus="false"
				panelWidth="49%" panelHeight="200" statusText="更多>>"style="float: right"
				panelUrl="#nogo">
			</div>
			<div class="box2" panelTitle="校园动态" roller="false" showStatus="false"
				panelWidth="50%" panelHeight="200" statusText="更多>>"
				panelUrl="#nogo" style="float: left">
				<div class="sgList">
					<ul>
						<li class="listArr" >最多二十四字*八行</li> 					
					</ul>
				</div>
			</div>
			<div class="box2" panelTitle="待办事宜" roller="false" showStatus="false"
				panelWidth="49%" panelHeight="200" statusText="更多>>"style="float: right"
				panelUrl="#nogo">
			</div>
			<div class="box2" panelTitle="工作计划" roller="false" showStatus="false"
				panelWidth="50%" panelHeight="200" statusText="更多>>"
				panelUrl="#nogo" style="float: left">
				<div class="sgList">
					<ul>
						<li class="listArr" >最多二十四字*八行</li> 					
					</ul>
				</div>
			</div>
			<div class="box2" panelTitle="快捷菜单" roller="false" showStatus="false"
				panelWidth="49%" panelHeight="200" statusText="更多>>"style="float: right"
				panelUrl="#nogo">
			</div>
		</div>
	</body>
</html>