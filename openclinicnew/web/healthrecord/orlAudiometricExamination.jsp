<%@page import="be.mxs.common.util.system.Audiometry,
                be.mxs.common.util.system.HearingLoss,java.util.*,
                be.openclinic.system.Healthrecord"%>
<%@include file="/includes/validateUser.jsp"%>
<%@page errorPage="/includes/error.jsp"%>

<%=checkPermission("occup.audiometry","select",activeUser)%>

<%!
    //--- WRITE SELECT ----------------------------------------------------------------------------
    private String writeSelect(SessionContainerWO sessionContainerWO, String sItemType){
        String sItemValue = "";
        if (sessionContainerWO.getCurrentTransactionVO().getTransactionId().intValue() > 0) {
            ItemVO item = sessionContainerWO.getCurrentTransactionVO().getItem(sItemType);
            if (item != null) {
                sItemValue = checkString(item.getValue());
            }
        }

        String sReturn = "";
        for (int i=-10;i<110;i+=10){
            sReturn += "<option value='"+i+"'";

            if (sItemValue.equals(i+"")){
                sReturn += " selected";
            }

            sReturn += ">"+i+"</option>";
        }

        return sReturn;
    }
%>

<form name="transactionForm" id="transactionForm" method="POST" action='<c:url value="/healthrecord/updateTransaction.do"/>?ts=<%=getTs()%>' onclick="setSaveButton(event);" onkeyup="setSaveButton(event);">
    <bean:define id="transaction" name="be.mxs.webapp.wl.session.SessionContainerFactory.WO_SESSION_CONTAINER" property="currentTransactionVO"/>
    <input type="hidden" id="transactionId" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.transactionId" value="<bean:write name="transaction" scope="page" property="transactionId"/>"/>
    <input type="hidden" id="serverId" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.serverId" value="<bean:write name="transaction" scope="page" property="serverId"/>"/>
    <input type="hidden" id="transactionType" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.transactionType" value="<bean:write name="transaction" scope="page" property="transactionType"/>"/>
    <input type="hidden" readonly name="be.mxs.healthrecord.updateTransaction.actionForwardKey" value="/main.do?Page=curative/index.jsp&ts=<%=getTs()%>"/>
    <input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_TRANSACTION_RESULT" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_TRANSACTION_RESULT" property="value"/>"/>
    <input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_RECRUITMENT_CONVOCATION_ID" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_RECRUITMENT_CONVOCATION_ID" property="value"/>"/>
    <input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_DEPARTMENT" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_DEPARTMENT" translate="false" property="value"/>"/>
    <input type="hidden" readonly name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_CONTEXT" translate="false" property="itemId"/>]>.value" value="<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_CONTEXT" translate="false" property="value"/>"/>

    <br>

    <%-- GRAPH TABLE ----------------------------------------------------------------------------%>
<table border='0' width='100%' id="tbltest" height="200">
    <tr>
        <td width="330" nowrap>
            <span id='freqs'>
            <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br><br><br><br>
            &nbsp; &nbsp; 0,125
            &nbsp; &nbsp; 0,25
            &nbsp; &nbsp; &nbsp; 0,5
            &nbsp; &nbsp; &nbsp; &nbsp; 1
            &nbsp; &nbsp; &nbsp; &nbsp; 2
            &nbsp; &nbsp; &nbsp; &nbsp; 4
            &nbsp; &nbsp; &nbsp; &nbsp; 8
            </span>
        </td>

        <td width="150" nowrap>
            <br><br>
            <input id="DVisible" type="checkbox" onclick="if (this.checked){setVisibility(true)}else{setVisibility(false)}" checked><%=getLabel("Web.Occup","medwan.common.view.graph",sWebLanguage,"DVisible")%>
            <br><br>
            <font color="red"><b><%=getTran("Web.Occup","medwan.healthrecord.audiometry.OD",sWebLanguage)%></b></font><br/>
            <font color="blue"><b><%=getTran("Web.Occup","medwan.healthrecord.audiometry.OG",sWebLanguage)%></b></font><br/>
            <font color="#00AA00"><b><%=getTran("Web.Occup","medwan.healthrecord.audiometry.normal",sWebLanguage)%></b></font><br/>
            <font color="#000000"><b><%=getTran("openclinic.chuk","audiometry.bony.OD",sWebLanguage)%></b></font><br/>
            <font color="#800080"><b><%=getTran("openclinic.chuk","audiometry.bony.OG",sWebLanguage)%></b></font>
        </td>

        <td nowrap valign="top">
            <%=getTran("Web.Occup","medwan.common.history",sWebLanguage)%>
            <select name="History" class="text" onchange="changeHistory()">
                <%
                    String sType, sValue, sOption = "", sDate = "", sTransactionID, sOldTransactionID = "";
                    Vector vAudiometric = Healthrecord.getAudiometricData(activePatient.personid);
                    Iterator iter = vAudiometric.iterator();
                    Hashtable hAudiometric;

                    while (iter.hasNext()) {
                        hAudiometric = (Hashtable) iter.next();
                        sTransactionID = (String) hAudiometric.get("transactionid");
                        sType = (String) hAudiometric.get("type");
                        sValue = (String) hAudiometric.get("value");

                        if (!sTransactionID.equals(sOldTransactionID)) {
                            if (sOldTransactionID.trim().length() > 0) {
                                %>
                                    <option value="<%=sOption%>"><%=sDate%></option>
                                <%
                            }
                            sOldTransactionID = sTransactionID;
                            sDate = ScreenHelper.getSQLDate((java.sql.Date)hAudiometric.get("updatetime"));//ScreenHelper.getSQLDate(Occuprs.getDate("updateTime"));
                            sOption = "";
                        }

                        if (sType.indexOf("BONY") > -1) {
                            sType = sType.substring(sType.indexOf("BONY"));
                        }
                        else if (sType.indexOf("RIGHT") > -1) {
                            sType = sType.substring(sType.indexOf("RIGHT"));
                        }
                        else if (sType.indexOf("LEFT") > -1) {
                            sType = sType.substring(sType.indexOf("LEFT"));
                        }
                        else {
                            sType = "";
                        }

                        if (sType.length()>0){
                            sOption += (":"+sType + "=" + sValue + ";");
                        }
                    }
                %>
                <option value="<%=sOption%>"><%=sDate%></option>
            </select>
            <br><br>
            <br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>&nbsp;<br>
            0,125
            &nbsp;0,25
            &nbsp;0,5
            &nbsp;&nbsp; 1
            &nbsp;&nbsp; 2
            &nbsp;&nbsp; 4
            &nbsp;&nbsp; 8
        </td>
    </tr>
