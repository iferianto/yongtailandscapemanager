<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

		<title>${cre.name }</title>



		<link href="${ctx }/cms/css/css.css" rel="stylesheet" type="text/css" />

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
									<img src="${ctx }/cms/images/_icon02.gif" />
									<a href='${ctx }/cms!detail.action?seqs=${item.id}'
										title="${item.title }"> <c:if
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

					<div>

						<div>
							<a href="http://www.fz.fjaic.gov.cn" target="_blank"> <img
									src="${ctx }/cms/images/ytxgsj.gif" width="220px" /> </a>
						</div>
						<div style="padding-top: 5px;">
							<a href="http://www.fjaic.gov.cn/" target="_blank"> <img
									src="${ctx }/cms/images/link_images2.gif" width="222px"
									height="60px" />
							</a>
						</div>
						<div style="height: 6px; clear: both;"></div>
					</div>
				</div>
				<div class="main_right">
					<div class="position">
						当前位置:
						<a href="${ctx }">首页</a> > 企业信用体系 >
						<a href="#nogo">详细内容</a>
					</div>
					<Div class="list_article">


						<div class="article_detail">
						</div>
						<div class="article_content">
							<table width="700" border=0 align="center" cellpadding=5
								cellspacing=1 bordercolor="#FFFFFF"
								style="border-collapse: collapse">
								<TR align=center>
									<TD height=20 colSpan=2>
										<b>${cre.name }</b>
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>成立时间：</b>

									</TD>
									<TD width="63%"  >
										<fmt:formatDate value="${cre.creattime }" />
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>等级：</b>

									</TD>
									<TD width="63%" >
										${cre.grade }
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>总分：</b>

									</TD>
									<TD width="63%" >
										<fmt:formatNumber value="${cre.base+cre.add-cre.reduce+cre.auto+cre.credits }"></fmt:formatNumber>
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>基本分：</b>

									</TD>
									<TD width="63%" >
										<fmt:formatNumber value="${cre.base  }"></fmt:formatNumber>
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>加分：</b>

									</TD>
									<TD width="63%" >
										<fmt:formatNumber value="${cre.add  }"></fmt:formatNumber>
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>减分：</b>

									</TD>
									<TD width="63%" >
										<fmt:formatNumber value="${cre.reduce  }"></fmt:formatNumber>
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>成立年限加分：</b>

									</TD>
									<TD width="63%" >
										<fmt:formatNumber value="${cre.auto  }"></fmt:formatNumber>
									</TD>
								</TR>
								<TR >
									<TD width="37%" align="right">
										<b>	连续守法经营加分：</b>

									</TD>
									<TD width="63%" >
										<fmt:formatNumber value="${cre.credits  }"></fmt:formatNumber>
									</TD>
								</TR>
							</table>

						</div>

						<div class="article_detail">
							<p>
								来源： 福州市永泰工商局&nbsp;&nbsp;&nbsp;
							</p>
						</div>
					</Div>

				</div>
			</div>
			<!--main end -->







			<%@ include file="/cms/footer.jsp"%>







		</div>

		<!--foot end -->



		</div>



	</body>

</html>
