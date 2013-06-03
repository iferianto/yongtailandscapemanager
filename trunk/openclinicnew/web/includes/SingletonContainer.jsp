<%@page import="net.admin.*,
                be.mxs.common.util.db.MedwanQuery,
                be.mxs.common.util.system.Debug,
                java.sql.*,java.text.*"%>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Vector" %>
<%@ page import="java.util.Iterator" %>
<%!
    
    //--- RELOAD SINGLETON ------------------------------------------------------------------------
    public void reloadSingleton(HttpSession session) {
        Hashtable labelLanguages = new Hashtable();
        Hashtable labelTypes = new Hashtable();
        Hashtable labelIds;
        net.admin.Label label;

        // only load labels in memory that are service nor function.
        Vector vLabels = net.admin.Label.getNonServiceFunctionLabels();
        Iterator iter = vLabels.iterator();

        if (Debug.enabled) Debug.println("About to (re)load labels.");
        while(iter.hasNext()){
            label = (net.admin.Label)iter.next();
            // type
            labelTypes = (Hashtable) labelLanguages.get(label.language);
            if (labelTypes == null) {
                labelTypes = new Hashtable();
                labelLanguages.put(label.language, labelTypes);
                //Debug.println("new language : "+label.language);
            }

            // id
            labelIds = (Hashtable) labelTypes.get(label.type);
            if (labelIds == null) {
                labelIds = new Hashtable();
                labelTypes.put(label.type, labelIds);
                //Debug.println("new type : "+label.type);
            }

            labelIds.put(label.id, label);
        }

        // status info
        if (Debug.enabled) {
            Debug.println("Labels (re)loaded.");

            Debug.println(" * " + labelLanguages.size() + " languages");
            Debug.println(" * " + labelTypes.size() + " types per language");
        }

        MedwanQuery.getInstance().putLabels(labelLanguages);
    }
%>