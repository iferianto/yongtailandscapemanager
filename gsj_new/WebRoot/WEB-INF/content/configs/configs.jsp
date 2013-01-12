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
	font-size: ${ c_font_size
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
			 'configs.indexmemo': {
				required:true,
				maxlength:250
			}  , 'configs.checkcount': {
				required:true,
				digits:true,
				max:10,
				min:1
			} 
			
		 },
		 messages: {
			 'configs.indexmemo': {
				required:'首页协会简介必填',
				maxlength:'首页协会简介不能超过250字'

			} , 'configs.checkcount': {
				required:'审核人数必填',
				digits:'审核人数必须为数字',
				max:'审核人数最大10',
				min:'审核人数最小1'
			}   
		 }
	});
	 
});

</script>
	<body>
		<div id="scrollContent">
			<s:form action="configs!save.action" id="form1"enctype="multipart/form-data">
				<div class="box2" panelWidth="100%" panelTitle="表单填写"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden>
					<s:hidden name="configs.id"></s:hidden> 
					<table width="95%" class="tableStyle">
						 
						<tr>
							<td width="15%" align="right">
								首页协会简介：
							</td>
							<td colspan="3">
								<s:textarea name="configs.indexmemo"  
									cssStyle="width:85%"></s:textarea>

							</td>
						</tr>
						 <tr>
							<td width="15%" align="right">
								审核人数：
							</td>
							<td colspan="3">
								<s:textfield name="configs.checkcount"  
									 ></s:textfield>
									同时几个人审核，才算通过

							</td>
						</tr>
						 <tr>
							<td width="15%" align="right">
								审核人员：
							</td>
							<td colspan="3">
								<s:textfield name="configs.checkusers"   maxlength="1000"
									cssStyle="width:85%" ></s:textfield>
									 有权限审核的人，必须输入用户名，多个用","隔开

							</td>
						</tr>
						 
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 保 存 " /> 
							</td>
						</tr>
					</table>
				</div>
			</s:form>
		</div>
	</body>
</html>