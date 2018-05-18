<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
  //这儿是得到url中的dep参数的信息
String dep=request.getParameter("id");
String account=null;
String position=null;
if(session.getAttribute("account")!=null)
{
	account=session.getAttribute("account").toString();
}
if(session.getAttribute("position")!=null)
{
	position=session.getAttribute("position").toString();
	if(position=="tea") position="教师";
	if(position=="stu") position="学生";
}
%>
	<title>学院老师信息</title>
	<!-- meta-tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="" />
	<script type="text/javascript" charset="uft-8">
	//个人信息单击事件
	var account=<%=account%>;
	function fun()
	{
//		alert("college:"+account);
		if(account==null||account==undefined||account=='')
		{
			alert("请先登陆");	
		}else{
			var position=document.getElementById("position").innerText;
			if(trim(position)=="教师")
			{
				var url="teainfo.jsp?id="+account;
				window.location.href=url;
			}
			if(position=="学生")
			{
				var url="stuinfo.jsp?id="+account;
				window.location.href=url;
			}
		}
	}
	//退出事件
	function Sign_out(){
		
		if(account!=null)
		{
			document.getElementById("account").innerText="";
        	document.getElementById("position").innerText="";
        	window.location.href='signout';
		}
	}
	//这些函数是去除字符串中的前后空格
	//供使用者调用  
	function trim(s){  
	    return trimRight(trimLeft(s));  
	}  
	//去掉左边的空白  
	function trimLeft(s){  
	    if(s == null) {  
	        return "";  
	    }  
	    var whitespace = new String(" \t\n\r");  
	    var str = new String(s);  
	    if (whitespace.indexOf(str.charAt(0)) != -1) {  
	        var j=0, i = str.length;  
	        while (j < i && whitespace.indexOf(str.charAt(j)) != -1){  
	            j++;  
	        }  
	        str = str.substring(j, i);  
	    }  
	    return str;  
	}  

	function trimRight(s){  
	    if(s == null) return "";  
	    var whitespace = new String(" \t\n\r");  
	    var str = new String(s);  
	    if (whitespace.indexOf(str.charAt(str.length-1)) != -1){  
	        var i = str.length - 1;  
	        while (i >= 0 && whitespace.indexOf(str.charAt(i)) != -1){  
	           i--;  
	        }  
	        str = str.substring(0, i+1);  
	    }  
	    return str;  
	}
	
		var xmlHttp;
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}
	 	//这一部分主要是用AJAX技术进行修改密码和实时地设置空闲和取消空闲时间的代码！
	  	function getMoreContents(dep)
	  	{	
	  		xmlHttp=createXMLHttp();
	  		//给服务器中发送数据
	  		var url="college?dep="+dep;
	  		//请求参数
	  		//这儿使用AJAX的同步方法，因为异步方法的话，会出现返回调用显示内容函数的问题。
	  		xmlHttp.open("GET",url,false);
	  		xmlHttp.onreadystatechange=callback;
	  		xmlHttp.send(null);
	  	}	
	  	//回掉函数
	  	function callback()
	  	{
	  		if(xmlHttp.status==200)
	  		{
	  			var result=xmlHttp.responseText;
	  			var json=eval("("+result+")");
	  			var l=json.length;
	  			setContent(json,l);
	  		}
	  	}
	  	

	  	//显示信息
	  	function setContent(json,l)
	  	{
	   	   for(var i=0;i<l;i=i+3)
	       {   
	   		 //这儿是以 工号-姓名-研究领域依次来得到的；
	       	var div=document.createElement("div");  //指定一个名称创建元素	    
	       	var dl=document.createElement("dl");  //列表
	       	var dt=document.createElement("dt");//列表项
	       	var image=document.createElement("img");
	     	var tr = document.createElement("tr");
	       	image.src="images/teacher_images/"+json[i].toString()+".jpg";
	       	image.width="160";
	       	image.height="110";
	       	image.border="2";
	       	var dd1=document.createElement("dd");
	    	var dd2=document.createElement("dd");
	    	var a=document.createElement("a");
	    	var div2=document.createElement("div");
	    	div2.color="red";
	       	a.href="appointment.jsp?id="+json[i].toString();//这儿暂时是ac，代表被点击的教师的账号       
	       	a.innerText=json[i+1].toString();//暂时用name表示教师的姓名
	      	if(json[i+2]!=null)
	      	{
	       		div2.innerText=json[i+2].toString();
	       	}else{
	       		div2.innerText="教师还没有设置自己的专业领域!";
	      	}
	       	dd1.setAttribute("class","dd_name"); 
	       	dd2.setAttribute("class","dd_city"); 
	       	dt.appendChild(image);
	       	dd1.appendChild(a);
	    	dd2.appendChild(div2);
	       	dl.appendChild(dt);
	       	dl.appendChild(dd1);
	    	dl.appendChild(dd2);
	    	var table=document.getElementById("table"); 
	        div.appendChild(dl);
	      	tr.appendChild(div);
	    	table.appendChild(tr);
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
	    //页面初始化加载的函数
	  	function load_completion(){
	  		getMoreContents("<%=dep%>");
	    }  
	  </script>
		<style type="text/css">
		
		.dt{
			float:left;
			margin:1000px;
		
		}
		image{
			float:right;
		
		}
		.du{
		float:left;
	      margin: 10px;
	    
		}
	    a{
	    float:center;
	       font-size:24px;
	    
	    }
	   div dd{
	      margin:0px;
	      font-size:10pt;
	      
	   }
	    .dudu{
        border: 0px solid #3bafda;
        margin: 100px auto;
        text-align: center;
        border-collapse: collapse;
         
       float:center;
       }
	   .dd_name
	   {
	      color:red;     
	   }
	   .dd_city
	   {
	   	width:500px;
	    heigth:300px;
	    color:#666;
	    float:right;
	    margin-top:-135px;
	    margin-left:300px;
	    font-size:18px;      
	   }
	</style>
	<!-- //meta-tags -->
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />
	<!-- font-awesome -->
	<link href="css/font-awesome.css" rel="stylesheet">
	<!-- fonts -->
	<link href="http://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	    rel="stylesheet">
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
</head>
<body onload="load_completion();goPage(1,7);">
	<!-- header -->
	<div class="header-top">
		<div class="container">
			<div class="bottom_header_left">
				<p>
					<label id="account"><%=account %></label>&nbsp&nbsp&nbsp&nbsp&nbsp
					<label id="position"><%=position %></label>&nbsp&nbsp&nbsp&nbsp&nbsp
					<button  style="background-color:#37BF91; border-style:none" onclick="fun()">个人信息</button>
					&nbsp&nbsp&nbsp&nbsp&nbsp<button  style="background-color:#37BF91; border-style:none" onclick="Sign_out()">退出</button>
				</p>
			</div>
			<div class="bottom_header_right">
				<div class="bottom-social-icons">
					<a class="facebook" href="#">
						<span class="fa fa-facebook"></span>
					</a>
					<a class="twitter" href="#">
						<span class="fa fa-twitter"></span>
					</a>
					<a class="pinterest" href="#">
						<span class="fa fa-pinterest-p"></span>
					</a>
					<a class="linkedin" href="#">
						<span class="fa fa-linkedin"></span>
					</a>
				</div>
				<div class="header-top-righ">
					<a href="login.html">
						<span class="fa fa-sign-out" aria-hidden="true"></span>Login</a>
				</div>
				<div class="clearfix"> </div>
			</div>
			<div class="clearfix"> </div>
		</div>
	</div>
	<div class="header">
		<div class="content white">
			<nav class="navbar navbar-default" >
				<div class="container">
					<div class="navbar-header">
						<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
							<span class="sr-only">Toggle navigation</span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
							<span class="icon-bar"></span>
						</button>
						<a class="navbar-brand" href="index.html">
							<h1>
								<span class="" aria-hidden="true"><img src="images/xh.jpg" height="50" width="50"></span>Best Communication
								<label>Education & Courses</label>
							</h1>
						</a>
					</div>
					<!--/.navbar-header-->
					<div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
						<nav class="link-effect-2" id="link-effect-2">
							<ul class="nav navbar-nav">
								<li class="active">
									<a href="main.jsp" class="effect-3">Home</a>
								</li>
								<li>
									<a href="college.jsp?id=eng" target="_blank" class="effect-3">理学院</a>
								</li>
								<li>
									<a href="college.jsp?id=ocean" target="_blank" class="effect-3">船舶海洋</a>
								</li>
								<li>
									<a href="college.jsp?id=infor" target="_blank" class="effect-3">信息学院</a>
								</li>
				
								<li class="active">
									<a href="college.jsp?id=Computer" target="_blank" class="effect-3">计算机学院
										<span class="caret"></span>
									</a>
									
								</li>
								<li>
									<a href="gallery.html" class="effect-3">Gallery</a>
								</li>
								<li>
									<a href="contact.html" class="effect-3">Contact Us</a>
								</li>
							</ul>
						</nav>
					</div>
					<!--/.navbar-collapse-->
					<!--/.navbar-->
				</div>
			</nav>
		</div>
	</div>
	<!-- banner -->
	<div class="inner_page_agile">

	</div>
	<!--//banner -->
	<!-- short-->
	<div class="services-breadcrumb">
		<div class="inner_breadcrumb">
			<ul class="short_ls">
				<li>
					<a href="index.html">Home</a>
					<span>| |</span>
				</li>
				<li>Courses</li>
			</ul>
		</div>
	</div>
	<!-- //short-->
	<!-- blog -->
	<div class="blog-cource">
		<div class="container">
		<div class="title-div">
				<h3 class="tittle">
					<span>P</span>opular
					<span>T</span>eachers
				</h3>
				<div class="tittle-style">

				</div>
			</div>
    <hr> 
    <center> 
    <div class="du">
    <table width="750" height="60" cellpadding="0" cellspacing="0" border="0" id="table">
        <td id="td1">    
        </td>
    </table>
    <table width="60%" align="right" class="dudu">
        <tr><td><div id="barcon" name="barcon"></div></td></tr>
    </table>
  </div>  
    </center>
  
	</div>
	<!-- //blog -->

	<!-- footer -->
	<div class="mkl_footer">
		<div class="sub-footer">
			<div class="container">
				<div class="mkls_footer_grid">
					<div class="col-xs-4 mkls_footer_grid_left">
						<h4>Location:</h4>
						<p>educa mfdflimbg 1235, Ipswich,
							<br> Weihahi, China</p>
					</div>
					<div class="col-xs-4 mkls_footer_grid_left">
						<h4>Mail Us:</h4>
						<p>
							<span>Phone : </span>17863135555</p>
						<p>
							<span>Email : </span>
							<a href="mailto:info@example.com">mail@tom.com</a>
						</p>
					</div>
					<div class="col-xs-4 mkls_footer_grid_left">
						<h4>Opening Hours:</h4>
						<p>Working days : 8am-10pm</p>
						<p>Sunday
							<span>(closed)</span>
						</p>
					</div>
					<div class="clearfix"> </div>
				</div>
				<div class="botttom-nav-allah">
					<ul>
						<li>
							<a href="index.html">Home</a>
						</li>
						<li>
							<a href="about.html">About Us</a>
						</li>
						<li>
							<a href="courses.html">Courses</a>
						</li>
						<li>
							<a href="join.html">Join Us</a>
						</li>
						<li>
							<a href="contact.html">Contact Us</a>
						</li>
					</ul>
				</div>
				<!-- footer-button-info -->
				<div class="footer-middle-thanks">
					<h2>Thanks For watching</h2>
				</div>
				<!-- footer-button-info -->
			</div>
		</div>
		<div class="footer-copy-right">
			<div class="container">
				<div class="allah-copy">
					<p>Copyright &copy; 2018.Company name All rights reserved.<a target="_blank" href="http://sc.chinaz.com/moban/">&#x7F51;&#x9875;&#x6A21;&#x677F;</a></p>
				</div>
				<div class="footercopy-social">
					<ul>
						<li>
							<a href="#">
								<span class="fa fa-facebook"></span>
							</a>
						</li>
						<li>
							<a href="#">
								<span class="fa fa-twitter"></span>
							</a>
						</li>
						<li>
							<a href="#">
								<span class="fa fa-rss"></span>
							</a>
						</li>
						<li>
							<a href="#">
								<span class="fa fa-vk"></span>
							</a>
						</li>
					</ul>
				</div>
				<div class="clearfix"></div>
			</div>
		</div>
	</div>
	<!--/footer -->

	<!-- js files -->
	<!-- js -->
	<script src="js/jquery-2.1.4.min.js"></script>
	<!-- bootstrap -->
	<script src="js/bootstrap.js"></script>
	<!-- stats numscroller-js-file -->
	<script src="js/numscroller-1.0.js"></script>
	<!-- //stats numscroller-js-file -->
	<!-- smooth scrolling -->
	<script src="js/SmoothScroll.min.js"></script>
	<script src="js/move-top.js"></script>
	<script src="js/easing.js"></script>
	<!-- here stars scrolling icon -->
	<script>
	/**
	 * 分页函数
	 * pno--页数
	 * psize--每页显示记录数
	 * 分页部分是从真实数据行开始，因而存在加减某个常数，以确定真正的记录数
	 * 纯js分页实质是数据行全部加载，通过是否显示属性完成分页功能
	 **/
	function goPage(pno,psize){
	    var itable = document.getElementById("table");
	    var num = itable.rows.length;//表格所有行数(所有记录数)
	    console.log(num);
	    var totalPage = 0;//总页数
	    var pageSize = psize;//每页显示行数
	    //总共分几页 
	    if(num/pageSize > parseInt(num/pageSize)){   
	            totalPage=parseInt(num/pageSize)+1;   
	       }else{   
	           totalPage=parseInt(num/pageSize);   
	       }   
	    var currentPage = pno;//当前页数
	    var startRow = (currentPage - 1) * pageSize+1;//开始显示的行  31 
	       var endRow = currentPage * pageSize;//结束显示的行   40
	       endRow = (endRow > num)? num : endRow;    40
	       console.log(endRow);
	       //遍历显示数据实现分页
	    for(var i=1;i<(num+1);i++){    
	        var irow = itable.rows[i-1];
	        if(i>=startRow && i<=endRow){
	            irow.style.display = "block";    
	        }else{
	            irow.style.display = "none";
	        }
	    }
	    var pageEnd = document.getElementById("pageEnd");
	    var tempStr = "共"+(num-1)+"条记录 分"+totalPage+"页 当前第"+currentPage+"页";
	    if(currentPage>1){
	        tempStr += "<a href=\"#\" onClick=\"goPage("+(1)+","+psize+")\">首页</a>";
	        tempStr += "<a href=\"#\" onClick=\"goPage("+(currentPage-1)+","+psize+")\"><上一页</a>"
	    }else{
	        tempStr += "首页";
	        tempStr += "<上一页";    
	    }
	    if(currentPage<totalPage){
	        tempStr += "<a href=\"#\" onClick=\"goPage("+(currentPage+1)+","+psize+")\">下一页></a>";
	        tempStr += "<a href=\"#\" onClick=\"goPage("+(totalPage)+","+psize+")\">尾页</a>";
	    }else{
	        tempStr += "下一页>";
	        tempStr += "尾页";    
	    }
	    document.getElementById("barcon").innerHTML = tempStr;
		}
		$(document).ready(function () {
			$().UItoTop({
				easingType: 'easeOutQuart'
			});

		});
	</script>
	<!-- //here ends scrolling icon -->
	<!-- smooth scrolling -->
	<!-- //js-files -->

</body>
</html>