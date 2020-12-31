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
<div class="index-div">
  <!--从 uploader 开始，是上传相关代码-->
  <div id="uploader" class="wu-display">
    <!--用来存放文件信息-->
    <div id="thelist" class="uploader-list"></div>
    <div class="btns">
      <!--<input class="style_file_content" accept="video/mp4" type="file" id="upload_file_id"/>-->
      <div id="picker">选择文件</div>
      <button id="ctlBtn" class="btn btn-default" >开始上传</button>
      <button id="resetBtn" class="btn btn-default" >重试</button>
    </div>
  </div>
</div>
<!--底部-->
<div class="footer-wrap js-use-footer">
  <c:import url="../common/footer.jsp"></c:import>
</div>


<script>

  $(function () {
    alert("uploader");
    $list = $('#thelist'),
      $ctlBtn = $('#ctlBtn'),
      $resetBtn = $('#resetBtn'),
      state = 'pending',
      uploader;
    // 初始化WebUploader插件
    uploader = WebUploader.create({

      // swf文件路径， 需要修改为你自己存放的路径
      swf: '/resources/webuploader/Uploader.swf',
      // 文件接收服务端。  // 需要修改为你的后端地址
      server: 'http://self-pic.klagri.com.cn/api/file/video',
      // dnd 指定Drag And Drop拖拽的容器，如果不指定，则不启动
      // 禁用全局拖拽，否则在没有启动拖拽容器的情况下，视频拖进来后会直接在浏览器内播放。
      disableGlobalDnd: true,

      // 选择文件的按钮。可选。内部根据当前运行是创建，可能是input元素，也可能是flash.
      pick: {
        id: '#picker',                     // 对应 html 中的 picker
        innerHTML: '选择文件',   // 按钮上显示的文字
        multiple: true,                  // 多文件选择
      },

      // 允许视频和图片类型的文件上传。
      accept: {
        title: 'Video',
        extensions: 'mp4,gif,jpg,jpeg,bmp,png',      // 可以多个后缀，以逗号分隔， 不要有空格
        mimeTypes: 'video/*,image/*'
      },

      // 只允许选择图片文件。
      //accept: {
      // title: 'Images',
      //  extensions: '',
      //  mimeTypes: ''
      //}

      // thumb配置生成缩略图的选项， 此项交由后台完成， 所以前台未配置

      // 自动上传暂时关闭，使用多文件队列上传， 如果值为true，那么在选择完文件后，将直接开始上传文件，因为我还要做一些其他处理，故选择false。
      auto: false,

      //是否允许在文件传输时提前把下一个文件准备好。 对于一个文件的准备工作比较耗时，比如图片压缩，md5序列化。 如果能提前在当前文件传输期处理，可以节省总体耗时。
      prepareNextFile: true,

      // 可选，是否要分片处理大文件上传
      chunked: true,
      // 如果要分片，分多大一片？这里我设置为2M, 如需更大值，可能需要需修改php.ini等配置
      chunkSize:2*1024*1024,
      // 如果某个分片由于网络问题出错，允许自动重传多少次
      chunkRetry: 3,
      // 上传并发数，允许同时上传最大进程数，默认3
      threads:5,

      // formData {Object} [可选] [默认值：{}] 文件上传请求的参数表，每次发送都会发送此对象中的参数。 其实就是post中的表单数据，可自定义字段。
      formData: {
        context: 1,     // 这里是我的业务数据，你可以自定义或者去掉此项都可以
        from: "pan"    // 这里是我的业务数据，你可以自定义或者去掉此项都可以
      },
      //[可选] 验证文件总数量, 超出9个文件则不允许加入队列。
      fileNumLimit: 9,
      // 验证文件总大小是否超出限制（2G）, 超出则不允许加入队列。根据需要进行设置。除了前面几个，其它都是可选项
      fileSizeLimit: 1024*1024*1024*2,
      // 验证单个文件大小是否超出限制（2G）, 超出则不允许加入队列。
      fileSingleSizeLimit: 1024*1024*1024*2,
      // [可选] 去重， 根据文件名字、文件大小和最后修改时间来生成hash Key.
      duplicate: true,
      // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
      // resize: false,
      // 压缩选项
      compress: {
        // 如果压缩后比源文件大，则不压缩，图片有可能压缩后比原文件还大，需设置此项
        noCompressIfLarger: true,
      },
    });

    // 以下都是监听事件， 方法中的file 和 response 参数，需了解，并

    // 当有文件被添加进队列的时候触发，用于显示加载进度条
    uploader.on( 'fileQueued', function( file ) {
      $list.append( '<div style="position: relative" id="' + file.id + '" class="item">' +
        '<h4 class="info" style="width: 150px; text-overflow: ellipsis">' + file.name + '</h4>' +
        '<p class="state" style="position: absolute; top: 0px; left: 120px; width: 120px; border: #00a2d4 solid 1px">正在加载...</p>' +
        '</div>' );
      var $li = $( '#'+file.id );
      // 生成文件的MD5值， 可以用来实现秒传， 如不需要，可以忽略（数据库中保存md5值，如果存在相同md5，直接在文件服务器复制一份，不需再次分片上传以及合并，极快）
      uploader.md5File( file )
      // 及时显示进度
        .progress(function(percentage) {
          $percent = $li.find('.state');
          $li.find('p.state').text('加载中 '+  Math.round(percentage * 100)  + '%');
          console.log('Percentage:', percentage);
        })
        // 完成
        .then(function(md5) {
          // 将md5值加入到post的表单数据formData中， 与上文中的 context 和 from字段相同
          uploader.option("formData",{
            ...{"md5": md5}
          });
          console.log('md5:', md5);
          alert("fileQueued")

        });
    });

    // 文件上传过程中创建进度条实时显示。
    // 显示进度条
    uploader.on( 'uploadProgress', function( file, percentage ) {
      var $li = $( '#'+file.id ),
        $percent = $li.find('.progress .progress-bar');

      // 避免重复创建
      if ( !$percent.length ) {
        // $percent = $('<div class="progress progress-striped active">' +
        //     '<div class="progress-bar" role="progressbar" style="width: 0%">' +
        //     '</div>' +
        //     '</div>').appendTo( $li ).find('.progress-bar');
      }

      $li.find('p.state').text('上传中'+ Math.round(percentage * 100)  + '%' );
      if(Math.round(percentage * 100) == 100)
      {
        $li.find('p.state').text('即将完成');
      }

      // $percent.css( 'width', percentage * 100 + '%' );
    });

    // 监听上传成功
    uploader.on( 'uploadSuccess', function( file ) {

      $( '#'+file.id ).find('p.state').text('已上传');
    });
    // 监听上传失败
    uploader.on( 'uploadError', function( file ) {
      alert("上传出错")
      $( '#'+file.id ).find('p.state').text('上传出错');
    });
    // 监听上传完成，不论失败还是成功
    uploader.on( 'uploadComplete', function( file ) {
      $( '#'+file.id ).find('.progress').fadeOut();
      console.log(uploader.getStats());
    });
    $('#ctlBtn').click(function(){
      uploader.upload(); // 手动上传
    })
    $('#resetBtn').click(function(){
      alert(666)
      uploader.retry(); // 重新上传
    })

  })

</script>
</body>
