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
	font-size: ${c_font_size};
}
</style>
	<!--多选框脚本start-->
	<script type="text/javascript" src="${ctx }/js/form/multiselect.js"></script>
	<!--多选框脚本end-->

	<script>
$().ready(function() {
	$("#form1").validate({
		 rules: {
			 'contentType.name': "required",
			 'contentType.seq': {
				  required: true ,
				  number:true
			 } 
		 },
		 messages: {
			  'contentType.name': "栏目名称不能为空",
			  'contentType.seq': {
			   required: "顺序号不能为空",
			   number: "顺序号必须为数字"
			  } 
		 }
	});
	
	var editor;
$().ready(function() {
	 
	KindEditor.ready(function(K) {
		editor = K.create('textarea[name="contentType.content"]', {
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
			<s:form action="content-type!save.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="表单填写"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden> 
					<s:hidden name="conetntType.hidden"  />
					<s:hidden name="contentType.state" value="1"/>
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								栏目名称：
							</td>
							<td width="40%">
								<s:textfield name="contentType.name" maxlength="30"></s:textfield>
							</td>
							<td>
								顺序号：
							</td>
							<td>
								<s:textfield name="contentType.seq" maxlength="2"></s:textfield>
							</td>
						</tr> 
						<tr>
							<td>
								描述：
							</td>
							<td>
						<s:textfield name="contentType.description" maxlength="200"></s:textfield>
	 
							</td>
							<td>
						关键字：
							</td>
							<td>

						 <s:textfield name="contentType.keyword" maxlength="200"></s:textfield>


							</td>
						</tr>
						<tr>
							<td>
								上级栏目：
							</td>
							<td> 
<select name="contentType.parent.id" colNum="3">
<option value="">请选择</option><c:forEach items="${types}" var="item"><option value="${item.id }">${item.name }</option></c:forEach>
</select>
							</td>
							<td>
						 		类型: 
							</td>
							<td>
						<s:radio list="#{'1':'列表页','2':'内容页','3':'超链接'}" name="contentType.type"   ></s:radio>
							
							</td>
						</tr>
						<tr>
							<td width="10%">
								超链接：
							</td>
							<td colspan="3">
								  <s:textfield name="contentType.href" maxlength="200"></s:textfield>当类型为超链接时有用
								 
							</td>

						</tr>
						<tr>
							<td width="10%">
								内容：
							</td>
							<td colspan="3">
								<s:textarea name="contentType.content" id="content"
									cssStyle="width:95%;height:400px"></s:textarea>
							</td>

						</tr>
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 提 交 " />
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