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

	<script>
$().ready(function() {
	$("#form1").validate({
		 rules: {
			 'flink.name': "required",
			 'flink.seq': {
				  required: true ,
				  number:true
			 } ,
			 'flink.url': {
				  required: true ,
				  url:true
			 } 
		 },
		 messages: {
			  'flink.name': "栏目名称不能为空",
			  'flink.seq': {
			   required: "顺序号不能为空",
			   number: "顺序号必须为数字"
			  } ,
			  'flink.url': {
				   required: "网址不能为空",
				   url: "网址必须形如:http://www.sina.com"
				  } 
		 }
	});
	
	 
});

</script>
	<body>
		<div id="scrollContent">
			<s:form action="flink!save.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="友情链接"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden>
					<s:hidden name="flink.id" />
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								网站名称：
							</td>
							<td width="40%">
								<s:textfield name="flink.name" maxlength="15" cssStyle="width:50%"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								顺序号：
							</td>
							<td>
								<s:textfield name="flink.seq" maxlength="2" cssStyle="width:50%"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								网址：
							</td>
							<td>
								<s:textfield name="flink.url" maxlength="200" cssStyle="width:50%"></s:textfield>

							</td>

						</tr>

						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 保 存 " />
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