</table>

<br>

<%=writeHistoryFunctions(((TransactionVO)transaction).getTransactionType(),sWebLanguage)%>
<%=contextHeader(request,sWebLanguage)%>

    <table class="list" width="100%" cellspacing="1">
		<tr>
			<td valign="top" class="admin2">
				<table class="list" width="100%" cellspacing="1" id="tbl1">
				    <%-- DATE --%>
				    <tr>
				        <td class="admin">
				            <a href="javascript:openHistoryPopup();" title="<%=getTran("Web.Occup","History",sWebLanguage)%>">...</a>&nbsp;
				            <%=getTran("Web.Occup","medwan.common.date",sWebLanguage)%>
				        </td>
				        <td class="admin2">
				            <input type="text" class="text" size="12" maxLength="10" value="<mxs:propertyAccessorI18N name="transaction" scope="page" property="updateTime" formatType="date" format="dd-mm-yyyy"/>" name="currentTransactionVO.<TransactionVO[hashCode=<bean:write name="transaction" scope="page" property="transactionId"/>]>.updateTime" id="trandate" OnBlur='checkDate(this)'> <script>writeMyDate("trandate","<c:url value="/_img/icon_agenda.gif"/>","<%=getTran("Web","PutToday",sWebLanguage)%>");</script>
				        </td>
				    </tr>
				
				    <%-- RIGHT EAR ---------------------------------------------------------------------------------------------------%>
				    <tr>
				        <td class="admin" align="left">
				            <%=getTran("Web.Occup","medwan.healthrecord.audiometry.OD",sWebLanguage)%>
				        </td>
				        <td class="admin2" align="left">
				            <table>
				                <tr>
				                    <td width="1%">0,125</td><td width="1%">0,25</td><td width="1%">0,5</td><td width="1%">1</td><td width="1%">2</td>
				                    <td width="1%">4</td><td width="1%">8</td><td/>
				                </tr>
				                <tr>
				                    <td>
				                        <%
				                            SessionContainerWO sessionContainerWO = (SessionContainerWO) SessionContainerFactory.getInstance().getSessionContainerWO(request, SessionContainerWO.class.getName());
				                        %>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_RIGHT_0125" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="R125">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_RIGHT_0125")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_RIGHT_025" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="R25">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_RIGHT_025")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_RIGHT_050" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="R50">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_RIGHT_050")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_RIGHT_1" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="R1">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_RIGHT_1")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_RIGHT_2" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="R2">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_RIGHT_2")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_RIGHT_4" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="R4">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_RIGHT_4")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_RIGHT_8" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="R8">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_RIGHT_8")%>
				                        </select>
				                    </td>
				                </tr>
				            </table>
				        </td>
				    </tr>
				
				    <%-- LEFT EAR -------------------------------------------------------------------------------%>
				    <tr>
				        <td class="admin" align="left">
				            <%=getTran("Web.Occup","medwan.healthrecord.audiometry.OG",sWebLanguage)%>
				        </td>
				        <td class="admin2" align="left">
				            <table>
				                <tr>
				                    <td width="1%">0,125</td><td width="1%">0,25</td><td width="1%">0,5</td><td width="1%">1</td>
				                    <td width="1%">2</td><td width="1%">4</td><td width="1%">8</td><td/>
				                </tr>
				                <tr>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_LEFT_0125" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="L125">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_LEFT_0125")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_LEFT_025" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="L25">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_LEFT_025")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_LEFT_050" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="L50">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_LEFT_050")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_LEFT_1" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="L1">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_LEFT_1")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_LEFT_2" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="L2">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_LEFT_2")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_LEFT_4" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="L4">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_LEFT_4")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_LEFT_8" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="L8">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_LEFT_8")%>
				                        </select>
				                    </td>
				                </tr>
				            </table>
				        </td>
				    </tr>
				
				    <%-- RIGHT EAR ------------------------------------------------------------------------------%>
				    <tr>
				        <td class="admin" align="left"><%=getTran("openclinic.chuk","audiometry.bony.OD",sWebLanguage)%></td>
				        <td class="admin2" align="left">
				            <table>
				                <tr>
				                    <td width="1%">0,125</td><td width="1%">0,25</td><td width="1%">0,5</td><td width="1%">1</td><td width="1%">2</td>
				                    <td width="1%">4</td><td width="1%">8</td><td/>
				                </tr>
				                <tr>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_0125" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="RBONY125">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_0125")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_025" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="RBONY25">
				                           <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_025")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_050" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="RBONY50">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_050")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_1" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="RBONY1">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_1")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_2" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="RBONY2">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_2")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_4" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="RBONY4">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_4")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_8" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="RBONY8">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_RIGHT_8")%>
				                        </select>
				                    </td>
				                </tr>
				            </table>
				        </td>
				    </tr>
				
				    <%-- LEFT EAR -------------------------------------------------------------------------------%>
				    <tr>
				        <td class="admin" align="left"><%=getTran("openclinic.chuk","audiometry.bony.OG",sWebLanguage)%></td>
				        <td class="admin2" align="left">
				            <table>
				                <tr>
				                    <td width="1%">0,125</td><td width="1%">0,25</td><td width="1%">0,5</td><td width="1%">1</td>
				                    <td width="1%">2</td><td width="1%">4</td><td width="1%">8</td><td/>
				                </tr>
				                <tr>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_LEFT_0125" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="LBONY125">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_LEFT_0125")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_LEFT_025" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="LBONY25">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_LEFT_025")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_LEFT_050" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="LBONY50">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_LEFT_050")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_LEFT_1" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="LBONY1">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_LEFT_1")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_LEFT_2" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="LBONY2">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_LEFT_2")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_LEFT_4" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="LBONY4">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_LEFT_4")%>
				                        </select>
				                    </td>
				                    <td>
				                        <select name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_BONY_LEFT_8" property="itemId"/>]>.value" class="text" onChange="setTable(this)" id="LBONY8">
				                            <%=writeSelect(sessionContainerWO,sPREFIX+"ITEM_TYPE_AUDIOMETRY_BONY_LEFT_8")%>
				                        </select>
				                    </td>
				                </tr>
				            </table>
				        </td>
				    </tr>
				
				    <%-- personal history --%>
				    <tr>
				        <td class="admin"><%=getTran("Web.Occup","personal.audiometric.history",sWebLanguage)%></td>
				        <td class="admin2">
				            <textarea onKeyup="resizeTextarea(this,10);limitChars(this,255);" cols="60" rows="2" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_PERSONAL_HISTORY" property="itemId"/>]>.value"><%=ScreenHelper.getLastItem(request,sPREFIX+"ITEM_TYPE_AUDIOMETRY_PERSONAL_HISTORY").getValue()%></textarea>
				        </td>
				    </tr>
				
				    <%-- family history --%>
				    <tr>
				        <td class="admin"><%=getTran("Web.Occup","family.audiometric.history",sWebLanguage)%></td>
				        <td class="admin2">
				            <textarea onKeyup="resizeTextarea(this,10);limitChars(this,255);" cols="60" rows="2" class="text" name="currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_AUDIOMETRY_FAMILY_HISTORY" property="itemId"/>]>.value"><%=ScreenHelper.getLastItem(request,sPREFIX+"ITEM_TYPE_AUDIOMETRY_FAMILY_HISTORY").getValue()%></textarea>
				        </td>
				    </tr>
				
				    <%-- BUTTONS --%>
				    <tr>
				        <td class="admin"/>
				        <td class="admin2">
				            <%=getButtonsHtml(request,activeUser,activePatient,"occup.audiometry",sWebLanguage)%>
				        </td>
				    </tr>
				</table>
			</td>
			<td valign="top" class="admin2">
			    <table class="list" width="100%" cellspacing="1">
			        <%-- Diagnoses --%>
			        <tr>
                        <td class="admin2">
                            <%ScreenHelper.setIncludePage(customerInclude("healthrecord/diagnosesEncoding.jsp"),pageContext);%>
                        </td>
			        </tr>
			    </table>
			</td>
		</tr>
    </table>

    <%=sJSDIAGRAM%>

    <%=ScreenHelper.contextFooter(request)%>
