<%@ page import="be.mxs.common.util.system.HTMLEntities,be.openclinic.finance.*,java.util.Vector" %>
<%@ page import="java.text.DecimalFormat" %>
<%@page errorPage="/includes/error.jsp"%>
<%@include file="/includes/validateUser.jsp"%>
<%
	double dPatientAmount=0,dInsurarAmount=0,dPatientAmount2=0,dInsurarAmount2=0,dCoverage1,dCoverage2;
	String sPrestationUIDs = checkString(request.getParameter("PrestationUIDs"));
	String sPrestationUID = checkString(request.getParameter("PrestationUID"));
	String sEditDebetUID = checkString(request.getParameter("EditDebetUID"));
	String sPrestationGroupUID = checkString(request.getParameter("PrestationGroupUID"));
    String sInsuranceUID = checkString(request.getParameter("EditInsuranceUID"));
    String sQuantity = checkString(request.getParameter("EditQuantity"));
    String sCoverageInsurance = checkString(request.getParameter("CoverageInsurance"));
    String sCoverageInsurance2 = checkString(request.getParameter("CoverageInsurance2"));
    String sPrestationServiceUid = checkString(request.getParameter("PrestationServiceUid"));
    String sPrestationServiceName= checkString(request.getParameter("PrestationServiceName"));
    String prestationcontent="",pa="",pi="", pc1="",pc2="";
    if(sQuantity.length()==0){
        sQuantity="0";
    }
    int quantity=Integer.parseInt(sQuantity);
    Insurance bestInsurance = null;
    Debet debet=null;
    Encounter encounter=Encounter.getActiveEncounter(activePatient.personid);
   	if(sEditDebetUID.length()>0){
    	debet = Debet.get(sEditDebetUID);
    	if(debet!=null && debet.getEncounter()!=null){
    		encounter=debet.getEncounter();
    	}
    }
   	

    if(sPrestationUIDs.length()>0){
        String type="";
        Insurance insurance=null;
        if(sInsuranceUID.length()==0){
            insurance = Insurance.getMostInterestingInsuranceForPatient(activePatient.personid);
        }
        else {
            insurance = Insurance.get(sInsuranceUID);
        }
		String[] prestations = sPrestationUIDs.split(";");
        prestationcontent ="<table width='100%' id='mytable'>";
        prestationcontent+="<tr><td><b>"+getTran("web","prestation",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTran("web.finance","amount.patient",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTran("web.finance","amount.insurar",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTranNoLink("web.finance","amount.complementaryinsurar",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTranNoLink("web","service",sWebLanguage)+"</b></td>"+
        "</tr>";
		for(int n=0;n<prestations.length;n++){
	        Prestation prestation = Prestation.get(prestations[n].split("=")[0]);
	        quantity=Integer.parseInt(prestations[n].split("=")[1]);
	        if (insurance != null) {
	            bestInsurance=insurance;
	            type = insurance.getType();

	            if (prestation != null) {
	                double dPrice = prestation.getPrice(type);
                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==1){
                    	dPrice+=prestation.getSupplement();
                    }
	                double dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),insurance.getInsuranceCategoryLetter());
	                if(encounter!=null && encounter.getType().equalsIgnoreCase("admission") && prestation.getMfpAdmissionPercentage()>0){
	                	dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),"*H");
	                }
	                String sShare=checkString(prestation.getPatientShare(insurance)+"");
	                if (sShare.length()>0){
	                    dPatientAmount2 = quantity * dPrice * Double.parseDouble(sShare) / 100;
	                    dInsurarAmount2 = quantity * dPrice - dPatientAmount2;
	                    if(dInsuranceMaxPrice>=0){
	                    	dInsurarAmount2=quantity * dInsuranceMaxPrice;
	                   		dPatientAmount2=quantity * dPrice - dInsurarAmount2;
	                    }
	                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
	                    	dPatientAmount2+=quantity*prestation.getSupplement();
	                    }
	                    dPatientAmount+=dPatientAmount2;
	                    dInsurarAmount+=dInsurarAmount2;
	                }
	            }
	        }
	        else {
	            dPatientAmount2=quantity * (prestation.getPrice("C")+prestation.getSupplement());
                dPatientAmount+=dPatientAmount2;
	            dInsurarAmount2= 0;
	        }
	        //Now we have the patient share and the insurance share, let's calculate complementary insurances
	        //Complementary insurance 1
	        dCoverage1=0;
	        dCoverage2=0;
	        if(sCoverageInsurance.length()>0){
	        	Insurar insurar = Insurar.get(sCoverageInsurance);
	        	if(insurar!=null){
	        		if(insurar.getCoverSupplements()==1 && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
	        			dCoverage1=dPatientAmount2;
	        		}
	        		else{
	        			dCoverage1=dPatientAmount2-quantity * prestation.getSupplement();
	        		}
	    			dPatientAmount=dPatientAmount-dCoverage1;
	    			dPatientAmount2=dPatientAmount2-dCoverage1;
	        	}
	        }
	        if(sCoverageInsurance2.length()>0){
	        	Insurar insurar = Insurar.get(sCoverageInsurance2);
	        	if(insurar!=null){
					dCoverage2=dPatientAmount2;
	        	}
	        }

	        pa=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dPatientAmount2);
	      	pi=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dInsurarAmount2);
	      	pc1=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage1);
	      	pc2=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage2);
	        prestationcontent+="<tr>";
	        prestationcontent+="<td><input type='hidden' name='PPQ_"+prestation.getUid()+"' value='"+quantity+"'/>"+quantity+" x <input type='hidden' name='PPC_"+prestation.getUid()+"'/>"+checkString(prestation.getCode())+": "+prestation.getDescription()+"</td>";
	        prestationcontent+="<td "+(sCoverageInsurance2.length()>0?"class='strikeonly'":"")+"><input type='hidden' name='PPP_"+prestation.getUid()+"' value='"+pa+"'/>"+pa+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	        prestationcontent+="<td><input type='hidden' name='PPI_"+prestation.getUid()+"' value='"+pi+"'/>"+pi+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	        prestationcontent+="<td><input type='hidden' name='PPE_"+prestation.getUid()+"' value='"+pc1+"'/>"+pc1+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
			String sServiceName = sPrestationServiceName;
	        if(prestation.getServiceUid()!=null && prestation.getServiceUid().length()>0){
				Service service = Service.getService(prestation.getServiceUid());
				if(service!=null){
					sServiceName=checkString(service.getLabel(sWebLanguage));
				}
				if(!sServiceName.equals(sPrestationServiceName)){
					sServiceName="<font color='red'><b>"+sServiceName+"</b></font>";
				}
			}
	        prestationcontent+="<td>"+sServiceName+"</td>";
	        prestationcontent+="</tr>";
	        
	        //Check if anesthesia prestation must be added
	        if(prestation!=null && prestation.getAnesthesiaPercentage()>0){
	        	Prestation anesthesiaPrestation = Prestation.get(MedwanQuery.getInstance().getConfigString("anesthesiaPrestationUid",""));
	        	if(anesthesiaPrestation!=null){
	    	        if (insurance != null) {
    	                double dPrice = prestation.getPrice(type)*(prestation.getAnesthesiaPercentage()/100);
                        if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==1){
                        	dPrice+=prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
                        }
    	                double dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),insurance.getInsuranceCategoryLetter())*(prestation.getAnesthesiaPercentage()/100);
    	                if(encounter!=null && encounter.getType().equalsIgnoreCase("admission") && prestation.getMfpAdmissionPercentage()>0){
    	                	dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),"*H")*(prestation.getAnesthesiaPercentage()/100);
    	                }
    	                String sShare=checkString(prestation.getPatientShare(insurance)+"");
    	                if (sShare.length()>0){
    	                    dPatientAmount2 = quantity * dPrice * Double.parseDouble(sShare) / 100;
    	                    dInsurarAmount2 = quantity * dPrice - dPatientAmount2;
    	                    if(dInsuranceMaxPrice>=0){
    	                    	dInsurarAmount2=quantity * dInsuranceMaxPrice;
    	                   		dPatientAmount2=quantity * dPrice - dInsurarAmount2;
    	                    }
    	                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
    	                    	dPatientAmount2+=quantity*prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
    	                    }
    	                    dPatientAmount+=dPatientAmount2;
    	                    dInsurarAmount+=dInsurarAmount2;
    	                }
	    	        }
	    	        else {
	    	            dPatientAmount2=quantity * (prestation.getPrice("C")+prestation.getSupplement())*(prestation.getAnesthesiaPercentage()/100);
	                    dPatientAmount+=dPatientAmount2;
	    	            dInsurarAmount2= 0;
	    	        }
	    	        //Now we have the patient share and the insurance share, let's calculate complementary insurances
	    	        //Complementary insurance 1
	    	        dCoverage1=0;
	    	        dCoverage2=0;
	    	        if(sCoverageInsurance.length()>0){
	    	        	Insurar insurar = Insurar.get(sCoverageInsurance);
	    	        	if(insurar!=null){
	    	        		if(insurar.getCoverSupplements()==1 && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
	    	        			dCoverage1=dPatientAmount2;
	    	        		}
	    	        		else{
	    	        			dCoverage1=dPatientAmount2-quantity * prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
	    	        		}
	    	    			dPatientAmount=dPatientAmount-dCoverage1;
	    	    			dPatientAmount2=dPatientAmount2-dCoverage1;
	    	        	}
	    	        }
	    	        if(sCoverageInsurance2.length()>0){
	    	        	Insurar insurar = Insurar.get(sCoverageInsurance2);
	    	        	if(insurar!=null){
	    					dCoverage2=dPatientAmount2;
	    	        	}
	    	        }

	    	        pa=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dPatientAmount2);
	    	      	pi=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dInsurarAmount2);
	    	      	pc1=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage1);
	    	      	pc2=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage2);
	    	        prestationcontent+="<tr>";
	    	        prestationcontent+="<td><input type='hidden' name='PPQ_"+anesthesiaPrestation.getUid()+"�"+prestation.getUid()+"' value='"+quantity+"'/>"+quantity+" x <input type='hidden' name='PPU_"+anesthesiaPrestation.getUid()+"�"+prestation.getUid()+"'/><input type='hidden' name='PPC_"+anesthesiaPrestation.getUid()+"'/>"+checkString(anesthesiaPrestation.getCode())+": "+anesthesiaPrestation.getDescription()+"</td>";
	    	        prestationcontent+="<td "+(sCoverageInsurance2.length()>0?"class='strikeonly'":"")+"><input type='hidden' name='PPP_"+anesthesiaPrestation.getUid()+"' value='"+pa+"'/>"+pa+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	    	        prestationcontent+="<td><input type='hidden' name='PPI_"+anesthesiaPrestation.getUid()+"' value='"+pi+"'/>"+pi+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	    	        prestationcontent+="<td><input type='hidden' name='PPE_"+anesthesiaPrestation.getUid()+"' value='"+pc1+"'/>"+pc1+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	    			sServiceName = sPrestationServiceName;
	    	        if(anesthesiaPrestation.getServiceUid()!=null && anesthesiaPrestation.getServiceUid().length()>0){
	    				Service service = Service.getService(anesthesiaPrestation.getServiceUid());
	    				if(service!=null){
	    					sServiceName=checkString(service.getLabel(sWebLanguage));
	    				}
	    				if(!sServiceName.equals(sPrestationServiceName)){
	    					sServiceName="<font color='red'><b>"+sServiceName+"</b></font>";
	    				}
	    			}
	    	        prestationcontent+="<td>"+sServiceName+"</td>";
	    	        prestationcontent+="</tr>";
	        	}
	        }
		}
        prestationcontent+="</table>";
    }
    else if (sPrestationUID.length() > 0) {
        String type="";
        Insurance insurance=null;
        if(sInsuranceUID.length()==0){
            insurance = Insurance.getMostInterestingInsuranceForPatient(activePatient.personid);
        }
        else {
            insurance = Insurance.get(sInsuranceUID);
        }
        Prestation prestation = Prestation.get(sPrestationUID);
        if (insurance != null) {
            bestInsurance=insurance;
            type = insurance.getType();

            if (prestation != null) {
                double dPrice = prestation.getPrice(type);
                if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==1){
                	dPrice+=prestation.getSupplement();
                }
                double dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),insurance.getInsuranceCategoryLetter());
                System.out.println("dInsuranceMaxPrice="+dInsuranceMaxPrice);
                if(encounter!=null && encounter.getType().equalsIgnoreCase("admission") && prestation.getMfpAdmissionPercentage()>0){
                	dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),"*H");
                }
                String sShare=checkString(prestation.getPatientShare(insurance)+"");
                if (sShare.length()>0){
                    dPatientAmount = quantity * dPrice * Double.parseDouble(sShare) / 100;
                    dInsurarAmount = quantity * dPrice - dPatientAmount;
                    if(dInsuranceMaxPrice>=0){
                    	dInsurarAmount=quantity * dInsuranceMaxPrice;
                   		dPatientAmount=quantity * dPrice - dInsurarAmount;
                    }
                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
                    	dPatientAmount+=quantity * prestation.getSupplement();
                    }
                }
            }
        }
        else {
            dPatientAmount=quantity * (prestation.getPrice("C")+prestation.getSupplement());
            dInsurarAmount = 0;
        }

        //Now we have the patient share and the insurance share, let's calculate complementary insurances
        //Complementary insurance 1
        dCoverage1=0;
        dCoverage2=0;
        if(sCoverageInsurance.length()>0){
        	Insurar insurar = Insurar.get(sCoverageInsurance);
        	if(insurar!=null){
        		if(insurar.getCoverSupplements()==1 && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
        			dCoverage1=dPatientAmount;
        		}
        		else{
        			dCoverage1=dPatientAmount-quantity * prestation.getSupplement();
        		}
    			dPatientAmount=dPatientAmount-dCoverage1;
        	}
        }
        if(sCoverageInsurance2.length()>0){
        	Insurar insurar = Insurar.get(sCoverageInsurance2);
        	if(insurar!=null){
				dCoverage2=dPatientAmount;
        	}
        }

        pa=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dPatientAmount);
      	pi=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dInsurarAmount);
      	pc1=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage1);
      	pc2=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage2);
        prestationcontent ="<table width='100%' id='mytable'>";
        prestationcontent+="<tr><td><b>"+getTran("web","prestation",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTran("web.finance","amount.patient",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTran("web.finance","amount.insurar",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTranNoLink("web.finance","amount.complementaryinsurar",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTranNoLink("web","service",sWebLanguage)+"</b></td>"+
        "</tr>";
        prestationcontent+="<tr>";
        prestationcontent+="<td><input type='hidden' name='PPC_"+prestation.getUid()+"'/>"+checkString(prestation.getCode())+": "+prestation.getDescription()+"</td>";
        prestationcontent+="<td "+(sCoverageInsurance2.length()>0?"class='strikeonly'":"")+"><input type='hidden' name='PPP_"+prestation.getUid()+"' value='"+pa+"'/>"+pa+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
        prestationcontent+="<td><input type='hidden' name='PPI_"+prestation.getUid()+"' value='"+pi+"'/>"+pi+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
        prestationcontent+="<td><input type='hidden' name='PPE_"+prestation.getUid()+"' value='"+pc1+"'/>"+pc1+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
		String sServiceName = sPrestationServiceName;
        if(prestation.getServiceUid()!=null && prestation.getServiceUid().length()>0){
			Service service = Service.getService(prestation.getServiceUid());
			if(service!=null){
				sServiceName=checkString(service.getLabel(sWebLanguage));
			}
			if(!sServiceName.equals(sPrestationServiceName)){
				sServiceName="<font color='red'><b>"+sServiceName+"</b></font>";
			}
		}
        prestationcontent+="<td>"+sServiceName+"</td>";
        prestationcontent+="</tr>";

        //Check if anesthesia prestation must be added
        if(prestation!=null && prestation.getAnesthesiaPercentage()>0 && (sEditDebetUID.length()==0 || sEditDebetUID.split("\\.").length<2)){
        	Prestation anesthesiaPrestation = Prestation.get(MedwanQuery.getInstance().getConfigString("anesthesiaPrestationUid",""));
        	if(anesthesiaPrestation!=null){
    	        if (insurance != null) {
	                double dPrice = prestation.getPrice(type)*(prestation.getAnesthesiaPercentage()/100);
                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==1){
                    	dPrice+=prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
                    }
	                double dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),insurance.getInsuranceCategoryLetter())*(prestation.getAnesthesiaPercentage()/100);
	                if(encounter!=null && encounter.getType().equalsIgnoreCase("admission") && prestation.getMfpAdmissionPercentage()>0){
	                	dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),"*H")*(prestation.getAnesthesiaPercentage()/100);
	                }
	                String sShare=checkString(prestation.getPatientShare(insurance)+"");
	                if (sShare.length()>0){
	                    dPatientAmount2 = quantity * dPrice * Double.parseDouble(sShare) / 100;
	                    dInsurarAmount2 = quantity * dPrice - dPatientAmount2;
	                    if(dInsuranceMaxPrice>=0){
	                    	dInsurarAmount2=quantity * dInsuranceMaxPrice;
	                   		dPatientAmount2=quantity * dPrice - dInsurarAmount2;
	                    }
	                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
	                    	dPatientAmount2+=quantity*prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
	                    }
	                    dPatientAmount+=dPatientAmount2;
	                    dInsurarAmount+=dInsurarAmount2;
	                }
    	        }
    	        else {
    	            dPatientAmount2=quantity * (prestation.getPrice("C")+prestation.getSupplement())*(prestation.getAnesthesiaPercentage()/100);
                    dPatientAmount+=dPatientAmount2;
    	            dInsurarAmount2= 0;
    	        }
    	        dCoverage1=0;
    	        dCoverage2=0;
    	        if(sCoverageInsurance.length()>0){
    	        	Insurar insurar = Insurar.get(sCoverageInsurance);
    	        	if(insurar!=null){
    	        		if(insurar.getCoverSupplements()==1 && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
    	        			dCoverage1=dPatientAmount2;
    	        		}
    	        		else{
    	        			dCoverage1=dPatientAmount2-quantity * prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
    	        		}
    	    			dPatientAmount2=dPatientAmount2-dCoverage1;
    	    			dPatientAmount=dPatientAmount-dCoverage1;
    	        	}
    	        }
    	        if(sCoverageInsurance2.length()>0){
    	        	Insurar insurar = Insurar.get(sCoverageInsurance2);
    	        	if(insurar!=null){
    					dCoverage2=dPatientAmount2;
    	        	}
    	        }
    	      	pa=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dPatientAmount2);
    	      	pi=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dInsurarAmount2);
    	      	pc1=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage1);
    	      	pc2=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage2);
    	        prestationcontent+="<tr>";
    	        prestationcontent+="<td><input type='hidden' name='PPU_"+anesthesiaPrestation.getUid()+"�"+prestation.getUid()+"'/><input type='hidden' name='PPC_"+anesthesiaPrestation.getUid()+"'/>"+checkString(anesthesiaPrestation.getCode())+": "+anesthesiaPrestation.getDescription()+"</td>";
    	        prestationcontent+="<td "+(sCoverageInsurance2.length()>0?"class='strikeonly'":"")+"><input type='hidden' name='PPP_"+anesthesiaPrestation.getUid()+"' value='"+pa+"'/>"+pa+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
    	        prestationcontent+="<td><input type='hidden' name='PPI_"+anesthesiaPrestation.getUid()+"' value='"+pi+"'/>"+pi+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
    	        prestationcontent+="<td><input type='hidden' name='PPE_"+anesthesiaPrestation.getUid()+"' value='"+pc1+"'/>"+pc1+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
    			sServiceName = sPrestationServiceName;
    	        if(anesthesiaPrestation.getServiceUid()!=null && anesthesiaPrestation.getServiceUid().length()>0){
    				Service service = Service.getService(anesthesiaPrestation.getServiceUid());
    				if(service!=null){
    					sServiceName=checkString(service.getLabel(sWebLanguage));
    				}
    				if(!sServiceName.equals(sPrestationServiceName)){
    					sServiceName="<font color='red'><b>"+sServiceName+"</b></font>";
    				}
    			}
    	        prestationcontent+="<td>"+sServiceName+"</td>";
    	        prestationcontent+="</tr>";
        	}
        }

        prestationcontent+="</table>";

    }
    else if(sPrestationGroupUID.length()>0){
        String type="";
        Insurance insurance=null;
        if(sInsuranceUID.length()==0){
            insurance = Insurance.getMostInterestingInsuranceForPatient(activePatient.personid);
        }
        else {
            insurance = Insurance.get(sInsuranceUID);
        }
        String sSql="select * from oc_prestationgroups_prestations where oc_prestationgroup_groupuid=?";
        Connection oc_conn=MedwanQuery.getInstance().getOpenclinicConnection();
		PreparedStatement ps=oc_conn.prepareStatement(sSql);
		ps.setString(1,sPrestationGroupUID);
		ResultSet rs = ps.executeQuery();
        prestationcontent ="<table width='100%' id='mytable'>";
        prestationcontent+="<tr><td><b>"+getTran("web","prestation",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTran("web.finance","amount.patient",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTran("web.finance","amount.insurar",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTranNoLink("web.finance","amount.complementaryinsurar",sWebLanguage)+"</b></td>"+
        "<td><b>"+getTranNoLink("web","service",sWebLanguage)+"</b></td>"+
        "</tr>";
		while(rs.next()){
	        Prestation prestation = Prestation.get(rs.getString("oc_prestationgroup_prestationuid"));
	        if (insurance != null) {
	            bestInsurance=insurance;
	            type = insurance.getType();

	            if (prestation != null) {
	                double dPrice = prestation.getPrice(type);
                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==1){
                    	dPrice+=prestation.getSupplement();
                    }
	                double dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),insurance.getInsuranceCategoryLetter());
	                if(encounter!=null && encounter.getType().equalsIgnoreCase("admission") && prestation.getMfpAdmissionPercentage()>0){
	                	dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),"*H");
	                }
	                String sShare=checkString(prestation.getPatientShare(insurance)+"");
	                if (sShare.length()>0){
	                    dPatientAmount2 = quantity * dPrice * Double.parseDouble(sShare) / 100;
	                    dInsurarAmount2 = quantity * dPrice - dPatientAmount2;
	                    if(dInsuranceMaxPrice>=0){
	                    	dInsurarAmount2=quantity * dInsuranceMaxPrice;
	                   		dPatientAmount2=quantity * dPrice - dInsurarAmount2;
	                    }
	                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
	                    	dPatientAmount2+=quantity*prestation.getSupplement();
	                    }
	                    dPatientAmount+=dPatientAmount2;
	                    dInsurarAmount+=dInsurarAmount2;
	                }
	            }
	        }
	        else {
	            dPatientAmount2=quantity * (prestation.getPrice("C")+prestation.getSupplement());
                dPatientAmount+=dPatientAmount2;
	            dInsurarAmount2= 0;
	        }
	        //Now we have the patient share and the insurance share, let's calculate complementary insurances
	        //Complementary insurance 1
	        dCoverage1=0;
	        dCoverage2=0;
	        if(sCoverageInsurance.length()>0){
	        	Insurar insurar = Insurar.get(sCoverageInsurance);
	        	if(insurar!=null){
	        		if(insurar.getCoverSupplements()==1 && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
	        			dCoverage1=dPatientAmount2;
	        		}
	        		else{
	        			dCoverage1=dPatientAmount2-quantity * prestation.getSupplement();
	        		}
	    			dPatientAmount=dPatientAmount-dCoverage1;
	    			dPatientAmount2=dPatientAmount2-dCoverage1;
	        	}
	        }
	        if(sCoverageInsurance2.length()>0){
	        	Insurar insurar = Insurar.get(sCoverageInsurance2);
	        	if(insurar!=null){
					dCoverage2=dPatientAmount2;
	        	}
	        }

	        pa=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dPatientAmount2);
	      	pi=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dInsurarAmount2);
	      	pc1=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage1);
	      	pc2=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage2);
	        prestationcontent+="<tr>";
	        prestationcontent+="<td><input type='hidden' name='PPC_"+prestation.getUid()+"'/>"+checkString(prestation.getCode())+": "+prestation.getDescription()+"</td>";
	        prestationcontent+="<td "+(sCoverageInsurance2.length()>0?"class='strikeonly'":"")+"><input type='hidden' name='PPP_"+prestation.getUid()+"' value='"+pa+"'/>"+pa+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	        prestationcontent+="<td><input type='hidden' name='PPI_"+prestation.getUid()+"' value='"+pi+"'/>"+pi+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	        prestationcontent+="<td><input type='hidden' name='PPE_"+prestation.getUid()+"' value='"+pc1+"'/>"+pc1+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
			String sServiceName = sPrestationServiceName;
	        if(prestation.getServiceUid()!=null && prestation.getServiceUid().length()>0){
				Service service = Service.getService(prestation.getServiceUid());
				if(service!=null){
					sServiceName=checkString(service.getLabel(sWebLanguage));
				}
				if(!sServiceName.equals(sPrestationServiceName)){
					sServiceName="<font color='red'><b>"+sServiceName+"</b></font>";
				}
			}
	        prestationcontent+="<td>"+sServiceName+"</td>";
	        prestationcontent+="</tr>";

	        //Check if anesthesia prestation must be added
	        if(prestation!=null && prestation.getAnesthesiaPercentage()>0){
	        	Prestation anesthesiaPrestation = Prestation.get(MedwanQuery.getInstance().getConfigString("anesthesiaPrestationUid",""));
	        	if(anesthesiaPrestation!=null){
	    	        if (insurance != null) {
		                double dPrice = prestation.getPrice(type)*(prestation.getAnesthesiaPercentage()/100);
                        if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==1){
                        	dPrice+=prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
                        }
    	                double dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),insurance.getInsuranceCategoryLetter())*(prestation.getAnesthesiaPercentage()/100);
    	                if(encounter!=null && encounter.getType().equalsIgnoreCase("admission") && prestation.getMfpAdmissionPercentage()>0){
    	                	dInsuranceMaxPrice = prestation.getInsuranceTariff(insurance.getInsurar().getUid(),"*H")*(prestation.getAnesthesiaPercentage()/100);
    	                }
		                String sShare=checkString(prestation.getPatientShare(insurance)+"");
		                if (sShare.length()>0){
		                    dPatientAmount2 = quantity * dPrice * Double.parseDouble(sShare) / 100;
		                    dInsurarAmount2 = quantity * dPrice - dPatientAmount2;
		                    if(dInsuranceMaxPrice>=0){
		                    	dInsurarAmount2=quantity * dInsuranceMaxPrice;
		                   		dPatientAmount2=quantity * dPrice - dInsurarAmount2;
		                    }
    	                    if(insurance.getInsurar()!=null && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
		                    	dPatientAmount2+=quantity*prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
		                    }
		                    dPatientAmount+=dPatientAmount2;
		                    dInsurarAmount+=dInsurarAmount2;
		                }
	    	        }
	    	        else {
	    	            dPatientAmount2=quantity * (prestation.getPrice("C")+prestation.getSupplement())*(prestation.getAnesthesiaPercentage()/100);
	                    dPatientAmount+=dPatientAmount2;
	    	            dInsurarAmount2= 0;
	    	        }
	    	        //Now we have the patient share and the insurance share, let's calculate complementary insurances
	    	        //Complementary insurance 1
	    	        dCoverage1=0;
	    	        dCoverage2=0;
	    	        if(sCoverageInsurance.length()>0){
	    	        	Insurar insurar = Insurar.get(sCoverageInsurance);
	    	        	if(insurar!=null){
	    	        		if(insurar.getCoverSupplements()==1 && insurance.getInsurar().getNoSupplements()==0 && insurance.getInsurar().getCoverSupplements()==0){
	    	        			dCoverage1=dPatientAmount2;
	    	        		}
	    	        		else{
	    	        			dCoverage1=dPatientAmount2-quantity * prestation.getSupplement()*(prestation.getAnesthesiaPercentage()/100);
	    	        		}
	    	    			dPatientAmount=dPatientAmount-dCoverage1;
	    	    			dPatientAmount2=dPatientAmount2-dCoverage1;
	    	        	}
	    	        }
	    	        if(sCoverageInsurance2.length()>0){
	    	        	Insurar insurar = Insurar.get(sCoverageInsurance2);
	    	        	if(insurar!=null){
	    					dCoverage2=dPatientAmount2;
	    	        	}
	    	        }

	    	        pa=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dPatientAmount2);
	    	      	pi=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dInsurarAmount2);
	    	      	pc1=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage1);
	    	      	pc2=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dCoverage2);
	    	        prestationcontent+="<tr>";
	    	        prestationcontent+="<td><input type='hidden' name='PPU_"+anesthesiaPrestation.getUid()+"�"+prestation.getUid()+"'/><input type='hidden' name='PPC_"+anesthesiaPrestation.getUid()+"'/>"+checkString(anesthesiaPrestation.getCode())+": "+anesthesiaPrestation.getDescription()+"</td>";
	    	        prestationcontent+="<td "+(sCoverageInsurance2.length()>0?"class='strikeonly'":"")+"><input type='hidden' name='PPP_"+anesthesiaPrestation.getUid()+"' value='"+pa+"'/>"+pa+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	    	        prestationcontent+="<td><input type='hidden' name='PPI_"+anesthesiaPrestation.getUid()+"' value='"+pi+"'/>"+pi+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	    	        prestationcontent+="<td><input type='hidden' name='PPE_"+anesthesiaPrestation.getUid()+"' value='"+pc1+"'/>"+pc1+" "+MedwanQuery.getInstance().getConfigParam("currency","�")+"</td>";
	    			sServiceName = sPrestationServiceName;
	    	        if(anesthesiaPrestation.getServiceUid()!=null && anesthesiaPrestation.getServiceUid().length()>0){
	    				Service service = Service.getService(anesthesiaPrestation.getServiceUid());
	    				if(service!=null){
	    					sServiceName=checkString(service.getLabel(sWebLanguage));
	    				}
	    				if(!sServiceName.equals(sPrestationServiceName)){
	    					sServiceName="<font color='red'><b>"+sServiceName+"</b></font>";
	    				}
	    			}
	    	        prestationcontent+="<td>"+sServiceName+"</td>";
	    	        prestationcontent+="</tr>";
	        	}
	        }

		}
        rs.close();
        ps.close();
        oc_conn.close();
        prestationcontent+="</table>";
    }
    System.out.println("dInsurarAmount="+dInsurarAmount);
%>
{
"PrestationContent":"<%=prestationcontent%>",
"EditAmount":"<%=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dPatientAmount)%>",
"EditInsurarAmount":"<%=new DecimalFormat(MedwanQuery.getInstance().getConfigString("priceFormat","#.00")).format(dInsurarAmount)%>"
<%
    if (sInsuranceUID.length()==0 && bestInsurance!=null){
        %>
        ,"EditInsuranceUID":"<%=HTMLEntities.htmlentities(bestInsurance.getUid())%>"
        ,"EditInsuranceName":"<%=HTMLEntities.htmlentities(bestInsurance.getInsurar().getName())%>"
        <%
    }
%>
}
