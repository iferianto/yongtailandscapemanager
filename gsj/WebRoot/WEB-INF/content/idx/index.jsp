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

		<title></title>

		<meta name="description" content="" />

		<meta name="keywords" content="" />

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

window.onload=function(){

	var err='${err}';
	if(err=='1'){
		alert('登录失败，用户名或密码错误');
	}
}
</script>


	</head>

	<body>

		<div class="container">

			<%@ include file="/cms/header.jsp"%>
			<!--head end -->

			<div id="main">

				<div class="right f_l">

					<div class="index_news">

						<div class="flash f_l" style="border: 1px solid #eee;">

							<script language='javascript'>

linkarr = new Array();

picarr = new Array();

var swf_width=345;

var swf_height=215;

var files = "";

var links = "";

var texts = "";

//这里设置调用标记

//这里设置调用标记
<c:forEach var="item" items="${ppt}" varStatus="i" >

linkarr[${i.index+1}] = "${ctx}/cms!detail.action?seqs=${item.content.id}";//第一张图片的链接，若是不需要则用#代替

picarr[${i.index+1}]  = "${ctx }${item.imgurl}";//第一张图片的路径，必填且填写正确
  

</c:forEach>

for(i=1;i<picarr.length;i++){

  if(files=="") files = picarr[i];

  else files += "|"+picarr[i];

}

for(i=1;i<linkarr.length;i++){

  if(links=="") links = linkarr[i];

  else links += "|"+linkarr[i];

}
 
document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');

document.write('<param name="movie" value="${ctx }/cms/images/bcastr3.swf"><param name="quality" value="high">');

document.write('<param name="menu" value="false"><param name=wmode value="opaque">');

document.write('<param name="FlashVars" value="bcastr_file='+files+'&bcastr_link='+links+'&bcastr_title='+texts+'">');

