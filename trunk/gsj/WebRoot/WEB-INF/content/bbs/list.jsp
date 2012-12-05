<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>论坛列表页</title>

		<meta name="description" content="" />

		<meta name="keywords" content="" />

		<link href="${ctx }/cms/css/css.css" rel="stylesheet" type="text/css" />

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
				<div class="main_left" style="width: 130px;">
					
			<%@ include file="/cms/bbsleft.jsp"%>

				</div>
				<div class="main_right" style="width: 815px;">
					<div class="position">
						<table width="100%">
							<tr>
								<td valign="center" width="80%">
									当前位置:
									<a href="${ctx }">首页</a> >
									<a href="${ctx }/bbs">论坛首页</a> >
									<a href="#nogo">${forum.name }</a>
								</td>
								<td valign="center" align="right">
								<c:if test="${empty MEMBER_USER}">
										<a href="${ctx }" />登录 </a>					
									</c:if>
									<c:if test="${not empty MEMBER_USER}">
									<a href="${ctx }/bbs!addPage.action?seqs=${forum.id}">发表主题</a>
									</c:if>
									&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
						</table>
					</div>
					<Div class="list_article">
						<ul>
						<c:forEach items="${page.result}" var="item">
							<li>
								<img src="${ctx }/cms/images/_icon02.gif" />
								<span class="riqi"><fmt:formatDate value="${item.lastdate}"/></span>[
								<a href="${ctx }/bbs!list.action?seqs=${item.forums.id}">${item.forumsname }</a>]
								<a href="${ctx }/bbs!detail.action?seqs=${item.id}">${item.title }</a>
							</li> 
							</c:forEach>
						</ul>
					</Div>
					<div class="page_list">
						<ul>
							${pageUtils }
						</ul>
					</div>
				</div>
			</div>
			<!--main end -->

			<%@ include file="/cms/footer.jsp"%>







		</div>

		<!--foot end -->



		</div>



	</body>

</html>