<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>



		<link rel="stylesheet" rev="stylesheet" href="${ctx }/css/style.css"
			type="text/css" media="all" />
		<link rel="stylesheet" type="text/css"
			href="${ctx }/js/jquery-easyui-1.2.5/themes/default/easyui.css">
			<link rel="stylesheet" type="text/css"
				href="${ctx }/js/jquery-easyui-1.2.5/themes/icon.css">
				<script type="text/javascript"
					src="${ctx }/js/jquery-easyui-1.2.5/jquery-1.7.1.min.js"></script>
				<script type="text/javascript"
					src="${ctx }/js/jquery-easyui-1.2.5/jquery.easyui.min.js"></script>
				<script type="text/javascript"
					src="${ctx }/js/jquery-easyui-1.2.5/jquery.validate.min.js"></script>
				<script type="text/javascript"
					src="${ctx }/js/jquery-easyui-1.2.5/jquery.portal.js"></script>
				<script type="text/javascript" src="${ctx }/js/common.js"></script>
				<style type="text/css">
<!--
.atten {
	font-size: 12px;
	font-weight: normal;
	color: #F00;
}
-->
</style>
				<script type="text/javascript">
$().ready(function() {
	$("#form1").validate({
		rules: {
			'role.name': "required"  
		},
		messages: {
			'role.name': "角色名称必填"  
		}
	});
	
});
</script>
	</head>
	<body class="ContentBody">

		<s:form action="role!save.action" method="post" name="form1"
			id="form1" onsubmit="return false;">
			<div class="MainDiv">
				<table width="99%" border="0" cellpadding="0" cellspacing="0"
					class="CContent">
					<tr>
						<th class="tablestyle_title">
							角色新增页面
							<input type="hidden" name="role.id" value="${role.id }" />
							<input type="hidden" name="id" value="${id }" />
						</th>
					</tr>
					<tr>
						<td class="CPanel">

							<table border="0" cellpadding="0" cellspacing="0"
								style="width: 100%">


								<TR>
									<TD width="100%">
										<fieldset style="height: 100%;">
											<legend>
												新增角色
											</legend>
											<table border="0" cellpadding="2" cellspacing="1"
												style="width: 100%">

												<tr>
													<td nowrap align="right" width="10%">
														角色名称:
													</td>
													<td width="38%">
														<s:textfield name="role.name" cssStyle="width: 154px"></s:textfield>
														<span class="red"> *</span>
													</td> 
												</tr> 
												<tr>
													<td nowrap align="right" width="10%">
													状态:
			  <s:hidden name="role.seq" ></s:hidden>
													</td>
													<td width="38%">
														<s:select name="role.state" list="#{1:'有效',0:'无效'}"  label="abc" listKey="key" listValue="value"></s:select>
													</td>
													 
												</tr> 
											</table>
											<br />
										</fieldset>
									</TD>
								</TR>
							</TABLE>
						</td>
					</tr>






					<TR>
						<TD colspan="2" align="center" height="50px">
							<input type="submit" name="Submit" value="保存" class="button" />

							<input type="button" name="Submit2" value="关闭" class="button"
								onclick="window.close();" />
						</TD>
					</TR>
				</TABLE>


				</td>
				</tr>




				</table>

			</div>
		</s:form>
	</body>
</html>