</form>
<div id="audiometricGraph"></div>
<div id="audiometricGraph2"></div>
<script>

var D=new Diagram();
D.SetFrame(35, 130, 320, 295);
D.XScale="";
D.YScale="1";
D.SetBorder(0,6,100,-10);
_DivDiagram = 'audiometricGraph';
D.Draw("#FFFFFF", "#000000", false, "", "", "#DDDDFF","#CCCCCC");

var R125, R25, R50, R1, R2, R4, L125, L25, L50, L1, L2, L4, L8
, dR125, dR25, dR50, dR1, dR2, dR4, dR8, dL125, dL25, dL50, dL1, dL2, dL4, dL8, A125, A25, A50, A1, A2, A4, A8
,RBONY125, RBONY25, RBONY50, RBONY1, RBONY2, RBONY4, LBONY125, LBONY25, LBONY50, LBONY1, LBONY2, LBONY4, LBONY8
, dRBONY125, dRBONY25, dRBONY50, dRBONY1, dRBONY2, dRv4, dRBONY8, dLBONY125, dLBONY25, dLBONY50, dLBONY1, dLBONY2, dLBONY4, dLBONY8;

function setTable(oObject){
  if (document.getElementsByName('DVisible')[0].checked) {
    sTable = oObject.id.substring(0,1);

    if (sTable == "R") {
      if (oObject.id == "R125") {
        R125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('R125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value));
        dR125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('R125')[0].value));
      }
      else if (oObject.id == "R25") {
        R125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('R125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value));
        R25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value));
        dR25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value));
      }
      else if (oObject.id == "R50") {
        R25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value));
        R50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value));
        dR50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value));
      }
      else if (oObject.id == "R1") {
        R50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value));
        R1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value));
        dR1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value));
      }
      else if (oObject.id == "R2") {
        R1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value));
        R2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value));
        dR2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value));
      }
      else if (oObject.id == "R4") {
        R2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value));
        R4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('R8')[0].value));
        dR4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value));
      }
      else if (oObject.id == "R8") {
        R4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('R8')[0].value));
        dR8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('R8')[0].value));
      }
      else if (oObject.id == "RBONY125") {
        RBONY125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('RBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value));
        dRBONY125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('RBONY125')[0].value));
      }
      else if (oObject.id == "RBONY25") {
        RBONY125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('RBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value));
        RBONY25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value));
        dRBONY25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value));
      }
      else if (oObject.id == "RBONY50") {
        RBONY25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value));
        RBONY50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value));
        dRBONY50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value));
      }
      else if (oObject.id == "RBONY1") {
        RBONY50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value));
        RBONY1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value));
        dRBONY1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value));
      }
      else if (oObject.id == "RBONY2") {
        RBONY1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value));
        RBONY2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value));
        dRBONY2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value));
      }
      else if (oObject.id == "RBONY4") {
        RBONY2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value));
        RBONY4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('RBONY8')[0].value));
        dRBONY4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value));
      }
      else if (oObject.id == "RBONY8") {
        RBONY4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('RBONY8')[0].value));
        dRBONY8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('RBONY8')[0].value));
      }
    }
    else {
      if (oObject.id == "L125") {
        L125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('L125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value));
        dL125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('L125')[0].value));
      }
      else if (oObject.id == "L25") {
        L125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('L125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value));
        L25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value));
        dL25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value));
      }
      else if (oObject.id == "L50") {
        L25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value));
        L50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value));
        dL50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value));
      }
      else if (oObject.id == "L1") {
        L50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value));
        L1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value));
        dL1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value));
      }
      else if (oObject.id == "L2") {
        L1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value));
        L2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value));
        dL2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value));
      }
      else if (oObject.id == "L4") {
        L2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value));
        L4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('L8')[0].value));
        dL4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value));
      }
      else if (oObject.id == "L8") {
        L4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('L8')[0].value));
        dL8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('L8')[0].value));
      }
      else if (oObject.id == "LBONY125") {
        LBONY125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('LBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value));
        dLBONY125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('LBONY125')[0].value));
      }
      else if (oObject.id == "LBONY25") {
        LBONY125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('LBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value));
        LBONY25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value));
        dLBONY25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value));
      }
      else if (oObject.id == "LBONY50") {
        LBONY25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value));
        LBONY50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value));
        dLBONY50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value));
      }
      else if (oObject.id == "LBONY1") {
        LBONY50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value));
        LBONY1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value));
        dLBONY1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value));
      }
      else if (oObject.id == "LBONY2") {
        LBONY1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value));
        LBONY2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value));
        dLBONY2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value));
      }
      else if (oObject.id == "LBONY4") {
        LBONY2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value));
        LBONY4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('LBONY8')[0].value));
        dLBONY4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value));
      }
      else if (oObject.id == "LBONY8") {
        LBONY4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('LBONY8')[0].value));
        dLBONY8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('LBONY8')[0].value));
      }
    }
  }
}
<%
    int iAge = MedwanQuery.getInstance().getAge(Integer.parseInt(activePatient.personid));
    String sGender = checkString(activePatient.gender);
    if ((iAge>0)&&(sGender.length()>0)){
        HearingLoss hearingLoss = Audiometry.calculateHearingloss(iAge, sGender);
        %>
        A125 = new Line(D.ScreenX(0), D.ScreenY(<%=hearingLoss.getLoss1250()%>), D.ScreenX(1), D.ScreenY(<%=hearingLoss.getLoss250()%>), "00AA00", 2, "");
        A25 = new Line(D.ScreenX(1), D.ScreenY(<%=hearingLoss.getLoss250()%>), D.ScreenX(2), D.ScreenY(<%=hearingLoss.getLoss500()%>), "00AA00", 2, "");
        A50 = new Line(D.ScreenX(2), D.ScreenY(<%=hearingLoss.getLoss500()%>), D.ScreenX(3), D.ScreenY(<%=hearingLoss.getLoss1000()%>), "00AA00", 2, "");
        A1 = new Line(D.ScreenX(3), D.ScreenY(<%=hearingLoss.getLoss1000()%>), D.ScreenX(4), D.ScreenY(<%=hearingLoss.getLoss2000()%>), "00AA00", 2, "");
        A2 = new Line(D.ScreenX(4), D.ScreenY(<%=hearingLoss.getLoss2000()%>), D.ScreenX(5), D.ScreenY(<%=hearingLoss.getLoss4000()%>), "00AA00", 2, "");
        A4 = new Line(D.ScreenX(5), D.ScreenY(<%=hearingLoss.getLoss4000()%>), D.ScreenX(6), D.ScreenY(<%=hearingLoss.getLoss8000()%>), "00AA00", 2, "");
        <%
    }
