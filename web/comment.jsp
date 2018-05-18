<%@ page language="java" import="java.util.*" contentType="text/html; charset=utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<%
  //这儿是得到url中的dep参数的信息
String tno=request.getParameter("id");
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
	var xmlHttp;
 	var tno=<%=request.getParameter("id")%>;//这个是老师的工号，通过上一个页面传过来的，
 	var time=<%=request.getParameter("time")%>;//这个是时间
	var account=<%=account%>;//这个是账号，可能是学生，也可能是教师，但是在这个评价页面中只能是学生了
	var position=<%=position%>;
	function fun1()
	{
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

	//去掉右边的空白 www.2cto.com   
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
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}
	</script>
		<style type="text/css">		
		.box{
				width:300px;
				height:40px;
				background:#FFFFFF;
 position:absolutet;
margin-bottom:20px;
margin-left:90px;
}
.kk{
height: 40px;
width:40px;
background: url('images/star.png');
background-repeat: no-repeat;
background-size: 25px 25px;
list-style: none;
background-position:  center;
margin-right:10px;
float:left;
cursor: pointer;
}
#score{
color:red;
margin-top:20px;
margin-left:-80px;
}
.hh{
 position:;
margin-bottom:20px;
margin-left:10px;
}
.ha{
 position: absolute;
 right: 775px;
 bottom: -116px;
 height: 40px;
 width:100px;

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

<body onload="load_completion()">
	<!-- header -->
	<div class="header-top">
		<div class="container">
			<div class="bottom_header_left">
				<p>
					<label id="account"><%=account %></label>&nbsp&nbsp&nbsp&nbsp&nbsp<label id="position"><%=position %></label>&nbsp&nbsp&nbsp&nbsp&nbsp
					<button  style="background-color:#37BF91; border-style:none" onclick="fun1()">个人信息</button>
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
					<span>M</span>y
					<span>C</span>omment
				</h3>
				<div class="tittle-style">

				</div>
			</div>
			<h1>评价及建议</h1>
    <hr> 
    <center> 
    <div class="du">
    <span class="ha" width:100px>点亮星星:</span>
 	<div class="box" id="star0" score="">
	<li class="kk"></li>
	<li class="kk"></li>
	<li class="kk"></li>
	<li class="kk"></li>
	<li class="kk"></li>
	</div>
	<div id="score"></div>
    <label class="hh">
    <span>我的建议 :</span>
    <textarea id="message" placeholder="Your Message to Us"></textarea>
    </label>
    <label>
    <span>&nbsp;</span>
   <button id="sub_btn">提交</button>
    </label>
    </form>
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
	var score=0;
	$(".box li").click(function(){
		var index = $(this).index();
		$(this).parent().attr("score",index+1);
		var parentId = $(this).parent().attr("id");
		$("#"+parentId).find("li").css("background-image","url('images/star.png')");
		for(var i=0;i<=index;i++){
		$("#"+parentId).find("li").eq(i).css("background-image","url('images/star1.png')");
		}
		score = $("#"+parentId).attr("score");
		$("#score").text("您选择的分数是:"+score+"分");
		});
		$(document).ready(function () {
			$().UItoTop({
				easingType: 'easeOutQuart'
			});
		});
		
			   $("#sub_btn").click(function(){
				var sub_text=$("#message").val();
				//t为时间，score为打的分数;ac为学生的学号，tno为教师的工号,text为评价信息
				 $.ajax({
						type:"POST",
			            url:"teainfo",
			            data:{"k":"sub_evaluate","t":time,"ac":account,"score":score,"text":sub_text},
			            success: function(result){
			            $("#message").val("");
			            alert("提交成功！");
			            window.location.reload();
			  	 	}  
				});
			 });
	</script>
	<!-- //here ends scrolling icon -->
	<!-- smooth scrolling -->
	<!-- //js-files -->

</body>

</html>