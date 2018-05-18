<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
<% 
//这儿通过cookie得到
//这个是通过cookie得到的用户账号;
String ac=request.getParameter("id");
%>
	<title>学生信息</title>
	<!-- meta-tags -->
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta name="keywords" content="" />
	<script type="text/javascript" charset="uft-8">
  	var tea_id;//这个是全局变量，是被学生预约的老师的信息 
 	var xmlHttp;
 	var ac=<%=ac%>;
 	//这一部分主要是用AJAX技术进行修改密码和实时地设置空闲和取消空闲时间的代码！
  	function getMoreContents(k,t)
  	{
 		//在得到个人信息和获取教师的时间信息时t=“”;就是t这个参数是空的
  		//给服务器发送用书输入的内容；
  		//采用的是Ajax的异步发送数据，使用一个对象叫做XmlHttp对象;
  		xmlHttp=createXMLHttp();
  		//给服务器中发送数据
  		var url="";
  		//请求参数
  		var request_parameters;
  		/*
  		if(k=="stu_change_passwd")
  		{//如果第一个参数是new_passwd时，就说明这是一个关于密码的参数,第二个参数time就是新密码
  			url="teainfo"
  			request_parameters="k=stu_change_passwd&t="+t+"&ac="+ac;
  		
  		}else*/ if(k=="stu_p_info"){
  			//得到个人信息
  			url="teainfo";
  			request_parameters="k=stu_p_info&t="+t+"&ac="+ac;
  			
  		}else if(k=="stu_get_rtime"){
  			//得到学生自己的预约信息
  			url="teainfo";
  			request_parameters="k=stu_get_rtime&t="+t+"&ac="+ac;
  		}else if(k=="stu_yellow"){
  			//学生取消预约信息
  			url="teainfo";
  			request_parameters="k=stu_yellow"+"&t="+t+"&ac="+ac+"&tea_id="+tea_id;
  		}
  		//这三个参数表示以get方式想这个url中传递数据，true表示js脚本会在send()方法之后继续执行，
  		//而不会等到来自服务器的响应
  		xmlHttp.open("POST",url,false);
  		//设置报文头信息
  		xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
  		//绑定一个回掉方法，回掉方法会在xmlhttp状态改变时调用，
  		//xmlHttp的状态0-4，我们只关心4（成功状态）
  		//4表示的完成，只有完成了调用才有意思
  		xmlHttp.onreadystatechange=function(){callback(k,t)};
  		//发送,并且设置参数
  		xmlHttp.send(request_parameters);
  	}
  	
  	
  	//回掉函数
  	function callback(k,t)
  	{
  		if(xmlHttp.status==200)
  		{//表示服务器响应成功
//  			alert("xmlHttp.status");
  			//交互成功，获得相应的数据，是文本格式
  			var result=xmlHttp.responseText;
  			//解析响应的json数据，js和java中的json有一点区别，就是js中的外面的括号
  		/*
  			if(k=="stu_change_passwd")
  			{
  			//这一部分都是关于修改密码和设置或者取消空闲时间的
  				if(result=="change_passwd_succeed")
  				{//如果响应的是成功
  					change_passwd_succeed();
  	  			}else if(result=="change_passwd_fail")
  	  			{
  	  				alert("修改密码失败！");
  	  			}
  			}else*/
  				if(k=="stu_yellow"){
  				//取消预约成功
				document.getElementById(t.toString()).style.backgroundColor="#99CC66";
	  			document.getElementById(t.toString()).innerHTML="";	
	  			alert("取消预约成功!");
  			}else{
  			//这一部分就是得到个人信息和一切关于时间的信息
  			//这些信息由于数据了大，所以就使用了json格式
  				var json=eval("("+result+")");
  			//用于显示信息,第一个参数是显示的内容，第二个参数是类别(1:显示个人信息，2:显示教师的空闲时间,3:显示预约的时间)
  				if(k=="stu_p_info")
  				{//得到的学生个人信息显示
  					setContent(json,1);	
  					
  				}else if(k=="stu_get_rtime"){
  					//得到的学生的预约信息显示
  					setContent(json,3);	
  				}
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
 			 //将所有的颜色设置为绿色
  			setAllColor();
  	    	 //加载教师的空闲时间
  	    	  //加载教师的空闲时间
 		   	getMoreContents("stu_get_rtime","");
  		}else if(kind==3){
  			//显示学生的预约时间，将对应的表格设置为黄色
  			for(var i=0;i<json.length;i=i+2)
  			{
  				var rl=json[i];
  				document.getElementById(rl.toString()).innerHTML=json[i+1].toString();
  				document.getElementById(rl.toString()).style.backgroundColor="#FFFF66";
  			}
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

     //这个是点击之后改变表格的颜色的
    	function fun(row_column)
    	{
    	 	var t=row_column.toString();
    	 	//得到点击的表格的id
    	 	var single_form=document.getElementById(t);
    	 	//得到表格的背景色，如果为黄色，则说明是取消预约的操作
    	 	var k=single_form.style.backgroundColor.toString();
    	 	//得到被预约老师的信息
    	 	tea_id=single_form.innerHTML.toString();
 //   	 	alert(tea_id);
    	 	if(k=="rgb(255, 255, 102)") getMoreContents("stu_yellow",t);
    	}
     /*
     //这个是点击修改密码后更改表格的函数
    	function change_passwd()
    	{
    	 //获得输入的新密码
    		var input_new_passwd=document.getElementById("input1");
    	 //动态地显示一个输入新密码的框
    		input_new_passwd.innerHTML="<input type='text' placeholder='输入新密码' id='new_passwd'/>";	
    		//callback();
    	}  
     //这个是点击提交修改按钮的响应函数
     function submit_change()
     {
    	 //获得新的密码
    	 var new_passwd=document.getElementById("new_passwd"); 
    	 if(new_passwd==null)
    	 {
    		alert("请输入新密码");	 
    	 }else{
    		 //调用AJAX传输数据
    		// alert(new_passwd);
    		 getMoreContents("stu_change_passwd",new_passwd.value);
    	 }
     }
     //修改密码成功后的操作：
     function change_passwd_succeed()
     {
    	 var input_new_passwd=document.getElementById("input1");
    	 //将输入框置空
    	 input_new_passwd.innerHTML="";	
    	 alert("修改密码成功!");
     }
     */
     //在页面加载完成后执行的函数：这是首先执行的函数
     function load_completion()
     {
    	 /*
    	 这儿有一个问题就是在加载初始化页面时，由于采用的是AJAX异步的方式，所以，如果一次性的将三个部分都加载的话
    	 就会出现当其他的部分没响应时，继续在响应另外的部分，这样就会造成最后只是显示最后一部分的页面，所以，
    	 有二种方式改变这一窘境，1.将AJAX改为同步，2.异步方式，但是执行加载的顺序改变，在这个中
    	 我选择是2，先加载的个人信息部分，后将所有表格都设为红色，然后加载教师空闲的时间，最后加载教师被预约的时间
    	 */
    	 //首先加载个人信息；
    	 getMoreContents("stu_p_info","");
     }
     //页面加载完成后执行的函数
     function setAllColor(){
    		for(var i=1;i<11;i++)
    		{
    			for(var j=1;j<8;j++)
    			{
    				var t=i.toString()+j.toString();
    				//alert(t);
    				var form=document.getElementById(t.toString());
    				form.style.backgroundColor="#99CC66";
    			}
    		}
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
			<li class="d2"><A class="hover" href="stuinfo.jsp?id=<%=ac%>">预约时间</A></li>
			<li class="d2"><A href="comment1.jsp?id=<%=ac%>">评价教师</A></li>
			<li class="d2"><A href="stu_changepassword.jsp?id=<%=ac%>">修改密码</A></li>
			<li class="d2"><A href="stu_setpic.jsp?id=<%=ac%>">上传头像</A></li>
			<div id="lanPos"></div>
	</ul>
<div style="text-align:center;">
	<div class="blog-cource">
		<div class="container">
			<div class="title-div">
				<h3 class="tittle">
					<span>S</span>tudent's
					<span>I</span>nformation
				</h3>
				<div class="tittle-style">
	
 <!-- S   课程表
    <table>
    	<tr>
              <th colspan="2">个人信息表</th>
        </tr>
        <tr>
              <td>账号：</td>
              <td id="account"></td>
        </tr>
         <tr>
          	 <td>姓名：</td>
              <td id="name"></td>
        </tr>
         <tr>
         	 <td>性别：</td>
              <td id="sex"></td>
        </tr>
         <tr>
       		 <td>院系：</td>
             <td id="dept"></td>
        </tr>
         <tr>
             <td colspan="2" id="input1"></td>
        </tr>
        <tr>
             <td><button id="b1" onclick="change_passwd();">修改密码</button></td>
             <td><button id="b2" onclick="submit_change();">提交修改</button></td>
        </tr>
        
    </table>
    -->
    <table>
        	<tr>
                <th colspan="9">设置空闲时间表</th>
            </tr>
         	<tr>
                <th colspan="2">时间</th>
                <th>星期一</th>
                <th>星期二</th>
                <th>星期三</th>
                <th>星期四</th>
                <th>星期五</th>
                <th>星期六</th>
                <th>星期天</th>
            </tr>
            <tbody id="t2">
            <tr >
                <td rowspan="4" bgcolor="#FFFFFF">上午</td>
                <td bgcolor="#FFFFFF">08:00-08:50</td>
                <td id="11" onClick="fun(11)"></td>
                <td id="12" onClick="fun(12)"></td>
                <td id="13" onClick="fun(13)"></td>
                <td id="14" onClick="fun(14)"></td>
                <td id="15" onClick="fun(15)"></td>
                <td id="16" onClick="fun(16)"></td>
                <td id="17" onClick="fun(17)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">8:55-09:45</td>
                <td id="21" onClick="fun(21)"></td>
                <td id="22" onClick="fun(22)"></td>
                <td id="23" onClick="fun(23)"></td>
                <td id="24" onClick="fun(24)"></td>
                <td id="25" onClick="fun(25)"></td>
                <td id="26" onClick="fun(26)"></td>
                <td id="27" onClick="fun(27)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">10:05-10:55</td>
                <td id="31" onClick="fun(31)"></td>
                <td id="32" onClick="fun(32)"></td>
                <td id="33" onClick="fun(33)"></td>
                <td id="34" onClick="fun(34)"></td>
                <td id="35" onClick="fun(35)"></td>
                <td id="36" onClick="fun(36)"></td>
                <td id="37" onClick="fun(37)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">11:00-11:50</td>
               <td id="41" onClick="fun(41)"></td>
                <td id="42" onClick="fun(42)"></td>
                <td id="43" onClick="fun(43)"></td>
                <td id="44" onClick="fun(44)"></td>
                <td id="45" onClick="fun(45)"></td>
                <td id="46" onClick="fun(46)"></td>
                <td id="47" onClick="fun(47)"></td>
            </tr>
            <tr>
             <td rowspan="4" bgcolor="#FFFFFF">下午</td>
            <td bgcolor="#FFFFFF">14:00-14:50</td>
             <td id="51" onClick="fun(51)"></td>
             <td id="52" onClick="fun(52)"></td>
             <td id="53" onClick="fun(53)"></td>
             <td id="54" onClick="fun(54)"></td>
             <td id="55" onClick="fun(55)"></td>
             <td id="56" onClick="fun(56)"></td>
             <td id="57" onClick="fun(57)"></td>
            </tr>
            <tr>
               
                <td bgcolor="#FFFFFF">14:55-15:45</td>
                <td id="61" onClick="fun(61)"></td>
                <td id="62" onClick="fun(62)"></td>
                <td id="63" onClick="fun(63)"></td>
                <td id="64" onClick="fun(64)"></td>
                <td id="65" onClick="fun(65)"></td>
                <td id="66" onClick="fun(66)"></td>
                <td id="67" onClick="fun(67)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">16:05-16:55</td>
                <td id="71" onClick="fun(71)"></td>
                <td id="72" onClick="fun(72)"></td>
                <td id="73" onClick="fun(73)"></td>
                <td id="74" onClick="fun(74)"></td>
                <td id="75" onClick="fun(75)"></td>
                <td id="76" onClick="fun(76)"></td>
                <td id="77" onClick="fun(77)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">17:00-17:50</td>
                <td id="81" onClick="fun(81)"></td>
                <td id="82" onClick="fun(82)"></td>
                <td id="83" onClick="fun(83)"></td>
                <td id="84" onClick="fun(84)"></td>
                <td id="85" onClick="fun(85)"></td>
                <td id="86" onClick="fun(86)"></td>
                <td id="87" onClick="fun(87)"></td>
            </tr>
			 <tr>
			<td rowspan="2" bgcolor="#FFFFFF">晚上</td>
			 <td bgcolor="#FFFFFF">19:00-19:50</td>
                <td id="91" onClick="fun(91)"></td>
                <td id="92" onClick="fun(92)"></td>
                <td id="93" onClick="fun(93)"></td>
                <td id="94" onClick="fun(94)"></td>
                <td id="95" onClick="fun(95)"></td>
                <td id="96" onClick="fun(96)"></td>
                <td id="97" onClick="fun(97)"></td>
            </tr>
			 <tr>
			 <td bgcolor="#FFFFFF">20:00-20:50</td>
                <td id="101" onClick="fun(101)"></td>
                <td id="102" onClick="fun(102)"></td>
                <td id="103" onClick="fun(103)"></td>
                <td id="104" onClick="fun(104)"></td>
                <td id="105" onClick="fun(105)"></td>
                <td id="106" onClick="fun(106)"></td>
                <td id="107" onClick="fun(107)"></td>
            </tr>
            </tbody>
			<tr>
                <td colspan="2" bgcolor="#99CC66"></td>
                <td colspan="2" bgcolor="#FFFFFF">代表空闲</td>
                <td colspan="2" bgcolor="#FFFF66"></td>
                <td colspan="3" bgcolor="#FFFFFF">代表有预约</td>
			</tr>
    </table>

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
			/*
				var defaults = {
				containerID: 'toTop', // fading element id
				containerHoverID: 'toTopHover', // fading element hover id
				scrollSpeed: 1200,
				easingType: 'linear' 
				};
			*/

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