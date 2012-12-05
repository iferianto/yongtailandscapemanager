<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
	<script type="text/javascript"
		src="${ctx }/js/validate/jquery.validate.min.js"></script>
	<link href="${ctx }/js/validate/css/screen.css" rel="stylesheet"
		type="text/css" />
	<script type="text/javascript"
		src="${ctx }/js/kindeditor/kindeditor.js"></script>
	<script type="text/javascript"
		src="${ctx }/js/kindeditor/lang/zh_CN.js"></script>
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx }/js/framework.js"></script>
	<link href="${ctx }/css/import_basic.css" rel="stylesheet"
		type="text/css" />
<script>
window.onload=function(){

	var msg='${glb_message}';
	if(msg!=''){
		alert(msg);
	}
}
</script>
	<link rel="stylesheet" type="text/css" id="skin" />
	<!--框架必需end-->
	<style>
table {
	font-size: ${
	c_font_size
}
;
}
</style>
	<!--多选框脚本start-->
	<script type="text/javascript" src="${ctx }/js/form/multiselect.js"></script>
	<!--多选框脚本end-->

	<body> 
			<div class="box1" panelWidth="95%">
				<table class="tableStyle">
					<tr>
						<td colspan="2" align="center" style="overflow:hidden; width:100px;TEXT-OVERFLOW: ellipsis;">
							${threads.title }
						</td>
					</tr>
					<tr>
						<td>
							内容：
						</td>
						<td  style="overflow:hidden; width:100px;TEXT-OVERFLOW: ellipsis;">
							${threads.content }
						</td>
					</tr>
					<c:forEach items="${page.result}" var="item" varStatus="i">
						<tr>
							<td width="10%">
								回复 :
							</td>
							<td  style="overflow:hidden; width:100px;TEXT-OVERFLOW: ellipsis;">
								${item.content }----<a onclick="return confirm('您确定要删除本回复？');" href="${ctx }/admin/threads!deletePosts.action?id=${threads.id }&postId=${item.id}">删除本回复</a>
							</td>
						</tr>
					</c:forEach>
					<tr>
						<td colspan="2">
							${pageUtils }
						</td>
					</tr>
					<tr>
						<td colspan="2">
						<script>
						function doback(){
							window.location.href='${ctx}/admin/threads!list.action';
						}
						</script>
							<input type="submit" value=" 返回   "
								onclick="doback();" />
						</td>
					</tr>
				</table>

 
	</body>
</html>