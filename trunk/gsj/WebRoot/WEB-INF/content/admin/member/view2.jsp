<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
	<script type="text/javascript"
		src="${ctx }/js/validate/jquery.validate.min.js"></script>
	<link href="${ctx }/js/validate/css/screen.css" rel="stylesheet"
		type="text/css" />
	<script type="text/javascript"
		src="${ctx }/js/kindeditor/kindeditor.js"></script>
	<script type="text/javascript"
		src="${ctx }/js/kindeditor/lang/zh_CN.js"></script>
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx }/js/framework.js"></script>
	<link href="${ctx }/css/import_basic.css" rel="stylesheet"
		type="text/css" />
	<link rel="stylesheet" type="text/css" id="skin" />
	<!--框架必需end-->
	<style>
table {
	font-size: ${
	c_font_size
}
;
}
</style>
	<!--多选框脚本start-->
	<script type="text/javascript" src="${ctx }/js/form/multiselect.js"></script>
	<!--多选框脚本end-->
 
	<body>
		<div id="scrollContent">
			<s:form action="member!check1.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="公司会员"
					showStatus="false" roller="true">
					 
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								用户名：
							</td>
							<td width="40%">
								${member.username }
							</td>
							<td  width="10%">
								性别：
							</td>
							<td>
								<c:if test="${member.sex=='1'}">男</c:if>
								<c:if test="${member.sex=='0'}">女</c:if>
							</td>
						</tr>
						<tr>
							<td>
								Email地址：
							</td>
							<td>
								${member.email }

							</td>
							<td>
								联系人：
							</td>
							<td>
								${member.connector }

							</td>

						</tr>
						<tr>
							<td>
								联系人手机：
							</td>
							<td>
								${member.mobile }

							</td>

							<td>
								联系电话：
							</td>
							<td>
								${member.phone }

							</td>

						</tr>
						<tr>
							<td>
								公司名称:
							</td>
							<td>
								${member.companyname }
							</td>
							<td>
								公司网址:
							</td>
							<td>
								${member.url }
							</td>
						</tr>
						<TR>
							<TD>

								公司地址：


							</TD>
							<TD>
								${member.address }
							</TD>
							<TD>
								单位性质：

							</TD>
							<TD>
								<c:if test="${member.kind==1}">国有企业</c:if>
								<c:if test="${member.kind==2}">私营企业</c:if>
								<c:if test="${member.kind==3}">事业单位</c:if>
								<c:if test="${member.kind==4}">中外合资</c:if>
								<c:if test="${member.kind==5}">其他</c:if>
							</TD>
						</TR>

						<TR>
							<TD>
								营业执照编号：

							</TD>
							<TD>
								${member.code }
							</TD>
							<TD>
								经营范围：
							</TD>
							<TD>
								${member.scope }
							</TD>
						</TR>
						<TR>
							<TD>
								法人代表：
							</TD>
							<TD>
								${member.faren }
							</TD>
							<TD>
								法人电话：
							</TD>
							<TD>
								${member.farenphone }
							</TD>
						</TR>
						<TR>
							<TD>
								法人手机：
							</TD>
							<TD colspan="3">
								${member.farenmobile }
							</TD>
						</TR>
						 
<tr>
							<td>
								审核历史：
							</td>
							<td  colspan="3">
								<ul>
								<c:forEach var="item" items="${member.checks}">
									<li>审核人：${item.username } | 意见:${item.opinion } | <c:if test="${item.state==2}">通过</c:if><c:if test="${item.state==3}">不通过</c:if></li>
								</c:forEach>
								</ul>

							</td>

						</tr>
						<tr>
							<td colspan="4" align="center">
								 
								<input type="button" value=" 后 退 "
									onclick="javascript:history.back();" />
							</td>
						</tr>
					</table>
				</div>
			</s:form>
		</div>
	</body>
</html>