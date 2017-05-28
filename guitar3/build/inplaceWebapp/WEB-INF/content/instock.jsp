<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>药品入库</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.mobile.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/easyloader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
<script>
var date=new Date();
var time=date.getFullYear()+"-"+(date.getMonth())+"-"+date.getDate();
var supplierId=null;
$(function() {
	$('#dg').datagrid({       
		pageNumber: 1,
	    url: "${pageContext.request.contextPath}/showBuy",
	    rownumbers:true,
	    fitColumns:true,
	    singleSelect:true,
	    height:650,
	    toolbar:[
	 			{
	 				text:'入库日期：<input id="timeselect" name="timehidden">'
	 			},
	 			{
	 				text:'供货单位：<input id="supplierselect" name="supplierhidden">'
	 			},
	 			{
					iconCls : 'icon-add',
					text : '入库登记',
					id:'addtool',
					handler : function() {
						$('#addbtn').show();
						$('#editbtn').hide();
						$('#win').window('open');
						$('#form').form('disableValidation');
					}
				}
// 				{
// 					iconCls : 'icon-edit',
// 					text : '修改记录',
// 					id:'edittool',
// 					handler : function() {	
						
// 					}
// 				},
// 				{
// 					iconCls : 'icon-remove',
// 					text : '删除记录',
// 					id:'deletetool',
// 					handler : function() {
						
// 					}
// 				}
	 			],
	    columns:[[    
	              {field:'id',title:'订单编号',width:100},
	              {field:'number',title:'采购数目',width:100} ,
	              {field:'orderItemPrice',title:'订单价格',width:100} ,
	              {field:'orderId',title:'总订单编号',width:100} ,
	              {field:'medicineName',title:'药物名称',width:100},
	              {field:'medicinePrice',title:'药物价格',width:100} ,
	              {field:'store',title:'药物库存',width:100} 
	    ]]
	});

    //时间
    $('#timeselect').datebox({   
    	width:120,
    	onSelect: function(date){
    		time=$('#timeselect').datebox('getValue');
    		query();
    	}
    });  
    //供货单位
    $('#supplierselect').combobox({
    	url : '${pageContext.request.contextPath}/supplierBuy',
		valueField : 'supplierId',
		textField : 'supplierId',
		prompt : '请选择供应商',
		onSelect: function(date){
    		supplierId=$('#supplierselect').combobox('getValue');
    		query();
    	}
	}); 
    //供货单位
    $('#suppliertext').combogrid({
    	   panelWidth:170,    
   	    prompt:'输入药品编号或名称搜索',    	     
   	    idField:'supplierId',    
   	    textField:'supplierId',  
           url: "${pageContext.request.contextPath}/supplierBuy",
           delay:200,
           mode:"remote",
   	    columns:[[    
   	        {field:'supplierId',title:'药品编号',width:60},    
   	        {field:'supplierId',title:'药品名称',width:100} 
   	    ]],
   	    onClickRow:function(index,row){
   	    }
	}); 
  	//查询药品
	$('#medicine').combogrid({    
	    panelWidth:170,    
	    prompt:'输入药品编号或名称搜索',    	     
	    idField:'medicineId',    
	    textField:'medicineName',  
        url: "${pageContext.request.contextPath}/medicineBuy",
        delay:200,
        mode:"remote",
	    columns:[[    
	        {field:'medicineId',title:'药品编号',width:60},    
	        {field:'medicineName',title:'药品名称',width:100} 
	    ]],
	    onClickRow:function(index,row){
	    }
	});  
  	//查询人员
	$('#person').combogrid({    
	    panelWidth:170,    
	    prompt:'输入人员编号或名称搜索',    	     
	    idField:'personId',    
	    textField:'personName',  
        url: "${pageContext.request.contextPath}/personBuy",
        delay:200,
        mode:"remote",
	    columns:[[    
	        {field:'personId',title:'人员编号',width:60},    
	        {field:'personName',title:'人员名称',width:100} 
	    ]],
	    onClickRow:function(index,row){
	    	
	    }
	});  
	$('#addbtn').bind('click', function(){    
// 		$('#form').form('enableValidation');
// 		var supplierId=$('#suppliertext').combogrid('getValue');
		$('#form').form('submit', {
			url:"${pageContext.request.contextPath}/addBuy",
			success: function(data){
				$.messager.alert('提示',data.substring(1,data.length-1)); 
				$('#dg').datagrid('reload');
				$('#win').window('close');
				$('#form').form('reset');
			}
		});
    });
})
//查询入库记录
function query(){
// 	$('#dg').treegrid('options').url="${pageContext.request.contextPath}/showBuy";
	$('#dg').datagrid('load',{
			storageDate:time,
			supplierId:supplierId
	});
}
</script>
</head>
<body>
	<table id="dg"></table>
	<input id="timehidden" type="hidden">
	<div id="win" class="easyui-window" title="药物入库信息" closed="true" style="width: 950px; height: 300px; padding: 5px;">
		<br />
		<form id="form" method="post">
			<div style="margin-left: 30px">
				<div style="diapaly: inline">
					 <label style="padding-right: 25px">票据编号：</label>
					 <input id="orderId" class="easyui-textbox easyui-validatebox" style="height: 25px" data-options="required:true,missingMessage:'请输入票据编号',panelHeight:'auto'" name="orderId" />
					 <label style="padding-right: 25px">查询药品：</label>
					 <input id="medicine" required="true" data-options="required:true,missingMessage:'请选择药品',editable:false"  style="height: 25px" name="medicineId"> 
					 <label style="padding-right: 25px">采购人员：</label>
					 <input id="person" required="true" data-options="required:true,missingMessage:'请选择采购人员',editable:false"  style="height: 25px" name="personId"> 
					 <br/><br/>
					 <label style="padding-right: 25px">票据日期：</label> 
					 <input name="orderDate" class="easyui-datebox" style="height: 25px" data-options="required:true,missingMessage:'请选择票据日期'" />
					 <label style="padding-right: 25px">入库批号：</label> 
					 <input name="orderItemId" style="height:20px" class="easyui-numberbox" precision="0"> 
					 <label style="padding-right: 25px">合格数量：</label> 
					 <input name="number" style="height:20px" class="easyui-numberbox" precision="0"> 
					  <br/><br/>
					  <label style="padding-right: 25px">入库单价：</label> 
					 <input name="medicinePrice" style="height:20px" class="easyui-numberbox" precision="2"> 
					 <label style="padding-right: 25px">入库价格：</label> 
					 <input name="orderItemPrice" style="height:20px" class="easyui-numberbox" precision="2"> 
					 <label style="padding-right: 25px">有效期限：</label> 
					 <input name="deadLine" class="easyui-datebox" style="height: 25px" data-options="required:true,missingMessage:'请选择票据日期'" />
					 <br/> <br/>
					 <label style="padding-right: 25px">生产日期：</label> 
					 <input name="productionDate" class="easyui-datebox" style="height: 25px" data-options="required:true,missingMessage:'请选择票据日期'" />
					<label style="padding-right: 25px">供货单位：</label> 
					 <input id="suppliertext" name="supplierId" class="easyui-combogrid" style="height: 25px" data-options="required:true,missingMessage:'请选择供货单位'" />
					 
					  <label style="padding-right: 25px">入库日期：</label> 
					 <input name="storageDate" class="easyui-datebox" style="height: 25px" data-options="required:true,missingMessage:'请选择入库日期'" /><br/>
				</div><br />
				<div id="dlg-buttons" style="text-align:center">
					<a id="addbtn" class="easyui-linkbutton" iconCls="icon-ok">确认登记</a>
					<a id="editbtn" class="easyui-linkbutton" iconCls="icon-ok">确认修改</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>