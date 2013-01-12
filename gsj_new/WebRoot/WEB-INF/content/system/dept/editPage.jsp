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
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx }/js/framework.js"></script>
	<link href="${ctx }/css/import_basic.css" rel="stylesheet"
		type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin" />
	<!--框架必需end-->
	<style>
table {
	font-size: ${c_font_size};
}
</style>
	<!--多选框脚本start-->
	<script type="text/javascript" src="${ctx }/js/form/multiselect.js"></script>
	<!--多选框脚本end-->

	<script>
$().ready(function() {
	$("#form1").validate({
		 rules: {
			 'dept.name': "required",
			 'dept.code': "required",
			 'dept.seq': {
				  required: true ,
				  number:true
			 } 
		 },
		 messages: {
			  'dept.name': "部门名称不能为空",
			  'dept.code': "部门代码不能为空",
			  'dept.seq': {
			   required: "顺序号不能为空",
			   number: "顺序号必须为数字"
			  } 
		 }
	});
});

</script>
	<body>
		<div id="scrollContent">
			<s:form action="dept!save.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="单位信息"
					showStatus="false" roller="true">
					<s:hidden name="dept.id"></s:hidden> 
					<s:hidden name="dept.state"></s:hidden> 
					<s:hidden name="dept.searchCode"></s:hidden> 
					<s:hidden name="dept.parent.id"></s:hidden> 
					<s:hidden name="id"></s:hidden>  
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								<font color="red">*</font>部门名称：
							</td>
							<td width="40%">
								<s:textfield name="dept.name" maxlength="30"></s:textfield>
							</td>
							<td>
								 上级部门
							</td>
							<td>
								 ${dept.parent.name }
							</td>
						</tr>
						 
						<tr>
							<td>
								<font color="red">*</font>顺序号：
							</td>
							<td>
								<s:textfield name="dept.seq" maxlength="2"></s:textfield>
							</td>
							<td>
							<font color="red">*</font>部门代码
							</td>
							<td>
								 <s:textfield name="dept.code"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								
							</td>
							<td>
								
							</td>
							<td>

							</td>
							<td>



							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 提 交 " />
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