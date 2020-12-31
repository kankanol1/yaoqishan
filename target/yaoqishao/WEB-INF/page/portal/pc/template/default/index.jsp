<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>${seoInfo.title}</title>
<meta name="keywords" content="${seoInfo.keywords}" />
<meta name="description" content="${seoInfo.description}" />
<c:import url="common/common.jsp"></c:import>
	<style>
		.header-wrap{
			width: 100%;
			position: fixed;
			top: 0;
			background-color: #eeeeee;
			padding-right: 100px;
		}
	</style>
</head>
<body style="background-color: #ffffff">
	<!--头部-->
	<div class="header-wrap header-channel">
		<c:import url="common/header.jsp"></c:import>
	</div>

	<!--图片处理-->
	<div style="margin-top: 87px;padding: 40px">
		<h1 style="padding: 20px 0">安全帽预警系统</h1>
		<p>根据视频抽帧分析工作人员是否佩戴安全帽。</p>


    </div>




	<!--底部-->
	<div class="footer-wrap js-use-footer" >
		<c:import url="common/footer.jsp"></c:import>
	</div>
</body>
<script>

	javaex.tab({
		id : "tab1",
		mode : "click"
	});
	
	javaex.tab({
		id : "tab2",
		display : "flex",
		mode : "click"
	});
	
	javaex.tab({
		id : "tab3",
		display : "flex",
		mode : "click"
	});
	
	javaex.tab({
		id : "tab4",
		mode : "click"
	});
</script>
</html>
