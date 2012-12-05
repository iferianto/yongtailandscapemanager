<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
	 
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui1.2.5/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="${ctx }/js/jeasyui1.2.5/themes/icon.css"> 
	<script type="text/javascript" src="${ctx }/js/jeasyui1.2.5/jquery.easyui.min.js"></script>
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx }/js/framework.js"></script>
	<link href="${ctx }/css/import_basic.css" rel="stylesheet"
		type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin" prePath="<%=request.getContextPath()%>/"/>
	<!--框架必需end-->
	<style>
table {
	font-size: ${c_font_size};
}
</style>  

<script>
$(function(){
	$('#tt1').tree({ 
		url: '${ctx}/system/dept!treeJson.action',
		onClick:function(node){
			$(this).tree('toggle', node.target);
			//alert('you click '+node.text);
		},
		onContextMenu: function(e, node){
			e.preventDefault();
			$('#tt1').tree('select', node.target);
			$('#mm').menu('show', {
				left: e.pageX,
				top: e.pageY
			});
		}
	});


});

function remove(){
	if(confirm('您是否要删除本部门？')){
		var node = $('#tt1').tree('getSelected'); 
		window.location.href='${ctx}/system/dept!delete.action?id='+node.id;
	}
	
}

function edit(){
	var node = $('#tt1').tree('getSelected');
	window.location.href='${ctx}/system/dept!editPage.action?id='+node.id;
	
}

function append(){

	var node = $('#tt1').tree('getSelected');
	window.location.href='${ctx}/system/dept!addPage.action?id='+node.id;
}
</script>
	<body>
		<div id="scrollContent"> 
				<div class="box2" panelWidth="100%" panelTitle="表单填写"
					showStatus="false" roller="true">
					 <ul id="tt1" class="easyui-tree"    >
					 ${str }
					 </ul>
				</div>
			 
		</div>
		
		<div id="mm" class="easyui-menu" style="width:120px;">
		<div onclick="append()" iconCls="icon-add">添加子部门</div>
		<div  onclick="edit()"iconCls="icon-edit">修改本部门</div> 
		<div onclick="remove()" iconCls="icon-remove">删除本部门</div>
	</div>
	</body>
</html>