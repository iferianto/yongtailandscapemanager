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
	font-size: ${
	c_font_size
}
;
}
</style>

	<body>
		<div class="box2" panelTitle="论坛主题列表" roller="false"
			showStatus="false">
			<table width="95%">
				<tr>

				</tr>
				<tr>
					<td colspan="7">
						 
						<input type='button' value='查看'
							onclick="doPermission({'url':'/admin/threads!view.action','opeCount':'1','msgBoxType':'1'})" />
					 <input type='button' value='删除'
							onclick="doPermission({'url':'/admin/threads!delete.action','opeCount':'2','msgBoxType':'2'})" />
					</td>
				</tr>
			</table>
			<div>
			<table class="tableStyle" useColor="false" useHover="false"
				useClick="false">
				<tr>
					<th width="3%">
						<input type="checkbox" id="CHECK_SELECT_ALL" />
					</th>
					<th>
						标题
					</th>
					<th  >
						板块
					</th>
					<th>
						回复数
					</th> 
					<th>
						发表人
					</th> 

				</tr>
				<form id="list_entity_form" name="list_entity_form" method="post">
					<s:hidden name="id" id="list_entity_id"></s:hidden>
					<c:forEach items="${page.result}" var="item">
						<tr>
							<td>
								<input type="checkbox" name="ids" value="${item.id }" />
							</td>
							<td>
							<c:if
													test="${fn:length(item.title) > 20}">
													<c:out value="${fn:substring(item.title, 0, 20)}..." />
												</c:if> <c:if test="${fn:length(item.title) <= 20}">
												${item.title }</c:if>
							</td>
						 
							<td>
								${item.forumsname}
							</td>
							<td>
								${item.replys }
							</td> 
							<td>
								${item.creatorname }
							</td> 
						</tr>
					</c:forEach>
				</form>
			</table>
		</div>
		
		<div style="height: 35px;">
			${pageUtils }
		</div>
		</div>
		



	</body>