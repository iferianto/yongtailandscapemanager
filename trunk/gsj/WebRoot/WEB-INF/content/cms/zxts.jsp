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

		<title>在线投诉</title>

		<meta name="description" content="" />

		<meta name="keywords" content="" />
<link href="${ctx }/js/validate/css/screen.css" rel="stylesheet"
				type="text/css" />
		<link href="${ctx }/cms/css/css.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
			<script type="text/javascript"
				src="${ctx }/js/validate/jquery.validate.min.js"></script>
			
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

	$().ready(function() {
		$("#form1").validate({
			 rules: {
				 'question.title': "required"  ,
				 'question.content':{
				  required: true,
				  maxlength: 1000
			 } 
			 },
			 messages: {
				  'question.title': "投诉标题不能为空"  ,
					 'question.content':{
				  required: "投诉内容不能为空",
				  maxlength: "投诉内容不能为超过1000字"
			 } 
			 }
		});
		 
	});
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
				<div class="main_left">
					<div class="main_left_tit1">
						最新资讯
					</div>
					<div class="info" id="info">

						<ul>
							<c:forEach items="${newest }" var="item">
								<li>
									<a href='${ctx }/cms!detail.action?seqs=${item.id}'> <c:if
											test="${fn:length(item.title) > 13}">
											<c:out value="${fn:substring(item.title, 0, 13)}..." />
										</c:if> <c:if test="${fn:length(item.title) <= 13}">
												${item.title }</c:if> </a>
								</li>
							</c:forEach>
						</ul>
						<div style="height: 6px; clear: both;"></div>
					</div>
					<div style="height: 8px; clear: both;"></div>
					 <div  >

     <div>
<a href="http://www.fz.fjaic.gov.cn" target="_blank">
<img src="${ctx }/cms/images/ytxgsj.gif" width="220px" />
</a>
</div>
<div style="padding-top: 5px;">
<a href="http://www.fjaic.gov.cn/" target="_blank">
<img src="${ctx }/cms/images/link_images2.gif" width="222px" height="60px"/></a>
</div><div style="height:6px;clear:both;"></div>
</div>
					 
				</div>
				<div class="main_right">
					<div class="position">
						当前位置:
						<a href="${ctx }">首页</a> > 
						<a href="${ctx }/cms!list.action?seqs=31">在线投诉</a> >
					</div>
					<Div class="list_article">
						<s:form action='/cms!addquestion.action' id="form1" method="post"> 
							<table width="700" border='0'  >
								<TR align=center>
									<TD height=20 colSpan=2>
										<b>在线投诉</b>
									</TD>
								</TR>
								<TR >
									<TD width="100" align="right" >
										<b>投诉标题：</b>
										 
									</TD>
									<TD width="600"  >
										<s:textfield name="question.title" maxlength="30" size="30">
										</s:textfield>
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR >
									<TD  align="right">
										<b>联系电话：</b>
										 
									</TD>
									<TD  >
										<s:textfield name="question.tel" maxlength="18" size="30">
										</s:textfield> 
									</TD>
								</TR>
								<TR >
									<TD  align="right" >
										<b>电子邮箱：</b>
										 
									</TD>
									<TD  >
										<s:textfield name="question.email" maxlength="14" size="30">
										</s:textfield>
									</TD>
								</TR>
								 
								<TR >
									<TD  align="right">
										<strong> 投诉内容（1000字以内）</strong>
									</TD>
									<TD  >
										<s:textarea name="question.content"  cssStyle="width:90%;height:80px"></s:textarea>
										<font color="#FF0000">*</font>
									</TD>
								</TR> 



							</TABLE>
							<div align="center">
								<INPUT type=submit value=" 投诉 " name=Submit2>
									&nbsp; <INPUT name=Reset2 type=reset id="Reset2" value=" 清 除 ">
							</div>
						</s:form>
					</Div>
					<div class="page_list">

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