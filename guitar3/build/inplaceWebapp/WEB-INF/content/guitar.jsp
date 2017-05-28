<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>乐器管理</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/jquery.easyui.mobile.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/easyloader.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
<script>

var builder=null;
var model=null;
var type=null;
var backWood=null;
var topWood=null;
function submitForm(){
	$.messager.confirm('确认','确定保存该记录，保存后将无法修改',function(r){
		if(r){
				$('#ff').form('submit' , {		
				url :'${pageContext.request.contextPath}/addg',
				onSubmit : function(){
				return $(this).form('validate');//用户点击提交表单时，若表单无效则阻止表单提交
				},
			  success: function(){			
							$.messager.alert('成功','上传成功');
			 				$('#win').window('close'); 		
				 				var url='${pageContext.request.contextPath}/searchg?';
								$('#dg').datagrid("options").url=url; 
								$('#dg').datagrid('reload');  	 
			}
	})
		}
		});
}

$(function() {
	$('#win').window({
		height:300,
		width:400,
		modal:true,
		minimizable:true,
		maximizable	:true,
		closable:true,
		closed:true,
		modal:false,
		draggable:true,
		title:'编辑'	
	});
	$('#dg').datagrid({       
		pageNumber: 1,
		url: "${pageContext.request.contextPath}/searchg",
	    rownumbers:true,
	    fitColumns:true,
	    singleSelect:true,
	    height:650,
	    toolbar:[{
			text:'添加',
			iconCls: 'icon-add',
			handler:function(){
				$("#win").window('open');
			}
			},{
				id:'delete',
				iconCls:'icon-remove',
				text:'删除',
				handler:function(){
					var row=$("#dg").datagrid("getSelected");
					if(row){						
					$.messager.confirm('确认对话框', '您想要删除所选数据吗？', function(r){
						if (r){
							
						 	$.ajax({
								url:'${pageContext.request.contextPath}/deleteg',
								method:'POST',
								dataType:'json',
								data:{'serialNumber':row.serialNumber},
								success:function(data){
									if(data.status=="ok"){
										$.messager.alert('我的提示','删除成功！','info');
										$("#dg").datagrid("reload");						
									}else{
										$.messager.alert('我的提示','删除失败！','error');
									}
								}
							})
						}
					})
				}else{
					$.messager.show({
						title:'我的提示',
						msg:'请先选择一条记录！',
						timeout:1000,
						showType:'show',
						style:{
							right:'',
							top:document.body.scrollTop+document.documentElement.scrollTop+200,
							bottom:''
						}
					})
				}
				}
			},
		 			{
						text:'制造商:<input id="builderInput" name="builder">'	
			 		},	
					{
						text:'型号：<input id="typeInput" name="type">'
					},
					{
						text:'背面木料：<input id="backWoodInput" name="backWood">'
					},
					{
						text:'头部木料：<input id="topWoodInput" name="topWood">'
					}
	 			],
	    columns:[[  
	              {field:'serialNumber',title:'编号',width:100} ,
	              {field:'price',title:'价格',width:100}, 
	              {field:'builder',title:'制造商',width:100},
	              {field:'model',title:'型号',width:100},
	              {field:'type',title:'类型',width:100},
	              {field:'backWood',title:'背面木料',width:100},
	              {field:'topWood',title:'头部木料',width:100}
	    ]]
	});
    $('#builderInput').combobox({    
        url:'${pageContext.request.contextPath}/json/builder.json',    
        valueField:'id',    
        textField:'text',
        onSelect: function(){
        	builder=$('#builderInput').combobox('getValue');
        	query();
		}
    });
    $('#typeInput').combobox({    
        url:'${pageContext.request.contextPath}/json/type.json',    
        valueField:'id',    
        textField:'text',
        onSelect: function(){
        	type=$('#typeInput').combobox('getValue');
        	query();
		}
    });
    $('#backWoodInput').combobox({    
        url:'${pageContext.request.contextPath}/json/wood.json',    
        valueField:'id',    
        textField:'text',
        onSelect: function(){
        	backWood=$('#backWoodInput').combobox('getValue');
        	query();
		}
    });
    $('#topWoodInput').combobox({    
        url:'${pageContext.request.contextPath}/json/wood.json',    
        valueField:'id',    
        textField:'text',
        onSelect: function(){
        	topWood=$('#topWoodInput').combobox('getValue');
        	query();
		}
    });

})
	function query(){
	$('#dg').datagrid('options').url='${pageContext.request.contextPath}/searchg';
		$('#dg').datagrid('load',{
			builder:builder,
			type:type,
			backWood:backWood,
			topWood:topWood
		});
	}
</script>
</head>
<body>
	<input id="builder" type="hidden">
	<input id="type" type="hidden">
	<input id="backWood" type="hidden">
	<input id="topWood" type="hidden">
	<table id="dg"></table>
	
	<div id="win" >
			   <form id="ff"   method="post" >
			   	<table>
		    		<tr> 
	    			<td>编号：</td> 
		    			<td><input id="serialNumber"  name="serialNumber" data-options="required:true"></td> 
 		    		</tr> 
 		    		</br>
		    		<tr>
		    			<td>制造商:</td>
		    			<td><input  name="builder"  id="builder"  data-options="required:true"/></td>
		    		</tr>
		    		<tr>
		    			<td>价格：</td>
		    			<td><input name="price"  id="price"  data-options="required:true"/>$</td>
		    		</tr>
		    		<tr>
		    			<td>型号:</td>
		    			<td><input name="model"   id="model"  data-options="multiline:true" /></td>
	    		   </tr>
	    		   <tr>
		    			<td>类型:</td>
		    			<td><input   name="type"   id="type"  data-options="multiline:true" /></td>
	    		   </tr>
	    		   <tr>
		    			<td>背面材料:</td>
		    			<td><input   name="backWood"   id="backWood"  data-options="multiline:true"/></td>
	    		   </tr>
	    		   <tr>
		    			<td>头部材料:</td>
		    			<td><input  name="topWood"   id="topWood"  data-options="multiline:true" /></td>
	    		   </tr>
		    	</table>
		    	</form>
		    	<div style="text-align:center;padding:5px">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()">保存</a>
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="javascript:$('#win').window('close')">取消</a>
	     </div>
	</div>
</body>
</html>