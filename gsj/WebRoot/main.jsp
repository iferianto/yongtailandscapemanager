<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Frameset//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title></title>
<!--框架必需start-->
<link href="${ctx}/css/import_basic.css" rel="stylesheet" type="text/css"/>
<link href="${ctx}/skins/sky/import_skin.css" rel="stylesheet" type="text/css" id="skin" themeColor="blue"/>
<script type="text/javascript" src="${ctx}/js/jquery-1.4.js"></script>
<script type="text/javascript" src="${ctx}/js/bsFormat.js"></script>
<!--框架必需end-->

	<script type="text/javascript" src="${ctx}/js/attention/messager.js"></script>
	<link rel="stylesheet" type="text/css" id="skin"	prePath="<%=request.getContextPath()%>/" />
<!--引入组件start-->
<script type="text/javascript" src="${ctx}/js/attention/zDialog/zDrag.js"></script>
<script type="text/javascript" src="${ctx}/js/attention/zDialog/zDialog.js"></script>
<!--引入弹窗组件end-->

<!--修正IE6支持透明png图片start-->
<script type="text/javascript" src="${ctx}/js/method/pngFix/supersleight.js"></script>
<!--修正IE6支持透明png图片end-->

<script >

function showSms(){
	$.ajax({
	    url: '${ctx}/oa/sms/sms!ajaxMySms.action',
	    type: 'GET',  
	    error: function(){
	        
	    },
	    success: function(xml){  
		    if(xml!=null&&xml!=''){
			    $.messager.lays(250, 140);
			    $.messager.show(0,xml,'10000');
		    }
	    	        
	    }
	});
	setTimeout(showSms, 60000);
}
window.onload=function(){
//	showSms();
	 
}

function openSms(id,type){
	if(type=='3'){
		document.getElementById('frmright').src='${ctx}/oa/notify/notify!listToMe.action';
	} else if(type=='2'){
		document.getElementById('frmright').src='${ctx}/oa/email/email!listRec.action';
	}
	else{

	}
	$.ajax({
	    url: '${ctx}/oa/sms/sms!view.action?id='+id,
	    type: 'GET',  
	    error: function(){
	        
	    },
	    success: function(xml){  
		     
	    	        
	    }
	});
}
</script>
</head>
<body>
<div id="mainFrame">
<!--头部与导航start-->
<div id="hbox">
	<div id="bs_bannercenter">
	<div id="bs_bannerleft">
	<div id="bs_bannerright">
		<div class="bs_banner_logo"></div>
		<div class="bs_banner_title" style="width:400px;">
		<span><font size="5" color="#cc0000">永泰县工商局旅游监管网后台管理</font></span>
		</div> 
		<div class="bs_nav">
			<div class="bs_navleft">
				<li>
					欢迎${SESSION_USER.username }用户，今天是
				<script>
					var weekDayLabels = new Array("星期日","星期一","星期二","星期三","星期四","星期五","星期六");
					var now = new Date();
				    var year=now.getFullYear();
					var month=now.getMonth()+1;
					var day=now.getDate()
				    var currentime = year+"年"+month+"月"+day+"日 "+weekDayLabels[now.getDay()]
					document.write(currentime);
				</script>
				</li>
				<li class="fontTitle">&nbsp;&nbsp;字号:</li>
				<li class="fontChange"><span><a href="#nogo" setFont="16">大</a></span></li>
				<li class="fontChange"><span><a href="#nogo" setFont="14">中</a></span></li>
				<li class="fontChange"><span><a href="#nogo" setFont="12">小</a></span></li>
				<div class="clear"></div>
			</div>
			<div class="bs_navright">
				 <span class="icon_no hand"  ><a href="${ctx}/index!logout.action">退出系统</a></span>
				 
				<div class="clear"></div>
			</div>
			<div class="clear"></div>
		</div>
	</div>
	</div>
	</div>
</div>
<!--头部与导航end-->

<table width="100%" cellpadding="0" cellspacing="0" class="table_border0">
	<tr>
		<!--左侧区域start-->
		<td id="hideCon" class="ver01 ali01">
							<div id="lbox">
								<div id="lbox_topcenter">
								<div id="lbox_topleft">
								<div id="lbox_topright">
									<div class="lbox_title">操作菜单</div>
								</div>
								</div>
								</div>
								<div id="lbox_middlecenter">
								<div id="lbox_middleleft">
								<div id="lbox_middleright">
										<div id="bs_left">
										<IFRAME scrolling="no" width="100%"  frameBorder=0 id=frmleft name=frmleft src="${ctx}/system/index!left.action"  allowTransparency="true"></IFRAME>
										</div>
										<!--更改左侧栏的宽度需要修改id="bs_left"的样式-->
								</div>
								</div>
								</div>
								<div id="lbox_bottomcenter">
								<div id="lbox_bottomleft">
								<div id="lbox_bottomright">
									<div class="lbox_foot"></div>
								</div>
								</div>
								</div>
							</div>
		</td>
		<!--左侧区域end-->
		
		<!--中间栏区域start-->
		<td class="main_shutiao">
			<div class="bs_leftArr" id="bs_center" title="收缩面板"></div>
		</td>
		<!--中间栏区域end-->
		
		<!--右侧区域start-->
		<td class="ali01 ver01"  width="100%">
							<div id="rbox">
								<div id="rbox_topcenter">
								<div id="rbox_topleft">
								<div id="rbox_topright">
									<div class="rbox_title">
										操作内容
									</div>
								</div>
								</div>
								</div>
								<div id="rbox_middlecenter">
								<div id="rbox_middleleft">
								<div id="rbox_middleright">
									<div id="bs_right">
									       <IFRAME scrolling="false" width="100%" frameBorder=0 id=frmright name=frmright src="${ctx}/lesson/open.html"  allowTransparency="true"></IFRAME>
									</div>
								</div>
								</div>
								</div>
								<div id="rbox_bottomcenter" >
								<div id="rbox_bottomleft">
								<div id="rbox_bottomright">

								</div>
								</div>
								</div>
							</div>
		</td>
		<!--右侧区域end-->
	</tr>
</table>

<!--尾部区域start-->
<div id="fbox">
	<div id="bs_footcenter">
	<div id="bs_footleft">
	<div id="bs_footright" class="white">
			福州市永泰县工商局旅游监管网
	</div>
	</div>
	</div>
</div>
</div>
<!--尾部区域end-->

<!--浏览器resize事件修正start-->
<div id="resizeFix"></div>
<!--浏览器resize事件修正end-->

<!--载进度条start-->
<div class="progressBg" id="progress" style="display:none;"><div class="progressBar"></div></div>
<!--载进度条end-->
</body>
</html>
