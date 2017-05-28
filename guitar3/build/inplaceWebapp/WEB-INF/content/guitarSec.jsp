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
	    url: "${pageContext.request.contextPath}/guitarSearch",
	    rownumbers:true,
	    fitColumns:true,
	    singleSelect:true,
	    height:650,
	    toolbar:[
	 			],
	    columns:[[  
	              {field:'guitarName',title:'吉他名字'} 
	    ]]
	});

})
// //查询入库记录
// function query(){
// // 	$('#dg').treegrid('options').url="${pageContext.request.contextPath}/showBuy";
// 	$('#dg').datagrid('load',{
// 			storageDate:time,
// 			supplierId:supplierId
// 	});
// }
</script>
</head>
<body>
	<table id="dg"></table>
	<input id="timehidden" type="hidden">
</body>
</html>