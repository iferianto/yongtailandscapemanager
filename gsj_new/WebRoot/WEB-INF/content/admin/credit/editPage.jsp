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
			 'credit.name': "required" ,
			 'credit.creattime': "required" 
		 },
		 messages: {
			  'credit.name': "企业名称不能为空" ,
			  'credit.creattime': "成立时间不能为空" 
		 }
	});
	 
	 
});
function addtr(){
 
	var tbody=document.getElementById('tbdy');
   
	var tr=document.createElement("tr");
 	var td1=document.createElement('td');
	td1.innerHTML='<input type="text"  maxlength="10"   	name="scores"></input><input type="hidden" name="ids"  />';   
	var td2=document.createElement('td');
	td2.innerHTML='<input type="text"  maxlength="200"   	name="reasons"></input>';  
	var td3=document.createElement('td');
	td3.innerHTML='<input type="text"  readonly="true"  style="width:80px"	onfocus="WdatePicker()"	name="dates"></input>';  
	var td4=document.createElement('td');
	td4.innerHTML='<select name="types"><option value="0">扣分</option>	<option value="1">加分</option>	</select>';  
	var td5=document.createElement('td');
	td5.innerHTML='<input type="button" class="button" value="删除"		onclick="deletetr(this);" />';  
	tr.appendChild(td1); 
	tr.appendChild(td2); 
	tr.appendChild(td3); 
	tr.appendChild(td4); 
	tr.appendChild(td5); 
	tbody.appendChild(tr); 
}
function deletetr(obj){
	if(!confirm('您确定要删除吗？')){
		return;
	}
	var tr=obj.parentNode.parentNode;
	var tb=tr.parentNode;
	tb.deleteRow(tr.rowIndex);
}

function checks(){

	var scores=document.getElementsByName('scores');
	var ret=true;
	for(var i=0;i<scores.length;i++){
		if(!/^-?(?:\d+|\d{1,3}(?:,\d{3})+)(?:\.\d+)?$/.test(scores[i].value)){
			 ret=false;
			 
		}
	} 
	if(ret==false){
		alert('分数必须是浮点型');
		return false;
	}

	var dates=document.getElementsByName('dates');
	for(var i=0;i<dates.length;i++){
		if(dates[i].value==null||dates[i].value==''){
			ret=false;
		}
	} 
	if(ret==false){
		alert('日期必填');
		return false;
	}
}
</script>
 
	<body>
		<div id="scrollContent">
			<s:form action="credit!save.action" id="form1">
				<div class="box2" panelWidth="100%" panelTitle="企业信用"
					showStatus="false" roller="true">
					<s:hidden name="id"></s:hidden>
					<s:hidden name="credit.id" />
					<table width="95%" class="tableStyle">
						<tr>
							<td width="10%">
								企业名称：
							</td>
							<td width="40%">
								<s:textfield name="credit.name" maxlength="15"
									cssStyle="width:50%"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								成立时间：
							</td>
							<td>
								<input type="text"  readonly="true"  value="<fmt:formatDate value="${credit.creattime}"/>"style="width:50%"	onfocus="WdatePicker()"	name="credit.creattime"></input>
									 
							</td>
						</tr>

						<tr>
							<td>
								基础分：
							</td>
							<td>
								<s:textfield name="credit.base" readonly="true" value="100"
									cssStyle="width:50%"></s:textfield>
							</td>
						</tr>
						<tr>
							<td>
								是否公开：
							</td>
							<td>
								<s:select name="credit.pub" list="#{'0':'否','1':'是'}"></s:select>
							</td>
						</tr>
						<tr>
							<td>
								明细：
							</td>

							<td colspan="3">
								<table width="95%" class="tableStyle">
									<tbody id="tbdy">
									<tr>										 
										<td>
											分数
										</td>
										<td>
											理由
										</td>
										<td>
											日期
										</td>
										<td>
											类型
										</td>
										 <td>
											操作
										</td>
									</tr>
									 
									<c:forEach var="item" items="${credit.details}">
									<tr>
									<input type="hidden" name="ids" value="${item.id }"/>
										<td>
											<input type="text"  maxlength="10" value="${item.score }"  	name="scores"></input>
										</td>
										<td>
											<input type="text"  maxlength="200" value="${item.reason }"   	name="reasons"></input>
										</td>
										<td>
											<input type="text"  readonly="true"  value="<fmt:formatDate value="${item.occerdate}"/>"style="width:80px"	onfocus="WdatePicker()"	name="dates"></input>
										</td>
										<td>
											<select name="types">
												<option value="0" <c:if test="${item.type==0}">selected</c:if>>扣分</option>	
												<option value="1" <c:if test="${item.type==1}">selected</c:if>>加分</option>	
											</select>
										</td>
										<td>
											<input type="button" class="button" value="删除"		onclick="deletetr(this);" />
										</td>
									</tr>
									</c:forEach>
									</tbody>
								</table>
								<div style="text-align: right; ">
											
														<input type="button" class="button" value="增加" onclick="addtr()" /> 
														 <input type="button" class="button" value="全部删除" id="delteAll" style="width:80px"/>
													</div>
							</td>
						</tr>
						<tr>
							<td colspan="4" align="center">
								<input type="submit" value=" 保 存 " onclick="return checks();"/>
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