
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>未遂事件录入及上报</title>
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/css/login.css">
<script type="text/javascript"
	src="${pageContext.request.contextPath}/easyui/jquery.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/easyui/jquery.easyui.mobile.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/easyui/easyloader.js"></script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/easyui/datagrid-detailview.js"></script>
<script>

	//权限管理
	var str="${sessionScope['permissions']}";	
	var riskResultValue=new Array();
	var naerMissSnValue=new Array();
	var eventProcessValue=new Array();
	var reasonAnalysisValue=new Array();
	var preventMeasureValue=new Array();
	$(function() {
		<!--数据网络-->
		$('#dg').datagrid({
							pageNumber : 1,
							pagination : true,
							url : "${pageContext.request.contextPath}/attempted/event/showNearMiss?range=上报",
							rownumbers : true,
							fitColumns : true,
							pageSize : 10,
							singleSelect : true,
							nowrap:false,
							pageList : [ 5, 10, 15, 20 ],
							toolbar : [
									{
										iconCls : 'icon-add',
										text : '增加',
										id:'addtool',
										handler : function() {
											var str="${sessionScope['permissions']}";
											if(str.indexOf("160101")==-1){
												$("#addtool").css('display','none');
											}else{
												$('#addbtn').show();
												$('#editbtn').hide();
												$('#win').window('open');
												$('#form').form('disableValidation');
											}
										}
									},
									{
										iconCls : 'icon-edit',
										text : '修改',
										id:'edittool',
										handler : function() {	
											var str="${sessionScope['permissions']}";
											if(str.indexOf("160102")==-1){
												$("#edittool").css('display','none');
											}else{
								    			//数据回显
								    			var rows=$("#dg").datagrid("getSelections");
								    			if (rows){
								    				if(rows[0].nearMissState=='未上报'){
														$('#editbtn').show();
														$('#addbtn').hide();	
										    			$('#win').window('open');  
										    			//对表单数据进行填充
										    			$('#form').form('load',{
										    				nearMissSn:rows[0].nearMissSn,
										    				eventName:rows[0].eventName,
										    				happenDate:rows[0].happenDate,
										    				happenLocation:rows[0].happenLocation,
										    				eventProcess:rows[0].eventProcess,
										    				riskResult:rows[0].riskResult,
										    				riskLevel:rows[0].riskLevel,
										    				reasonAnalysis:rows[0].reasonAnalysis,
										    				preventMeasure:rows[0].preventMeasure,
										    				
										    				nearMissTypeSn:rows[0].nearMissTypeSn
										    			});
													}
								    				else{
								    					$.messager.alert('提示','已上报');
								    				}
								    			}
												else
												{
													$.messager.show({
														title:'消息提示',
														msg:'请先选择您要编辑的未遂事件！',
														showType:'null',
														style:{
															top:'50'
														}
													});
												}
											}
										}
									},
									{
										iconCls : 'icon-remove',
										text : '删除',
										id:'deletetool',
										handler : function() {
											var str="${sessionScope['permissions']}";
											if(str.indexOf("160103")==-1){
												$("#deletetool").css('display','none');
											}else{
												var row = $('#dg').datagrid('getSelected');
												if (row) {
													if(row.nearMissState=='未上报'){
														$.messager.confirm('选择是否删除','您确定要删除该未遂事件吗?',function(fn) {
															if(fn==true){
																$.post('${pageContext.request.contextPath}/attempted/event/deleteNearMiss',{nearMissSn:row.nearMissSn},function(message){
																	$.messager.alert('提示',message); 
																	$('#dg').datagrid('reload');
																});
															}
														});
													}
													else{
														$.messager.alert('提示','已上报');
													}
												} 
												else {
													$.messager.alert('提示','请先选择要删除的未遂事件');
												}
											}
										}
									}, {
										iconCls : 'icon-mini-add',
										text : '上报',
										id:'reporttool',
										handler : function() {
											var str="${sessionScope['permissions']}";
											if(str.indexOf("160104")==-1){
												$("#reporttool").css('display','none');
											}else{
												var row = $('#dg').datagrid('getSelected');
												if (row) {
													if(row.nearMissState=='未上报'){
														$.messager.confirm('选择是否上报','您确定要上报该未遂事件吗?',function(fn) {
															if (fn==true) 
															{
																$.post('${pageContext.request.contextPath}/attempted/event/changeStateNearMiss',{nearMissSn:row.nearMissSn,range:'上报'},function(message){
																	$.messager.alert('提示',message); 
																	$('#dg').datagrid('reload');
																});
															}
														});
													}
													else{
														$.messager.alert('提示','已上报');
													}
												} 
												else {
													$.messager.alert('提示','请先选择要上报的行');
												}
											}
										}
									} ],
							columns : [ [ {
								field : 'nearMissSn',
								title : '未遂事件编号',
								width : 1,hidden:true,
						    	formatter: function(value,row,index){
					        		  if(value!=null && value!=""){
					        			  naerMissSnValue[index]=value;
					        		  }else{
					        			  naerMissSnValue[index]="无";
					        		  }
					  		  	  }	
							},  {
								field : 'parentDepartmentName',
								title : '发生单位',
								width : 100
							},{
								field : 'departmentName',
								title : '发生区队',
								width : 100
							}, {
								field : 'eventName',
								title : '事件名称',
								width : 100
							}, {
								field : 'nearMissState',
								title : '未遂事件状态',
								width : 100
							}, {
								field : 'happenLocation',
								title : '发生地点',
								width :100
							}, {
								field : 'nearMissTypeName',
								title : '未遂事件类型',
								width : 100
							}, {
								field : 'nearMissTypeSn',
								title : '未遂事件类型编号',
								width : 100
							},{
								field : 'preventMeasure',
								title : '防范措施',
								width : 100,hidden:true,
						    	formatter: function(value,row,index){
					        		  if(value!=null && value!=""){
					        			  preventMeasureValue[index]=value;
					        		  }else{
					        			  preventMeasureValue[index]="无";
					        		  }
					  		  	  }	
							}, {
								field : 'reasonAnalysis',
								title : '原因分析',
								width : 100,hidden:true,
						    	formatter: function(value,row,index){
					        		  if(value!=null && value!=""){
					        			  reasonAnalysisValue[index]=value;
					        		  }else{
					        			  reasonAnalysisValue[index]="无";
					        		  }
					  		  	  }	
							}, {
								field : 'reportPersonName',
								title : '上报人',
								width : 100
							}, {
								field : 'riskLevel',
								title : '风险等级',
								width : 100
							}, {
								field : 'riskResult',
								title : '风险后果',
								width : 100,hidden:true,
						    	formatter: function(value,row,index){
					        		  if(value!=null && value!=""){
					        			  riskResultValue[index]=value;
					        		  }else{
					        			  riskResultValue[index]="无";
					        		  }
					  		  	  }	
							}, {
								field : 'reportTime',
								title : '上报时间',
								width : 200
							}, {
								field : 'eventProcess',
								title : '事件过程',
								width : 100,hidden:true,
						    	formatter: function(value,row,index){
					        		  if(value!=null && value!=""){
					        			  eventProcessValue[index]=value;
					        		  }else{
					        			  eventProcessValue[index]="无";
					        		  }
					  		  	  }	
							}, {
								field : 'happenDate',
								title : '发生日期',
								width : 300
							} ] ],
							view: detailview, 
							detailFormatter: function(rowIndex, row){
								return '<table style="border:1"><tr>' + 								
								'<td style="width:100px;text-align:center">'+'未遂事件编号：' + '</td>' + 
								'<td style="width:700px;text-align:center">' + 
								'<p>' + naerMissSnValue[rowIndex] + '</p>' + 
								'</td>' +
								'</tr><tr>' +
								

								'<td style="width:100px;text-align:center">'+'事件过程：' + '</td>' + 
								'<td style="width:700px;text-align:center">' + 
								'<p>' + eventProcessValue[rowIndex] + '</p>' + 
								'</td>' +
								'</tr><tr>' +
								
								'<td style="width:100px;text-align:center">'+'预防措施：' + '</td>' + 
								'<td style="width:700px;text-align:center" >' + 
								'<p>' + preventMeasureValue[rowIndex] + '</p>' + 
								'</td>' +
								'</tr><tr>' +
								

								'<td style="width:100px;text-align:center">'+'风险后果：' + '</td>' + 
								'<td style="width:700px;text-align:center">' + 
								'<p>' + riskResultValue[rowIndex] + '</p>' + 
								'</td>' +
								'</tr><tr>' +
								
								'<td style="width:100px;text-align:center">'+'原因分析：' + '</td>' + 
								'<td style="width:700px;text-align:center" colspan="3">' + 
								'<p>' + reasonAnalysisValue[rowIndex] + '</p>' + 
								'</td>' +
								'</tr></table>'; 
							}
						});
		//事件类型编号下拉框加载
		$('#nearMissType').combobox({
			url : '${pageContext.request.contextPath}/attempted/event/typeNearMiss',
			valueField : 'nearMissTypeSn',
			textField : 'nearMissTypeName',
			prompt : '请选择未遂事件类型'
		});
		$('#addbtn').bind('click', function(){    
			$('#form').form('enableValidation');
			$('#form').form('submit', {
				url:"${pageContext.request.contextPath}/attempted/event/addNearMiss",
				success: function(message){
					$.messager.alert('提示',message.substring(1,message.length-1)); 
					$('#dg').datagrid('reload');
					$('#win').window('close');
					$('#form').form('reset');
				}
			});
	    });
		$('#editbtn').bind('click', function(){    
			$('#form').form('enableValidation');
			$('#form').form('submit', {
				url:"${pageContext.request.contextPath}/attempted/event/updateNearMiss.action",
				success: function(){
					$.messager.alert('提示','修改成功'); 
					$('#dg').datagrid('reload');
					$('#win').window('close');
					$('#form').form('reset');
				}
			})  
	    });
		//第一层权限
		if(str.indexOf('160101')==-1){
			$('#addtool').css('display','none');
		}
		if(str.indexOf('160102')==-1){
			$('#edittool').css('display','none');
		}
		if(str.indexOf('160103')==-1){
			$('#deletetool').css('display','none');
		}
		if(str.indexOf('160104')==-1){
			$('#reporttool').css('display','none');
		}
		

		$('#addtool').linkbutton({
			plain:false
		});
		$('#edittool').linkbutton({
			plain:false
		});
		$('#deletetool').linkbutton({
			plain:false
		});
		$('#reporttool').linkbutton({
			plain:false
		});
	})
