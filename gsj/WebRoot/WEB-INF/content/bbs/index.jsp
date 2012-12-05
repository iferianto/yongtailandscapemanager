<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.ecko.cms.entity.BbsForums"%>
<%@page import="com.ecko.cms.entity.Threads"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>论坛首页</title>

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
	text-align: left;
}
</style>
			<div id="main">
				<div class="main_left" style="width: 130px;">

					<%@ include file="/cms/bbsleft.jsp"%>

				</div>

				<div class="main_right" style="border: 0px; width: 815px;">
					<div class="position">
						<table width="100%">
							<tr>
								<td valign="center" width="80%">
									当前位置:
									<a href="${ctx }">首页</a> >
									<a href="${ctx }/bbs">论坛首页</a>
								</td>
								<td valign="center" align="right">

									<c:if test="${empty MEMBER_USER}">
										<a href="${ctx }" />登录 </a>
									</c:if>
									<c:if test="${not empty MEMBER_USER}">
										<a href="${ctx }/bbs!addPage.action">发表主题</a>
									</c:if>
									&nbsp;&nbsp;&nbsp;&nbsp;

								</td>
							</tr>
						</table>


					</div>
					 <%
 List<BbsForums>ls=(List)request.getAttribute("bbs");
 for(int i=0;i<ls.size();i++){
	 BbsForums f=ls.get(i);
 %>
 <%
 if(i%3==0){
 %>
		<div class="bankuai_list">
		<%} %>
				<div class="sub_bankuai">
							<Div class="sub_bankuai_tit">
								<div class="sub_bk_img">
									<a href=""><img src="${ctx }/cms/images/forum.gif" /> </a>
								</div>
								<div class="sub_bk_des">
									<a href="${ctx }/bbs!list.action?seqs=<%=f.getId() %>"><strong><%=f.getName()%></strong>
									</a>
									<br />
									主题: <%=f.getThreads() %>, 回复数:<%=f.getPosts()%>
								</div>
								<div style="clear: both;"></div>
							</Div>
							<div class="info"
								style="clear: both; background: #fff; border: 1px solid #D9ECFF;">
								<ul>
								<%
									List <Threads>threads=(List)request.getAttribute("threads"+i);
									if(threads!=null&&threads.size()>0){
										for(int j=0;j<threads.size();j++){
											Threads t=threads.get(j);
								%> 
										<li>
											<a href="${ctx }/bbs!detail.action?seqs=<%=t.getId() %>"> <%=t.getTitle().length()>14?t.getTitle().substring(0,14)+"...":t.getTitle() %></a>
										</li>
								<%} %>
								<%}else{ %>
								<li>&nbsp;</li>
								<%} %>
								</ul>
							</div>
						</div>
  <%
 if(i%3==2){
 %>
			<div style="clear: both;"></div>
					</div>
		<%} %>
					

<%} %>

				</div>
			</div>
			<!--main end -->
			<%@ include file="/cms/footer.jsp"%>
		</div>

		<!--foot end -->



		</div>



	</body>

</html>