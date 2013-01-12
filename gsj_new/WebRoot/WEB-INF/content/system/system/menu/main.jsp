<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<html>
	<head>
		<title>main</title>
		<base target="_self">
		<link rel="stylesheet" type="text/css" href="${ctx}/dede/css/base.css" />
		<link rel="stylesheet" type="text/css" href="${ctx}/dede/css/main.css" />
		<link rel="stylesheet" type="text/css"
			href="${ctx }/js/jeasyui1.2.5/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css"
			href="${ctx }/js/jeasyui1.2.5/themes/icon.css">
		<script type="text/javascript"
			src="${ctx }/js/jeasyui1.2.5/jquery-1.7.1.min.js"></script>
		<script type="text/javascript"
			src="${ctx }/js/jeasyui1.2.5/jquery.easyui.min.js"></script>
		<script>
	$(function() {
		$('#tt')
				.tree(
						{
							url : '${ctx }/system/menu!mtree.action',
							onClick : function(node) {
								$(this).tree('toggle', node.target);

							},
							onContextMenu : function(e, node) {
								e.preventDefault();
								$('#tt').tree('select', node.target);
								$('#mm').menu('show', {
									left : e.pageX,
									top : e.pageY
								});
							},
							onBeforeExpand : function(node) {
								$('#tt').tree('options').url = "${ctx }/system/menu!mtree.action?parentId="
										+ node.id;
							}
						});
	});
	function add(){
		var node = $('#tt').tree('getSelected'); 
		showWind('${ctx }/system/menu!addPage.action?id='+node.id);
	}

	function edit(){
		var node = $('#tt').tree('getSelected');
		if(node.id==0){
			jAlert('不能修改根菜单');
			return;
		}
		showWind('${ctx }/system/menu!editPage.action?id='+node.id);
	}
	function remove(){
		var node = $('#tt').tree('getSelected');
		if(node.id==0){
			jAlert('不能删除根菜单');
			return;
		}
		showWind('${ctx }/system/menu!delete.action?id='+node.id);
	}

	function showWind(url){
		window.location.href=url;
	}
</script>
	</head>
	<body leftmargin="8" topmargin='8'>
		 
		<table width="98%" align="center" border="0" cellpadding="3"
			cellspacing="1" bgcolor="#CBD8AC"
			style="margin-bottom: 8px; margin-top: 8px;">
			<tr>
				<td background="${ctx}/dede/images/frame/wbg.gif" bgcolor="#EEF4EA"
					class='title'>
					<span style="font-size: 12px">菜单管理</span>
				</td>
			</tr>
			<tr bgcolor="#FFFFFF">
				<td>
					&nbsp;
					<ul id="tt">

					</ul>
				</td>
			</tr>
		</table>
<div id="mm" class="easyui-menu" style="width: 120px;">
			<div onclick="add()" iconCls="icon-add">
				新增
			</div>
			<div onclick="edit()" iconCls="icon-edit">
				修改
			</div>
			<div onclick="remove()" iconCls="icon-remove">
				删除
			</div>
		</div>
	</body>
</html>