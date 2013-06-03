<%@page import="be.openclinic.pharmacy.ProductStock,
                java.util.GregorianCalendar,
                java.util.Calendar" %>
<%@include file="/includes/validateUser.jsp"%>
<%@page errorPage="/includes/error.jsp"%>

<%=checkPermission("pharmacy.productstockfiche","all",activeUser)%>
<%=sJSSORTTABLE%>

<%
    String sAction = checkString(request.getParameter("Action"));

    // get data from form
    String sFindServiceStockName = checkString(request.getParameter("FindServiceStockName")),
            sFindProductStockUid = checkString(request.getParameter("FindProductStockUid")),
                    sGetYear = checkString(request.getParameter("GetYear")),
                    sFindYear = checkString(request.getParameter("FindYear"));
    
    if(sFindYear.length()==0 && sGetYear.length()>0){
    	sFindYear=sGetYear;
    }

    // default year
    if (sFindYear.length() == 0) {
        Calendar calendar = new GregorianCalendar();
        sFindYear = calendar.get(Calendar.YEAR) + "";
    }

    ///////////////////////////// <DEBUG> /////////////////////////////////////////////////////////
    if (Debug.enabled) {
        Debug.println("\n\n################## sAction : " + sAction + " ############################");
        Debug.println("* sFindServiceStockName : " + sFindServiceStockName);
        Debug.println("* sFindProductStockUid  : " + sFindProductStockUid);
        Debug.println("* sFindYear             : " + sFindYear + "\n");
    }
    ///////////////////////////// </DEBUG> ////////////////////////////////////////////////////////

    // variables
    ProductStock productStock = null;
    String sSelectedProductStockUid = "";

    // display options
    boolean displayFiche = false;

    String sDisplaySearchFields = checkString(request.getParameter("DisplaySearchFields"));
    if (sDisplaySearchFields.length() == 0) sDisplaySearchFields = "true"; // default
    boolean displaySearchFields = sDisplaySearchFields.equalsIgnoreCase("true");
    if (Debug.enabled) Debug.println("@@@ displaySearchFields : " + displaySearchFields);

    //******************************************************************************************************************
    //*** process actions **********************************************************************************************
    //******************************************************************************************************************

    //-- FIND ----------------------------------------------------------------------------------------------------------
    if (sAction.startsWith("find")) {
        displaySearchFields = true;
        displayFiche = true;

        productStock = ProductStock.get(sFindProductStockUid);
        sSelectedProductStockUid = productStock.getUid();
    }