%>
R125 = new Line(D.ScreenX(0), D.ScreenY(document.getElementsByName('R125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value), "ff0000", 2, "");
R25 = new Line(D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value), "ff0000", 2, "");
R50 = new Line(D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value), "ff0000", 2, "");
R1 = new Line(D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value), "ff0000", 2, "");
R2 = new Line(D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value), "ff0000", 2, "");
R4 = new Line(D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('R8')[0].value), "ff0000", 2, "");

dR125 = new Dot(D.ScreenX(0), D.ScreenY(document.getElementsByName('R125')[0].value), 12, 6, "ff0000","");
dR25 = new Dot(D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value), 12, 6, "ff0000","");
dR50 = new Dot(D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value), 12, 6, "ff0000","");
dR1 = new Dot(D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value), 12, 6, "ff0000","");
dR2 = new Dot(D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value), 12, 6, "ff0000","");
dR4 = new Dot(D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value), 12, 6, "ff0000","");
dR8 = new Dot(D.ScreenX(6), D.ScreenY(document.getElementsByName('R8')[0].value), 12, 6, "ff0000","");

L125 = new Line(D.ScreenX(0), D.ScreenY(document.getElementsByName('L125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value), "0000ff", 2, "");
L25 = new Line(D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value), "0000ff", 2, "");
L50 = new Line(D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value), "0000ff", 2, "");
L1 = new Line(D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value), "0000ff", 2, "");
L2 = new Line(D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value), "0000ff", 2, "");
L4 = new Line(D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('L8')[0].value), "0000ff", 2, "");

dL125 = new Dot(D.ScreenX(0), D.ScreenY(document.getElementsByName('L125')[0].value), 12, 1, "0000ff","");
dL25 = new Dot(D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value), 12, 1, "0000ff","");
dL50 = new Dot(D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value), 12, 1, "0000ff","");
dL1 = new Dot(D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value), 12, 1, "0000ff","");
dL2 = new Dot(D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value), 12, 1, "0000ff","");
dL4 = new Dot(D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value), 12, 1, "0000ff","");
dL8 = new Dot(D.ScreenX(6), D.ScreenY(document.getElementsByName('L8')[0].value), 12, 1, "0000ff","");

RBONY125 = new Line(D.ScreenX(0), D.ScreenY(document.getElementsByName('RBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value), "000000", 2, "");
RBONY25 = new Line(D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value), "000000", 2, "");
RBONY50 = new Line(D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value), "000000", 2, "");
RBONY1 = new Line(D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value), "000000", 2, "");
RBONY2 = new Line(D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value), "000000", 2, "");
RBONY4 = new Line(D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('RBONY8')[0].value), "000000", 2, "");

dRBONY125 = new Dot(D.ScreenX(0), D.ScreenY(document.getElementsByName('RBONY125')[0].value), 12, 6, "000000","");
dRBONY25 = new Dot(D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value), 12, 6, "000000","");
dRBONY50 = new Dot(D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value), 12, 6, "000000","");
dRBONY1 = new Dot(D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value), 12, 6, "000000","");
dRBONY2 = new Dot(D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value), 12, 6, "000000","");
dRBONY4 = new Dot(D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value), 12, 6, "000000","");
dRBONY8 = new Dot(D.ScreenX(6), D.ScreenY(document.getElementsByName('RBONY8')[0].value), 12, 6, "000000","");

LBONY125 = new Line(D.ScreenX(0), D.ScreenY(document.getElementsByName('LBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value), "800080", 2, "");
LBONY25 = new Line(D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value), "800080", 2, "");
LBONY50 = new Line(D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value), "800080", 2, "");
LBONY1 = new Line(D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value), "800080", 2, "");
LBONY2 = new Line(D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value), "800080", 2, "");
LBONY4 = new Line(D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('LBONY8')[0].value), "800080", 2, "");

