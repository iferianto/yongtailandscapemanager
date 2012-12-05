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
	<script type="text/javascript" src="${ctx }/js/date/WdatePicker.js"
		defer="defer"></script>
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

	<script>
$().ready(function() {
	 
	$("#form1").validate({
		 rules: {
		 'xcfq.name': "required",
			 'xcfq.wzjy': {
				  required: true ,
				  number:true
			 }  
		 },
		 messages: {'xcfq.name':'景区名称必填',
			  'xcfq.wzjy': {
			   required: "分数不能为空",
			   number: "分数必须为数字"
			  }   
		 }
	});
	
	 
});

</script>
	<body>
		<div id="scrollContent">
			<s:form action="xcfq!edit.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="巡查反馈"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden>
					<s:hidden name="xcfq.id" />
					<s:hidden name="xcfq.fqjg" value="1" />
					<table width="95%" class="tableStyle">
						<tr>
							<td width="15%">
								景区单位名称 ：
							</td>
							<td colspan="3">
								<s:select cssClass="default" name="userId" list="#request.users"
									listKey="id" listValue="realname"></s:select>
							</td>
						</tr>
						<tr>
							<td width="15%" align="right">
								巡查人员：
							</td>
							<td width="35%">
								<s:textfield name="xcfq.checker" maxlength="20"  ></s:textfield>
							</td>

							<td width="15%" align="right">
								巡查时间：
							</td>
							<td>
							<input type="text" name="xcfq.occerdate" onfocus="WdatePicker({dateFmt: 'yyyy-MM-dd'})"  readonly="true" value="<fmt:formatDate value="${xcfq.occerdate}"/>"/>
								 
							</td>
						</tr>
						<tr>
							<td width="15%" align="right">
								巡查结果：
							</td>
							<td  colspan="3">
								<s:textarea name="xcfq.result"  cssStyle="width:80%;height:60px;" ></s:textarea>
							</td>
						</tr>
						<tr>
							<td width="15%" align="right">
								总分：
							</td>
							<td width="35%">
								<s:textfield name="xcfq.zf"   readonly="true"></s:textfield>
							</td>

							<td width="15%" align="right">
								平均分：
							</td>
							<td>
								<s:textfield name="xcfq.pjf"   readonly="true"></s:textfield>
							</td>
						</tr>
						<c:forEach items="${details}" var="item" varStatus="i">
							<c:if test="${i.index%2==0}">
								<tr>
							</c:if>
							<td width="15%" align="right">
								${item.name }：
							</td>
							<td width="35%">
 								<input type="hidden" name="ids" value="${item.id}"/>
 								<input type="hidden" name="opn_${item.id }" value="${item.option.id}"/>
<%--								<input name="option_${item.id}" maxlength="5" type="text" value="${item.score }"></input>(请输入数字)--%>
<select name="option_${item.id}" class="default">
										<option value="100" <c:if test="${item.score >1}">selected</c:if>>否</option>
										<option value="0"  <c:if test="${item.score <= 1}">selected</c:if>>是</option>
									</select>
							</td>
							<c:if test="${i.index%2==1}">
								</tr>
							</c:if>
						</c:forEach>
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 保 存 " id="submitBtn" />
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