%>
<form name="transactionForm" method="post">
    <%-- page title --%>
    <%=writeTableHeader("Web","viewproductstockfiches",sWebLanguage," doBack();")%>
    <%
        //**************************************************************************************************************
        //*** process display options **********************************************************************************
        //**************************************************************************************************************

        //--- SEARCH FIELDS --------------------------------------------------------------------------------------------
        if(displaySearchFields){
            // afgeleide data
            String sFindProductStockName = checkString(request.getParameter("FindProductStockName"));
            if(sFindProductStockName.length()==0 && productStock!=null){
            	sFindProductStockName=productStock.getProduct().getName();
            }

            %>
                <table width="100%" class="list" cellspacing="1" onClick="transactionForm.onkeydown='if(enterEvent(event,13)){doSearch();}';" onKeyDown="if(enterEvent(event,13)){doSearch();}">
                    <%-- PRODUCT STOCK --%>
                    <tr>
                        <td class="admin2" width="<%=sTDAdminWidth%>" nowrap><%=getTran("Web","productstock",sWebLanguage)%></td>
                        <td class="admin2">
                            <input type="hidden" name="FindProductStockUid" value="<%=sFindProductStockUid%>">
                            <input class="text" type="text" name="FindProductStockName" readonly size="<%=sTextWidth%>" value="<%=sFindProductStockName%>">
                            <img src="<c:url value="/_img/icon_search.gif"/>" class="link" alt="<%=getTranNoLink("Web","select",sWebLanguage)%>" onclick="searchProductStock('FindProductStockUid','FindProductStockName','FindServiceStockName');">
                            <img src="<c:url value="/_img/icon_delete.gif"/>" class="link" alt="<%=getTran("Web","clear",sWebLanguage)%>" onclick="transactionForm.FindProductStockUid.value='';transactionForm.FindProductStockName.value='';transactionForm.FindServiceStockName.value='';">
                        </td>
                    </tr>
                    <%-- SERVICE STOCK (automatic) --%>
                    <tr>
                        <td class="admin2" nowrap><%=getTran("Web","servicestock",sWebLanguage)%></td>
                        <td class="admin2">
                            <input class="text" type="text" name="FindServiceStockName" readonly size="<%=sTextWidth%>" value="<%=sFindServiceStockName%>">
                        </td>
                    </tr>
                    <%-- YEAR --%>
                    <tr>
                        <td class="admin2" nowrap><%=getTran("Web","year",sWebLanguage)%></td>
                        <td class="admin2">
                            <select class="text" name="FindYear">
                                <%
                                    Calendar calendar = new GregorianCalendar();
                                    int currentYear = calendar.get(Calendar.YEAR); 

                                    for(int i=5; i>=0; i--){
                                        %><option value="<%=currentYear-i%>" <%=(Integer.parseInt(sFindYear)==(currentYear-i)?"selected":"")%>><%=currentYear-i%></option><%
                                    }
                                %>
                            </select>
                        </td>
                    </tr>
                    <%-- SEARCH BUTTONS --%>
                    <tr>
                        <td class="admin2"/>
                        <td class="admin2">
                            <input type="button" class="button" name="searchButton" value="<%=getTranNoLink("Web","search",sWebLanguage)%>" onclick="doSearch();">
                            <input type="button" class="button" name="clearButton" value="<%=getTranNoLink("Web","Clear",sWebLanguage)%>" onclick="clearSearchFields();">
                        </td>
                    </tr>
                </table>
                <br>
            <%
        }

        //--- DISPLAY FICHE --------------------------------------------------------------------------------------------
        if(displayFiche){
            %>
                <table width="100%" class="sortable" id="searchresults" cellspacing="1" style="border-bottom:none;">
                    <%-- HEADER --%>
                    <tr class="admin">
                        <td width="100"/>
                        <td width="100" style="text-align:right;"><%=getTran("web","in",sWebLanguage)%></td>
                        <td width="100" style="text-align:right;"><%=getTran("web","out",sWebLanguage)%></td>
                        <td width="100" style="text-align:right;"><%=getTran("web","netto",sWebLanguage)%></td>
                        <td width="100" style="text-align:right;"><%=getTran("web","level",sWebLanguage)%></td>
                        <td width="*"/>
                    </tr>
                    <%-- DISPLAY MONTHS --%>
                    <tbody onmouseover="this.style.cursor='hand';" onmouseout="this.style.cursor='default';">
                        <%
                            Calendar calendar = new GregorianCalendar();
                            calendar.set(Integer.parseInt(sFindYear),0,0,0,0,0);

                            String detailsTran = getTran("web","showdetails",sWebLanguage);
                            
                            String sClass = "1";
                            int unitsIn, unitsOut, unitsDiff;
                            for(int i=0; i<12; i++){
                                // alternate row-style
                                if(sClass.equals("")) sClass = "1";
                                else                  sClass = "";

                                calendar.add(Calendar.MONTH,1);

                                // count units
                                unitsIn   = productStock.getTotalUnitsInForMonth(calendar.getTime());
                                unitsOut  = productStock.getTotalUnitsOutForMonth(calendar.getTime());
                                unitsDiff = unitsIn - unitsOut;

                                %>
                                <tr class="list<%=sClass%>" title="<%=detailsTran%>" onClick="showUnitsForMonth(<%=i%>,'<%=calendar.get(Calendar.YEAR)%>','<%=productStock.getServiceStockUid()%>','<%=productStock.getUid()%>');">
                                    <td>&nbsp;<%=i+1%>&nbsp;<%=getTran("web","month"+(i+1),sWebLanguage)%></td>
                                    <td style="text-align:right;"><%=unitsIn%>&nbsp;</td>
                                    <td style="text-align:right;"><%=unitsOut%>&nbsp;</td>
                                    <td style="text-align:right;"><%=(unitsDiff<0?""+unitsDiff:(unitsDiff==0?unitsDiff+"":"+"+unitsDiff))%>&nbsp;</td>
                                    <td style="text-align:right;"><%=productStock.getLevel(calendar.getTime())%>&nbsp;</td>
                                    <td/>
                                </tr>
                                <%
                            }
                        %>
                    </tbody>
                </table>
                <%-- YEAR TOTAL --%>
                <table width="100%" class="list" cellspacing="1">
                    <%
                        // count units
                        unitsIn   = productStock.getTotalUnitsInForYear(calendar.getTime());
                        unitsOut  = productStock.getTotalUnitsOutForYear(calendar.getTime());
                        unitsDiff = unitsIn - unitsOut;
                    %>
                    <tr class="admin">
                        <td width="100">&nbsp;<%=getTran("web","total",sWebLanguage)%></td>
                        <td width="100" style="text-align:right;"><%=unitsIn%>&nbsp;</td>
                        <td width="100" style="text-align:right;"><%=unitsOut%>&nbsp;</td>
                        <td width="100" style="text-align:right;"><%=(unitsDiff<0?unitsDiff+"":(unitsDiff==0?unitsDiff+"":"+"+unitsDiff))%>&nbsp;</td>
                        <td width="100"/>
                        <td width="*"/>
                    </tr>
                </table>
                <%-- PRINT BUTTON --%>
                <%=ScreenHelper.alignButtonsStart()%>
                    <button accesskey="<%=ScreenHelper.getAccessKey(getTranNoLink("accesskey","print",sWebLanguage))%>" class="buttoninvisible" onclick="doPrint();"></button>
                    <button class="button" name="printButton" onclick="doPrint();"><%=getTran("accesskey","print",sWebLanguage)%></button>
                <%=ScreenHelper.alignButtonsStop()%>
                <br>
            <%
        }
    %>
    <%-- hidden fields --%>
    <input type="hidden" name="Action">
    <input type="hidden" name="DisplaySearchFields" value="<%=displaySearchFields%>">