dLBONY125 = new Dot(D.ScreenX(0), D.ScreenY(document.getElementsByName('LBONY125')[0].value), 12, 1, "800080","");
dLBONY25 = new Dot(D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value), 12, 1, "800080","");
dLBONY50 = new Dot(D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value), 12, 1, "800080","");
dLBONY1 = new Dot(D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value), 12, 1, "800080","");
dLBONY2 = new Dot(D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value), 12, 1, "800080","");
dLBONY4 = new Dot(D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value), 12, 1, "800080","");
dLBONY8 = new Dot(D.ScreenX(6), D.ScreenY(document.getElementsByName('LBONY8')[0].value), 12, 1, "800080","");

////////////////////////////////////////////////////////////////////////////

var H = new Diagram();
H.SetFrame(520, 175, 680, 280);
H.XScale="";
H.YScale="1";
H.SetBorder(0,6,100,-10);
_DivDiagram = 'audiometricGraph2';
H.Draw("#FFFFFF", "#000000", false, "", "", "#DDDDFF","#CCCCCC");

var HLR125, HLR25, HLR50, HLR1, HLR2, HLR4, HLL125, HLL25, HLL50, HLL1, HLL2, HLL4
, HdR125, HdR25, HdR50, HdR1, HdR2, HdR4, HdR8, HdL125, HdL25, HdL50, HdL1, HdL2, HdL4, HdL8
,HLRBONY125, HLRBONY25, HLRBONY50, HLRBONY1, HLRBONY2, HLRBONY4, HLLBONY125, HLLBONY25, HLLBONY50, HLBONYL1, HLLBONY2, HLLBONY4
, HdRBONY125, HdRBONY25, HdRBONY50, HdRBONY1, HdRBONY2, HdRBONY4, HdRBONY8, HdLBONY125, HdLBONY25, HdLBONY50, HdLBONY1, HdLBONY2, HdLBONY4, HdLBONY8;

function changeHistory(){
  sOption = document.getElementsByName('History')[0].value;

  HLR125.ResizeTo(H.ScreenX(0), H.ScreenY(getH("RIGHT_0125")), H.ScreenX(1), H.ScreenY(getH("RIGHT_025")));
  HdR125.MoveTo(H.ScreenX(0), H.ScreenY(getH("RIGHT_0125")));
  HLR25.ResizeTo(H.ScreenX(1), H.ScreenY(getH("RIGHT_025")), H.ScreenX(2), H.ScreenY(getH("RIGHT_050")));
  HdR25.MoveTo(H.ScreenX(1), H.ScreenY(getH("RIGHT_025")));
  HLR50.ResizeTo(H.ScreenX(2), H.ScreenY(getH("RIGHT_050")), H.ScreenX(3), H.ScreenY(getH("RIGHT_1")));
  HdR50.MoveTo(H.ScreenX(2), H.ScreenY(getH("RIGHT_050")));
  HLR1.ResizeTo(H.ScreenX(3), H.ScreenY(getH("RIGHT_1")), H.ScreenX(4), H.ScreenY(getH("RIGHT_2")));
  HdR1.MoveTo(H.ScreenX(4), H.ScreenY(getH("RIGHT_1")));
  HLR2.ResizeTo(H.ScreenX(4), H.ScreenY(getH("RIGHT_2")), H.ScreenX(5), H.ScreenY(getH("RIGHT_4")));
  HdR2.MoveTo(H.ScreenX(5), H.ScreenY(getH("RIGHT_2")));
  HLR4.ResizeTo(H.ScreenX(5), H.ScreenY(getH("RIGHT_4")), H.ScreenX(6), H.ScreenY(getH("RIGHT_8")));
  HdR4.MoveTo(H.ScreenX(5), H.ScreenY(getH("RIGHT_4")));
  HdR8.MoveTo(H.ScreenX(6), H.ScreenY(getH("RIGHT_8")));

  HLL125.ResizeTo(H.ScreenX(0), H.ScreenY(getH("LEFT_0125")), H.ScreenX(1), H.ScreenY(getH("LEFT_025")));
  HdL125.MoveTo(H.ScreenX(0), H.ScreenY(getH("LEFT_0125")));
  HLL25.ResizeTo(H.ScreenX(1), H.ScreenY(getH("LEFT_025")), H.ScreenX(2), H.ScreenY(getH("LEFT_050")));
  HdL25.MoveTo(H.ScreenX(1), H.ScreenY(getH("LEFT_025")));
  HLL50.ResizeTo(H.ScreenX(2), H.ScreenY(getH("LEFT_050")), H.ScreenX(3), H.ScreenY(getH("LEFT_1")));
  HdL50.MoveTo(H.ScreenX(2), H.ScreenY(getH("LEFT_050")));
  HLL1.ResizeTo(H.ScreenX(3), H.ScreenY(getH("LEFT_1")), H.ScreenX(4), H.ScreenY(getH("LEFT_2")));
  HdL1.MoveTo(H.ScreenX(3), H.ScreenY(getH("LEFT_1")));
  HLL2.ResizeTo(H.ScreenX(4), H.ScreenY(getH("LEFT_2")), H.ScreenX(5), H.ScreenY(getH("LEFT_4")));
  HdL2.MoveTo(H.ScreenX(4), H.ScreenY(getH("LEFT_2")));
  HLL4.ResizeTo(H.ScreenX(5), H.ScreenY(getH("LEFT_4")), H.ScreenX(6), H.ScreenY(getH("LEFT_8")));
  HdL4.MoveTo(H.ScreenX(5), H.ScreenY(getH("LEFT_4")));
  HdL8.MoveTo(H.ScreenX(6), H.ScreenY(getH("LEFT_8")));

  HLRBONY125.ResizeTo(H.ScreenX(0), H.ScreenY(getH("BONY_RIGHT_0125")), H.ScreenX(1), H.ScreenY(getH("BONY_RIGHT_025")));
  HdRBONY125.MoveTo(H.ScreenX(0), H.ScreenY(getH("BONY_RIGHT_0125")));
  HLRBONY25.ResizeTo(H.ScreenX(1), H.ScreenY(getH("BONY_RIGHT_025")), H.ScreenX(2), H.ScreenY(getH("BONY_RIGHT_050")));
  HdRBONY25.MoveTo(H.ScreenX(1), H.ScreenY(getH("BONY_RIGHT_025")));
  HLRBONY50.ResizeTo(H.ScreenX(2), H.ScreenY(getH("BONY_RIGHT_050")), H.ScreenX(3), H.ScreenY(getH("BONY_RIGHT_1")));
  HdRBONY50.MoveTo(H.ScreenX(2), H.ScreenY(getH("BONY_RIGHT_050")));
  HLRBONY1.ResizeTo(H.ScreenX(3), H.ScreenY(getH("BONY_RIGHT_1")), H.ScreenX(4), H.ScreenY(getH("BONY_RIGHT_2")));
  HdRBONY1.MoveTo(H.ScreenX(4), H.ScreenY(getH("BONY_RIGHT_1")));
  HLRBONY2.ResizeTo(H.ScreenX(4), H.ScreenY(getH("BONY_RIGHT_2")), H.ScreenX(5), H.ScreenY(getH("BONY_RIGHT_4")));
  HdRBONY2.MoveTo(H.ScreenX(5), H.ScreenY(getH("BONY_RIGHT_2")));
  HLRBONY4.ResizeTo(H.ScreenX(5), H.ScreenY(getH("BONY_RIGHT_4")), H.ScreenX(6), H.ScreenY(getH("BONY_RIGHT_8")));
  HdRBONY4.MoveTo(H.ScreenX(5), H.ScreenY(getH("BONY_RIGHT_4")));
  HdRBONY8.MoveTo(H.ScreenX(6), H.ScreenY(getH("BONY_RIGHT_8")));

  HLLBONY125.ResizeTo(H.ScreenX(0), H.ScreenY(getH("BONY_LEFT_0125")), H.ScreenX(1), H.ScreenY(getH("BONY_LEFT_025")));
  HdLBONY125.MoveTo(H.ScreenX(0), H.ScreenY(getH("BONY_LEFT_0125")));
  HLLBONY25.ResizeTo(H.ScreenX(1), H.ScreenY(getH("BONY_LEFT_025")), H.ScreenX(2), H.ScreenY(getH("BONY_LEFT_050")));
  HdLBONY25.MoveTo(H.ScreenX(1), H.ScreenY(getH("BONY_LEFT_025")));
  HLLBONY50.ResizeTo(H.ScreenX(2), H.ScreenY(getH("BONY_LEFT_050")), H.ScreenX(3), H.ScreenY(getH("BONY_LEFT_1")));
  HdLBONY50.MoveTo(H.ScreenX(2), H.ScreenY(getH("BONY_LEFT_050")));
  HLLBONY1.ResizeTo(H.ScreenX(3), H.ScreenY(getH("BONY_LEFT_1")), H.ScreenX(4), H.ScreenY(getH("BONY_LEFT_2")));
  HdLBONY1.MoveTo(H.ScreenX(3), H.ScreenY(getH("BONY_LEFT_1")));
  HLLBONY2.ResizeTo(H.ScreenX(4), H.ScreenY(getH("BONY_LEFT_2")), H.ScreenX(5), H.ScreenY(getH("BONY_LEFT_4")));
  HdLBONY2.MoveTo(H.ScreenX(4), H.ScreenY(getH("BONY_LEFT_2")));
  HLLBONY4.ResizeTo(H.ScreenX(5), H.ScreenY(getH("BONY_LEFT_4")), H.ScreenX(6), H.ScreenY(getH("BONY_LEFT_8")));
  HdLBONY4.MoveTo(H.ScreenX(5), H.ScreenY(getH("BONY_LEFT_4")));
  HdLBONY8.MoveTo(H.ScreenX(6), H.ScreenY(getH("BONY_LEFT_8")));

  function getH(sItem) {
    sTmp = sOption.substring(sOption.indexOf(":"+sItem)+sItem.length+2);
    return sTmp.substring(0,sTmp.indexOf(";"));
  }
}

