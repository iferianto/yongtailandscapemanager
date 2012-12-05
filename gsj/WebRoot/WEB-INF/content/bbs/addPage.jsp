<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctx" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">

	<head>

		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

		<title>发表主题</title>

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
					allowFileManager : false
				});
			});
		});
	});

	function checkform(){
		var title=document.getElementById('title').value;
		if(title==null||title==''){
			alert('标题不能为空');
			return false;
		}
		 

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
				<div class="main_left" style="width: 130px;">
					 
			<%@ include file="/cms/bbsleft.jsp"%>

				</div>
				<div class="main_right" style="width: 815px;">
					<div class="position">
						<table width="100%">
							<tr>
								<td valign="center" width="80%">
									当前位置:
									<a href="${ctx }">首页</a> >
									<a href="${ctx }/bbs">论坛首页</a> >
									<c:if test="${not empty forum}">
									<a href="${ctx }/bbs!list.action?seqs=${forum.id}">${forum.name }</a>>
									</c:if>
									<a href="#nogo">发表主题</a>
								</td>

							</tr>
						</table>
					</div>
					<Div class="list_article">
						<form action="${ctx }/bbs!add.action" method="post" onsubmit="return checkform();">
							<table width="100%">
							<tr>
									<td width="10%" align="right">
									
										版 块:
									</td>
									<td>
										<select name="seqs">
											<c:forEach items="${bbs}" var="item">
											<option value="${item.id }" <c:if test="${item.id==forum.id}">selected</c:if>>
											${item.name }
											</option>
											</c:forEach>
										</select>
									</td>
								</tr>
								<tr>
									<td width="10%" align="right">
										标 题:
									</td>
									<td>
										<input type="text" name="title" id="title" style="width: 80%" />
									</td>
								</tr>
								<tr>
									<td width="10%" align="right">
										内 容:
									</td>
									<td>
										<textarea style="width: 95%; height: 300px" name="content"
											id="content"></textarea>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="center">
										<input type="submit" value="发表" />

										<input type="reset" value="重置" />

									</td>
								</tr>
							</table>
							
						<input type="hidden" name="userid" value="${MEMBER_USER.id }"/>
						<input type="hidden" name="username" value="${MEMBER_USER.username }"/>
						</form>
					</Div>
					<div class="page_list">

					</div>
				</div>
			</div>
			<!--main end -->


			<%@ include file="/cms/footer.jsp"%>






		</div>

		<!--foot end -->



		</div>



	</body>

</html>