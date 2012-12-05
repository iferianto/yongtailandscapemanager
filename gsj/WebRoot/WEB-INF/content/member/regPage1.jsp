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

		<title>集美人力资源协会-个人会员申请</title>

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
				 'member.username': "required" ,
				 'member.name': "required" ,
				 'member.idcard': "required" ,
				 'member.answer': "required" ,
				 'member.email': "required" ,
				 'member.mobile': "required" ,
				 'member.question': "required" ,
				 'member.fax': "required" ,
				 'member.phone': "required" ,
				 'password1':{
					  required: true,
					  minlength: 6
				 } ,
					'password2': {
						required: true, 
						equalTo: "#password1"
					}
			 },
			 messages: {
				  'member.username': "用户名不能为空" ,
					 'member.answer': "密码答案不能为空" ,
					 'member.question': "密码问题不能为空" ,
					 'member.name': "姓名不能为空" ,
					 'member.idcard': "身份证不能为空" ,
					 'member.fax': "联系传真不能为空" ,
					 'member.email': "Email地址不能为空" ,
					 'member.mobile': "联系手机不能为空" ,
					 'member.phone': "联系电话不能为空" ,
				  'password1': {
					   required: "密码不能为空",
					   minlength: "密码至少要6个字符"
					  }  ,
					'password2': {
						required: "确认密码不能为空", 
						equalTo: "两次输入密码不一致" 
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
<a href="http://www.jmrl.gov.cn/project/index.jsp" target="_blank">
<img src="${ctx }/cms/images/cyxx.png" width="220px" />
</a>
</div>
<div style="padding-top: 5px;">
<a href="http://www.jmzhaopin.com/hrservicedesktop/index.jsp" target="_blank">
<img src="${ctx }/cms/images/jmzp.png" width="220px" />
</a>
</div><div style="height:6px;clear:both;"></div>
</div>
					 
				</div>
				<div class="main_right">
					<div class="position">
						当前位置:
						<a href="${ctx }">首页</a> >

						<a href="${ctx }/cms!list.action?seqs=11"> 在线入会</a> >

						<a href="${ctx }/cms!list.action?seqs=14">个人会员申请</a> >
					</div>
					<Div class="list_article">
						<s:form action='/reg!reg.action' id="form1" method="post">
							<s:hidden name="member.type" value="1"></s:hidden>
							<table width="700" border=0 align="center" cellpadding=5
								cellspacing=1 bordercolor="#FFFFFF"
								style="border-collapse: collapse">
								<TR align=center>
									<TD height=20 colSpan=2>
										<b>新用户注册</b>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<b>姓名：</b>
										<BR>
											不能超过14个字符 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.name" maxlength="14" size="30">
										</s:textfield>
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<b>身份证：</b>
										<BR>
											不能超过18个字符 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.idcard" maxlength="18" size="30">
										</s:textfield>
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<b>用户名：</b>
										<BR>
											不能超过14个字符 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.username" maxlength="14" size="30">
										</s:textfield>
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<B>密码(至少6位)：</B>
										<BR>
											请输入密码，区分大小写。 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:password name="password1" id="password1" size="30" maxlength="14">
										</s:password>
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<strong>确认密码(至少6位)：</strong>
										<BR>
											请再输一遍确认 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:password name="password2" id="password2"size="30" maxlength="14" />
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<strong>密码问题：</strong>
										<BR>
											忘记密码的提示问题 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.question" size="30" maxlength="14" />

										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<strong>问题答案：</strong>
										<BR>
											忘记密码的提示问题答案，用于取回密码 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.answer" size="30" maxlength="14" />
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<strong>性别：</strong>
										<BR>
											请选择您的性别 
									</TD>
									<TD width="63%" class="index_text_zw">
										<INPUT type=radio CHECKED value="1" name="member.sex">
											男 &nbsp;&nbsp; <INPUT name="member.sex" type=radio
												class="index_text_zw" value="0">
												女 
									</TD>
								</TR>
								<TR class="tdbg">
									<TD width="37%" class="index_text_zw">
										<strong>Email地址：</strong>
										<BR>
											请输入有效的邮件地址 
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.email" size="30" maxlength="50" /><font color="#FF0000">*</font>
									</TD>
								</TR>

<%--								<TR class="tdbg">--%>
<%--									<TD class="index_text_zw">--%>
<%--										<strong>联系人：<br>--%>
<%--										</strong>主要的负责人--%>
<%--										<strong> </strong>--%>
<%--									</TD>--%>
<%--									<TD width="63%" class="index_text_zw">--%>
<%--										<///s:textfield name="member.connector" size="30" maxlength="50" />--%>
<%--									</TD>--%>
<%--								</TR>--%>
<s:hidden name="member.connector"></s:hidden>
								<TR class="tdbg">
									<TD class="index_text_zw">
										<strong>联系人手机：</strong>
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.mobile" size="30" maxlength="50" /><font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD class="index_text_zw">
										<strong>联系电话：<br>
										</strong>格式+86-0592-8888888
										<strong> </strong>
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.phone" size="30" maxlength="50" />
										<font color="#FF0000">*</font>
									</TD>
								</TR>
								<TR class="tdbg">
									<TD class="index_text_zw">
										<strong>联系传真：<br>
										</strong>格式+86-0592-8888888
										<strong> </strong>
									</TD>
									<TD width="63%" class="index_text_zw">
										<s:textfield name="member.fax" size="30" maxlength="50" />
										<font color="#FF0000">*</font>
									</TD>
								</TR>



							</TABLE>
							<div align="center">
								<INPUT type=submit value=" 注 册 " name=Submit2>
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