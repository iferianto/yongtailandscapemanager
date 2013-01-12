<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />

		<title>论坛详细页面</title>

		<meta name="description" content="" />

		<meta name="keywords" content="" />

		<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
		<script type="text/javascript"
			src="${ctx }/js/kindeditor/kindeditor.js"></script>
		<script type="text/javascript"
			src="${ctx }/js/kindeditor/lang/zh_CN.js"></script>
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
	$().ready(function() {

		var editor;
		$().ready(function() {

			KindEditor.ready(function(K) {
				editor = K.create('textarea[name="content"]', {
					resizeType : 1,
					allowPreviewEmoticons : true,
					uploadJson : '${ctx}/js/kindeditor/jsp/upload_json.jsp',
					//fileManagerJson : '${ctx}/js/kindeditor/jsp/file_manager_json.jsp',
					allowFileManager : false,
					items : [
         						'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor', 'bold', 'italic', 'underline',
       						'removeformat', '|', 'justifyleft', 'justifycenter', 'justifyright', 'insertorderedlist',
       						'insertunorderedlist', '|', 'emoticons', 'image', 'link']
					        					
				});
			});
		});
	});
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
				<div class="position">

					当前位置:
					<a href="${ctx }">首页</a> >
					<a href="${ctx }/bbs">论坛首页</a> > 
						<a href="${ctx }/bbs!list.action?seqs=${thread.forums.id}">${thread.forumsname}</a> >
									 
					<a href="#nogo">${thread.title }</a>
				</div>
				<div class="forum_first">
					<div class="forum_photo">
						<img src="${ctx }/cms/images/noavatar_small.gif" />
					</div>
					<div class="forum_title">
						<strong style="height: 25px; line-height: 25px; font-size: 15px;">${forum.name}</strong>
						<br />
						<div
							style="height: 25px; line-height: 25px; border-bottom: 1px dashed #eee;">
							楼主${thread.creatorname} &nbsp;&nbsp; 时间：<fmt:formatDate value="${thread.createdate}"/>
						</div>
						<div class="forum_content">
							 ${thread.content }
							 </div>

					</div>
					<div style="clear: both;"></div>
				</div>
	<c:forEach items="${page.result}" var="item" varStatus="i">
				<div class="reply">
					<div class="forum_photo">
						<img src="${ctx }/cms/images/noavatar_small.gif" />
					</div>
					<Div class="forum_replier">
						<div style="height: 25px; line-height: 25px;">
							${(pageNo-1)*pageSize+i.index+2 }楼:${item.creatorname } &nbsp;&nbsp;时间：<fmt:formatDate value="${item.createdate}"/>
						</div>
						<div style="font-size: 14px;">
							${item.content }
						</div>
					</Div>
					<div style="clear: both;"></div>
				</div>
				</c:forEach>

				<div class="page_list" style="width: 600px;">
					<ul>
					${pageUtils }
					</ul>
				</div>
				<div style="clear: both;"></div>
				<div style="padding-left: 73px;">
					<form action="${ctx }/bbs!reply.action?seqs=${thread.id}" method="post">
						<textarea style="height: 130px; width: 80%;" name="content"></textarea>
						<br />
						<input type="submit" name="submit" value="回复"
							style="height: 25px; width: 50px;" />
					</form>
				</div>


			</div>
			<!--main end -->
			<%@ include file="/cms/footer.jsp"%>
		</div>

		<!--foot end -->



		</div>



	</body>

</html>