HdR125 = new Dot(H.ScreenX(0), H.ScreenY(0), 8, 6, "ff0000","");
HdR25 = new Dot(H.ScreenX(1), H.ScreenY(0), 8, 6, "ff0000","");
HdR50 = new Dot(H.ScreenX(2), H.ScreenY(0), 8, 6, "ff0000","");
HdR1 = new Dot(H.ScreenX(3), H.ScreenY(0), 8, 6, "ff0000","");
HdR2 = new Dot(H.ScreenX(4), H.ScreenY(0), 8, 6, "ff0000","");
HdR4 = new Dot(H.ScreenX(5), H.ScreenY(0), 8, 6, "ff0000","");
HdR8 = new Dot(H.ScreenX(6), H.ScreenY(0), 8, 6, "ff0000","");

HdL125 = new Dot(H.ScreenX(0), H.ScreenY(0), 8, 1, "0000ff","");
HdL25 = new Dot(H.ScreenX(1), H.ScreenY(0), 8, 1, "0000ff","");
HdL50 = new Dot(H.ScreenX(2), H.ScreenY(0), 8, 1, "0000ff","");
HdL1 = new Dot(H.ScreenX(3), H.ScreenY(0), 8, 1, "0000ff","");
HdL2 = new Dot(H.ScreenX(4), H.ScreenY(0), 8, 1, "0000ff","");
HdL4 = new Dot(H.ScreenX(5), H.ScreenY(0), 8, 1, "0000ff","");
HdL8 = new Dot(H.ScreenX(6), H.ScreenY(0), 8, 1, "0000ff","");

HLR125 = new Line(H.ScreenX(0), H.ScreenY(0), H.ScreenX(1), H.ScreenY(0), "ff0000", 1, "");
HLR25 = new Line(H.ScreenX(1), H.ScreenY(0), H.ScreenX(2), H.ScreenY(0), "ff0000", 1, "");
HLR50 = new Line(H.ScreenX(2), H.ScreenY(0), H.ScreenX(3), H.ScreenY(0), "ff0000", 1, "");
HLR1 = new Line(H.ScreenX(3), H.ScreenY(0), H.ScreenX(4), H.ScreenY(0), "ff0000", 1, "");
HLR2 = new Line(H.ScreenX(4), H.ScreenY(0), H.ScreenX(5), H.ScreenY(0), "ff0000", 1, "");
HLR4 = new Line(H.ScreenX(5), H.ScreenY(0), H.ScreenX(6), H.ScreenY(0), "ff0000", 1, "");

