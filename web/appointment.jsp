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
	var xmlHttp;
 	var ac=<%=request.getParameter("id")%>;
	var sno=<%=account%>;
	var position="<%=position%>";
	//这是一个js的不重复元素的set容器，主要作用就是防止一个表格别多次预约；
	var set = new Set();
	//个人信息显示的函数
	function fun1()
	{
		if(account==null||account==undefined||account=='')
		{
			alert("请先登陆");	
		}else{
//			var position=document.getElementById("position").innerText;
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
	
		var xmlHttp;
		addEventListener("load", function () {
			setTimeout(hideURLbar, 0);
		}, false);

		function hideURLbar() {
			window.scrollTo(0, 1);
		}
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
  		if(k=="appoint_get_time")
  		{//得到教师以前设置的空闲时间
  			url="teainfo";
  			request_parameters="k=appoint_get_time&t="+t+"&ac="+ac;
  		}/*
  		else if(k=="tea_get_rtime"){
  			//得到教师的被预约的信息
  			url="teainfo";
  			request_parameters="k=tea_get_rtime&t="+t+"&ac="+ac;
  		}*/
  		else{
  			//学生预约教师的空闲时间
  			url="teainfo";
  	  		request_parameters="k="+k+"&t="+t+"&ac="+ac+"&sno="+sno;	
  		}
  		xmlHttp.open("POST",url,false);
  		xmlHttp.setRequestHeader("Content-Type","application/x-www-form-urlencoded;charset=UTF-8");
  		//绑定一个回掉方法，回掉方法会在xmlhttp状态改变时调用，
  		//xmlHttp的状态0-4，我们只关心4（成功状态）
  		//4表示的完成，只有完成了调用才有意思
  		xmlHttp.onreadystatechange=function(){callback(k,t)};
  		xmlHttp.send(request_parameters);
  	}
  	//回掉函数
  	function callback(k,t)
  	{
  		if(xmlHttp.status==200)
  		{//表示服务器响应成功
  			//交互成功，获得相应的数据，是文本格式
  			var result=xmlHttp.responseText;
  			//解析响应的json数据，js和java中的json有一点区别，就是js中的外面的括号
  			
  			//这一部分就是得到个人信息和一切关于时间的信息
  			//这些信息由于数据了大，所以就使用了json格式
  			//用于显示信息,第一个参数是显示的内容，第二个参数是类别(1:显示个人信息，2:显示教师的空闲时间,3:显示预约的时间)
  				if(k=="appoint_get_time"){
 					var json=eval("("+result+")");
  					setContent(json,2);	
  				}/*
  				else if(k=="tea_get_rtime"){
//  					alert("callback-get_rtime");
					var json=eval("("+result+")");
  					setContent(json,3);	
  				}*/else{
					//首先查看这个上的可预约人数是不是为1，为1说明已经约满了，将其显示为黄色；否则减1显示为绿色
					var num=document.getElementById(t.toString()).innerHTML;
					if(num=="1")
					{
						document.getElementById(t.toString()).style.backgroundColor="#FFFF66";
						document.getElementById(t.toString()).innerHTML="";
					}else{
						document.getElementById(t.toString()).innerHTML=(parseInt(num)-1)+"";
					}
  	  				alert("预约成功！");
  				}
  		}
  	}
  	//显示信息
  	function setContent(json,kind)
  	{
  		if(kind==2){
  			//适用于JSON的情况
  			//显示教师空闲时间,将对应的表格设置为绿色,如果老师空闲表中的num为0说明已经预约满了，所以将这样的时间设置为黄色
  			for(var i=0;i<json.length;i=i+2)
  			{
  				var rl=json[i];
  				if(json[i+1].toString()=="0")
  				{
  					document.getElementById(rl.toString()).style.backgroundColor="#FFFF66";
  					document.getElementById(rl.toString()).innerHTML="";
  				}else{
  					document.getElementById(rl.toString()).style.backgroundColor="#99CC66";
  	  				document.getElementById(rl.toString()).innerHTML=json[i+1].toString();
  				}
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
    	 //得到预约人的职称，是教师就不能预约
    	 	if(sno==null||position=="教师")
    	 	{
    	 		alert("请先登陆或者教师不能预约!");
    	 	}else{
    	 		var t=row_column.toString();
        	 	var single_form=document.getElementById(t);
        		var k=single_form.style.backgroundColor;
        	//	alert(k);
        		if(k=="rgb(255, 102, 102)")
        		{
        			alert("这是教师忙碌时间，不能预约!");	
        		}else if(k=="rgb(255, 255, 102)")
        		{
        			alert("此时间已预约满，不能再预约!");	
        		}else{
        			//这个if只要是判断此时间是否已经被预约过了，如果是已经被预约了，则不能在预约
        			if(set.has(t))
        			{
        				alert("你已经预约了这个时间，不能重复预约!");
        			}else{
        				k="ap_time";//预约类型;
            			//t就是时间的横纵坐标
            			set.add(t);
            			getMoreContents(k,t);	
            			
        			}
        		}
    	 	}
    	}
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
    //	 getMoreContents("p_info","");
    	 //首先将所有的表格中的颜色设置为红色；
    	 setAllColor();
    	 //加载教师的空闲时间
 //   	 getMoreContents("get_ftime","");
    	 //加载教师的被预约的时间
  //  	 getMoreContents("get_rtime","");
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
    				form.style.backgroundColor="#FF6666";
    			}
    		}
    		getMoreContents("appoint_get_time","");
    	}
	</script>
		<style type="text/css">
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
					<span>	T</span>eacher's
					<span>T</span>imetable
				</h3>
				<div class="tittle-style">

				</div>
			</div>
			
			<h1>教师时间表</h1>
    <hr> 
    <center> 
    <div class="du">
    <table>
        	<tr>
                <th colspan="9" bgcolor="">预约时间表</th>
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
            <tbody id="t2" bgcolor="#FF6666">
            <tr >
                <td rowspan="4" bgcolor="#FFFFFF">上午</td>
                <td bgcolor="#FFFFFF">08:00-08:50</td>
                <td id="11" onclick="fun(11)"></td>
                <td id="12" onclick="fun(12)"></td>
                <td id="13" onclick="fun(13)"></td>
                <td id="14" onclick="fun(14)"></td>
                <td id="15" onclick="fun(15)"></td>
                <td id="16" onclick="fun(16)"></td>
                <td id="17" onclick="fun(17)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">8:55-09:45</td>
                <td id="21" onclick="fun(21)"></td>
                <td id="22" onclick="fun(22)"></td>
                <td id="23" onclick="fun(23)"></td>
                <td id="24" onclick="fun(24)"></td>
                <td id="25" onclick="fun(25)"></td>
                <td id="26" onclick="fun(26)"></td>
                <td id="27" onclick="fun(27)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">10:05-10:55</td>
                <td id="31" onclick="fun(31)"></td>
                <td id="32" onclick="fun(32)"></td>
                <td id="33" onclick="fun(33)"></td>
                <td id="34" onclick="fun(34)"></td>
                <td id="35" onclick="fun(35)"></td>
                <td id="36" onclick="fun(36)"></td>
                <td id="37" onclick="fun(37)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">11:00-11:50</td>
               <td id="41" onclick="fun(41)"></td>
                <td id="42" onclick="fun(42)"></td>
                <td id="43" onclick="fun(43)"></td>
                <td id="44" onclick="fun(44)"></td>
                <td id="45" onclick="fun(45)"></td>
                <td id="46" onclick="fun(46)"></td>
                <td id="47" onclick="fun(47)"></td>
            </tr>
            <tr>
             <td rowspan="4" bgcolor="#FFFFFF">下午</td>
            <td bgcolor="#FFFFFF">14:00-14:50</td>
             <td id="51" onclick="fun(51)"></td>
             <td id="52" onclick="fun(52)"></td>
             <td id="53" onclick="fun(53)"></td>
             <td id="54" onclick="fun(54)"></td>
             <td id="55" onclick="fun(55)"></td>
             <td id="56" onclick="fun(56)"></td>
             <td id="57" onclick="fun(57)"></td>
            </tr>
            <tr>
               
                <td bgcolor="#FFFFFF">14:55-15:45</td>
                <td id="61" onclick="fun(61)"></td>
                <td id="62" onclick="fun(62)"></td>
                <td id="63" onclick="fun(63)"></td>
                <td id="64" onclick="fun(64)"></td>
                <td id="65" onclick="fun(65)"></td>
                <td id="66" onclick="fun(66)"></td>
                <td id="67" onclick="fun(67)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">16:05-16:55</td>
                <td id="71" onclick="fun(71)"></td>
                <td id="72" onclick="fun(72)"></td>
                <td id="73" onclick="fun(73)"></td>
                <td id="74" onclick="fun(74)"></td>
                <td id="75" onclick="fun(75)"></td>
                <td id="76" onclick="fun(76)"></td>
                <td id="77" onclick="fun(77)"></td>
            </tr>
            <tr>
            <td bgcolor="#FFFFFF">17:00-17:50</td>
                <td id="81" onclick="fun(81)"></td>
                <td id="82" onclick="fun(82)"></td>
                <td id="83" onclick="fun(83)"></td>
                <td id="84" onclick="fun(84)"></td>
                <td id="85" onclick="fun(85)"></td>
                <td id="86" onclick="fun(86)"></td>
                <td id="87" onclick="fun(87)"></td>
            </tr>
			 <tr>
			<td rowspan="2" bgcolor="#FFFFFF">晚上</td>
			 <td bgcolor="#FFFFFF">19:00-19:50</td>
                <td id="91" onclick="fun(91)"></td>
                <td id="92" onclick="fun(92)"></td>
                <td id="93" onclick="fun(93)"></td>
                <td id="94" onclick="fun(94)"></td>
                <td id="95" onclick="fun(95)"></td>
                <td id="96" onclick="fun(96)"></td>
                <td id="97" onclick="fun(97)"></td>
            </tr>
			 <tr>
			 <td bgcolor="#FFFFFF">20:00-20:50</td>
                <td id="101" onclick="fun(101)"></td>
                <td id="102" onclick="fun(102)"></td>
                <td id="103" onclick="fun(103)"></td>
                <td id="104" onclick="fun(104)"></td>
                <td id="105" onclick="fun(105)"></td>
                <td id="106" onclick="fun(106)"></td>
                <td id="107" onclick="fun(107)"></td>
            </tr>
            </tbody>
			<tr>
			<td bgcolor="#FF6666"></td>
               <td bgcolor="#FFFFFF">代表忙碌</td>
                <td bgcolor="#99CC66"></td>
                <td colspan="2" bgcolor="#FFFFFF">代表空闲</td>
                <td bgcolor="#FFFF66"></td>
                <td colspan="3" bgcolor="#FFFFFF">代表有预约</td>
			</tr>
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