<%@page import="org.dom4j.io.SAXReader,
                java.net.URL,
                org.dom4j.Document,
                org.dom4j.Element,
                be.mxs.common.util.db.MedwanQuery,
                be.mxs.common.util.system.*,
                org.dom4j.DocumentException,
                java.net.MalformedURLException,
                java.sql.PreparedStatement,
                java.util.Iterator" %>
<%@page errorPage="/includes/error.jsp" %>
<%@include file="/includes/helper.jsp" %>
<%@include file="/includes/SingletonContainer.jsp" %>
<%
    response.setHeader("Content-Type", "text/html; charset=ISO-8859-1");
	session.setAttribute("javaPOSServer", checkString(request.getParameter("javaPOSServer")));
%>
<html>
<script>
	//Automatically redirect mobile devices to OpenClinic Mobile login
	(function(a,b){if(/android|avantgo|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|iris|kindle|lge |maemo|midp|mmp|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(a)||/1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|e\-|e\/|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(di|rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|xda(\-|2|g)|yas\-|your|zeto|zte\-/i.test(a.substr(0,4)))window.location=b})(navigator.userAgent||navigator.vendor||window.opera,'mobile/login.jsp');
</script>
<head>
    <link rel="shortcut icon" href="favourite.ico"/>
    <META HTTP-EQUIV="Refresh" CONTENT="300">
    <%=sCSSNORMAL%><%=sJSCHAR%><%=sJSPROTOTYPE%><%=sJSCOOKIE%><%=sJSDROPDOWNMENU%>
    <%
    MedwanQuery.getInstance("http://" + request.getServerName() + request.getRequestURI().replaceAll(request.getServletPath(), "") + "/" + sAPPDIR);
    reloadSingleton(request.getSession());

    //*** retreive application version ***
    String version = "version unknown";
    try {
		if(MedwanQuery.getInstance().getConfigString("configureCountry","").length()>0){
			UpdateSystem.initialSetup("country", MedwanQuery.getInstance().getConfigString("configureCountry",""), request);
			MedwanQuery.getInstance().reloadConfigValues();
			MedwanQuery.getInstance().reloadLabels();
			MedwanQuery.getInstance().setConfigString("configureCountry", "");
		}
    	String sDoc = net.chelson.constant.Constants.CLASSPATH + "/xml/application.xml";
        SAXReader reader = new SAXReader(false);
        Document document = reader.read(new URL(sDoc));
        Element element = document.getRootElement().element("version");
        version = "v" + element.attribute("major").getValue() + "." + element.attribute("minor").getValue() + "." + element.attribute("bug").getValue() + " (" + element.attribute("date").getValue() + ")";
        session.setAttribute("ProjectVersion", version);
        int thisversion=Integer.parseInt(element.attribute("major").getValue())*1000000+Integer.parseInt(element.attribute("minor").getValue())*1000+Integer.parseInt(element.attribute("bug").getValue());
        if(thisversion>MedwanQuery.getInstance().getConfigInt("updateVersion",0)){
    		%>
    		<script>
    			alert("Upgrade needed, this may take several minutes depending on your system's performance");
    			window.location.href='<c:url value="/"/>util/updateSystem.jsp?updateVersion=<%=thisversion+""%>';
    		</script>    		
    		<%
        }
    }
    catch (Exception e) {
        // nothing
    }

    //*** process 'updatequeries.xml' containing queries that need to be executed at login ***
    Object updateQueriesProcessedDate = application.getAttribute("updateQueriesProcessedDateOC");
    boolean processUpdateQueries = (updateQueriesProcessedDate == null);
    if (processUpdateQueries) {
		UpdateQueries.updateQueries(application);
    } else {
        // display last date of processing update queries
        if (updateQueriesProcessedDate != null && Debug.enabled) {
            SimpleDateFormat fullDateFormat = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            Debug.println("INFO : UpdateQueries last processed at " + fullDateFormat.format(updateQueriesProcessedDate));
        }
    }

    //*** app-title and app-dir ***
    String sTmpAPPTITLE = checkString(request.getParameter("Title")),
            sTmpAPPDIR = checkString(request.getParameter("Dir"));
    if (sTmpAPPTITLE.length() > 0) {
        session.setAttribute("activeProjectDir", sTmpAPPDIR);
        session.setAttribute("activeProjectTitle", sTmpAPPTITLE);
    } else {
        sTmpAPPTITLE = checkString((String) session.getAttribute("activeProjectTitle"));
        sTmpAPPDIR = checkString((String) session.getAttribute("activeProjectDir"));
    }
    if (sTmpAPPTITLE.equals("")) {%>
    <script>
        var activeProjectDir = GetCookie('activeProjectDir');
        if (activeProjectDir == null) {
            activeProjectDir = "";
        }
            //window.location.href = activeProjectDir;
    </script>
    <%} else {%>
    <script>
        SetCookie('activeProjectDir', "<%=sTmpAPPDIR%>", exp);
        SetCookie('activeProjectTitle', "<%=sTmpAPPTITLE%>", exp);
    </script>
    <%}%>
    <script>
        if (window.history.forward(1) != null) {
            window.history.forward(1);
        }
    </script>
    <title><%=sWEBTITLE + " " + sTmpAPPTITLE%>
    </title>
</head>
<body class="Geenscroll login">
<%
	if("openinsurance".equalsIgnoreCase(MedwanQuery.getInstance().getConfigString("edition",""))) {
%>
	<div id="loginopeninsurance">
<%
	}
	else {
%>
	<div id="login">
<%
	}
%>
    <div id="logo">
        <% if ("datacenter".equalsIgnoreCase(MedwanQuery.getInstance().getConfigString("edition",""))) {
            session.setAttribute("edition", "datacenter");%>
        <img src="projects/datacenter/_img/logo.jpg" border="0">
        <% } else if ("openlab".equalsIgnoreCase(MedwanQuery.getInstance().getConfigString("edition",""))) {
            session.setAttribute("edition", "openlab");%>
        <img src="projects/openlab/_img/logo.jpg" border="0">
        <% } else if ("openpharmacy".equalsIgnoreCase(MedwanQuery.getInstance().getConfigString("edition",""))) {
            session.setAttribute("edition", "openpharmacy");%>
        <img src="_img/openpharmacy_logo.jpg" border="0">
        <% } else if ("openinsurance".equalsIgnoreCase(MedwanQuery.getInstance().getConfigString("edition",""))) {
            session.setAttribute("edition", "openinsurance");%>
        <img src="_img/openinsurancelogo.jpg" border="0">
        <% } else {
            session.setAttribute("edition", "openclinic");%>
        <img src="<%=sTmpAPPDIR%>_img/logo.jpg" border="0">
        <% }%>
    </div>
    <div id="version">
        <%=version%>&nbsp;
    </div>
    <div id="fields">
        <form name="entranceform" action="checkLogin.do?ts=<%=getTs()%>" method="post" id="entranceform">
            <div id="login_field">
                <input class="text" name="login" size="17" onblur='validateText(this);limitLength(this);'/></div>
            <div id="pwd_field">
                <input class="text" type="password" name="password" size="17" onblur='validateText(this);limitLength(this);'/>
            </div>
            <div id="submit_button"><input class="button" type="submit" name="Login" title="login" value="">
                <div id="finger_button">
                    <a href="javascript:void(0)" title="Logon using fingerprint" onclick="readFingerprint();" >&nbsp;</a>
                </div>
            </div>
            <div id="error_msg">
            <%
                String sMsg = checkString(request.getParameter("message"));
                if (sMsg.length() > 0) {
                    out.write("<div>"+sMsg+"</div>");
                }
            %>
                 </div>
        </form>
    </div>
    <div id="messages">

        <%
            if (MedwanQuery.getInstance().getConfigInt("enableProductionWarning", 0) == 1) {
        	out.print("<center>" + ScreenHelper.getTranDb("web", "productionsystemwarning", "EN") + "<br/></center>");
        	//out.print("<center>" + ScreenHelper.getTranDb("web", "testsystemredirection", "EN") + "</center>");
    	}
        %>
        <br/><center>GA Open Source Edition by:
        <% if (MedwanQuery.getInstance().getConfigString("mxsref", "rw").equalsIgnoreCase("rw")) { %>
        <img src="_img/rwandaflag.jpg" height="15px" width="30px" alt="Rwanda"/>
        <a href="http://mxs.rwandamed.org" target="_new"><b>MXS Central Africa SARL</b></a>
        <BR/> PO Box 3242 - Kigali Rwanda Tel +250 07884 32 435 -
        <a href="mailto:mxs@rwandamed.org">mxs@rwandamed.org</a>
        <% } else if (MedwanQuery.getInstance().getConfigString("mxsref", "rw").equalsIgnoreCase("bi")) { %>
        <img src="_img/burundiflag.jpg" height="15px" width="30px" alt="Burundi"/>
        <a href="http://www.openit-burundi.net" target="_new"><b>Open-IT Burundi SPRL</b></a>
        <BR/> Avenue de l'ONU 6, BP 7205 - Bujumbura +257 78 837 342<br/>
        <a href="mailto:info@openit-burundi.net">info@openit-burundi.net</a>
        <% } else if (MedwanQuery.getInstance().getConfigString("mxsref", "rw").equalsIgnoreCase("ml")) { %>
        <img src="_img/maliflag.jpg" height="15px" width="30px" alt="Mali"/>
        <a href="http://www.sante.gov.ml/" target="_new"><b>ANTIM</b></a> et <a href="http://www.mxs.be" target="_new"><b>MXS</b></a>
        <BR/> Hamdalaye ACI 2000, Rue 340, Porte 541, Bamako - Mali<br/>
        <a href="mailto:info@openit-burundi.net">antim@sante.gov.ml</a>
        <% } else { %>
        <img src="_img/belgiumflag.jpg" height="10px" width="20px" alt="Belgium"/>
        <a href="http://www.mxs.be" target="_new"><b>MXS SA/NV</b></a>
        <BR/> Pastoriestraat 50, 3370 Boutersem Belgium Tel: +32 16 721047 -
        <a href="mailto:mxs@rwandamed.org">info@mxs.be</a>
        <% } %>
        </center>
    </div>
</div>
<script type="text/javascript">
    Event.observe(window, 'load', function() {
        changeInputColor();
        $("entranceform").login.focus();
       
    });
    function readFingerprint() {
    <%
    if(checkString(MedwanQuery.getInstance().getConfigString("referringServer")).length()==0){
    %>
        openPopup("_common/readUserFingerPrint.jsp?ts=<%=getTs()%>&referringServer=<%="http://" + request.getServerName()+"/"+sCONTEXTPATH%>", 400, 300);
    <%
    }
    else {
    %>
        openPopup("_common/readUserFingerPrint.jsp?ts=<%=getTs()%>&referringServer=<%=MedwanQuery.getInstance().getConfigString("referringServer")+sCONTEXTPATH%>", 400, 300);
    <%
    }
    %>
    }
    function openPopup(page, width, height) {
        var url = page;
        window.open(url, "Popup" + new Date().getTime(), "toolbar=no, status=yes, scrollbars=yes, resizable=yes, width=" + width + ", height=" + height + ", menubar=no").moveTo((screen.width - width) / 2, (screen.height - height) / 2);
    }
</script>
</body>
</html>