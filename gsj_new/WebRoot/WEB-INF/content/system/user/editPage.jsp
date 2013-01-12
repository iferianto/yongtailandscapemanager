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

</style><script type="text/javascript" src="${ctx }/js/form/lister.js"></script>
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
			 'user.username': "required", 
			 'user.seq': {
				  required: true ,
				  number:true
			 }  
		 },
		 messages: {
			  'user.username': "用户名不能为空", 
			  'user.seq': {
			   required: "顺序号不能为空",
			   number: "顺序号必须为数字"
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
			<s:form action="user!edit.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="用户信息"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden>
					<s:hidden name="user.id"></s:hidden>
					<s:hidden name="user.createTime"></s:hidden>
					<s:hidden name="user.lastLoginTime"></s:hidden>
					<s:hidden name="state"></s:hidden>
					<input type="hidden" value="${user.password}" name="pwd"/>
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								用户名：
							</td>
							<td width="40%">
								<s:textfield name="user.username" readonly="true"></s:textfield>
								</td>
							<td>
								密码：
							</td>
							<td>
								<s:password name="user.password"  ></s:password>密码为空则为则表示不更改密码
								</td>
						</tr>
						<tr>
							<td width="10%">
								真实姓名：
							</td>
							<td>
								<s:textfield name="user.realname" maxlength="30"></s:textfield>
							</td>
							<td> 状态：
							</td>
							<td>
								 <s:select list="#{'1':'有效','0':'无效'}" name="user.state"></s:select>
							</td>
						</tr>
						<tr>
							<td>
								顺序号：
							</td>
							<td>
								<s:textfield name="user.seq" maxlength="2"></s:textfield>
							</td>
							<td>
								 类型：
							</td>
							<td>
								<label for="radio-3">
									网站管理员
								</label>
								<input type="radio" id="radio-3" name="user.type" value="1"   <c:if test="${user.type==1}">checked</c:if>/>
								<label for="radio-4">
									工商所
								</label>
								<input type="radio" id="radio-4" name="user.type" value="2"  <c:if test="${user.type==2}">checked</c:if>/>
								<label for="radio-4">
									科室
								</label>
								<input type="radio" id="radio-4" name="user.type" value="3"  <c:if test="${user.type==3}">checked</c:if>/>
							</td>
						</tr>
						  
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 提 交 " onclick="doCheckRole();"  />
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