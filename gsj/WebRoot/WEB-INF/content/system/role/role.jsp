<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />



		<link rel="stylesheet" rev="stylesheet" href="${ctx }/css/style.css"
			type="text/css" media="all" />
		<link rel="stylesheet" type="text/css"
			href="${ctx }/js/jeasyui1.2.5/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="${ctx }/js/jeasyui1.2.5/themes/icon.css">
		<script type="text/javascript"
			src="${ctx }/js/jeasyui1.2.5/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="${ctx }/js/jeasyui1.2.5/jquery.easyui.min.js"></script>
		<script type="text/javascript"
			src="${ctx }/js/jeasyui1.2.5/jquery.portal.js"></script>
		<script type="text/javascript" src="${ctx }/js/common.js"></script>
		<script>
	$(function() {
		$('#tt').tree(
			{checkbox: true,cascadeCheck:false ,
			url : '${ctx }/system/role!roleMenu.action?id=${id}',
			onClick : function(node) {
				$(this).tree('toggle', node.target);
				
			}  
		});
		$('#checkRole').click(function(){
				var nodes = $('#tt').tree('getChecked');
			var s = '';
			for(var i=0; i<nodes.length; i++){
				if (s != '') s += ',';
				s += nodes[i].id;
			}
		 $('#rightIds').val(s);
		 $('#roleSaveForm').submit();	
		});
	});
	 
</script>
	</head>
	<style type="text/css">
<!--
.atten {
	font-size: 12px;
	font-weight: normal;
	color: #F00;
}
-->
</style>
	</head>

	<body class="ContentBody">
		<div class="MainDiv">
			<table width="99%" border="0" cellpadding="0" cellspacing="0"
				class="CContent">
				<tr>
					<th class="tablestyle_title">
						菜单管理
					</th>
				</tr>
				<tr>
					<td class="CPanel">
<s:form   id="roleSaveForm" action="role!setRole.action">
<s:hidden name="rightIds" id="rightIds"> </s:hidden>
<s:hidden name="role.id"></s:hidden>
</s:form>
						<table border="0" cellpadding="0" cellspacing="0"
							style="width: 100%">

							<tr align="center">
								<td class="TablePanel">

								</td>
							</tr>
							<TR>
								<TD width="100%">
									<ul id="tt" >

									</ul>
								</TD>
							</TR>
						</TABLE>

						<TR>
							<TD colspan="2" align="center" height="50px">
								<input type="button" name="Submit" value="保存" class="button"
									id="checkRole" />

								<input type="button" name="Submit2" value="后退" class="button"
									onclick="history.back();" />
							</TD>
						</TR>
					</td>
				</tr>




			</table>

		</div>

	</body>
</html>
