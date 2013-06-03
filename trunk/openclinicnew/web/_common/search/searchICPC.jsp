<%@page import="be.mxs.common.model.vo.healthrecord.ICPCCode,
                be.openclinic.medical.UserDiagnosis,java.util.Vector" %>
<%@page errorPage="/includes/error.jsp"%>
<%@include file="/includes/validateUser.jsp"%>
<%
    String sCodeClass =MedwanQuery.getInstance().getConfigString("ICPCClass","diagnosis");
    boolean bSubClasses=MedwanQuery.getInstance().getConfigInt("ICPCSubClasses",0)>0;
    String sListMode = checkString(request.getParameter("ListMode"));
    String sListChoice = checkString(request.getParameter("ListChoice"));
    String sListLink = "";
    if(sListMode.equals("ALL")){
        sListLink = "MY_LIST";
    }else{
        sListLink = "ALL";
    }

%>
<form name="icpcForm" method="post" onSubmit="doFind();">
    <input type="hidden" name="ListMode" value="">
    <table class='menu' width='100%' cellspacing="0" border='0'>
        <tr>
            <td><%=getTran("Web","Keyword",sWebLanguage)%>&nbsp;&nbsp;</td>
            <td colspan='2'>
                <input type='text' class='text' name='keywords' size='40' value="<%=request.getParameter("keywords")!=null?request.getParameter("keywords"):""%>" onblur="validateText(this);limitLength(this);" onKeyDown='if(event.keyCode==13){doFind();return false;}else{return true;}'/>
                <input class='button' type='button' name='findButton' onClick='doFind();' value='<%=getTran("Web","Find",sWebLanguage)%>'/>
                <input class='button' type='button' name='cancel' onclick='window.close()' value='<%=getTran("Web","Close",sWebLanguage)%>'/>
            </td>
        </tr>
        <script type="text/javascript">
            document.getElementsByName('keywords')[0].focus();
      </script>

        <tr><td class="navigation_line" height="1" colspan="3"></td></tr>
        <tr><td colspan='3'><span id='info'></span></td></tr>
        <%
            if (sListMode.equals("MY_LIST") || sListMode.equals("")) {

                String keywords = checkString(request.getParameter("keywords"));
                Vector vUserDiagnoses = new Vector();
                vUserDiagnoses = UserDiagnosis.selectUserDiagnoses(activeUser.userid, "", "", "");

                Iterator iter = vUserDiagnoses.iterator();

                UserDiagnosis uTmp;
                int foundRecordsICPC2 = 0;
                int foundRecordsICD10 = 0;
                StringBuffer sbResultsICPC2 = new StringBuffer();
                StringBuffer sbResultsICd10 = new StringBuffer();

                String sCode = "";
                String sCodeType = "";
                String sLabel = "";

                while (iter.hasNext()) {
                    uTmp = (UserDiagnosis) iter.next();
                    sCode = checkString(uTmp.getCode());
                    sCodeType = checkString(uTmp.getCodeType());
                    // parent-codes end with xx00
                    if (sCodeType.equals("icpc")) {
                        if(sCodeClass.equalsIgnoreCase("diagnosis") && "789".indexOf(sCode.substring(1,2))==-1){
                            continue;
                        }
                        if(!bSubClasses && sCode.length()==5 && !sCode.substring(3,5).equalsIgnoreCase("00")){
                            continue;
                        }
                        if (sCode.length()==5 && sCode.substring(3, 5).equalsIgnoreCase("00")) {
                            sbResultsICPC2.append("<tr class='label2'>");
                        } else {
                            sbResultsICPC2.append("<tr>");
                        }
                        sLabel = checkString(MedwanQuery.getInstance().getCodeTran(sCodeType + "code" + sCode, sWebLanguage));
                        sbResultsICPC2.append(" <td width='15%' onclick='addICPC(\"" + sCode + "\",\"" + sLabel + "\",\"" + sCodeType + "\");'>" + sCode + "</td>");
                        sbResultsICPC2.append(" <td onclick='addICPC(\"" + sCode + "\",\"" + sLabel + "\",\"" + sCodeType + "\");'>" + sLabel + "</td>");
                        sbResultsICPC2.append("</tr>");
                        foundRecordsICPC2++;
                    } else if (sCodeType.equals("icd10")) {
                        if (sCode.indexOf(".")==-1) {
                            sbResultsICd10.append("<tr class='label2'>");
                        } else {
                            sbResultsICd10.append("<tr>");
                        }
                        sLabel = checkString(MedwanQuery.getInstance().getCodeTran(sCodeType + "code" + sCode, sWebLanguage));
                        sbResultsICd10.append(" <td width='15%' onclick='addICPC(\"" + sCode + "\",\"" + sLabel + "\",\"" + sCodeType + "\");'>" + sCode + "</td>");
                        sbResultsICd10.append(" <td onclick='addICPC(\"" + sCode + "\",\"" + sLabel + "\",\"" + sCodeType + "\");'>" + sLabel + "</td>");
                        sbResultsICd10.append("</tr>");
                        foundRecordsICD10++;
                    }
                }


                if (foundRecordsICPC2 > 0) {
                    out.print("<tr class='admin'><td colspan='2'>" + getTran("Web.Occup", "ICPC-2", sWebLanguage) + "</td></tr>");
                }
        %><tbody onmouseover='this.style.cursor="hand"' onmouseout='this.style.cursor="default"'><%

            out.print(sbResultsICPC2.toString());

            if(foundRecordsICD10 > 0){
                out.print("</table><table class='menu' width='100%' cellspacing='0' border='0'>");
                out.print("<tr class='admin'><td colspan='2'>"+getTran("Web.Occup","ICD-10",sWebLanguage)+"</td></tr>");
            }
            %><tbody onmouseover='this.style.cursor="hand"' onmouseout='this.style.cursor="default"'><%

            out.print(sbResultsICd10.toString());

            if(foundRecordsICPC2==0 && foundRecordsICD10 == 0 && keywords.length() > 1){
                // display 'no results' message
                %>
                    <tr class="label2">
                        <td colspan='3'><%=getTran("web","norecordsfound",sWebLanguage)%></td>
                    </tr>
                <%
            }
        }else{

            String keywords = checkString(request.getParameter("keywords"));
            int foundRecords = 0;

            // List the found ICPC-codes
            if (keywords.length() > 0){
                MedwanQuery.getInstance();
                String sLanguage = "N";
                if(sWebLanguage.toUpperCase().equals("NL")){
                    sLanguage = "N";
                }else if(sWebLanguage.toUpperCase().equals("FR")){
                    sLanguage = "F";
                }else if(sWebLanguage.toUpperCase().equals("EN")){
                    sLanguage = "E";
                }
                Vector codes = MedwanQuery.getInstance().findICPCCodes(keywords,sLanguage);
                ICPCCode code;

                // header
                if(codes.size() > 0){
                    out.print("<tr class='admin'><td colspan='2'>"+getTran("Web.Occup","ICPC-2",sWebLanguage)+"</td></tr>");
                }

                %><tbody onmouseover='this.style.cursor="hand"' onmouseout='this.style.cursor="default"'><%

                for (int n=0; n<codes.size(); n++){
                    foundRecords++;

                    code = (ICPCCode)codes.elementAt(n);
					if("ABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf(code.code.substring(0,1).toUpperCase())<0){
						continue;
					}
                    if(sCodeClass.equalsIgnoreCase("diagnosis") && "789".indexOf(code.code.substring(1,2))==-1){
                        continue;
                    }
                    if(!bSubClasses && code.code.length()==5 && !code.code.substring(3,5).equalsIgnoreCase("00")){
                        continue;
                    }

                    // parent-codes end with xx00
                    if (code.code.length()==5 && code.code.substring(3,5).equalsIgnoreCase("00")){
                        out.print("<tr class='label2'>");
                    }
                    else {
                        out.print("<tr>");
                    }

                    out.print(" <td onclick='addICPC(\""+code.code+"\",\""+code.label+"\",\"icpc\");'>"+code.code+"</td>");
                    out.print(" <td onclick='addICPC(\""+code.code+"\",\""+code.label+"\",\"icpc\");'>"+code.label+"</td>");
                    out.print("</tr>");
                }

                if (MedwanQuery.getInstance().getConfigInt("enableICD10")==1 || request.getParameter("enableICD10")!=null){
                    // Hier worden de geselecteerde ICD10-codes getoond
                    codes = MedwanQuery.getInstance().findICD10Codes(request.getParameter("keywords"),sLanguage);

                    // header
                    if(codes.size() > 0){
                        out.print("<tr class='admin'><td colspan='2'>"+getTran("Web.Occup","ICD-10",sWebLanguage)+"</td></tr>");
                    }

                    for (int n=0; n<codes.size(); n++){

                        code = (ICPCCode)codes.elementAt(n);
    					if("ABCDEFGHIJKLMNOPQRSTUVWXYZ".indexOf(code.code.substring(0,1).toUpperCase())<0){
    						continue;
    					}
                        foundRecords++;
                        if (code.code.length()<=3){
                            out.print("<tr class='label2'>");
                        }
                        else {
                            out.print("<tr>");
                        }

                        out.print(" <td onclick='addICD10(\""+code.code+"\",\""+code.label+"\",\"icd10\");'>"+code.code+"</td>");
                        out.print(" <td onclick='addICD10(\""+code.code+"\",\""+code.label+"\",\"icd10\");' onmouseover='this.style.cursor=\"hand\"' onmouseout='this.style.cursor=\"default\"'>"+code.label+"</td>");
                        out.print("</tr>");
                    }
                }

                %></tbody><%
            }
            if(foundRecords==0 && keywords.length() > 0){
                // display 'no results' message
                %>
                    <tr class="label2">
                        <td colspan='2'><%=getTran("web","norecordsfound",sWebLanguage)%></td>
                    </tr>
                <%
            }
        }
        %>
    </table>
