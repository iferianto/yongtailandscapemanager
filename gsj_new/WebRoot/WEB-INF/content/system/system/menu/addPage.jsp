<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
	<head>

		<script type="text/javascript"
			src="${ctx }/js/jeasyui1.2.5/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="${ctx }/js/validate/jquery.validate.js"></script>
		<script type="text/javascript" src="${ctx }/js/common.js"></script>
		<script type="text/javascript" src="${ctx }/js/edit.js"></script>
		<script type="text/javascript">
	$().ready(function() {
		$("#submitForm").validate( {
			rules : {
				'menu.name' : "required", 
				'menu.seq' : {
					digits:true,
					required:true 
				}
			},
			messages : {
				'menu.name' : "菜单名称必填",
				  
				'menu.seq' : {
				'digits':"顺序号必须是数字",
				'required':'顺序号必填'
				}
			} 
		});

	});
</script>
		<style type="text/css">
<!--
body {
	background-image: url(${ctx}/dede/images/allbg.gif);
}
-->
</style>
		<link href="${ctx}/dede/css/base.css" rel="stylesheet" type="text/css">

		<link href="${ctx}/js/validate/css/screen.css" rel="stylesheet"
			type="text/css">
	</head>
	<body topmargin="8">
		<table width="98%" border="0" align="center" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="4%" height="30">
					<IMG height=14 src="${ctx}/dede/images/book1.gif" width=20>
					&nbsp;
				</td>
				<td width="60%">
					<a href="#nogo"><u>首页</u> </a> &gt;&gt; 系统管理&gt;&gt; 添加菜单
				</td>
				<td width="30%" align='right'>

				</td>
				<td width="1%">
					&nbsp;
				</td>
			</tr>
		</table>

		<table width="97%" border="0" align="center" cellpadding="0"
			cellspacing="0" id="head1" style="border-bottom: 1px solid #CCCCCC">
			<tr>
				<td colspan="2">
					<table border="0" cellpadding="0" cellspacing="0">
						<tr>
							<td width="84" height="24" align="center"
								background="${ctx}/dede/images/itemnote1.gif">
								&nbsp;添加菜单&nbsp;
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>


		<s:form id="submitForm" action="menu!save.action" method="post">

			<s:hidden name="id"></s:hidden>
			<s:hidden name="menu.id"></s:hidden>
			<input type="hidden" name="menu.parent.id" value="${menu.parent.id }" />
			<table width="98%" border="0" align="center" cellpadding="2"
				cellspacing="2" id="adset">
				<tr>
					<td height="24" width="12%" class="bline" align="right">
						菜单名称：
					</td>
					<td height="24" width="38%" class="bline">
						<s:textfield name="menu.name" cssStyle="width:150px"></s:textfield>
					</td>
					<td height="24" width="12%" align="right" class="bline">
						URL：
					</td>
					<td height="24" width="38%" class="bline">
						<s:textfield name="menu.url" cssStyle="width:150px"></s:textfield>
					</td>
				</tr>
				<tr>
					<td height="24" width="12%" class="bline" align="right">
						操作数:
					</td>
					<td height="24" width="38%" class="bline">
						<select name="menu.opeCount">
							<option value="0"
								<c:if test="${menu.opeCount=='0'}">selected</c:if>>
								不操作任何数据（新增）
							</option>
							<option value="1"
								<c:if test="${menu.opeCount=='1'}">selected</c:if>>
								操作一条数据（修改）
							</option>
							<option value="2"
								<c:if test="${menu.opeCount=='2'}">selected</c:if>>
								操作多条数据（删除）
							</option>
						</select>
						当type=2时可用
					</td>
					<td height="24" width="12%" align="right" class="bline">
						排序号:
					</td>
					<td height="24" width="38%" class="bline">
						<input name="menu.seq" id="Input22" class="text" maxlength="2"
							value="${menu.seq }" style="width: 150px" />
					</td>
				</tr>
				<tr>
					<td height="24" width="12%" class="bline" align="right">
						菜单类型:
					</td>
					<td height="24" width="38%" class="bline">
						<select name="menu.type">

							<option value="1" <c:if test="${menu.type=='1'}">selected</c:if>>
								菜单
							</option>
							<option value="2" <c:if test="${menu.type=='2'}">selected</c:if>>
								功能
							</option>
						</select>
					</td>
					<td height="24" width="12%" align="right" class="bline">
						是否提示:
					</td>
					<td height="24" width="38%" class="bline">
						<select name="menu.msgBoxType">
							<option value="1"
								<c:if test="${menu.msgBoxType=='1'}">selected</c:if>>
								不做任何操作
							</option>
							<option value="2"
								<c:if test="${menu.msgBoxType=='2'}">selected</c:if>>
								弹出confirm框
							</option>
						</select>
						当type=2时可用
					</td>
				</tr>
				<tr>
					<td height="24" width="12%" class="bline" align="right">
						上级菜单:
					</td>
					<td height="24" width="38%" class="bline">
						&nbsp;${menu.parent.name }
					</td>
					<td height="24" width="12%" align="right" class="bline">
						css样式:
					</td>
					<td height="24" width="38%" class="bline">
						<input name="menu.css" id="Input22" class="text"
							value="${menu.css }" style="width: 150px" />
						当type=2时可用
					</td>
				</tr>
<tr>
					<td height="24" width="12%" class="bline" align="right">
						系统:
					</td>
					<td height="24" width="38%" class="bline">
<%--						<s:select list="sysList"listKey="id" listValue="name"></s:select> --%>
						<select name="menu.system.id">
							<c:forEach items="${sysList}" var="item" >
							
							<option value="${item.id }" <c:if test="${item.id==menu.system.id}">selected</c:if>>
								${item.name }
							</option>
							</c:forEach>
						</select>
					</td>
					<td height="24" width="12%" align="right" class="bline">
						 
					</td>
					<td height="24" width="38%" class="bline">
						 
					</td>
				</tr>
				<tr>
					<td width="50%" align="right" colspan="2">
						<input name="imageField" type="image"
							src="${ctx}/dede/images/button_ok.gif" width="60" height="22"
							class="np" border="0" style="cursor: pointer">
					</td>
					<td colspan="2">

						<img onclick="javascript:history.go(-1)"
							src="${ctx}/dede/images/button_back.gif" width="60" height="22"
							border="0" style="cursor: pointer" />
					</td>
				</tr>
			</table>
		</s:form>

	</body>
</html>