document.write('<embed src="${ctx }/cms/images/bcastr3.swf" wmode="opaque" FlashVars="bcastr_file='+files+'&bcastr_link='+links+'&bcastr_title='+texts+'& menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); document.write('</object>');

</script>

						</div>

						<div class="news f_r">
							<div class="t"
								style="padding-left: 12px; font-weight: 600; color: #fff; line-height: 28px;">
								<span style="float: right; color: #333; padding-right: 12px;"><a
									style="color: #fff;" href="${ctx }/cms!listAll.action">更多>></a>
								</span>最新资讯
							</div>

							<div class="m">
								<ul>
									<c:forEach items="${newest }" var="item">
										<li>
											<span> <fmt:formatDate value="${item.pubdate}" /> </span>
											<a href='${ctx }/cms!detail.action?seqs=${item.id}'
												title="${item.title }" target="_blank"> <c:if
													test="${fn:length(item.title) > 19}">
													<c:out value="${fn:substring(item.title, 0, 19)}..." />
												</c:if> <c:if test="${fn:length(item.title) <= 19}">
												${item.title }</c:if> </a>
										</li>
									</c:forEach>
								</ul>
							</div>

							<div class="index_more">
								<%--																<a href="#">更多 >></a>--%>
							</div>



							<div class="b"></div>

						</div>

					</div>

					<!--index_news -->


					<div style="clear: both; height: 175px;">
						<Div
							style="height: 28px; line-height: 28px; padding-left: 15px; background: #07ABE9; color: #fff; font-size: 15px;">
							<b> <span
								style="float: right; color: #333; padding-right: 12px;">
									<a href="${ ctx}/cms!list.action?seqs=35" style="color: #fff;">更多>></a>
							</span> <a href="${ ctx}/cms!list.action?seqs=35" style="color: #fff;">
									景区介绍 </a> </b>
						</Div>
						<div class="rollBox1">
							<div style="height: 12px; clear: both;"></div>
							<style>
.pic_list {
	width: 125px;
	height: 90px;
	padding: 2px;
	float: left;
	border: 1px solid #ddd;
	text-align: center;
	padding-top: 2px;
}

.pic_list img {
	
}

.pic_blist {
	width: 125px;
	height: 90px;
	float: left;
	padding-left: 5px;
	padding-right: 4px;
}
</style>
						<marquee onmouseover="this.stop()" onmouseout="this.start()"
								scrollamount='5'>  	<table width="100%">
								<tr>
									 <c:forEach items="${jqjsPhotos}"
										var="item" varStatus="i"><td>
										<div class="pic_list" >
											<a href="${ctx }/cms!detail.action?seqs=${item.content.id}"
												title="${item.title }" target="_blank"> <img
													src="${ctx }${item.imgurl}" width="125px" height="90px" />
											</a>
								
										</div>
										 
										</td>
								</c:forEach>
								</tr>
								<tr>
								 <c:forEach items="${jqjsPhotos}"
										var="item" varStatus="i"><td>
										 
										<div
											style="text-align: center; height: 25px; line-height: 25px;">
											<a style="font-size: 12px"
												href="${ctx }/cms!detail.action?seqs=${item.content.id}"
												title="${item.title }" target="_blank"> <c:if
													test="${not empty item.title}">
													<c:if test="${fn:length(item.title) > 9}">
														<c:out value="${fn:substring(item.title, 0, 9)}..." />
													</c:if>
													<c:if test="${fn:length(item.title) <= 9}">
												${item.title }</c:if>
												</c:if> <c:if test="${empty item.title}">
									景区介绍
									 </c:if> </a>


										</div>
										</td>
								</c:forEach>
								</tr>
							</table>
							<!-- 图片列表 begin -->
							
							 
									 </marquee>
							<!-- 图片列表 end -->

							<Div style="clear: both;"></Div>
						</div>
						<Div style="clear: both;"></Div>
					</div>

					<div class=" clear index_class">




						<div class="box358x174 rsdl f_l">
							<div
								style="padding-left: 160px; padding-top: 10px; font-size: 15px; font-weight: 600; color: #0072A8;">
								<span style="float: right; color: #333; padding-right: 12px;">
									<a href="${ ctx}/cms!list.action?seqs=35"
									style="color: #0072A8;">更多>></a>
								</span>
								<a href="${ ctx}/cms!list.action?seqs=35"
									style="color: #0072A8;"> 景区介绍 </a>
							</div>
							<div class="index_info">
								<ul>
									<c:forEach items="${jqjsnews }" var="item">
										<li>
											<a href='${ctx }/cms!detail.action?seqs=${item.id}'
												title="${item.title }" target="_blank"> <c:if
													test="${fn:length(item.title) > 15}">
													<c:out value="${fn:substring(item.title, 0, 15)}..." />
												</c:if> <c:if test="${fn:length(item.title) <= 15}">
												${item.title }</c:if> </a>
										</li>
									</c:forEach>

								</ul>
							</div>



						</div>

						<div class="box356x174 hkdl f_r">
							<div
								style="padding-left: 160px; padding-top: 10px; font-size: 15px; font-weight: 600; color: #0072A8;">
								<span style="float: right; color: #333; padding-right: 12px;">
									<a href="${ ctx}/cms!list.action?seqs=40"
									style="color: #0072A8;">更多>></a>
								</span>
								<a href="${ ctx}/cms!list.action?seqs=40"
									style="color: #0072A8;"> 服务指南 </a>
							</div>
							<div class="index_info">
								<ul>
									<c:forEach items="${tsznnews }" var="item">
										<li>
											<a href='${ctx }/cms!detail.action?seqs=${item.id}'
												title="${item.title }" target="_blank"> <c:if
													test="${fn:length(item.title) > 15}">
													<c:out value="${fn:substring(item.title, 0, 15)}..." />
												</c:if> <c:if test="${fn:length(item.title) <= 15}">
													${item.title }</c:if> </a>
										</li>
									</c:forEach>

								</ul>
							</div>



						</div>
						<div class="clear"></div>
						<div>
							<fieldset style="height: 210px;">
								<legend>
									在线办事
								</legend>

								<table width="100%" cellspacing="0" cellpadding="0" border="0">
									<tbody>
										<tr>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=NZ')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_nzqydj.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																内资企业登记
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=WZ')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_wzqydj.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																外资企业登记
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=GT')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_gagtdj.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																港澳居民个体工商登记
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=NJ')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_wsnj.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																网上年检服务
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=SP')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_splt.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																食品流通许可证业务申请
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=GG')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_gggl.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																广告管理
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
										<tr>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=HT')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_htgl.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																合同管理
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=LOGON&amp;TYPE=SC')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_scgl.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																市场管理
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick=" ;alert('网上工商，系统子模块，正在建设中！');"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_sbgl.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																商标管理
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="82%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://www.fj12315.gov.cn/ncindex.aspx')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_12315.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																12315消费维权
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick=" ;alert('网上工商，系统子模块，正在建设中！');"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_wswt.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																网上委托检验
															</td>
														</tr>
													</tbody>
												</table>
											</td>
											<td align="center" class="zxfw_td">
												<table width="80%" height="81" cellspacing="0"
													cellpadding="0" border="0">
													<tbody>
														<tr>
															<td valign="middle" height="50" align="center">
																<img style="cursor: hand;"
																	onclick="openUrl('http://wsgs.fjaic.gov.cn/WSGS_QYBSDT/HttpChannel?action=WQXX_WQJBCX_QUERY_INIT')"
																	src="http://www.fz.fjaic.gov.cn/fastcms/styles/cms/images/gshd-index/home_zxfw_wfjb.gif">
															</td>
														</tr>
														<tr>
															<td valign="top" height="31" align="center"
																style="font-size: 12px;">
																经济违法违章举报
															</td>
														</tr>
													</tbody>
												</table>
											</td>
										</tr>
									</tbody>
								</table>
							</fieldset>
						</div>
					</div>
					<div class="clear index_class">
					</div>

					<div id="link">

					</div>


					<!--link end -->

				</div>

				<!--left end -->

				<div class="left f_r">

					<div class="about">

						<div class="main_left_tit1">
							会员登录
						</div>

						<div class="m">

							<div class="info">

								<p style="text-indent: 25px">
									<c:if test="${empty SESSION_USER}">
										<form action="${ctx }/index!login.action" method="post">
											<table>
												<tr>
													<td align="right">
														用户名：
													</td>
													<td>
														<input type="text" name="username"
															style="width: 120px; height: 20px;" />
													</td>
												</tr>
												<tr>
													<td align="right">
														密 码：
													</td>
													<td>
														<input type="password" name="password"
															style="width: 120px; height: 20px;" />
													</td>
												</tr>
												<tr>
													<td></td>
													<td>
														<input type="submit" value="登录" />
														<input type="reset" value="重置" />
													</td>
												</tr>
											</table>
										</form>
									</c:if>
									<div style="text-align: center; letter-spacing: 2px">
										<c:if test="${not empty SESSION_USER}">
									欢迎您:<span style="color: red;">${SESSION_USER.username }</span>

											<br />
											<a style="color: red;" href="${ctx }/system/index.action">
												进入后台</a>
											<br />
											我要<a style="color: red;" href="${ctx }/index!logout.action">退出</a>
									</div>
									</c:if>
								</p>
							</div>


						</div>

						<div class="b"></div>

					</div>
					<div class="contact p_t_5">
						<div>

							<a href="http://www.fjaic.gov.cn/" target="_blank"> <img
									src="${ctx }/cms/images/link_images2.gif" width="222px"
									height="60px" /> </a>
						</div>
						<div>
							<a href="http://www.fz.fjaic.gov.cn" target="_blank"> <img
									src="${ctx }/cms/images/11.gif" width="222px" /> </a>
						</div>
					</div>
					<div style="height: 155px; width:100%; ">

						<div class="main_left_tit1" >
							<span style="float: right; color: #333; padding-right: 12px;">
								<a href="${ ctx}/cms!list.action?seqs=23" style="color: #fff;">更多>></a>
							</span>
							<a href="${ ctx}/cms!list.action?seqs=23" style="color: #fff;">
								法律法规 </a>
						</div>

						<div CLASS="am" 
							style="margin-top: 0px; border: 1px solid #ddd; width:100%;  width:219px;   height: 138px; ">

							<ul>
								<c:forEach items="${fvfgnews }" var="item">
									<li>
										<a href='${ctx }/cms!detail.action?seqs=${item.id}'
											title="${item.title }" target="_blank"> <c:if
												test="${fn:length(item.title) > 14}">
												<c:out value="${fn:substring(item.title, 0, 14)}..." />
											</c:if> <c:if test="${fn:length(item.title) <= 14}">
												${item.title }</c:if> </a>
									</li>
								</c:forEach>
							</ul>
						</div>

					</div>

					<div class="b"></div>
					<!--about end -->



					<div class="contact p_t_5" style="height: 155px">

						<div class="main_left_tit1">
							<span style="float: right; color: #333; padding-right: 12px;">
								<a href="${ ctx}/cms!list.action?seqs=24" style="color: #fff;">更多>></a>
							</span>
							<a href="${ ctx}/cms!list.action?seqs=24" style="color: #fff;">
								工商政策 </a>
						</div>

						<div class="am"
							style="margin-top: 0px; border: 1px solid #ddd;   width: 216px; height: 138px;">

							<ul>
								<c:forEach items="${gszcnews }" var="item">
									<li>
										<a href='${ctx }/cms!detail.action?seqs=${item.id}'
											title="${item.title }" target="_blank"> <c:if
												test="${fn:length(item.title) > 14}">
												<c:out value="${fn:substring(item.title, 0, 14)}..." />
											</c:if> <c:if test="${fn:length(item.title) <= 14}">
												${item.title }</c:if> </a>
									</li>
								</c:forEach>
							</ul>
						</div>

					</div>

					<div class="b"></div>
					<!--contact end -->

					<div class="contact p_t_5" style="height: 155px">

						<div class="main_left_tit1">
							<span style="float: right; color: #333; padding-right: 12px;">
								<a href="${ ctx}/cms!list.action?seqs=25" style="color: #fff;">更多>></a>
							</span>
							<a href="${ ctx}/cms!list.action?seqs=25" style="color: #fff;">
								政府文件 </a>
						</div>

						<div class="am"
							style="margin-top: 0px; border: 1px solid #ddd;  width: 219px; height: 138px;">

							<ul>
								<c:forEach items="${zfwjnews }" var="item">
									<li>
										<a href='${ctx }/cms!detail.action?seqs=${item.id}'
											title="${item.title }" target="_blank"> <c:if
												test="${fn:length(item.title) > 14}">
												<c:out value="${fn:substring(item.title, 0, 14)}..." />
											</c:if> <c:if test="${fn:length(item.title) <= 14}">
												${item.title }</c:if> </a>
									</li>
								</c:forEach>
							</ul>
						</div>

					</div>
				</div>

				<!--ask end-->
			</div>

			<!--right end -->

			<!--main end -->


			<div class="link1">

				<div class="t"></div>

				<div class="m">

					<div class="p_h10_v5" style="border: 1px solid #eee;">
						<c:forEach items="${flinks}" var="item">
							<a href='${item.url }' target='_blank'>${item.name }</a>

						</c:forEach>

					</div>

				</div>

				<div class="b"></div>

			</div>

			<%@ include file="/cms/footer.jsp"%>

		</div>

		<!--foot end -->
		</div>

	</body>
	<script>
function openUrl(url){
	window.location.href=url;
} 
</script>

</html>