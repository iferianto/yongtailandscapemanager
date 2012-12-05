<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
	<script type="text/javascript" src="${ctx }/js/common.js"></script>
	<script type="text/javascript"
		src="${ctx }/js/validate/jquery.validate.min.js"></script>
	<link href="${ctx }/js/validate/css/screen.css" rel="stylesheet"
		type="text/css" />
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx }/js/framework.js"></script>
				<script type="text/javascript" src="${ctx }/js/date/WdatePicker.js"
					defer="defer"></script>
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
</style><script type="text/javascript" src="${ctx }/js/form/lister.js"></script>
	<!--多选框脚本start-->
	<script type="text/javascript" src="${ctx }/js/form/multiselect.js"></script>
	<!--多选框脚本end-->

	<script>
	function selectAll(){
		$('#listA').lister('listB').sendAll(true);
	}
	function cancelAll(){
		$('#listA').lister('listB').sendAll(false);
	}
	$(document).ready(function(){
		$("#listA").lister("listB");		
	});
$().ready(function() {
	$("#form1").validate({
		 rules: {
			 'user.realname': "required", 
			 'user.username': "required", 
			  'user.seq': {
				  required: true ,
				  number:true
			 },
			 'user.password': {
				  
				  minlength: 6
			 } 
		 },
		 messages: {
			  'user.realname': "景区名称不能为空", 
			  'user.username': "用户名不能为空", 
			  'user.seq': {
			   required: "顺序号不能为空",
			   number: "顺序号必须为数字"
			  },
			  'user.password': {
			  
			   minlength: "密码至少要6个字符"
			  } 
		 }
	});
});

</script>
<style>
ul.lister{
	height:250px;
}
div.listerLinksLeft,div.listerLinksRight{
	text-align:left;
	width:240px;
	padding:5px;
}
.listBtn{
	padding:100px 0 0 0;
	float:left;
}
</style>
	<body>
		<div id="scrollContent">
			<s:form action="user!edit.action?fromUrl=jingqu" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="景区用户信息"
					showStatus="false" roller="true">
					<s:hidden name="user.id"></s:hidden>
					<s:hidden name="user.createTime"></s:hidden>
					<s:hidden name="user.lastLoginTime"></s:hidden>
					<s:hidden name="user.state" value="1"></s:hidden>
					<s:hidden name="user.type" value="4"></s:hidden>
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								用户名：
							</td>
							<td width="40%">
								<s:textfield name="user.username" maxlength="30"></s:textfield>
							</td>
							<td>
								密码：
							</td>
							<td>
								<s:password name="pwd" maxlength="30"></s:password>如不修改，可不填
							</td>
						</tr>
						<tr>
							<td width="10%">
								景区名称：
							</td>
							<td>
								<s:textfield name="user.realname" maxlength="30"></s:textfield>
							</td>
							<td>
注册号：
							</td>
							<td>
								
								<s:textfield name="user.regcode" maxlength="50"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								字号：
							</td>
							<td>
								<s:textfield name="user.code" maxlength="50"></s:textfield>
							</td>
							<td>
								经营场所：
							</td>
							<td>
								<s:textfield name="user.place" maxlength="50"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								经营范围：
							</td>
							<td>
								<s:textfield name="user.scope" maxlength="50"></s:textfield>
							</td>
							<td>
								开业时间：
							</td>
							<td>
								<s:textfield name="user.begintime"	onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'})" readonly="true" maxlength="50"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								联系电话：
							</td>
							<td>
								<s:textfield name="user.tel" maxlength="50"></s:textfield>
							</td>
							<td>
								管辖工商所：
							</td>
							<td>
								<s:textfield name="user.chargedept" maxlength="50"></s:textfield>
							</td>
						</tr>
						    
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 提 交 " onclick="doCheckRole();" />
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