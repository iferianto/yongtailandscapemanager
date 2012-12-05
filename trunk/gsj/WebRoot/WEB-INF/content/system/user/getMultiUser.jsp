<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="com.ecko.core.entity.Page"%>
<%@page import="com.ecko.system.entity.User"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ taglib uri="/BtnMultiTag" prefix="bm"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<script type="text/javascript" src="${ctx }/js/jquery-1.7.1.min.js"></script>
	<script type="text/javascript" src="${ctx }/js/list.js"></script>
	<!--框架必需start-->
	<script type="text/javascript" src="${ctx }/js/jquery-1.4.js"></script>
	<script type="text/javascript" src="${ctx }/js/framework.js"></script>
	<link href="${ctx }/css/import_basic.css" rel="stylesheet"
		type="text/css" />

	<link rel="stylesheet" type="text/css" id="skin"
		prePath="<%=request.getContextPath()%>/" />
	<!--框架必需end-->

	<style>
table {
	font-size: ${c_font_size};
}
</style>
<script>
window.onload=function(){

	document.all.us.value=document.all.users.value;
}
function doCheck(v,id){
 	var users=document.all.users.value;
 	var c=document.getElementById(id);
 	if(c.checked){ 
		users=users+v+",";
		 
 	} 	else{ 
 	 	var v1=v+",";  
		users=users.replace(v1,"");
		 
 	}
 	 
 	document.all.users.value=users;
	document.all.us.value=users;
 	 
}
function docheckall(obj){
	var users=document.all.users.value;
	var inputs = document.getElementsByTagName('input');
	var selected = false;
	var checkAll = obj;
	for ( var i = 0; i < inputs.length; i++) {
		var check = inputs[i];
		if (check.type != 'checkbox' || check.name != "ids") {
			continue;
		}
		if (check.disabled == true) {
			continue;
		}
		check.checked = checkAll.checked;
		var v=check.value;
		var v1=v+","; 
		users=users.replace(v1,"");	
		 
	}
	for ( var i = 0; i < inputs.length; i++) {
		var check = inputs[i];
		if (check.type != 'checkbox' || check.name != "ids") {
			continue;
		}
		if (check.disabled == true) {
			continue;
		}
		if(checkAll.checked){
			var v=inputs[i].value;
			users=users+v+",";
		}else{

			 
		}
	}
	document.all.users.value=users;
	document.all.us.value=users;
}
</script>
	<body>
		<div class="box2" panelTitle="用户信息" showStatus="false">
			<table width="95%">
				<tr>
<%--					<s:form action="" >--%>
<s:form action="user!getMultiUser.action">
						<td>
							用户名		 
							<s:textfield name="username" cssStyle="width:80px"></s:textfield>
							真名
							<s:textfield name="realname" cssStyle="width:80px"></s:textfield>
							部门							
							 <s:select name="deptId" list="#request.depts" listKey="id" listValue="name" cssClass="default" headerKey="" headerValue="全部"></s:select>
							用户组
							<s:select list="#request.groups" name="groupId" listKey="id" listValue="name" cssClass="default" headerKey="" headerValue="全部"></s:select>
							<input type="submit" value="查 询"/>
							 <s:hidden name="us" id="us" ></s:hidden>
						</td>

					</s:form>
				</tr>
				 
			</table>
		</div>
		<div>
			<table class="tableStyle" useColor="false" useHover="false"useCheckBox="false" 
			
				useClick="false">
				<tr>
					<th>
						 <input type="checkbox" onclick="docheckall(this)" />
					</th>
					<th>
						用户名
					</th>
					<th>
						真实姓名
					</th>
					<th>
						部门
					</th>
					<th>
						性别
					</th>
					 
					 
				 
				</tr>
				<form id="list_entity_form" name="list_entity_form" method="post" >
				<s:hidden name="id" id="list_entity_id"></s:hidden>
				 
				<%
				Page p=(Page)request.getAttribute("page");
				List ls=(List)p.getResult();
				String users=(String)request.getAttribute("users");
				for(int i=0;i<ls.size();i++){
					User u=(User)ls.get(i);
					Long userId=u.getId();
					String username=u.getUsername();
					String realname=u.getRealname();
					String deptName=u.getDeptName();
					Integer in=u.getSex(); 
					String temp=userId+"-"+username;
					String check="";
					if(users.contains(temp	)){
						check="checked";
					}
					if(realname==null) realname="";
				%>
					<tr  >
						<td>  
							<input <%=check %> id="id<%=userId %>" onclick="doCheck('<%=userId %>-<%=realname %>','id<%=userId %>')" type="checkbox" name="ids" value="<%=userId %>-<%=realname %>"    />
						</td>
						<td>
						<%=username %>
						</td>
						<td>
							<%=realname %>
						</td>
						<td>
							<%=deptName==null?"":deptName %>
						</td>
						<td>
							<%
							if(in!=null&&in==1){
								out.print("男");
							}else {
								out.print("女");
							}
							%>
						</td>
						 
						 
					</tr>
					<%} %> 
				</form>
			</table>
		</div>


		<div style="height: 35px;">
			
			
			
				
					 ${pageUtils }
				
		</div>

	</body>