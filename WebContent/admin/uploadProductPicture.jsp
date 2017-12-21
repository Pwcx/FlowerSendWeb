<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page language="java" import="java.util.*,config.*"%>

<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<%
	String picUrl = request.getParameter("Picurl");
	String step = request.getParameter("step");
	String defaultPic = basePath + "image/man.GIF";
	Integer pid=Integer.valueOf((String)request.getAttribute("pid"));
	if(pid==null){
		System.out.println("我不知道为什么这里会没有的我也很懵逼");
	}
	if ("3".equals(step))
		defaultPic = basePath + "Product/ProductPicture/" + picUrl;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>上传商品图片</title>

<jsp:include page="../static/must.jsp"></jsp:include>
<link href="<%=basePath%>css/main.css" type="text/css" rel="Stylesheet" />
<script type="text/javascript"
	src="<%=basePath%>js/jquery1.2.6.pack.js"></script>
<script type="text/javascript" src="<%=basePath%>js/ui.core.packed.js"></script>
<script type="text/javascript"
	src="<%=basePath%>js/ui.draggable.packed.js"></script>
<script type="text/javascript" src="<%=basePath%>js/CutPic.js"></script>
<script type="text/javascript">
	function Step1() {
		$("#Step2Container").hide();
	}

	function Step2() {
		$("#CurruntPicContainer").hide();
	}
	function Step3() {
		$("#Step2Container").hide();
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
  	<jsp:include page="left.jsp"/>
  	
	<%
		String info = (String) request.getAttribute("info");
		if (info != null && !info.equals("")) {
			out.print("<script type=\"text/javascript\">alert(\"" + info + "\");</script>");
		}
	%>
	<div class="content">
		<div class="left">
			<!--当前照片-->
			<div id="CurruntPicContainer">
				<div class="title">
					<h4>商品<%=pid %>的当前图片</h4>
				</div>
				<div class="photocontainer">
					<img id="imgphoto" src="<%=defaultPic%>" style="border-width: 0px;" />
				</div>
			</div>
			<!--Step 2-->
			<div id="Step2Container">
				<div class="title">
					<b>为商品<%=pid %>裁切图片</b>
				</div>
				<div class="uploadtooltip">您可以拖动照片以裁剪满意的图片</div>
				<div id="Canvas" class="uploaddiv">

					<div id="ImageDragContainer">
						<img id="ImageDrag" class="imagePhoto"
							src="<%=basePath%>UploadPhoto/<%=picUrl%>"
							style="border-width: 0px;" />
					</div>
					<div id="IconContainer">
						<img id="ImageIcon" class="imagePhoto"
							src="<%=basePath%>UploadPhoto/<%=picUrl%>"
							style="border-width: 0px;" />
					</div>
				</div>
				<div class="uploaddiv">
					<table>
						<tr>
							<td id="Min"><img alt="缩小" src="<%=basePath%>image/_c.gif"
								onmouseover="this.src='<%=basePath%>image/_c.gif';"
								onmouseout="this.src='image/_h.gif';" id="moresmall"
								class="smallbig" /></td>
							<td>
								<div id="bar">
									<div class="child"></div>
								</div>
							</td>
							<td id="Max"><img alt="放大" src="<%=basePath%>image/c.gif"
								onmouseover="this.src='<%=basePath%>image/c.gif';"
								onmouseout="this.src='image/h.gif';" id="morebig"
								class="smallbig" /></td>
						</tr>
					</table>
				</div>
				<form action="<%=basePath%>admin/ZoomProductImage" method="post">
					<input type="hidden" name="pid" value="<%=pid%>"/>
					<input type="hidden" name="picture" value="<%=picUrl%>" />
					<div class="uploaddiv">
						<input type="submit" name="btn_Image" value="保存图片" id="btn_Image" />
					</div>
					<div>
						图片实际宽度： <input name="txt_width" type="text" value="1"
							id="txt_width" /><br /> 图片实际高度： <input name="txt_height"
							type="text" value="1" id="txt_height" /><br /> 距离顶部： <input
							name="txt_top" type="text" value="82" id="txt_top" /><br />
						距离左边： <input name="txt_left" type="text" value="73" id="txt_left" /><br />
						截取框的宽： <input name="txt_DropWidth" type="text" value="120"
							id="txt_DropWidth" /><br /> 截取框的高： <input name="txt_DropHeight"
							type="text" value="120" id="txt_DropHeight" /><br /> 放大倍数： <input
							name="txt_Zoom" type="text" id="txt_Zoom" />
					</div>
					
				</form>
			</div>

		</div>
		<form name="form1" method="post"
			action="<%=basePath%>admin/UpLoadProductPicture" id="form1" enctype="multipart/form-data">
			<input type="hidden" name="pid" id="pid" value="<%=pid%>"/>
			<div class="right">
				<!--Step 1-->
				<div id="Step1Container">
					<div class="title">
						<b>更换照片</b>
					</div>
					<div id="uploadcontainer">
						<div class="uploadtooltip">请选择新的照片文件，文件需小于2.5MB</div>
						<div class="uploaddiv">
							<input type="file" name="fuPhoto" id="fuPhoto" title="选择照片" />
						</div>
						<div class="uploaddiv">
							<input type="submit" name="btnUpload" value="上 传" id="btnUpload" />
						</div>
					</div>

				</div>
			</div>
		</form>
	</div>
	<%
		if (null == picUrl || "".equals(picUrl)) {
	%>
	<script type='text/javascript'>
		Step1();
	</script>
	<%
		} else if (!"".equals(picUrl) && "2".equals(step)) {
	%>
	<script type='text/javascript'>
		Step2();
	</script>
	<%
		} else if (!"".equals(picUrl) && "3".equals(step)) {
	%>
	<script type='text/javascript'>
		Step3();
	</script>
	<%
		}
	%>

</body>


</html>