</form>
<%
    if(sListChoice.equals("TRUE")){
%>
<script type="text/javascript">
    function selectMyCodes(){
        window.location.href="<c:url value='/'/>popup.jsp?Page=_common/search/searchICPC.jsp&returnField=<%=checkString(request.getParameter("returnField"))%>&returnField2=<%=checkString(request.getParameter("returnField2"))%>&ListMode=<%=sListLink%>&ListChoice=TRUE";
    }
</script>
<a href="javascript:selectMyCodes();">
<%
        if(sListMode.equals("ALL")){
            out.print(getTranNoLink("medical.diagnosis","search_in_my_list",sWebLanguage));
        }
    %>
</a>
<%
    }
    String sReturnField = checkString(request.getParameter("returnField"));
    String sReturnField2 = checkString(request.getParameter("returnField2"));
    String sReturnField3 = checkString(request.getParameter("returnField3"));
    //Debug.println("sReturnField" + ": "  +sReturnField);
    //Debug.println("sReturnField2" + ": "  +sReturnField2);
    //Debug.println("sReturnField3" + ": "  +sReturnField3);
%>

<script>
  window.resizeTo(700,470);
  document.getElementById('info').innerHTML='';

  function doFind(){
    ToggleFloatingLayer('FloatingLayer',1);
    icpcForm.findButton.disabled = true;
    icpcForm.ListMode.value="ALL";
    icpcForm.submit();
  }

  function addICPC(code,label,codeType){
    <%
        if(sReturnField.length() > 0){
    %>
        window.opener.document.getElementById('<%=sReturnField%>').value = code;
    <%
        }
        if(sReturnField2.length() > 0){
    %>
        window.opener.document.getElementById('<%=sReturnField2%>').value = code + " " + label;
    <%
        }
        if(sReturnField3.length() > 0){
    %>
        window.opener.document.getElementById('<%=sReturnField3%>').value = codeType;
    <%
        }
    %>
    window.close();
  }

  function addICD10(code,label,codeType){
    <%
        if(sReturnField.length() > 0){
    %>
        window.opener.document.getElementById('<%=sReturnField%>').value = code;
    <%
        }
        if(sReturnField2.length() > 0){
    %>
        window.opener.document.getElementById('<%=sReturnField2%>').value = code+": " + label;
    <%
        }
        if(sReturnField3.length() > 0){
    %>
        window.opener.document.getElementById('<%=sReturnField3%>').value = codeType;
    <%
        }
    %>
    window.close();
  }
  window.setTimeout("document.getElementsByName('keywords')[0].focus()",200);
</script>
