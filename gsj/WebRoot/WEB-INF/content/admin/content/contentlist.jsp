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
		<div class="box2" panelTitle="信息列表" roller="false"
			showStatus="false">
			<table width="95%">
				<tr>
					<s:form action="content!list.action" id="searchForm">
						<td>
							标题：
							<s:textfield name="title"  cssClass="default"></s:textfield>
							<s:hidden name="typeId"></s:hidden>
							栏目：
						<select  class="default" disabled="disabled">
<c:forEach items="${types}" var="item">
									<option value="${item.id }"
										<c:if test="${item.id==typeId}">selected</c:if>>
										<c:if test="${not empty item.parent     }">---</c:if>${item.name }
									</option>
								</c:forEach></select>
							<input type="submit" value="查 询" />
						</td>

					</s:form>
				</tr>
				<tr>
					<td colspan="7">
						<input type='button' value='新增'
							onclick="doPermission({'url':'/admin/content!addPage.action?typeId=${typeId}','opeCount':'0','msgBoxType':'1'})" />
						<input type='button' value='修改'
							onclick="doPermission({'url':'/admin/content!editPage.action?typeId=${typeId}','opeCount':'1','msgBoxType':'1'})" />
						<input type='button' value='删除'
							onclick="doPermission({'url':'/admin/content!delete.action?typeId=${typeId}','opeCount':'2','msgBoxType':'2'})" />

					</td>
				</tr>
			</table>
		</div>
		<div>
			<table class="tableStyle" useColor="false" useHover="false"
				useClick="false">
				<tr>
					<th width="3%">
						<input type="checkbox" id="CHECK_SELECT_ALL" />
					</th>
					<th>
						栏目
					</th>
					<th  width="50%">
						标题
					</th>
					<th>
						发布日期
					</th>
					<th width="10%">
						点击次数
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
								${item.typename }
							</td><td>
							<a href="${ctx }/cms!detail.action?seqs=${item.id}" target="_blank">
							<c:if
													test="${fn:length(item.title) > 15}">
													<c:out value="${fn:substring(item.title, 0, 15)}..." />
												</c:if> <c:if test="${fn:length(item.title) <= 15}">
												${item.title }</c:if>  
												</a>
							</td>
							<td>
								<fmt:formatDate value="${item.pubdate }" pattern="yyyy-MM-dd"/>
							</td>
							<td>

								${item.click }
								 
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