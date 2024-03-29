<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/BtnMultiTag" prefix="bm"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/list.js"></script>
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
	<script type="text/javascript" src="${ctx }/js/framework.js"></script>
	<link href="${ctx }/css/import_basic.css" rel="stylesheet"
		type="text/css" />

	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=request.getContextPath()%>/" />
	<!--框架必需end-->

	<style>
table {
	font-size: ${c_font_size};
}
</style>
<script>

</script>
	<body>
		<div class="x" panelTitle="用户信息" showStatus="false">
			<table width="95%">
				<tr> 
<s:form action="user!list.action">
						<td>
							用户名：		 
							<s:textfield name="username"></s:textfield>
						 
							 <input type="submit" value="查 询"/>
							 
						</td>

					</s:form>
				</tr>
				<tr>
					<td colspan="7" >
						<bm:show />
					</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="tableStyle" useColor="false" useHover="false"
				useClick="false">
				<tr>
					<th>
						<input type="checkbox" id="CHECK_SELECT_ALL" />
					</th>
					<th>
						姓名
					</th>
					<th>
						真实姓名
					</th>
					 
					 
					<th>
						状态
					</th>
					<th>
						最近登录时间
					</th>
				 
				</tr>
				<form id="list_entity_form" name="list_entity_form" method="post" >
				<s:hidden name="id" id="list_entity_id"></s:hidden>
				<c:forEach items="${page.result}" var="item">
					<tr>
						<td>
							<input type="checkbox" name="ids" value="${item.id }" />
						</td>
						<td>
							${item.username }
						</td>
						<td>
							${item.realname }
						</td>
						 
						 
						<td>
							<c:choose>
								<c:when test="${item.state==1 }">有效</c:when>
								<c:otherwise>无效</c:otherwise>
							</c:choose>
						</td>
						<td>
							 <fmt:formatDate value="${item.lastLoginTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
						</td>
					</tr>
				</c:forEach>
				</form>
			</table>
		</div>


		<div style="height: 35px;"> 
					 ${pageUtils } 
		</div>

	</body>