HLL125 = new Line(H.ScreenX(0), H.ScreenY(0), H.ScreenX(1), H.ScreenY(0), "0000ff", 1, "");
HLL25 = new Line(H.ScreenX(1), H.ScreenY(0), H.ScreenX(2), H.ScreenY(0), "0000ff", 1, "");
HLL50 = new Line(H.ScreenX(2), H.ScreenY(0), H.ScreenX(3), H.ScreenY(0), "0000ff", 1, "");
HLL1 = new Line(H.ScreenX(3), H.ScreenY(0), H.ScreenX(4), H.ScreenY(0), "0000ff", 1, "");
HLL2 = new Line(H.ScreenX(4), H.ScreenY(0), H.ScreenX(5), H.ScreenY(0), "0000ff", 1, "");
HLL4 = new Line(H.ScreenX(5), H.ScreenY(0), H.ScreenX(6), H.ScreenY(0), "0000ff", 1, "");

HdRBONY125 = new Dot(H.ScreenX(0), H.ScreenY(0), 8, 6, "000000","");
HdRBONY25 = new Dot(H.ScreenX(1), H.ScreenY(0), 8, 6, "000000","");
HdRBONY50 = new Dot(H.ScreenX(2), H.ScreenY(0), 8, 6, "000000","");
HdRBONY1 = new Dot(H.ScreenX(3), H.ScreenY(0), 8, 6, "000000","");
HdRBONY2 = new Dot(H.ScreenX(4), H.ScreenY(0), 8, 6, "000000","");
HdRBONY4 = new Dot(H.ScreenX(5), H.ScreenY(0), 8, 6, "000000","");
HdRBONY8 = new Dot(H.ScreenX(6), H.ScreenY(0), 8, 6, "000000","");

HdLBONY125 = new Dot(H.ScreenX(0), H.ScreenY(0), 8, 1, "800080","");
HdLBONY25 = new Dot(H.ScreenX(1), H.ScreenY(0), 8, 1, "800080","");
HdLBONY50 = new Dot(H.ScreenX(2), H.ScreenY(0), 8, 1, "800080","");
HdLBONY1 = new Dot(H.ScreenX(3), H.ScreenY(0), 8, 1, "800080","");
HdLBONY2 = new Dot(H.ScreenX(4), H.ScreenY(0), 8, 1, "800080","");
HdLBONY4 = new Dot(H.ScreenX(5), H.ScreenY(0), 8, 1, "800080","");
HdLBONY8 = new Dot(H.ScreenX(6), H.ScreenY(0), 8, 1, "800080","");

HLRBONY125 = new Line(H.ScreenX(0), H.ScreenY(0), H.ScreenX(1), H.ScreenY(0), "000000", 1, "");
HLRBONY25 = new Line(H.ScreenX(1), H.ScreenY(0), H.ScreenX(2), H.ScreenY(0), "000000", 1, "");
HLRBONY50 = new Line(H.ScreenX(2), H.ScreenY(0), H.ScreenX(3), H.ScreenY(0), "000000", 1, "");
HLRBONY1 = new Line(H.ScreenX(3), H.ScreenY(0), H.ScreenX(4), H.ScreenY(0), "000000", 1, "");
HLRBONY2 = new Line(H.ScreenX(4), H.ScreenY(0), H.ScreenX(5), H.ScreenY(0), "000000", 1, "");
HLRBONY4 = new Line(H.ScreenX(5), H.ScreenY(0), H.ScreenX(6), H.ScreenY(0), "000000", 1, "");

HLLBONY125 = new Line(H.ScreenX(0), H.ScreenY(0), H.ScreenX(1), H.ScreenY(0), "800080", 1, "");
HLLBONY25 = new Line(H.ScreenX(1), H.ScreenY(0), H.ScreenX(2), H.ScreenY(0), "800080", 1, "");
HLLBONY50 = new Line(H.ScreenX(2), H.ScreenY(0), H.ScreenX(3), H.ScreenY(0), "800080", 1, "");
HLLBONY1 = new Line(H.ScreenX(3), H.ScreenY(0), H.ScreenX(4), H.ScreenY(0), "800080", 1, "");
HLLBONY2 = new Line(H.ScreenX(4), H.ScreenY(0), H.ScreenX(5), H.ScreenY(0), "800080", 1, "");
HLLBONY4 = new Line(H.ScreenX(5), H.ScreenY(0), H.ScreenX(6), H.ScreenY(0), "800080", 1, "");

changeHistory();

