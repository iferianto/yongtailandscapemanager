package com.ecko.core.util;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import com.ecko.core.entity.Page;

public class PageUtils {
	
	public static String cmsPageTag(String url,Map params,Page page){
		Long seqs=(Long)params.get("typeId");
		long pageCount = page.getTotalPages();
		long totalCount = page.getTotalCount();
		long pageNo = page.getPageNo();
		StringBuffer sb = new StringBuffer();
		sb.append("<li>共<span style='color:red;'>" + pageCount
				+ "</span>页 共<span style='color:red;'>"+totalCount+"</span>条记录 当前第<span style='color:red;'>"+pageNo+"</span>页</li>"); 
		
		sb.append("<li><a href='"+url+"?seqs="+seqs+"'>首页</a></li>");
		long prepage=pageNo-1;
		if(prepage<1){
			prepage=1;
		}
		if(prepage>pageCount){
			prepage=pageCount;
		}
		String preurl=url;
		if(url.contains("?")){
			preurl=preurl+"&pageNo="+prepage+"&seqs="+seqs;
		}else{
			preurl=preurl+"?pageNo="+prepage+"&seqs="+seqs;
		}
		sb.append("<li><a href='"+preurl+"'>上一页</a></li>");
		long nextpage=pageNo+1;
		if(nextpage<1){
			nextpage=1;
		}
		if(nextpage>pageCount){
			nextpage=pageCount;
		}
		String nexturl=url;
		if(url.contains("?")){
			nexturl=nexturl+"&pageNo="+nextpage+"&seqs="+seqs;
		}else{
			nexturl=nexturl+"?pageNo="+nextpage+"&seqs="+seqs;
		}
		sb.append("<li><a href='"+nexturl+"'>下一页</a></li>");
		

		sb.append("<li><a href='"+url+"?seqs="+seqs+"&pageNo="+pageCount+"'>末页</a></li>");
		return sb.toString();
	}
	public static String bbsPageTag(String url,Map params,Page page){
		Long seqs=(Long)params.get("typeId");
		long pageCount = page.getTotalPages();
//		long totalCount = page.getTotalCount();
		long pageNo = page.getPageNo();
		StringBuffer sb = new StringBuffer();
//		sb.append("<li>共"+(pageCount==0?1:pageCount)+"页</li>"); 
		
		sb.append("<li><a href='"+url+"?seqs="+seqs+"'>首页</a></li>");
		long prepage=pageNo-1;
		if(prepage<1){
			prepage=1;
		}
		if(prepage>pageCount){
			prepage=pageCount;
		}
		String preurl=url;
		if(url.contains("?")){
			preurl=preurl+"&pageNo="+prepage+"&seqs="+seqs;
		}else{
			preurl=preurl+"?pageNo="+prepage+"&seqs="+seqs;
		}
		sb.append("<li><a href='"+preurl+"'>上一页</a></li>");
		long nextpage=pageNo+1;
		if(nextpage<1){
			nextpage=1;
		}
		if(nextpage>pageCount){
			nextpage=pageCount;
		}
		String nexturl=url;
		if(url.contains("?")){
			nexturl=nexturl+"&pageNo="+nextpage+"&seqs="+seqs;
		}else{
			nexturl=nexturl+"?pageNo="+nextpage+"&seqs="+seqs;
		}
		sb.append("<li><a href='"+nexturl+"'>下一页</a></li>");
		

		sb.append("<li><a href='"+url+"?seqs="+seqs+"&pageNo="+pageCount+"'>末页</a></li>");
		return sb.toString();
	}
	
