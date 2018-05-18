<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
<% 
//这儿通过cookie得到
//这个是通过cookie得到的用户账号;
String ac=request.getParameter("id");
%>
	<title>教师个人信息</title>
	<!-- meta-tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="" />
<script type="text/javascript">
addEventListener("load", function () {
	setTimeout(hideURLbar, 0);
}, false);

function hideURLbar() {
	window.scrollTo(0, 1);
}
	var xmlHttp;
	var ac=<%=ac%>;
	//这一部分主要是用AJAX技术进行修改密码和实时地设置空闲和取消空闲时间的代码！
	function getMoreContents(k,t)
	{
		xmlHttp=createXMLHttp();
		var url="";
		//请求参数
		var request_parameters;
		if(k=="stu_p_info"){
			//得到个人信息
			url="teainfo";
			request_parameters="k=stu_p_info&t="+t+"&ac="+ac;
		}
		xmlHttp.open("POST",url,false);
		//设置报文头信息
		xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
		xmlHttp.onreadystatechange=function(){callback(k,t)};
		xmlHttp.send(request_parameters);
	}
	//回掉函数
	function callback(k,t)
	{
		if(xmlHttp.status==200)
		{
			var result=xmlHttp.responseText;
			//解析响应的json数据，js和java中的json有一点区别，就是js中的外面的括号
			var json=eval("("+result+")");
			if(k=="stu_p_info")
			{
				setContent(json,1);	
					
			}
		}
	}
	//显示信息
	function setContent(json,kind)
	{
		if(kind==1)
		{
			document.getElementById("account").innerHTML=ac;
			document.getElementById("name").innerHTML=json[0].toString();
			document.getElementById("dept").innerHTML=json[2].toString();
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
 	//在页面加载完成后执行的函数：这是首先执行的函数
 	function load_completion()
 	{
		 getMoreContents("stu_p_info","");
 	}
 	//下面用于图片上传预览功能
 	function setImagePreview(avalue) {
 		var docObj=document.getElementById("doc");
 		var imgObjPreview=document.getElementById("preview");
 		if(docObj.files &&docObj.files[0])
 		{
 		//火狐下，直接设img属性
 	 		imgObjPreview.style.display = 'block';
 	 		imgObjPreview.style.width = '150px';
 	 		imgObjPreview.style.height = '180px'; 
 	 		//imgObjPreview.src = docObj.files[0].getAsDataURL();
 	 		//火狐7以上版本不能用上面的getAsDataURL()方式获取，需要一下方式
 	 		imgObjPreview.src = window.URL.createObjectURL(docObj.files[0]);
 	 	}
 		else
 		{
 	 		//IE下，使用滤镜
 	 		docObj.select();
 	 		var imgSrc = document.selection.createRange().text;
 	 		var localImagId = document.getElementById("localImag");
 	 		//必须设置初始大小
 	 		localImagId.style.width = "150px";
 	 		localImagId.style.height = "180px";
 	 		//图片异常的捕捉，防止用户修改后缀来伪造图片
 			try{
 				localImagId.style.filter="progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)";
 	 			localImagId.filters.item("DXImageTransform.Microsoft.AlphaImageLoader").src = imgSrc;
 	 		}catch(e){
 				alert("您上传的图片格式不正确，请重新选择!");
 				return false;
 			}
 				imgObjPreview.style.display = 'none';
 				document.selection.empty();
 		}
 		return true;
 	}
</script>
<!-- //meta-tags -->
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/style1.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/dudu.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/basic.css" rel="stylesheet" type="text/css" media="all" />
	<!-- font-awesome -->
	<link href="css/font-awesome.css" rel="stylesheet">
	<!-- fonts -->
	<link href="http://fonts.googleapis.com/css?family=Raleway:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	    rel="stylesheet">
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i,800,800i" rel="stylesheet">
	  <!-- S  CSS -->
    <style>
    * {
        padding: 0;
        margin: 0;
    }

    table {
        border: 1px solid #3bafda;
        margin: 100px auto;
        text-align: center;
        border-collapse: collapse;
    }
     table th {
        border: 1px solid #3bafda;
        padding: 10px;
    }

    table td {
        border: 1px solid #48cfad;
        padding: 4px 10px;
    }
    .huhuhu{
    
        margin: 0px 230px;
        text-align: center;
        border-collapse: collapse;
        width:100px;
    }
      #hahaha{
    
        text-align: center;
        width:68px;
        float:left;
    }
    input{
    float:center;
    }
    </style>
    <!-- E  CSS -->
</head>
<body onLoad="load_completion()">
	<!-- header -->
	<div class="header-top">
		<div class="container">
			<div class="bottom_header_left">
				<p>
					<label id="account"></label>&nbsp&nbsp&nbsp&nbsp&nbsp
					<label id="name"></label>&nbsp&nbsp&nbsp&nbsp&nbsp
					<label id="dept"></label>
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
									<a href="Gallery.html" class="effect-3">Gallery</a>
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
	<ul class="d1">
			<li class="d2"><A href="stuinfo.jsp?id=<%=ac%>">预约时间</A></li>
			<li class="d2"><A href="comment1.jsp?id=<%=ac%>">评价教师</A></li>
			<li class="d2"><A class="hover" href="stu_setpic.jsp?id=<%=ac%>">上传头像</A></li>
			<li class="d2"><A href="stu_changepassword.jsp?id=<%=ac%>">修改密码</A></li>
			<div id="lanPos"></div>
		</ul>
<div style="text-align:center;">
	<div class="blog-cource">
		<div class="container">
			<div class="title-div">
				<h3 class="tittle">
					<span>S</span>tudent's
					<span>P</span>hoto
				</h3>
			<!-- 文件上传功能 -->	
			<div align="center">	
			<div id="localImag"><img id="preview" src="" width="150" height="180" style="display: block; width: 150px; height: 180px;" /></div>
			<form method="post" action="upload?k=stu&id=<%=ac %>" enctype="multipart/form-data">				
    		<input type="file" name="uploadFile" id="doc" style="width:180px;" onchange="setImagePreview();">
	 		<br/>	<br/>				
			<input style="width:100px;height:30px;background-color:#FF1493;" type="submit" value="上传">
			</form>
			</div>
			</div>
		</div>			
	</div>
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
							<br> Foxhall Road, USA</p>
					</div>
					<div class="col-xs-4 mkls_footer_grid_left">
						<h4>Mail Us:</h4>
						<p>
							<span>Phone : </span>001 234 5678</p>
						<p>
							<span>Email : </span>
							<a href="mailto:info@example.com">mail@example.com</a>
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
	<script src="js/index.js"></script>
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