</form>
<%-- SCRIPTS ---------------------------------------------------------------------------------------------------------%>
<script>
  <%
      if(displaySearchFields){
          %>transactionForm.FindProductStockName.focus();<%
      }
  %>

  <%-- SHOW UNITS FOR MONTH --%>
  function showUnitsForMonth(monthIdx,year,serviceStockUid,productStockUid){
    openPopup("pharmacy/popups/unitOverviewForMonth.jsp&monthIdx="+monthIdx+"&serviceStockUid="+serviceStockUid+"&productStockUid="+productStockUid+"&year="+year+"&ts=<%=getTs()%>");
  }

  <%-- CLEAR SEARCH FIELDS --%>
  <%
      Calendar calendar = new GregorianCalendar();
      String sCurrentYear = calendar.get(Calendar.YEAR)+"";
  %>
  function clearSearchFields(){
    transactionForm.FindProductStockUid.value = "";
    transactionForm.FindProductStockName.value = "";
    transactionForm.FindServiceStockName.value = "";

    transactionForm.FindYear.value = '<%=sCurrentYear%>';
    transactionForm.FindProductStockName.focus();
  }

  <%-- DO SEARCH --%>
  function doSearch(){
    if(transactionForm.FindProductStockName.value.length>0 &&
       transactionForm.FindProductStockUid.value.length>0 &&
       transactionForm.FindYear.value.length>0){
      transactionForm.searchButton.disabled = true;
      transactionForm.clearButton.disabled = true;

      transactionForm.Action.value = "find";
      transactionForm.submit();
    }
    else{
      var popupUrl = "<c:url value="/popup.jsp"/>?Page=_common/search/okPopup.jsp&ts=<%=getTs()%>&labelType=web.manage&labelID=datamissing";
      var modalities = "dialogWidth:266px;dialogHeight:163px;center:yes;scrollbars:no;resizable:no;status:no;location:no;";
      (window.showModalDialog)?window.showModalDialog(popupUrl,"",modalities):window.confirm("<%=getTranNoLink("web.manage","datamissing",sWebLanguage)%>");

      if(transactionForm.FindProductStockName.value.length==0){
        transactionForm.FindProductStockName.focus();
      }
      else if(transactionForm.FindYear.value.length==0){
        transactionForm.FindYear.focus();
      }
    }
  }

  <%-- popup : search product stock --%>
  function searchProductStock(productStockUidField,productStockNameField,serviceStockNameField){
    openPopup("/_common/search/searchProductStock.jsp&ts=<%=getTs()%>&ReturnProductStockUidField="+productStockUidField+"&ReturnProductStockNameField="+productStockNameField+"&ReturnServiceStockNameField="+serviceStockNameField);
  }

  <%-- DO PRINT --%>
  function doPrint(){
    var url = "<%=sCONTEXTPATH%>/pharmacy/createProductStockFichePdf.jsp?ProductStockUid=<%=sSelectedProductStockUid%>&FicheYear=<%=sCurrentYear%>&ts=<%=getTs()%>";
    window.open(url,"OrderTicketsPDF<%=new java.util.Date().getTime()%>","height=600, width=845, toolbar=no, status=no, scrollbars=yes, resizable=yes, menubar=yes, left=50, top=30");
  }

  <%-- DO BACK --%>
  function doBack(){
    window.location.href = "<%=sCONTEXTPATH%>/main.do?Page=pharmacy/viewProductStockFiches.jsp&ts=<%=getTs()%>";
  }

  <%-- close "search in progress"-popup that might still be open --%>
  var popup = window.open("","Searching","width=1,height=1");
  popup.close();
</script>