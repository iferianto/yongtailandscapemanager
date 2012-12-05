<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
	<script type="text/javascript" src="${ctx }/js/common.js"></script>
	<script type="text/javascript"
		src="${ctx }/js/validate/jquery.validate.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/form/lister.js"></script>
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
	font-size: ${
	c_font_size
}
;
}
</style>
	<style>
ul.lister {
	height: 250px;
}

div.listerLinksLeft,div.listerLinksRight {
	text-align: left;
	width: 240px;
	padding: 5px;
}

.listBtn {
	padding: 100px 0 0 0;
	float: left;
}
</style>
	<!--多选框脚本start-->
	<script type="text/javascript" src="${ctx }/js/form/multiselect.js"></script>
	<!--多选框脚本end-->

	<script>
	$(document).ready(function(){
		$("#listA").lister("listB");		
	});
	function selectAll(){
		$('#listA').lister('listB').sendAll(true);
	}
	function cancelAll(){
		$('#listA').lister('listB').sendAll(false);
	}

	function doSubmit(){
		document.getElementById('userIds').value=$('#listA').lister('listB').getList();
		
		document.getElementById('form1').submit();
	}
</script>
	<body>
		<div id="scrollContent">
			<s:form action="group!save.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="用户组信息"
					showStatus="false" roller="true">
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								用户名：
							</td>
							<td width="40%">
								<s:textfield name="group.name" maxlength="30"></s:textfield>
							</td>

						</tr>

						<tr>
							<td>
								状态：
							</td>
							<td>
								<s:select list="#{'1':'有效','0':'无效'}" name="group.state"></s:select>
							</td>

						</tr>
						<tr>
							<td colspan="2">
								<div>
									<ul id="listA">
										<c:forEach var="item" items="${users}">
										<li el="${item.id }">
											${item.realname }
										</li>
										</c:forEach>
										
									</ul>
									<div class="listBtn">
										<input type="button" value="全选>>" onclick="selectAll()" />
										<br />
										<br />
										<input type="button" value="<<还原" onclick="cancelAll()" />
									</div>
									<ul id="listB"></ul>
								</div>
								<div class="clear"></div>
								<s:hidden id="userIds" name="userIds"></s:hidden>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
								<input type="button" value=" 保存" onclick="doSubmit()"/>
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