	public static String viewthreads(String url,Map params,Page page){
		Long seqs=(Long)params.get("typeId");
		long pageCount = page.getTotalPages();
//		long totalCount = page.getTotalCount();
		long pageNo = page.getPageNo();
		StringBuffer sb = new StringBuffer();
//		sb.append("<li>共"+(pageCount==0?1:pageCount)+"页</li>"); 
		
		sb.append(" <a href='"+url+"?id="+seqs+"'>首页</a> ");
		long prepage=pageNo-1;
		if(prepage<1){
			prepage=1;
		}
		if(prepage>pageCount){
			prepage=pageCount;
		}
		String preurl=url;
		if(url.contains("?")){
			preurl=preurl+"&pageNo="+prepage+"&id="+seqs;
		}else{
			preurl=preurl+"?pageNo="+prepage+"&id="+seqs;
		}
		sb.append(" <a href='"+preurl+"'>上一页</a> ");
		long nextpage=pageNo+1;
		if(nextpage<1){
			nextpage=1;
		}
		if(nextpage>pageCount){
			nextpage=pageCount;
		}
		String nexturl=url;
		if(url.contains("?")){
			nexturl=nexturl+"&pageNo="+nextpage+"&id="+seqs;
		}else{
			nexturl=nexturl+"?pageNo="+nextpage+"&id="+seqs;
		}
		sb.append(" <a href='"+nexturl+"'>下一页</a> ");
		

		sb.append(" <a href='"+url+"?id="+seqs+"&pageNo="+pageCount+"'>末页</a> ");
		return sb.toString();
	}
	@SuppressWarnings("unchecked")
	public static String pageTag(String url, Map params, Page page) {
		long pageCount = page.getTotalPages();
		long totalCount = page.getTotalCount();
		long pageNo = page.getPageNo();
		StringBuffer sb = new StringBuffer();
		sb.append("<div class='float_left padding5'>");
		sb.append("共  <font color='red'>"+totalCount+"</font>  条记录 | 共<font color='red'> "+pageCount+"</font> 页 | 第 <font color='red'>"+pageNo+"</font> 页");
		sb.append("\n</div><div class='float_right padding5 paging'> <div class='float_left padding_top4'>\n");
		 
		sb
				.append("<span class='paging'><a href='#nogo' onclick='paged_go(1)'>首页</a></span> \n ");
		if (pageNo > 1) {
			 
			sb
					.append("<span class='paging'><a href='#nogo'  onclick='paged_go("
							+ (pageNo - 1) + ")'>上一页</a></span> \n ");
		}
		if (pageNo < pageCount) {
		 
			sb
					.append("<span class='paging'><a href='#nogo'  onclick='paged_go("
							+ (pageNo + 1) + ")'>下一页</a></span> \n");
		}
		sb
				.append("<span class='paging'><a href='#nogo' onclick='paged_go("
						+ pageCount + ")'>末页</a></span> \n ");
		sb.append("</div><div class='float_left'>");
		sb.append(" 跳转至：第<input name='go_page'id=='go_page' type='text'  style='width:30px' />页");
		sb.append("<input type='button' value='跳转' onclick='jumpPage()' style='width:30px'/> ");
		sb
				.append("<form  style='display:none' id='paged_form' method='post' action='");
		sb.append(url);
		sb.append("'></div> <div class='clear'></div></div>	<div class='clear'></div>\n");
		// 构造参数
		if (params == null) {
			params = new HashMap();
		}
		Iterator it = params.keySet().iterator();
		while (it.hasNext()) {
			String key = it.next().toString();
			if (params.get(key) == null)
				continue;
			sb.append("<input type=hidden name='" + key + "' value='"
					+ params.get(key) + "' />\n");
		}
		sb.append("<input type=hidden name='pageNo' id='pageNo' value='");
		sb.append(pageNo);
		sb.append("'/>\n");
		if (page.getOrderBy() != null) {
			sb
					.append("<input type=hidden name='orderBy' id='pageorderBy' value='");
			sb.append(page.getOrderBy());
			sb.append("'/>\n");
		}
		if (page.getOrder() != null) {
			sb.append("<input type=hidden name='order' id='pageorder' value='");
			sb.append(page.getOrder());
			sb.append("'/>\n");
		}
		sb.append("</form>\n");
		sb.append("<script  language='javascript'>\n");
		sb.append("function paged_go(pageNo){\n");
		sb.append("document.getElementById('pageNo').value=pageNo;\n ");
		sb.append("document.getElementById('paged_form').submit();\n");
		sb.append("}\n");

		sb.append("function jumpPage(){\n");
		sb.append("var jmpPage=document.getElementById('go_page').value;\n");
		sb.append("var pageCount=" + pageCount + ";");
		sb.append("if(jmpPage==''||jmpPage==null) return false;");
		sb.append("if(jmpPage>pageCount) return false;");
		sb.append("if((jmpPage.replace(/\\d/g, '').length != 0))return false;");
		sb.append("document.getElementById('pageNo').value=jmpPage;\n");
		sb.append("document.getElementById('paged_form').submit();\n");
		sb.append("}\n");
		sb.append("</script>");
		return sb.toString();
	}
}
