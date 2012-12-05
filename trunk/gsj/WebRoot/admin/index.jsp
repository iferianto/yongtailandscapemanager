<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<%
String cookie_username="";
Cookie[] cs=request.getCookies();
if(cs!=null)
for(int i=0;i<cs.length;i++){
	if(cs[i].getName().equals("cookie_username")){
		cookie_username=cs[i].getValue();
	}
} 
%>
	<head>
		<meta http-equiv="Content-Type" content="text/html;charset=utf-8">
			<title> </title>
			<link href="${ctx}/login/skin1/style.css" rel="stylesheet"
				type="text/css" id="skin" />
			<script type="text/javascript" src="${ctx}/js/jquery-1.4.js"></script>
			<script type="text/javascript" src="${ctx}/js/login.js"></script>

			<!--引入弹窗组件start-->
			<script type="text/javascript"
				src="${ctx}/js/attention/zDialog/zDrag.js"></script>
			<script type="text/javascript"
				src="${ctx}/js/attention/zDialog/zDialog.js"></script>
			<!--引入弹窗组件end-->

			<!--修正IE6支持透明png图片start-->
			<script type="text/javascript"
				src="${ctx}/js/method/pngFix/supersleight.js"></script>
			<!--修正IE6支持透明png图片end-->

			<!--居中显示start-->
			<script type="text/javascript"
				src="${ctx}/js/method/center-plugin.js"></script>
<script>
$(function(){
	// $('.login_main').center();
	 
	$("#username").focus();  

	var msg='${glb_message}';
	if(msg!=''){
		$('#errmsg_div').html(msg);
	}
	
	$('#submitbtn').click(function() {
		 
		var username=$("#username").val();
		var password=$("#password").val();
		if(username==null||username==''){ 
			$('#errmsg_div').html("用户名不能为空！");
			$("#username").focus();
			return false;
		}
		if(password==null||password==''){
			$('#errmsg_div').html("密码不能为空！");
			
			$("#password").focus();
			return false;
		}
		$('#errmsg_div').html("");
		$("#loginForm").submit();
	});
	$("#username").keydown(function (event){
		if(event.keyCode==13){
			$("#password").focus();
		}
	});
	$("#password").keydown(function (event){
		if(event.keyCode==13){
			var username=$("#username").val();
			var password=$("#password").val();
			if(username!=null&&username!=''&&password!=null&&password!=''){
				 
				$('#submitbtn').click();
			}else{
				$("#username").focus();
			}
		}
	});
})
</script>
			<!--居中显示end-->
			<style>
/*提示信息*/
#cursorMessageDiv {
	position: absolute;
	z-index: 99999;
	border: solid 1px #cc9933;
	background: #ffffcc;
	padding: 2px;
	margin: 0px;
	display: none;
	line-height: 150%;
}
/*提示信息*/
</style>
	</head>
	<body>
		<div class="login_main">
			<div class="login_top">
				<div class="login_title"></div>
			</div>
			<div class="login_middle">
				<div class="login_middleleft"></div>
				<div class="login_middlecenter">
					<form action="${ctx }/system/login!login.action" class="login_form" id="loginForm" method="post">
						<div class="login_user">
							<input type="text" name="username" id="username">
						</div>
						<div class="login_pass">
							<input type="password" name="password" id="password"  >
						</div>
						<div class="clear"></div>
						<div class="login_button">
							<div class="login_button_left">
								<input type="button" id="submitbtn" value="" onfocus="this.blur()" />
							</div>
							<div class="login_button_right">
								<input type="reset" value="" onfocus="this.blur()" />
							</div>
							<div class="clear"></div>
						</div>
					</form>
					<div id="errmsg_div" class="login_info"  >
						 
					</div>
				</div>
				<div class="login_middleright"></div>
				<div class="clear"></div>
			</div>
			<div class="login_bottom">
				<div class="login_copyright">
					福州市永泰工商局旅游监管网

				</div>
			</div>
		</div>
		<div class="login_skin">
			 
		</div>
	</body>
</html>
