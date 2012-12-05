<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" /
 <table width="100%">
							<tr>
								<td valign="center" width="80%">
									当前位置:
									<a href="${ctx }">首页</a> >
									<a href="${ctx }/bbs">论坛首页</a>
								</td>
								<td valign="center" align="right">
								<a href="${ctx }/bbs!addPage.action">发表主题</a>&nbsp;&nbsp;&nbsp;&nbsp;
								</td>
							</tr>
						</table>