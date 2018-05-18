<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
<script type="text/javascript">
	var xmlHttp;
 	function getMoreContents()
 	{
 		//首先获得用户的输入
 		var content=document.getElementById("keyword");
 		if(content.value=="")
 		{
 				return;
 		}
 		//给服务器发送用书输入的内容；
 		//采用的是Ajax的异步发送数据，使用一个对象叫做XmlHttp对象;
 		alert(content.value);
 		xmlHttp=createXMLHttp();
 		alert(xmlHttp);
 		//给服务器中发送数据
 		var url="search?keyword="+escape(content.value);
 		//这三个参数表示以get方式想这个url中传递数据，true表示js脚本会在send()方法之后继续执行，
 		//而不会等到来自服务器的响应
 		xmlHttp.open("GET",url，true);
 		//绑定一个回掉方法，回掉方法会在xmlhttp状态改变时调用，
 		//xmlHttp的状态0-4，我们只关心4（成功状态）
 		//4表示的完成，只有完成了调用才有意思
 		xmlHttp.onreadyStatechange=callback;
 		//send不需要传输数据了，在url中已经写好了
 		xmlHttp.send(null);
 	}
 	//回掉函数
 	function callback()
 	{
 		if(xmlHttp.status==200)
 		{//表示服务器响应成功
 			//交互成功，获得相应的数据，是文本格式
 			var result=xmlHttp.responseText;
 		//解析响应的json数据，js和java中的json有一点区别，就是js中的外面的括号
 			var json=eval("("+result+")");
 		//获得数据后，就可以动态地显示这些数据了，把这些嗯数据展示输入框的下面
 		
 		}
 		
 	}
 	//设置关联数据的展示
 	function setContent(contents)
 	{
 		//首先获得关联数据的长度
 		var size=contents.length;
 		//设置内容
 		for(var i=0;i<size;i++)
 		{
 			var nextNode=contents[i];//代表json格式数据的第i个数据
 			var tr=document.createElement("tr");
 			var td=document.createElement("td");
 			td.setAttribute("border","0");
 			td.setAttribute("bgcolor","#FFFAFA");
 			td.onmouseover=function(){
 				this.className='mouseOver';
 			};
 			td.onmouseout=function(){
 				this.className='mouseOut';
 			};
 			td.onclick=function(){
 				//这个方法实现的是，当鼠标点击一个关联数据是，将数据显示到输入框
 				
 			};
 			var text=document.createTextNode(nextNode);
 			td.appendChild(text);
 			tr.appendChild(td);
 			document.getElementById("content_table_body").appendChild(tr);
 		}
 	}
 	//创建xmlhttpRequest对象
 	function createXMLHttp()
 	{
 		//对大多数的浏览器都使用的；
 		var xmlHttp;
 		
 		if(window.XMLHttpRequest)
 		{
 			xmlHttp=new XMLHttpRequest();	
 			return xmlHttp;
 		}
 		//考虑浏览器的兼容性
 		if(window.ActiveXObject)
 		{
 			xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");
 			if(!xmlHttp)
 			{
 				xmlHttp=new ActiveObject("Msxml2.XMLHTTP");	
 			}
 		}
 		
 		return xmlHttp;
 	}
</script>
</head>
<body>
<div align="center">
<input type="text" size="50" id="keyword" onkeyup="getMoreContents()"/>
<input type="button" width="50px" value="百度一下"/>
<!-- 显示数据部分 -->
<div id="pop">
<table id="content_table" bgcolor="#FFFAFA" border="0" cellspacing="0" cellpadding="0">
<tbody id="content_table_body"></tbody>

</div>
</div>
</body>
</html>