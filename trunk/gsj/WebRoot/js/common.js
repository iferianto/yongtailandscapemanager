 
 
function isBlank(str){
	
	if(str==null||str=='')
		return true;
	return false;
}
function isNotBlank(str){
	
	if(str==null||str=='')
		return false;
	return true;
}


function getMultiDept(objId,objName){
	var diag = new top.Dialog();
	diag.Title = "选择部门 ";
	diag.URL = ctx+"/system/dept!getMultiDept.action";
	diag.ShowButtonRow=true;
	diag.OkButtonText=" 选 择 ";
	diag.OKEvent=function(){ 
		var nodes=diag.innerFrame.contentWindow.getSelected();
	 
		var s = ',';
		var ids=',';
		for(var i=0; i<nodes.length; i++){
		 
			s= s+ nodes[i].text+",";
		 
			ids=ids+nodes[i].id+",";
		}
		document.getElementById(objId).value=ids;
		document.getElementById(objName).value=s;
		diag.close();
	};
	diag.show();

	
}

function getSingleDept(objId,objName){
	
	var diag = new top.Dialog();
	diag.Title = "选择部门 ";
	diag.URL = ctx+"/system/dept!getSingleDept.action";
	diag.ShowButtonRow=true;
	diag.OkButtonText=" 选 择 ";
	diag.OKEvent=function(){ 
		var nodes=diag.innerFrame.contentWindow.getSelected();
		if(nodes==null||nodes.length==0){
			document.getElementById(objId).value='';
			document.getElementById(objName).value='';
			diag.close();
			return;
		}
		if(nodes.length>1){
			top.Dialog.alert('只能选择一个部门');
			return ;
			
		}
		 
		document.getElementById(objId).value=nodes[0].id;
		document.getElementById(objName).value=nodes[0].text;
		diag.close();
	};
	diag.show();
}

function getSingleUser(objId,objName){
	var diag = new top.Dialog();
	diag.Title = "选择用户 ";
	diag.URL = ctx+"/system/user!getSingleUser.action";
	diag.ShowButtonRow=true;
	diag.OkButtonText=" 选 择 ";
	diag.OKEvent=function(){ 
		var ids=diag.innerFrame.contentWindow.document.getElementsByName("ids");
		if(ids){
			for(var i=0;i<ids.length;i++){
				if(ids[i].checked){
					var v=ids[i].value;
					var objs=v.split("-"); 
					document.getElementById(objId).value=objs[0];
					document.getElementById(objName).value=objs[1];
				}
			}
		}
		diag.close();
	};
	diag.show();

}

function getMultiUser(objId,objName){
	var diag = new top.Dialog();
	diag.Title = "选择用户 ";
	var oid=document.getElementById(objId).value;
	var oname=document.getElementById(objName).value;
	diag.URL = ctx+"/system/user!getMultiUser.action";
	diag.ShowButtonRow=true;
	diag.OkButtonText=" 选 择 ";
	diag.OKEvent=function(){ 
		var nodes=diag.innerFrame.contentWindow.document.all.users.value;
		var ns=nodes.split(",");
		var s = ',';
		var ids=',';
		for(var i=0; i<ns.length; i++){
			if(ns[i]==null||ns[i]==''){
				continue;
			}
			var objs=ns[i].split("-"); 
			
			s =s+ objs[1]+",";
			ids=ids+objs[0]+",";
		}
		document.getElementById(objId).value=ids;
		document.getElementById(objName).value=s;
		diag.close();
	};
	diag.show();

	
}



