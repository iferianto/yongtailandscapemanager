<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<!--框架必需start-->
<script type="text/javascript" src="${ctx}/js/jquery-1.4.js"></script>
<script type="text/javascript" src="${ctx}/js/framework.js"></script>
<link href="${ctx}/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link  rel="stylesheet" type="text/css" id="skin"prePath="<%=request.getContextPath()%>/"/>
<!--框架必需end-->

<script type="text/javascript" src="${ctx}/js/tree/dtree/dtree.js"></script>
<link href="${ctx}/js/tree/dtree/dtree.css" rel="stylesheet" type="text/css"/>
<script>
	
</script>
</head>
<body leftFrame="true">
	 
	<div id="scrollContent">
	<script type="text/javascript">
		<!--

		d = new dTree('d');

		d.add(0,-1,'操作目录');
		${str}
		
		document.write(d);

		//-->
	</script>
</div>

</body>

</html>