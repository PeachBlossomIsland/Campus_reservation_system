<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
<% 
//这儿通过cookie得到
//这个是通过cookie得到的用户账号;
String ac=null;
ac=request.getParameter("id");
%>
	<title>学生信息</title>
	<!-- meta-tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="" />
	<script type="text/javascript" charset="uft-8"> 
 	var xmlHttp;
 	var ac=<%=ac%>;
  	function getMoreContents(k,t)
  	{
  		xmlHttp=createXMLHttp();
  		
  		//给服务器中发送数据
  		var url="";
  		//请求参数
  		var request_parameters;
  		if(k=="tea_p_info"){
  			//得到个人信息
  			url="teainfo";
  			request_parameters="k=tea_p_info&t="+t+"&ac="+ac;
  		}
  		//这三个参数表示以get方式想这个url中传递数据，true表示js脚本会在send()方法之后继续执行，
  		//而不会等到来自服务器的响应
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
  			var json=eval("("+result+")");
  			if(k=="tea_p_info")
  			{
  				setContent(json);		
  			}
  		 }
  	}
  	//显示信息
  	function setContent(json)
  	{
  		document.getElementById("account").innerHTML=ac;
  		document.getElementById("name").innerHTML=json[0].toString();
  	    document.getElementById("dept").innerHTML=json[2].toString();
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
     function load_completion()
     {
    	 /*
    	 这儿有一个问题就是在加载初始化页面时，由于采用的是AJAX异步的方式，所以，如果一次性的将三个部分都加载的话
    	 就会出现当其他的部分没响应时，继续在响应另外的部分，这样就会造成最后只是显示最后一部分的页面，所以，
    	 有二种方式改变这一窘境，1.将AJAX改为同步，2.异步方式，但是执行加载的顺序改变，在这个中
    	 我选择是2，先加载的个人信息部分，后将所有表格都设为红色，然后加载教师空闲的时间，最后加载教师被预约的时间
    	 */
    	 //首先加载个人信息；
    	 getMoreContents("tea_p_info","");
     }
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
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
	<ul class="d1">
			<li class="d2"><A href="teainfo.jsp?id=<%=ac%>">设置时间</A></li>
			<li class="d2"><A href="commpro.jsp?id=<%=ac%>">查看预约</A></li>
			<li class="d2"><A href="view_evaluation.jsp?id=<%=ac%>">查看评价</A></li>
			<li class="d2"><A class="hover" href="tea_changepassword1.jsp?id=<%=ac%>">修改密码</A></li>
			<li class="d2"><A class="hover" href="tea_changepassword.jsp?id=<%=ac%>">设置专业领域</A></li>
			<li class="d2"><A href="tea_setpic.jsp?id=<%=ac%>">上传头像</A></li>
			<div id="lanPos"></div>
	</ul>
<div style="text-align:center;">
	<div class="blog-cource">
		<div class="container">
			<div class="title-div">
				<h3 class="tittle">
				<h3 class="tittle">
					<span>C</span>hange
					<span>P</span>assword
				</h3>
				<div class="tittle-style">
				</div>
			</div>
			<div class="login-form">
				<form action="teainfo" method="post">
					<div class="">
						<input  type="hidden" name="k" value="tea_change_passwd"/>
						<p>账号</p>
						<input type="text" class="password" name="ac" readonly="readonly" value="<%=ac %>"/>
						<p>新密码</p>
						<input type="password" class="password" name="t" required="" />
					</div>
					<input type="submit" value="提交">
					<div class="register-forming">
					</div>
				</form>
				<form action="teainfo" method="post">
					<div class="">
						<input  type="hidden" name="k" value="set_pro_field"/>
						<input  type="hidden" name="ac" value="<%=ac %>"/>
						<p>专业领域</p>
						<input type="text" class="name" name="t" required="" />
					</div>
					<input type="submit" value="确认修改">
					<div class="register-forming">
					</div>
				</form>
			</div>

		</div>
	</div>

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