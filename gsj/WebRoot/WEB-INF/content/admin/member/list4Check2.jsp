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
		<div class="box2" panelTitle="待审核公司会员" roller="false"
			showStatus="false">
			<table width="95%">
				<tr>

				</tr>
				<tr>
					<td colspan="7">
						<input type='button' value='审核'
							onclick="doPermission({'url':'/admin/member!checkPage2.action','opeCount':'1','msgBoxType':'1'})" />

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
						用户名
					</th>
					<th  >
						公司名称
					</th>
					<th>
						 地址
					</th>
					<th >
						类型
					</th>
					<th >
						法人代表
					</th>
					<th >
						法人电话
					</th>
					<th >
						法人手机
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
								${item.username }
							</td>
							<td>
								${item.companyname }
							</td>
							<td>
								${item.address }
							</td>
							<td>
							<c:if test="${item.kind==1}">国企</c:if>
								<c:if test="${item.kind==2}">私营</c:if>
								<c:if test="${item.kind==3}">事业单位</c:if>
								<c:if test="${item.kind==4}">中外合资</c:if>
								<c:if test="${item.kind==5}">其它</c:if>
							</td>
							<td>
								${item.faren }
							</td>
							<td>
								${item.farenphone }
							</td>
							<td>
								${item.farenmobile }
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