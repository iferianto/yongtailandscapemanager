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
		<div id="scrollContent">
			<s:form action="flink!save.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="在线投诉"
					showStatus="false" roller="true">
					 
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								投诉标题：
							</td>
							<td width="40%">
								${question.title }
							</td>
						</tr>
						<tr>
							<td width="10%">
								联系电话：
							</td>
							<td width="40%">
								${question.tel }
							</td>
						</tr>
<tr>
							<td width="10%">
								电子邮箱：
							</td>
							<td width="40%">
								${question.email }
							</td>
						</tr>
						<tr>
							<td width="10%">
								投诉内容：
							</td>
							<td width="40%">
								${question.content }
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center"> 
								<input type="button" value=" 后 退 "
									onclick="javascript:history.back();" />
							</td>
						</tr>
					</table>
				</div>
			</s:form>
		</div>
	</body>
</html>