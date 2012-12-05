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
	font-size: ${ c_font_size
}
;
}
</style>
	<!--多选框脚本start-->
	<script type="text/javascript" src="${ctx }/js/form/multiselect.js"></script>
	<!--多选框脚本end-->

	<script>
$().ready(function() {
	$("#form1").validate({
		 rules: {
			 'content.title': "required" ,
			 'content.type.id':'required'
		 },
		 messages: {
			  'content.title': "标题不能为空" ,
			  'content.type.id': "栏目不能为空" 
		 }
	});
	
	var editor;
$().ready(function() {
	 
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="content.content"]', {
			resizeType : 1,
			allowPreviewEmoticons : true , 
			uploadJson : '${ctx}/js/kindeditor/jsp/upload_json.jsp',
			//fileManagerJson : '${ctx}/js/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : false
		}); 
	});
});
});

</script>
	<body>
		<div id="scrollContent">
			<s:form action="content!audit.action" id="form1"enctype="multipart/form-data">
				<div class="box2" panelWidth="100%" panelTitle="信息修改"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden>
					<s:hidden name="content.id"></s:hidden> 
					<table width="95%" class="tableStyle">
						<tr>
							<td width="15%" align="right">
								<font color="red">*</font>标题：
							</td>
							<td width="85%" colspan="3">
								${content.title }
							</td>

						</tr>
						<tr>
							<td align="right">
								描述：
							</td>
							<td colspan="3">
								${content.description }

							</td>
						</tr>
						<tr>
							<td align="right">
								关键字：
							</td>
							<td colspan="3">

								${content.keyword }


							</td>
						</tr>
						<tr>
							<td align="right">
								幻灯片标志：
							</td>
							<td colspan="3">
							<c:if test="${content.top==1}">显示在首页幻灯片</c:if>
							<c:if test="${content.top==0}">不显示在首页幻灯片</c:if>  （是否显示在首页幻灯片位置，需要添加图片）

							</td>
						</tr>
						<tr>
							<td align="right">
								栏目：
								
							</td>
							<td>
								${content.typename }
							</td>
							<td align="right">
								是否置顶：
							</td>
							<td>
							<c:if test="${content.top==1}">置顶</c:if>
							<c:if test="${content.top==0}">不置顶</c:if> 
						
							</td>

						</tr>
						<tr>
													<td nowrap align="right" width="10%">
														图片:
													</td>
													<td width="38%" colspan="3"> 
															<div id="files">
															 <c:forEach items="${photos}" var="item">
															 <li ><a href="${ctx }${item.imgurl}" target="_blank">${item.imgurl }点击查看</a> </li>
															 </c:forEach>
																 
				</div>
				<label id="photoMsg"></label>
													</td>

												</tr>
						<tr>
							<td  align="right">
								内容：
							</td>
							<td colspan="3">
								${content.content }
							</td>

						</tr>
						<tr>
							<td  align="right">
								审核结果：
							</td>
							<td colspan="3">
									<s:select name="audit" list="#{ '1':'审核通过','2':'审核不通过' }" cssClass="default"></s:select>
							</td>

						</tr>
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 保 存 " />
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