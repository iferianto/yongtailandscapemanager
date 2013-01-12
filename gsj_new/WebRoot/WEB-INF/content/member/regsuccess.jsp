<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

<head>

<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

<title>文章列表页面设计</title>

<meta name="description" content="" />

<meta name="keywords" content="" />

<link href="${ctx }/cms/css/css.css" rel="stylesheet" type="text/css" />

<meta name="google-site-verification" content="s2DfhdRTF2H-DUujgtPfxurIHOQ_4PQq45EUpUDXD4Q" />

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
<style>.info ul li{line-height:23px;height:23px;}.info{border:1px solid #ddd;}</style>
  <div id="main">
<div class="main_left">
<div class="main_left_tit1">最新资讯</div>
<div class="info" id="info">

            <ul>

          <c:forEach items="${newest }" var="item">
								<li>
									<img src="${ctx }/cms/images/_icon02.gif"/>
									<a href='${ctx }/cms!detail.action?seqs=${item.id}' title="${item.title }"> 
									<c:if
											test="${fn:length(item.title) > 13}">
											<c:out value="${fn:substring(item.title, 0, 13)}..." />
										</c:if> <c:if test="${fn:length(item.title) <= 13}">
												${item.title }</c:if> </a>
								</li>
							</c:forEach>
         
          </ul><div style="height:6px;clear:both;"></div>
</div>
<div style="height:8px;clear:both;"></div>
 
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
<div class="position">当前位置:
						<a href="${ctx }">首页</a> >
						<c:if test="${ not empty contentType.parent}">
							<a href="${ctx }/cms!list.action?seqs=${contentType.parent.id}">${contentType.parent.name
								}</a> >
						 	</c:if>
						<a href="${ctx }/cms!list.action?seqs=${contentType.id}">${contentType.name
							}</a> ></div>
<Div class="list_article">
 <c:if test="${state==1}">
							<p style="width:100%;text-align: center;">
								注册成功，您的注册用户名是：${member.username }
							</p>
							<p style="width:100%;text-align: center;">
								<a href="${ctx }">返回首页</a>
							</p>
						</c:if>
						<c:if test="${state==2}">
							<p style="width:100%;text-align: center;">
								${error }
							</p>
							<p style="width:100%;text-align: center;">
								<a href="#nogo" onclick="javascript: history.back();">点此返回上一页</a>
							</p>
						</c:if>
						<c:if test="${state==3}">
							<p style="width:100%;text-align: center;">
								您没有登录，无法查看，请<a href="${ ctx}/">登录</a>
							</p>
							<p style="width:100%;text-align: center;">
								<a href="#nogo" onclick="javascript: history.back();">点此返回上一页</a>
							</p>
						</c:if>
</Div>
<div class="page_list">
<ul>
 
</ul>
</div>
</div>
    </div>   
  <!--main end -->

  <%@ include file="/cms/footer.jsp" %> 







</div>

<!--foot end -->



 </div>



</body>

</html>