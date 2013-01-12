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
		<div class="box2" panelTitle="新闻栏目管理" roller="false"
			showStatus="false">
			<table width="95%">
				<tr>
					<s:form action="content-type!list.action" id="searchForm">
						<td>
							栏目名称：
							<s:textfield name="name"></s:textfield>
							<input type="submit" value="查 询" />
						</td>

					</s:form>
				</tr>
				<tr>
					<td colspan="7">
						<input type='button' value='新增'
							onclick="doPermission({'url':'/admin/content-type!addPage.action','opeCount':'0','msgBoxType':'1'})" />
						<input type='button' value='修改'
							onclick="doPermission({'url':'/admin/content-type!editPage.action','opeCount':'1','msgBoxType':'1'})" />
						<input type='button' value='删除'
							onclick="doPermission({'url':'/admin/content-type!delete.action','opeCount':'2','msgBoxType':'2'})" />

					</td>
				</tr>
			</table>
			<div>
			<table class="tableStyle" useColor="false" useHover="false"
				useClick="false">
				<tr>
					<th>
						<input type="checkbox" id="CHECK_SELECT_ALL" />
					</th>
					<th>
						栏目名称
					</th>
					<th>
						顺序号
					</th>
					<th>
						父栏目
					</th>
					<th>
						是否显示
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
								${item.name }
							</td>
							<td>
								${item.seq }
							</td>
							<td>
								${item.parentname }
							</td>

							<td>

								<c:if test="${item.hidden==1 }">显示 </c:if>
								<c:if test="${item.hidden==0 }">隐藏 </c:if>
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