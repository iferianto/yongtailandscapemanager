<%@page import="be.openclinic.pharmacy.ProductStock"%>
<%@ page import="java.text.DecimalFormat,
                 be.openclinic.pharmacy.Product,
                 java.util.Vector,
                 be.mxs.common.util.system.HTMLEntities" %>
<%@ page errorPage="/includes/error.jsp" %>
<%@ include file="/includes/validateUser.jsp" %>

<%
    String sSearchProductName = HTMLEntities.unhtmlentities(checkString(request.getParameter("SearchProductName"))),
            sSearchSupplierUid = checkString(request.getParameter("SearchSupplierUid")),
            sSearchProductGroup = HTMLEntities.unhtmlentities(checkString(request.getParameter("SearchProductGroup")));

    ///////////////////////////// <DEBUG> /////////////////////////////////////////////////////////
    if (Debug.enabled) {
        System.out.println("\n######################## getProducts ########################");
        System.out.println("* sSearchProductName  : " + sSearchProductName);
        System.out.println("* sSearchSupplierUid  : " + sSearchSupplierUid);
        System.out.println("* sSearchProductGroup : " + sSearchProductGroup + "\n");

    }
    ///////////////////////////// </DEBUG> ////////////////////////////////////////////////////////

    StringBuffer sHtml = new StringBuffer();
    int iMaxRecordsToShow = MedwanQuery.getInstance().getConfigInt("maxRecordsToShow", 100);

    // variables
    String sClass = "1", sSupplierUid, sSupplierName, sUnitTran, sUnitPrice, sUnitsPerTimeUnit, sProductGroup, sProductName;
    DecimalFormat priceDeci = new DecimalFormat("0.00"),
            unitCountDeci = new DecimalFormat("#.#");

    // frequently used translations
    String sCurrency = MedwanQuery.getInstance().getConfigParam("currency", "�"),
            chooseTran = getTranNoLink("web", "choose", sWebLanguage);

    // header
    sHtml.append("<tr class='admin'>")
            .append(" <td nowrap>" + getTranNoLink("web", "product", sWebLanguage) + "</td>")
            .append(" <td>" + getTranNoLink("web", "unit", sWebLanguage) + "</td>")
            .append(" <td>" + getTranNoLink("web", "unitprice", sWebLanguage) + " </td>")
            .append(" <td>" + getTranNoLink("web", "supplier", sWebLanguage) + "</td>")
            .append(" <td>" + getTranNoLink("web", "productGroup", sWebLanguage) + "</td>")
            .append("</tr>");

    // tbody
    sHtml.append("<tbody onmouseover=\"this.style.cursor='hand'\" onmouseout=\"this.style.cursor='default'\">");
    Vector products = new Vector();
    if (sSearchProductName.length() > 0 || sSearchSupplierUid.length() > 0 || sSearchProductGroup.length() > 0) {
        products = Product.find(sSearchProductName, "", "", "", "", "", sSearchSupplierUid, sSearchProductGroup, "OC_PRODUCT_NAME", "ASC");
    }
	System.out.println("supplier="+sSearchSupplierUid);
    // run thru found products
    Product product;
    int iTotal = 0;
    for (int i = 0; i < products.size() && i < iMaxRecordsToShow; i++) {
        product = (Product) products.get(i);

        // units per time unit
        sUnitsPerTimeUnit = product.getUnitsPerTimeUnit() + "";
        if (sUnitsPerTimeUnit.length() > 0) {
            sUnitsPerTimeUnit = unitCountDeci.format(Double.parseDouble(sUnitsPerTimeUnit));
        }

        // translate unit
        sUnitTran = getTranNoLink("product.unit", product.getUnit(), sWebLanguage);

        // line unit price out
        sUnitPrice = priceDeci.format(product.getUnitPrice());

        // supplier
        sSupplierUid = checkString(product.getSupplierUid());
        if (sSupplierUid.length() > 0) sSupplierName = getTranNoLink("service", sSupplierUid, sWebLanguage);
        else sSupplierName = "";

        // productGroup
        sProductGroup = checkString(product.getProductGroup());
        if (sProductGroup.length() > 0) {
            sProductGroup = getTranNoLink("product.productgroup", sProductGroup, sWebLanguage);
        }

        // alternate row-style
        if (sClass.equals("")) sClass = "1";
        else sClass = "";

        boolean inStock;
        if(sSearchSupplierUid.length()==0){
	        inStock= activePatient!=null && activePatient.getActiveDivision()!=null && product.isInStock(activePatient.getActiveDivision().code);
	        if(MedwanQuery.getInstance().getConfigInt("assumeStock",0)==1){
	        	inStock=true;
	        }
        }
        else {
     		inStock=product.isInStock(sSearchSupplierUid);
        }

        sProductName = checkString(product.getName());
        sProductName = sProductName.replaceAll("'", "");

        //*** display product in one row ***
        sHtml.append("<tr title='" + chooseTran + "'  class='list" + sClass + "' onClick=\"selectProduct('" + product.getUid() + "','" + sProductName + "','" + product.getUnit() + "','" + sUnitsPerTimeUnit + "','" + sSupplierUid + "','" + sSupplierName + "','" + product.getPackageUnits() + "');\">")
                .append(" <td nowrap " + (inStock ? "" : " class='strikeonly'") + ">" + sProductName + "</td>")
                .append(" <td" + (inStock ? "" : " class='strikeonly'") + ">" + sUnitTran + "</td>")
                .append(" <td align='right'" + (inStock ? "" : " class='strikeonly'") + ">" + sUnitPrice + " " + sCurrency + " </td>")
                .append(" <td" + (inStock ? "" : " class='strikeonly'") + ">" + sSupplierName + "</td>")
                .append(" <td" + (inStock ? "" : " class='strikeonly'") + ">" + sProductGroup + "</td>")
                .append("</tr>");

        iTotal++;
    }

    sHtml.append("</tbody>");
%>

<%
    // display search results
    if (iTotal == 0) {
        String recordsFoundMsg = getTranNoLink("web", "norecordsfound", sWebLanguage);

        // 'no results' message
%>
<div><%=HTMLEntities.htmlentities(recordsFoundMsg)%>
</div>
<%
} else {
    String html = HTMLEntities.unhtmlentities(sHtml.toString());
    html = HTMLEntities.htmlentities(html);

%>
<table width="100%" class="sortable" id="searchresults">
    <%=html.toString()%>
</table>
<%
    }
%>
<script>
    var setMax = setMaxRows

</script>