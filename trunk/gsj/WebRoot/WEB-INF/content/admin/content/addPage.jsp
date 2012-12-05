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
			uploadJson : '${ctx}/js/kindeditor/jsp/upload_json.jsp?id=${content.id}',
			//fileManagerJson : '${ctx}/js/kindeditor/jsp/file_manager_json.jsp',
			allowFileManager : false
		}); 
	});
});
});

</script>
	<body>
		<div id="scrollContent">
			<s:form action="content!save.action" id="form1"enctype="multipart/form-data">
				<div class="box2" panelWidth="100%" panelTitle="信息发布"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden>
					<s:hidden name="content.id"></s:hidden>
					<s:hidden name="content.pubdate"></s:hidden>
					<s:hidden name="content.createdate"></s:hidden>
					<s:hidden name="content.creator"></s:hidden> 
					<s:hidden name="content.state" value="1" />
					<s:hidden name="content.click" value="0" />
					<s:hidden name="typeId"   />
					<s:hidden name="content.audit"   />
					<table width="95%" class="tableStyle">
						<tr>
							<td width="15%" align="right">
								<font color="red">*</font>标题：
							</td>
							<td width="85%" colspan="3">
								<s:textfield name="content.title" maxlength="80"
									cssStyle="width:85%"></s:textfield>
							</td>

						</tr>
						<tr>
							<td align="right">
								描述：
							</td>
							<td colspan="3">
								<s:textfield name="content.description" maxlength="200"
									cssStyle="width:85%"></s:textfield>

							</td>
						</tr>
						<tr>
							<td align="right">
								关键字：
							</td>
							<td colspan="3">
								<s:textfield name="content.keyword" maxlength="200"
									cssStyle="width:85%"></s:textfield>
							</td>
						</tr>
						<tr>
							<td align="right">
								幻灯片标志：
							</td>
							<td colspan="3">
								<s:radio list="#{'1':'显示在首页幻灯片','0':'不显示在首页幻灯片' }" name="content.ppt"  ></s:radio>（是否显示在首页幻灯片位置，需要添加图片）

							</td>
						</tr>
						<tr>
							<td align="right">
								栏目： 
							</td>
							<td>
								<select name="content.type.id" colNum="3"  >
								 <c:forEach items="${types}" var="item" > <option value="${item.id }"<c:if test="${item.id==content.type.id}">selected</c:if>>${item.name }	</option>
									</c:forEach>
								</select>
							</td>
							<td align="right">
								是否置顶：
							</td>
							<td>
								<s:radio list="#{'1':'置顶','0':'不置顶' }" name="content.top" value="0" ></s:radio>
						
							</td>

						</tr>
						<tr>
													<td nowrap align="right" width="10%">
														图片:
													</td>
													<td width="38%" colspan="3">
														<input type=button onclick="add();" class="button" value="添加图片">
															<div id="files">
																<script>
																var phc=0;
				var html="<input name='file'  onchange='changefile(this)' type=file class='button'> <input type=button class='button' value='删除' onclick=\"remove(this)\">";
				function add()
				{
					if(phc>=5){
						alert('最多只能传5张');
						return ;
					}
					phc++;
					var o=document.getElementById('files') ;
					var div=document.createElement("div");
					div.innerHTML=html;
					o.appendChild(div);
				}
				function remove(obj)
				{
					phc--;
					obj.parentElement.parentElement.removeChild(obj.parentElement);
				}
				function changefile(obj){
					var imgs=new Array(); 
					imgs[0]='.JPG';
					imgs[1]='.JPEG';
					imgs[2]='.GIF';
					imgs[3]='.PNG';
					imgs[4]='.BMP';  
					var uv=obj.value.toUpperCase();
					var ext=uv.substring(uv.lastIndexOf('.'));
			 		var allow=false;
					for(var j=0;j<imgs.length;j++){
						if(ext==imgs[j]){
							allow=true;
							break;
						}
					}
					if(allow==false){
						alert('只允许上传jpg,jpeg,gif,png,bmp类型的图片');
						 obj.outerHTML=obj.outerHTML.replace(/(value=\").+\"/i,"$1\"");  
					}	
				}
				</script>
				</div>
				<label id="photoMsg"></label>
													</td>

												</tr>
						<tr>
							<td  align="right">
								内容：
							</td>
							<td colspan="3">
								<s:textarea name="content.content" id="content"
									cssStyle="width:95%;height:400px"></s:textarea>
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