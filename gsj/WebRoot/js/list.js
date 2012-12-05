window.onload = function() {

	$('#CHECK_SELECT_ALL').click(function() {

		var inputs = document.getElementsByTagName('input');
		var selected = false;
		var checkAll = document.getElementById('CHECK_SELECT_ALL');
		for ( var i = 0; i < inputs.length; i++) {
			var check = inputs[i];
			if (check.type != 'checkbox' || check.name != "ids") {
				continue;
			}
			if (check.disabled == true) {
				continue;
			}
			check.checked = checkAll.checked;
		}
	});
	// loadMulti();

}

function doPermission(config) {
	var url = config.url;
	var msgBoxType = config.msgBoxType;
	var opeCount = config.opeCount;

	var num = 0;
	var inputs = document.getElementsByTagName('input');
	var checkId;
	for ( var i = 0; i < inputs.length; i++) {
		var check = inputs[i];
		if (check.type != 'checkbox' || check.name != "ids") {
			continue;
		}
		if (check.disabled == true) {
			continue;
		}
		if (check.checked) {
			checkId=check.value;
			num++;
		}
	}
	if (opeCount == '0') {
		window.location.href = ctx + url;
	} else if (opeCount == '1') {
		if (num == 0) {
			top.Dialog.alert("至少选择一条记录");
			return;
		} else if (num > 1) {
			top.Dialog.alert('请选择一条记录!');
			return;
		}else{
			document.getElementById('list_entity_id').value=checkId;
		}
	} else {
		if (num == 0) {
			top.Dialog.alert('至少选择一条记录');
			return;
		}
	}
	var b = false;
	if (msgBoxType == '2') {
		top.Dialog.confirm("您确定要做此操作吗？", function() {
			document.getElementById('list_entity_form').action = ctx + url;
			document.getElementById('list_entity_form').submit();
			
		});

	}else{
		document.getElementById('list_entity_form').action = ctx + url;
		document.getElementById('list_entity_form').submit();
	}
	  
	
}
