<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<%
request.setAttribute("now", new Date());
%>
 <div id="head">

			 <div style=" width:959px; height:110px; margin:0; padding:0;">
  
<%--    <div class="topinfo">--%>
<%--    <a style="PADDING-RIGHT:15px"href="#nogo"  id="UserControls_System_public_SWPUC_HomePageOrFavorites1_aHomePage" onclick="this.style.behavior='url(#default#homepage)';this.setHomePage('#');">设为首页</a>--%>
<%--     <a href="javascript:window.external.Addfavorite('#','')"  id="UserControls_System_public_SWPUC_HomePageOrFavorites1_aFavorites">加入收藏</a>--%>
<%--</div>--%>
  
   </div>
<div style="float:right;"></div>

				<div class="nav">
					<ul id="navigation">
						<li onmouseover="displaySubMenu(this)"
							onmouseout="hideSubMenu(this)">
							<a href="${ctx }/index!index.action"><b>首 页</b>
							</a>
						</li>
						<li onmouseover="displaySubMenu(this)"
							onmouseout="hideSubMenu(this)">
							<a href="${ctx }/cms!list.action?seqs=22"><b>政策法规</b>
							</a>
							<ul>
								<li>
									<a href="${ctx }/cms!list.action?seqs=23">法律法规</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=24">工商政策</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=25">政府文件</a>
								</li>
							</ul>
						</li> 
<%--						<li onmouseover="displaySubMenu(this)"--%>
<%--							onmouseout="hideSubMenu(this)">--%>
<%--							<a href="${ctx }/cms!list.action?seqs=26"><b>巡查监管</b>--%>
<%--							</a>--%>
<%--							<ul>--%>
<%--								<li>--%>
<%--									<a href="${ctx }/cms!list.action?seqs=27">巡查反馈</a>--%>
<%--								</li>--%>
<%--								<li>--%>
<%--									<a href="${ctx }/cms!list.action?seqs=28">整改提示</a>--%>
<%--								</li>--%>
<%--								<li>--%>
<%--									<a href="${ctx }/cms!list.action?seqs=29">整改反馈</a>--%>
<%--								</li><li>--%>
<%--									<a href="${ctx }/cms!crelist.action?seqs=29">信用评分体系</a>--%>
<%--								</li>--%>
<%--							</ul>--%>
<%--						</li> --%>
						<li onmouseover="displaySubMenu(this)"
							onmouseout="hideSubMenu(this)">
							<a href="${ctx }/cms!list.action?seqs=30"><b>消费维权</b>
							</a>
							<ul>
								<li>
									<a href="${ctx }/cms!list.action?seqs=31">在线投诉</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=32">电话投诉</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=33">消费警示</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=34">消费提示</a>
								</li>
							</ul>
						</li>
						<li onmouseover="displaySubMenu(this)"
							onmouseout="hideSubMenu(this)">
							<a href="${ctx }/cms!list.action?seqs=35"><b>景区介绍</b>
							</a>
							<ul>
								<li>
									<a href="${ctx }/cms!list.action?seqs=36">景区介绍</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=37">联系方式</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=38">服务授权网络</a>
								</li>
<%--								<li>--%>
<%--									<a href="${ctx }/cms!list.action?seqs=39">景区客服答疑</a>--%>
<%--								</li> --%>
							</ul>
						</li>
						<li onmouseover="displaySubMenu(this)"
							onmouseout="hideSubMenu(this)">
							<a href="${ctx }/cms!list.action?seqs=40"><b>服务指南</b>
							</a>
							<ul>
								<li>
									<a href="${ctx }/cms!list.action?seqs=41">联系方式</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=42">出行建议</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=43">景区分类图</a>
								</li>
								<li>
									<a href="${ctx }/cms!list.action?seqs=44">旅游产品</a>
								</li> <li>
									<a href="${ctx }/cms!list.action?seqs=45">公交线路</a>
								</li> <li>
									<a href="${ctx }/cms!list.action?seqs=46">天气预报</a>
								</li> 
							</ul>
						</li>
						<li style="float: right;color: #fff;padding-right: 10px">
							<fmt:formatDate value="${now}" pattern="yyyy年MM月dd日 E"/> 欢迎访问本网站
						
						</li>
					</ul>

				</div>


			</div>