</script>
</head>
<body>
	<!-- 未遂事件数据列表 -->
	<table id="dg"></table>
	<!-- 未遂事件填写窗口-->
	<div id="win" class="easyui-window" title="未遂事件信息" closed="true" style="width: 950px; height: 400px; padding: 5px;">
		<br />
		<form id="form" method="post">
			<div style="margin-left: 30px">
				<div style="diapaly: inline">
					 <input name="nearMissSn" hidden/>
					 <label style="padding-right: 25px">事件类型：</label>
					 <input id="nearMissType" required="true" data-options="panelHeight:'auto'" name="nearMissTypeSn" />
					<label style="padding-right: 25px">事件名称：</label>
					 <input name="eventName" class="easyui-textbox easyui-validatebox" data-options="required:true,missingMessage:'请输入未遂事件名称'"> 
					 <label style="padding-right: 25px">发生日期：</label> 
					 <input name="happenDate" class="easyui-datebox" data-options="required:true,missingMessage:'请输入未遂事件发生日期'" />
					 <br/><br/>
					 <label style="padding-right: 25px">发生地点：</label> 
					 <input name="happenLocation" class="easyui-textbox easyui-validatebox" data-options="required:true,missingMessage:'请输入发生地点'" /> 
					 <label style="padding-right: 25px">风险等级：</label> 
					 <select name="riskLevel" class="easyui-combobox" data-options="panelHeight:'auto'" style="width: 175px">
						<option value="一般风险">一般风险</option>
						<option value="中等风险">中等风险</option>
						<option value="重大风险">重大风险</option>
					 </select> 
					 <label style="padding-right: 25px">发生区队：</label> 
					 <input value="${sessionScope['person'].department.departmentName}" readonly="true" iconCls="icon-lock" class="easyui-textbox" data-options="panelHeight:'auto'"/>					 
					 <br/>
				</div><br />
				<div id="tt" class="easyui-tabs" style="width:830px;height:200px;">   
				    <div title="事件过程 "  style="padding:20px;"> 
				      <input class="easyui-textbox" multiline="true" style="width:760px;height:120px" name="eventProcess"/>
				    </div>   
				    <div title="风险后果"   style="overflow:auto;padding:20px;">
				      <input class="easyui-textbox" name="riskResult" multiline="true" style="width:760px;height:120px" />
				    </div>   
				    <div title="防范措施" style="padding:20px;">   
				      <input class="easyui-textbox"  name="preventMeasure" multiline="true" style="width:760px;height:120px"/>
				    </div>   
				    <div title="原因分析" style="padding:20px;">   
				      <input class="easyui-textbox"  name="reasonAnalysis" multiline="true" style="width:760px;height:120px" />
				    </div>  
				</div> <br />
				<div id="dlg-buttons" style="text-align:center">
					<a id="addbtn" class="easyui-linkbutton" iconCls="icon-ok">确认添加</a>
					<a id="editbtn" class="easyui-linkbutton" iconCls="icon-ok">确认修改</a>
				</div>
			</div>
		</form>
	</div>
</body>
</html>