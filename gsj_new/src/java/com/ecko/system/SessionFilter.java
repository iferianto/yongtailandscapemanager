package com.ecko.system;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ecko.core.util.MD5;
import com.ecko.system.util.CommonConstants;
import com.ecko.system.util.UserSession;

public class SessionFilter implements Filter {

	public void destroy() {
		 

	}

	public void doFilter(ServletRequest req, ServletResponse res,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        HttpSession session = request.getSession();

        String currentURI = request.getRequestURI(); 
        if (!currentURI.endsWith(".action")) {
            chain.doFilter(req, res);
            return;
        } else if (currentURI.endsWith("login.action")) {
            chain.doFilter(req, res);
            return;
        }else if (currentURI.endsWith("logout.action")) {
            chain.doFilter(req, res);
            return;
        }else if(!currentURI.contains("/admin/")&&!currentURI.contains("/system/")){
        	 chain.doFilter(req, res);
             return;
        }
        
        
        UserSession loginUser = (UserSession) session.getAttribute(CommonConstants.SESSION_USER);
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/common/sessionOut.jsp");
            return;
        }
        String parent_menu_id=request.getParameter("parent_menu_id");
        if(parent_menu_id!=null&&!parent_menu_id.equals("")){
        	session.setAttribute(CommonConstants.SESSION_PARENT_MENU_ID, parent_menu_id);
        }
        chain.doFilter(req, res);
        return ; 
	}

	public void init(FilterConfig arg0) throws ServletException {
		 

	}

	public static void  main(String[] args){
		System.out.print(MD5.toMD5("1"));
	}
}