function setVisibility(bVisible){
  D.SetVisibility(bVisible);
  R125.SetVisibility(bVisible);
  R25.SetVisibility(bVisible);
  R50.SetVisibility(bVisible);
  R1.SetVisibility(bVisible);
  R2.SetVisibility(bVisible);
  R4.SetVisibility(bVisible);
  L125.SetVisibility(bVisible);
  L25.SetVisibility(bVisible);
  L50.SetVisibility(bVisible);
  L1.SetVisibility(bVisible);
  L2.SetVisibility(bVisible);
  L4.SetVisibility(bVisible);
  dR125.SetVisibility(bVisible);
  dR25.SetVisibility(bVisible);
  dR50.SetVisibility(bVisible);
  dR1.SetVisibility(bVisible);
  dR2.SetVisibility(bVisible);
  dR4.SetVisibility(bVisible);
  dR8.SetVisibility(bVisible);
  dL125.SetVisibility(bVisible);
  dL25.SetVisibility(bVisible);
  dL50.SetVisibility(bVisible);
  dL1.SetVisibility(bVisible);
  dL2.SetVisibility(bVisible);
  dL4.SetVisibility(bVisible);
  dL8.SetVisibility(bVisible);
  A125.SetVisibility(bVisible);
  A25.SetVisibility(bVisible);
  A50.SetVisibility(bVisible);
  A1.SetVisibility(bVisible);
  A2.SetVisibility(bVisible);
  A4.SetVisibility(bVisible);

  RBONY125.SetVisibility(bVisible);
  RBONY25.SetVisibility(bVisible);
  RBONY50.SetVisibility(bVisible);
  RBONY1.SetVisibility(bVisible);
  RBONY2.SetVisibility(bVisible);
  RBONY4.SetVisibility(bVisible);
  LBONY125.SetVisibility(bVisible);
  LBONY25.SetVisibility(bVisible);
  LBONY50.SetVisibility(bVisible);
  LBONY1.SetVisibility(bVisible);
  LBONY2.SetVisibility(bVisible);
  LBONY4.SetVisibility(bVisible);
  dRBONY125.SetVisibility(bVisible);
  dRBONY25.SetVisibility(bVisible);
  dRBONY50.SetVisibility(bVisible);
  dRBONY1.SetVisibility(bVisible);
  dRBONY2.SetVisibility(bVisible);
  dRBONY4.SetVisibility(bVisible);
  dRBONY8.SetVisibility(bVisible);
  dLBONY125.SetVisibility(bVisible);
  dLBONY25.SetVisibility(bVisible);
  dLBONY50.SetVisibility(bVisible);
  dLBONY1.SetVisibility(bVisible);
  dLBONY2.SetVisibility(bVisible);
  dLBONY4.SetVisibility(bVisible);
  dLBONY8.SetVisibility(bVisible);

  if (bVisible) {
    document.getElementsByName('freqs')[0].style.display='block';
    R125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('R125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value));
    dR125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('R125')[0].value));
    R25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value));
    dR25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('R25')[0].value));
    R50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value));
    dR50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('R50')[0].value));
    R1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value));
    dR1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('R1')[0].value));
    R2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value));
    dR2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('R2')[0].value));
    R4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('R8')[0].value));
    dR4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('R4')[0].value));
    dR8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('R8')[0].value));

    L125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('L125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value));
    dL125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('L125')[0].value));
    L25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value));
    dL25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('L25')[0].value));
    L50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value));
    dL50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('L50')[0].value));
    L1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value));
    dL1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('L1')[0].value));
    L2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value));
    dL2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('L2')[0].value));
    L4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('L8')[0].value));
    dL4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('L4')[0].value));
    dL8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('L8')[0].value));

    RBONY125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('RBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value));
    dRBONY125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('RBONY125')[0].value));
    RBONY25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value));
    dRBONY25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('RBONY25')[0].value));
    RBONY50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value));
    dRBONY50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('RBONY50')[0].value));
    RBONY1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value));
    dRBONY1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('RBONY1')[0].value));
    RBONY2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value));
    dRBONY2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('RBONY2')[0].value));
    RBONY4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('RBONY8')[0].value));
    dRBONY4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('RBONY4')[0].value));
    dRBONY8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('RBONY8')[0].value));

    LBONY125.ResizeTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('LBONY125')[0].value), D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value));
    dLBONY125.MoveTo(D.ScreenX(0), D.ScreenY(document.getElementsByName('LBONY125')[0].value));
    LBONY25.ResizeTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value), D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value));
    dLBONY25.MoveTo(D.ScreenX(1), D.ScreenY(document.getElementsByName('LBONY25')[0].value));
    LBONY50.ResizeTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value), D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value));
    dLBONY50.MoveTo(D.ScreenX(2), D.ScreenY(document.getElementsByName('LBONY50')[0].value));
    LBONY1.ResizeTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value), D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value));
    dLBONY1.MoveTo(D.ScreenX(3), D.ScreenY(document.getElementsByName('LBONY1')[0].value));
    LBONY2.ResizeTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value), D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value));
    dLBONY2.MoveTo(D.ScreenX(4), D.ScreenY(document.getElementsByName('LBONY2')[0].value));
    LBONY4.ResizeTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value), D.ScreenX(6), D.ScreenY(document.getElementsByName('LBONY8')[0].value));
    dLBONY4.MoveTo(D.ScreenX(5), D.ScreenY(document.getElementsByName('LBONY4')[0].value));
    dLBONY8.MoveTo(D.ScreenX(6), D.ScreenY(document.getElementsByName('LBONY8')[0].value));
  }
  else {
    document.getElementsByName('freqs')[0].style.display='none';
  }
}

if (document.getElementsByName('transactionId')[0].value.substring(0,1)=="-"){
    document.getElementById("R125").options.selectedIndex = 1;
    document.getElementById("R25").options.selectedIndex = 1;
    document.getElementById("R50").options.selectedIndex = 1;
    document.getElementById("R1").options.selectedIndex = 1;
    document.getElementById("R2").options.selectedIndex = 1;
    document.getElementById("R4").options.selectedIndex = 1;
    document.getElementById("R8").options.selectedIndex = 1;
    document.getElementById("L125").options.selectedIndex = 1;
    document.getElementById("L25").options.selectedIndex = 1;
    document.getElementById("L50").options.selectedIndex = 1;
    document.getElementById("L1").options.selectedIndex = 1;
    document.getElementById("L2").options.selectedIndex = 1;
    document.getElementById("L4").options.selectedIndex = 1;
    document.getElementById("L8").options.selectedIndex = 1;

    document.getElementById("RBONY125").options.selectedIndex = 1;
    document.getElementById("RBONY25").options.selectedIndex = 1;
    document.getElementById("RBONY50").options.selectedIndex = 1;
    document.getElementById("RBONY1").options.selectedIndex = 1;
    document.getElementById("RBONY2").options.selectedIndex = 1;
    document.getElementById("RBONY4").options.selectedIndex = 1;
    document.getElementById("RBONY8").options.selectedIndex = 1;
    document.getElementById("LBONY125").options.selectedIndex = 1;
    document.getElementById("LBONY25").options.selectedIndex = 1;
    document.getElementById("LBONY50").options.selectedIndex = 1;
    document.getElementById("LBONY1").options.selectedIndex = 1;
    document.getElementById("LBONY2").options.selectedIndex = 1;
    document.getElementById("LBONY4").options.selectedIndex = 1;
    document.getElementById("LBONY8").options.selectedIndex = 1;
}

  <%-- SUBMIT FORM --%>
  function submitForm(){
    if(document.getElementById('encounteruid').value==''){
		alert('<%=getTranNoLink("web","no.encounter.linked",sWebLanguage)%>');
		searchEncounter();
	}	
    else {
	    document.transactionForm.saveButton.style.visibility = "hidden";
	     var temp = Form.findFirstElement(transactionForm);
	      <%
	          out.print(takeOverTransaction(sessionContainerWO, activeUser,"document.transactionForm.submit();"));
	      %>
    }
  }
  function searchEncounter(){
      openPopup("/_common/search/searchEncounter.jsp&ts=<%=getTs()%>&VarCode=currentTransactionVO.items.<ItemVO[hashCode=<mxs:propertyAccessorI18N name="transaction.items" scope="page" compare="type=be.mxs.common.model.vo.healthrecord.IConstants.ITEM_TYPE_CONTEXT_ENCOUNTERUID" property="itemId"/>]>.value&VarText=&FindEncounterPatient=<%=activePatient.personid%>");
  }
  if(document.getElementById('encounteruid').value==''){
	alert('<%=getTranNoLink("web","no.encounter.linked",sWebLanguage)%>');
	searchEncounter();
  }	

</script>

<%=writeJSButtons("transactionForm", "save")%>