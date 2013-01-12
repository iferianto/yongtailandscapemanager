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
			'menu.name': "required" 
		},
		messages: {
			'menu.name': "菜单名称必填"  
		}
	});
	
});
</script>
	</head> 
	<body class="ContentBody">
		<form action="${ctx }/system/menu!save.action" method="post"  name="form1"
			id="form1" onsubmit="return false;">
			<div class="MainDiv">
				<table width="99%" border="0" cellpadding="0" cellspacing="0"
					class="CContent">
					<tr>
						<th class="tablestyle_title">
							菜单新增页面
							<input type="hidden" name="menu.id" value="${menu.id }"/>
							<input type="hidden" name="id" value="${id }"/>
							<input type="hidden" name="menu.parent.id" value="${menu.parent.id }"/>
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
												菜单新增
											</legend>
											<table border="0" cellpadding="2" cellspacing="1"
												style="width: 100%">

												<tr>
													<td nowrap align="right" width="10%">
														菜单名称:
													</td>
													<td width="38%">
														<input name="menu.name" class="text"  value="${menu.name }" 
															type="text" style="width: 154px" />
														<span class="red"> *</span>
													</td>
													<td align="right" width="8%">
														菜单url:
													</td>
													<td width="44%" >
														<input name="menu.url" id="Input22" class="text" value="${menu.url }"
															style="width: 154px" />
													</td>
												</tr>
												 <tr>
													<td nowrap align="right"  >
														操作数:
													</td>
													<td width="35%">
														<select name="menu.opeCount">
															 <option value="0" <c:if test="${menu.opeCount=='0'}">selected</c:if>>
																不操作任何数据（新增）
															</option>
															<option value="1" <c:if test="${menu.opeCount=='1'}">selected</c:if>>
																操作一条数据（修改）
															</option>
															<option value="2" <c:if test="${menu.opeCount=='2'}">selected</c:if>>
																操作多条数据（删除）
															</option> 
														</select>当type=2时可用
													</td>
													<td align="right" width="15%">
														排序号:
													</td>
													<td width="35%">
														<input name="menu.seq" id="Input22" class="text"value="${menu.seq }"
															style="width: 154px" />
													</td>
												</tr>
												<tr>
													<td nowrap align="right">
														菜单类型:
													</td>
													<td>
														<select name="menu.type">
															
															<option value="1" <c:if test="${menu.type=='1'}">selected</c:if>>
																菜单
															</option>
															<option value="2" <c:if test="${menu.type=='2'}">selected</c:if>>
																功能
															</option> 
														</select>
													</td>
													<td align="right">
														是否提示:
													</td>
													<td>
														<select name="menu.msgBoxType"> 
															<option value="1" <c:if test="${menu.msgBoxType=='1'}">selected</c:if>>
																不做任何操作
															</option>
															<option value="2" <c:if test="${menu.msgBoxType=='2'}">selected</c:if>>
																弹出confirm框
															</option> 
														</select>当type=2时可用
													</td>
												</tr>
												<tr>
													<td nowrap align="right">
														上级菜单:
													</td>
													<td>
														${menu.parent.name }
													</td>
													<td align="right">
														 css样式
													</td>
													<td>
														 <input name="menu.css" id="Input22" class="text" value="${menu.css }"
															style="width: 154px" />当type=2时可用
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
		</form>
	</body>
</html>
