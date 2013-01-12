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
			 
		},
		onCheck: function(node, checked){
			 
		}
	});


});

function getSelected(){
	var nodes = $('#tt1').tree('getChecked');
	var s = '';
	for(var i=0; i<nodes.length; i++){
		if (s != '') s += ',';
		s += nodes[i].text;
	}
	return nodes;
}
 
</script>
	<body>
		<div id="scrollContent"> 
				 
					 <ul id="tt1" class="easyui-tree" checkbox="true"   >
					 ${str }
					 </ul>
				 
			 
		</div>
	 
	</div>
	</body>
</html>