<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ include file="/common/taglibs.jsp"%>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
			<title>文档管理</title>
			<link rel="stylesheet" type="text/css"
				href="${ctx}/dede/css/base.css">
	</head>
	<body leftmargin="8" topmargin="8"
		background='${ctx}/dede/images/allbg.gif'>

		<!--  搜索表单  -->
		<form name='form3' action='' method='get'>
			<input type='hidden' name='dopost' value='' />
			<table width='98%' border='0' cellpadding='1' cellspacing='1'
				bgcolor='#CBD8AC' align="center" style="margin-top: 8px">
				<tr bgcolor='#EEF4EA'>
					<td background='${ctx}/dede/images/wbg.gif' align='center'>
						<table border='0' cellpadding='0' cellspacing='0'>
							<tr>
								<td width='90' align='center'>
									搜索条件：
								</td>
								<td width='160'>
									<select name='cid' style='width: 150'>
										<option value='0'>
											选择类型...
										</option>
										<option value='1'>
											名称
										</option>
									</select>
								</td>
								<td width='70'>
									关键字：
								</td>
								<td width='160'>
									<input type='text' name='keyword' value='' style='width: 150px' />
								</td>
								<td width='110'>
									<select name='orderby' style='width: 80px'>
										<option value='id'>
											排序...
										</option>
										<option value='pubdate'>
											发布时间
										</option>
									</select>
								</td>
								<td>
									<input name="imageField" type="image"
										src="${ctx}/dede/images/frame/search.gif" width="45"
										height="20" border="0" class="np" />
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</form>
		<!--  快速转换位置按钮  -->
		<table width="98%" border="0" cellpadding="0" cellspacing="1"
			bgcolor="#D1DDAA" align="center">
			<tr>
				<td height="26" background="${ctx}/dede/images/newlinebg3.gif">
					<table width="98%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td align="right">
								<input type='button' class="coolbg np" onClick="location='';"
									value='添加文档' />
								<input type='button' class="coolbg np" onClick="location='';"
									value='我的文档' />
								<input type='button' class='coolbg np' onClick="location='';"
									value='稿件审核' />
								<input type='button' class="coolbg np" onClick="location='';"
									value='栏目管理' />
								<input type='button' class="coolbg np" onClick="location='';"
									value='更新列表' />
								<input type='button' class="coolbg np" onClick="location='';"
									value='更新文档' />
								<input type='button' class="coolbg np" onClick="location='';"
									value='文章回收站' />
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<!--  内容列表   --> 

			<table width="98%" border="0" cellpadding="2" cellspacing="1"
				bgcolor="#D1DDAA" align="center" style="margin-top: 8px">
				<tr bgcolor="#E7E7E7">
					<td height="24" colspan="10"
						background="${ctx}/dede/images/tbg.gif">
						&nbsp;文档列表&nbsp;
					</td>
				</tr>
				<tr align="center" bgcolor="#FAFAF1" height="22">
					 
					<td  >
						选择
					</td>
					<td width="28%">
						文章标题
					</td>
					<td width="10%">
						录入时间
					</td>
					<td width="10%">
						类目
					</td>
					<td width="8%">
						点击
					</td>
					<td width="6%">
						HTML
					</td>
					<td width="8%">
						权限
					</td>
					<td width="8%">
						发布人
					</td>
					<td width="10%">
						操作
					</td>
				</tr>

				<tr align='center' bgcolor="#FFFFFF"
					onMouseMove="javascript:this.bgColor='#FCFDEE';"
					onMouseOut="javascript:this.bgColor='#FFFFFF';" height="22">
					 
					<td>
						<input name="id" type="checkbox" id="id" value="101" class="np">
					</td>
					<td align="left">
						<a href=''><u>朱晖</u>
						</a>
					</td>
					<td>
						2009-05-29
					</td>
					<td>
						预防保健
					</td>
					<td>
						3
					</td>
					<td>
						已生成
					</td>
					<td>
						开放浏览
					</td>
					<td>
						admin
					</td>
					<td>
						<a href="101">编辑</a> |
						<a href="101">预览</a>
					</td>
				</tr>

			 

				 
				<tr align="right" bgcolor="#EEF4EA">
					<td height="36" colspan="10" align="right">
						<!--翻页代码 -->
						<div class="pagelistbox">
<span>共 11 页/33条记录 </span><span class='indexPage'>首页 
</span><strong>1</strong>
<a href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=2'>2</a>
<a href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=3'>3</a>
<a href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=4'>4</a>
<a href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=5'>5</a>
<a href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=6'>6</a>
<a href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=7'>7</a>
<a class='nextPage' href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=2'>下页</a> 
<a class='endPage' href='/dede/content_list.php?dopost=listArchives&keyword=&cid=0&flag=&orderby=id&arcrank=&channelid=0&f=form1.arcid1&totalresult=33&pageno=11'>末页</a> 
</div>
						
					</td>
				</tr>
			</table>
 

	</body>
</html>