<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>
<html>
<head>
    <meta charset="UTF-8">
     <script language=javascript>
    	function fun(row_column)
    	{
    		//alert(row_column.toString()+2);
    		var form=document.getElementById(row_column.toString());
			alert(form.style.backgroundColor);
			if(form.style.backgroundColor=="red")
			{
				form.style.backgroundColor="green";
			}else{
				form.style.backgroundColor="red";
			}
    	}
    	function setColor(){
    		for(var i=1;i<11;i++)
    		{
    			for(var j=1;j<8;j++)
    			{
    				var t=i.toString()+j.toString();
    				//alert(t);
    				var form=document.getElementById(t.toString());
    				form.style.backgroundColor="red"
    			}
    		}
    	}
    </script>
    <title>课程表</title>
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

<body>
    <!-- S   课程表 -->
    <table onMouseOver="setColor()">
        <caption>空闲时间设置表</caption>
        <thead >
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
        </thead>
        <tbody bgcolor="#FF0000">
            <tr>
                <td rowspan="4" bgcolor="#33FF00">上午</td>
                <td bgcolor="#33FFCC">08:00-08:50</td>
                <td id="11" onclick="fun(11)"></td>
                <td id="12" onclick="fun(12)"></td>
                <td id="13" onclick="fun(13)"></td>
                <td id="14" onclick="fun(14)"></td>
                <td id="15" onclick="fun(15)"></td>
                <td id="16" onclick="fun(16)"></td>
                <td id="17" onclick="fun(17)"></td>
            </tr>
            <tr>
            <td bgcolor="#33FFCC">8:55-09:45</td>
                <td id="21" onclick="fun(21)"></td>
                <td id="22" onclick="fun(22)"></td>
                <td id="23" onclick="fun(23)"></td>
                <td id="24" onclick="fun(24)"></td>
                <td id="25" onclick="fun(25)"></td>
                <td id="26" onclick="fun(26)"></td>
                <td id="27" onclick="fun(27)"></td>
            </tr>
            <tr>
            <td bgcolor="#33FFCC">10:05-10:55</td>
                <td id="31" onclick="fun(31)"></td>
                <td id="32" onclick="fun(32)"></td>
                <td id="33" onclick="fun(33)"></td>
                <td id="34" onclick="fun(34)"></td>
                <td id="35" onclick="fun(35)"></td>
                <td id="36" onclick="fun(36)"></td>
                <td id="37" onclick="fun(37)"></td>
            </tr>
            <tr>
            <td bgcolor="#33FFCC">11:00-11:50</td>
               <td id="41" onclick="fun(41)"></td>
                <td id="42" onclick="fun(42)"></td>
                <td id="43" onclick="fun(43)"></td>
                <td id="44" onclick="fun(44)"></td>
                <td id="45" onclick="fun(45)"></td>
                <td id="46" onclick="fun(46)"></td>
                <td id="47" onclick="fun(47)"></td>
            </tr>
            <tr>
             <td rowspan="4" bgcolor="#33FF00">下午</td>
            <td bgcolor="#33FFCC">14:00-14:50</td>
             <td id="51" onclick="fun(51)"></td>
             <td id="52" onclick="fun(52)"></td>
             <td id="53" onclick="fun(53)"></td>
             <td id="54" onclick="fun(54)"></td>
             <td id="55" onclick="fun(55)"></td>
             <td id="56" onclick="fun(56)"></td>
             <td id="57" onclick="fun(57)"></td>
            </tr>
            <tr>
               
                <td bgcolor="#33FFCC">14:55-15:45</td>
                <td id="61" onclick="fun(61)"></td>
                <td id="62" onclick="fun(62)"></td>
                <td id="63" onclick="fun(63)"></td>
                <td id="64" onclick="fun(64)"></td>
                <td id="65" onclick="fun(65)"></td>
                <td id="66" onclick="fun(66)"></td>
                <td id="67" onclick="fun(67)"></td>
            </tr>
            <tr>
            <td bgcolor="#33FFCC">16:05-16:55</td>
                <td id="71" onclick="fun(71)"></td>
                <td id="72" onclick="fun(72)"></td>
                <td id="73" onclick="fun(73)"></td>
                <td id="74" onclick="fun(74)"></td>
                <td id="75" onclick="fun(75)"></td>
                <td id="76" onclick="fun(76)"></td>
                <td id="77" onclick="fun(77)"></td>
            </tr>
            <tr>
            <td bgcolor="#33FFCC">17:00-17:50</td>
                <td id="81" onclick="fun(81)"></td>
                <td id="82" onclick="fun(82)"></td>
                <td id="83" onclick="fun(83)"></td>
                <td id="84" onclick="fun(84)"></td>
                <td id="85" onclick="fun(85)"></td>
                <td id="86" onclick="fun(86)"></td>
                <td id="87" onclick="fun(87)"></td>
            </tr>
			 <tr>
			<td rowspan="2" bgcolor="#33FF00">晚上</td>
			 <td bgcolor="#33FFCC">19:00-19:50</td>
                <td id="91" onclick="fun(91)"></td>
                <td id="92" onclick="fun(92)"></td>
                <td id="93" onclick="fun(93)"></td>
                <td id="94" onclick="fun(94)"></td>
                <td id="95" onclick="fun(95)"></td>
                <td id="96" onclick="fun(96)"></td>
                <td id="97" onclick="fun(97)"></td>
            </tr>
			 <tr>
			 <td bgcolor="#33FFCC">20:00-20:50</td>
                <td id="101" onclick="fun(101)"></td>
                <td id="102" onclick="fun(102)"></td>
                <td id="103" onclick="fun(103)"></td>
                <td id="104" onclick="fun(104)"></td>
                <td id="105" onclick="fun(105)"></td>
                <td id="106" onclick="fun(106)"></td>
                <td id="107" onclick="fun(107)"></td>
            </tr>
			<tr>
			<td bgcolor="#FF0000"></td>
               <td bgcolor="#FFFFFF">代表忙碌</td>
                <td bgcolor="green"></td>
                <td colspan="2" bgcolor="#FFFFFF">代表空闲</td>
                <td bgcolor="yellow"></td>
                <td colspan="3" bgcolor="#FFFFFF">代表有预约</td>
			</tr>
        </tbody>
    </table>
    <!-- S   课程表 -->
</body>

</html>	