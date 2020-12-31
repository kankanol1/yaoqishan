<%--
  Created by IntelliJ IDEA.
  User: kankan
  Date: 2020-12-30
  Time: 15:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<head>
  <meta charset="utf-8">
  <title>视频编译</title>
  <c:import url="../common/common.jsp"></c:import>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/default/webupload/webuploader.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/default/bootstrap-3.3.7-dist/css/bootstrap-theme.css">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/static/default/bootstrap-3.3.7-dist/css/bootstrap.css">
</head>
<body>


<!--头部-->
<div class="header-wrap header-channel">
  <c:import url="../common/header.jsp"></c:import>
</div>
<!--
https://www.jb51.net/article/142736.htm
-->
<!--视频处理-->
<div style="margin-top: 30px;padding: 40px">
  <div>
    <h4>测试编译</h4>
    <p>编译过程会耗时3-5分钟，视频上传成功后，请前往结果集查看（滞后查看）</p>
  </div>
  <div id="uploader" class="wu-example">
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
      <div id="picker" style="display: inline-block;margin-right: 10px">选择文件</div>
      <button id="ctlBtn" class="btn btn-default" style="vertical-align: top;height: 40px">开始上传</button>
    </div>
  </div>
</div>

<!--底部-->
<div class="footer-wrap js-use-footer">
  <c:import url="../common/footer.jsp"></c:import>
</div>


<script>
  $(function() {
    var $list = $("#thelist");
    var $btn = $("#ctlBtn");
    var state = 'pending'; // 上传文件lBt
    var uploader = WebUploader.create({
      swf : '${pageContext.request.contextPath}/static/default/webupload/Uploader.swf',
      server : "${pageContext.request.contextPath}/portal/audio/audio.json",
      pick : '#picker',
      resize : false,
      accept:{

      }
    });
    uploader.on('fileQueued', function(file) {
      $list.append('<div id="' + file.id + '" class="item">'
        + '<h4 class="info">' + file.name + '</h4>'
        + '<p class="state">等待上传...</p>' + '</div>');
    });

    uploader.on('uploadProgress',
      function(file, percentage) {
        var $li = $('#' + file.id), $percent = $li
          .find('.progress .progress-bar');

        // 避免重复创建
        if (!$percent.length) {
          $percent = $(
            '<div class="progress progress-striped active">'
            + '<div class="progress-bar" role="progressbar" style="width: 0%">'
            + '</div>' + '</div>')
            .appendTo($li).find('.progress-bar');
        }

        $li.find('p.state').text('上传中');

        $percent.css('width', percentage * 100 + '%');
      });


    uploader.on('uploadSuccess', function(file) {
      $('#' + file.id).find('p.state').text('已上传');
    });

    uploader.on('uploadError', function(file) {
      $('#' + file.id).find('p.state').text('上传出错');
    });

    uploader.on('uploadComplete', function(file) {
      $('#' + file.id).find('.progress').fadeOut();
    });
    $btn.on('click', function() {
      if (state === 'uploading') {
        uploader.stop();
      } else {
        uploader.upload();
      }
    });

  });
</script>
</body>
