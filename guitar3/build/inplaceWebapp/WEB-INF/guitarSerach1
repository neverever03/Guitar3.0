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
</body>
</html>