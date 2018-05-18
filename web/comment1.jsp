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
 //	alert(ac);
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
  		if(k=="stu_p_info"){
  			//得到个人信息
  			url="teainfo";
  			request_parameters="k=stu_p_info&t="+t+"&ac="+ac;	
  		}else if(k=="stu_get_rtime"){
  			//得到学生自己的预约信息
  			url="teainfo";
  			request_parameters="k=stu_get_rtime&t="+t+"&ac="+ac;
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
  	//这个是根据k的值将数字转化成对应的实际意义的词语
  	function numSwitch(c,k)
  	{
  		var re;//返回值
  		
  		if(k==0)
  		{
  			//k==0;星期数
  			switch(c)
  			{
  				case "1":
  					re="星期一";
  	 			break;
  				case "2":
  					re="星期二";
  	 			break;
  				case "3":
  					re="星期三";
  	 			break;
  				case "4":
  					re="星期四";
  	 			break;
  				case "5":
  					re="星期五";
  	 			break;
  				case "6":
  					re="星期六";
  	 			break;
  				case "7":
  					re="星期日";
  	 			break;
  			}
  		}else{
  			//节数
  			switch(c)
  			{
  				case "1":
  					re="08:00-08:50";
  	 			break;
  				case "2":
  					re="8:55-09:45";
  	 			break;
  				case "3":
  					re="10:05-10:55";
  	 			break;
  				case "4":
  					re="11:00-11:50";
  	 			break;
  				case "5":
  					re="14:00-14:50";
  	 			break;
  				case "6":
  					re="14:55-15:45";
  	 			break;
  				case "7":
  					re="16:05-16:55";
  	 			break;
  				case "8":
  					re="17:00-17:50";
  	 			break;
  				case "9":
  					re="19:00-19:50";
  	 			break;
  				case "10":
  					re="20:00-20:50";
  	 			break;
  				case "10":
  					re="20:00-20:50";
  	 			break;
  			}
  		}
  		return re;
  	}
  //这个函数是将23这样的数字转化成”星期二第三小节“这样的词语
  	function numToC(t)
  	{
  		return numSwitch(t.substr(t.length-1,1),0)+numSwitch(t.substring(0,t.length-1),1);
  	}
  	//显示信息
  	function setContent(json,kind)
  	{
  		if(kind==1)
  		{
  			document.getElementById("account").innerHTML=ac;
  			document.getElementById("name").innerHTML=json[0].toString();
  			document.getElementById("dept").innerHTML=json[2].toString();
 		   	getMoreContents("stu_get_rtime","");
  			
  		}else if(kind==3){
  			//显示学生的预约时间，将对应的表格设置为黄色
  			for(var i=0;i<json.length;i=i+2)
  			{
  				var tr = document.createElement("tr");
  		  	    var td = document.createElement("td");
  		  		var td1= document.createElement("td");
  		  		var td2= document.createElement("td");
  				var td3= document.createElement("td");
  				var a=document.createElement("a");
  				a.href="comment.jsp?id="+json[i+1].toString()+"&time="+json[i].toString();//教师的工号,预约的时间 
  				a.innerText="评价";
  		  		td.innerHTML = ac;
  		  		td1.innerHTML = json[i+1].toString();//显示教师工号
  		  		td2.innerHTML =numToC(json[i].toString());
  		  		td3.appendChild(a);
  		  	 	var table=document.getElementById("table");
  		 		tr.appendChild(td);
  		  		tr.appendChild(td1);
  		  		tr.appendChild(td2);
  		  		tr.appendChild(td3);
  		  		table.appendChild(tr);
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
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}	
	</script>
	<!-- //meta-tags -->
	<link href="css/bootstrap.css" rel="stylesheet" type="text/css" media="all" />
	<link href="css/style2.css" rel="stylesheet" type="text/css" media="all" />
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
         width:600px;
       
      
    }
 .dudu{
        border: 0px solid #3bafda;
        margin: 100px auto;
        text-align: center;
        border-collapse: collapse;
         
       float:center;
    }
    table th {
         border: 1px solid #48cfad;
      
       float:center;
        text-align: center;
          width:600px;
        vertical-align:top;
     
    }
      table tr {
      
      width:600px;
       float:center;
        text-align: center;
          vertical-align:top;
       
    }

    table td {
        border: 1px solid #48cfad;
       margin: auto;
        width:20%;
          vertical-align:top;
    }
    </style>
    <!-- E  CSS -->
</head>

<body onLoad="load_completion();goPage(1,6);">
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
			<li class="d2"><A href="stuinfo.jsp?id=<%=ac%>">预约时间</A></li>
			<li class="d2"><A class="hover" href="comment1.jsp?id=<%=ac%>">评价教师</A></li>
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
				<table width="300" border="1" id="table" >
				<tr>
					<th >学号</th>
					<th >工号</th>
					<th >时间</th>
					<th >评价</th>
				</tr>
				</table>
				<table width="60%" align="right" class="dudu">
        <tr><td><div id="barcon" name="barcon"></div></td></tr>
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