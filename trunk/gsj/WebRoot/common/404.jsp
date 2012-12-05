<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

		<title> </title>

		<meta name="description" content="" />

		<meta name="keywords" content="" />

		<link href="${ctx }/cms/css/css.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
		<script type="text/javascript"
			src="${ctx }/js/validate/jquery.validate.min.js"></script>
		<link href="${ctx }/js/validate/css/screen.css" rel="stylesheet"
			type="text/css" />
		<meta name="google-site-verification"
			content="s2DfhdRTF2H-DUujgtPfxurIHOQ_4PQq45EUpUDXD4Q" />

		<script type="text/javascript">
	function displaySubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "block";
	}
	function hideSubMenu(li) {
		var subMenu = li.getElementsByTagName("ul")[0];
		subMenu.style.display = "none";
	}
</script>


	</head>

	<body>

		<div class="container">

			<%@ include file="/cms/header.jsp"%>

			<!--head end -->
			<style>
.info ul li {
	line-height: 23px;
	height: 23px;
}

.info {
	border: 1px solid #ddd;
}
</style>

			<div id="main">
				 
				 
					 
					<Div class="list_article" >
						 
							<p style="width:100%;text-align: center;color: red;">
								您访问的页面不存在，请点此返回<a style="color:blue;" href="${ctx }/">首页</a>
							</p>
							 
						 
						 
					</Div>
					 
				 
			</div>
			<!--main end -->

			<%@ include file="/cms/footer.jsp"%>





		</div>

		<!--foot end -->



		</div>



	</body>

</html>