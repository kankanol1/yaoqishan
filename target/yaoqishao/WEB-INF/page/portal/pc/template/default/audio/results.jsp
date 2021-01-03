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
  <title>结果集</title>
  <c:import url="../common/common.jsp"></c:import>
  <style>
    .box-images {
      display: flex;
      text-align: center;
      justify-content: space-around;
      overflow: auto;
      height: calc(100% - 50px);
      border: 1px solid #eeeeee;
    }
    .box-title{
      display: flex;
      text-align: center;
      justify-content: space-around;
    }

    #images,
    #imagesc {
      margin: 0 5px;
      width: 50%;
    }

    #images .image-item,
    #imagesc .image-item {
      width: 100%;
      height: 100%;
      padding: 10px 0;
      display: inline-block;
    }

    #images .image-item img,
    #imagesc .image-item img {
      width: 100%;
      height: 100%;
    }

    #model {
      height: 80%;
      display: none;
      padding: 20px;
      box-shadow: 0 0 8px 1px #e4e5e6;
      z-index: 10000;
      position: fixed;
      top: 60px;
      background-color: #ffffff;
      margin: 0 20px;
    }
    #close-button{
      position: absolute;
      right: 20px;
      top: 20px;
    }
  </style>
</head>
<body>
<!--头部-->
<div class="header-wrap header-channel">
  <c:import url="../common/header.jsp"></c:import>
</div>

<!--图片处理-->
<div style="padding: 20px;background-color: #fff;">
  <!-- 面包屑导航和主体内容 -->
  <div class="content">
    <!--全部主体内容-->
    <div class="list-content">
      <!--块元素-->
      <div class="block">
        <!--页面有多个表格时，可以用于标识表格-->
        <h2>视频列表</h2>
        <!--正文内容-->
        <div class="main">
          <!--表格上方的操作元素，添加、删除-->
          <%-- <div class="operation-wrap">
             <div class="buttons-wrap">
               <a href="edit.action">
               <button class="button blue"><span class="icon-plus"></span> 添加</button>
               </a>
           </div>--%>
          <!--class加上color可以实现隔行变色-->
          <!--color1表示奇数行着色、color2表示偶数行着色-->
          <table id="table" class="table" style="text-align: center">
            <thead>
            <tr>
              <th style="width:10%;">编号</th>
              <th>名称</th>
              <th>视频查看</th>
              <th>图片对比</th>
              <th>结果集下载</th>
              <th style="width:20%;">操作</th>
            </tr>
            </thead>
            <tbody>
            <c:choose>
              <c:when test="${fn:length(list)==0}">
                <tr>
                  <td colspan="4" style="text-align:center;">暂无记录</td>
                </tr>
              </c:when>
              <c:otherwise>
                <c:forEach items="${list}" var="entity" varStatus="status">
                  <tr>
                    <td>${entity.id}</td>
                    <td>${entity.name}</td>
                    <td><a href="${entity.url}" target="_blank" style="color:blue">查看</a></td>
                    <td>
                      <button class="button blue" onclick="showImages('${entity.images}','${entity.imagesc}')">对比</button>
                    </td>
                    <td><a href="${entity.result}" download="result" target="_blank" style="color:blue">下载</a></td>
                    <td>
                      <a href="${pageContext.request.contextPath}/portal/edit.action?id=${entity.id}">
                        <button class="button wathet"><span class="icon-edit-2"></span> 编辑</button>
                      </a>
                      <button class="button wathet" onclick="deleteById(this, '${entity.id}')"><span
                              class="icon-trash-can2"></span> 删除
                      </button>
                    </td>
                  </tr>
                </c:forEach>
              </c:otherwise>
            </c:choose>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <div class="list-content" id="model">
      <div style="margin:0 20px 20px 20px;text-align: center">
        <div class="box-title">
            <h2>抽帧图片</h2>
            <h2>编译图片</h2>
        </div>
          <button class="button blue" onclick="closeModel('none')"
                  id="close-button">关闭
          </button>
      </div>
      <div class="box-images">
          <div id="images"></div>
          <div id="imagesc"></div>
      </div>
    </div>
  </div>
</div>

<!--底部-->
<%--<div class="footer-wrap js-use-footer">
  <c:import url="../common/footer.jsp"></c:import>
</div>--%>


<script>
  function closeModel(str) {
    var model = document.getElementById("model");
    model.style.display = str;
  }

  function showImages(params1,params2) {
    var imagesBox = document.getElementById("images");
    var imagescBox = document.getElementById("imagesc");
    var str1 = "";
    var str2 = "";
    var images = params1.split(',');
    var imagesc = params2.split(',');
    for (var i = 0; i < images.length; i++) {
      str1 += '<div class="image-item" style="display: inline-block"><img src="' + images[i] + '" alt=""></div>';
    }
    for (var j = 0; j < imagesc.length; j++) {
      str2 += '<div class="image-item" style="display: inline-block"><img src="' + imagesc[j] + '" alt=""></div>';
    }
    imagesBox.innerHTML = str1;
    imagescBox.innerHTML = str2;
    closeModel("block");
  }

  javaex.loading();

  function deleteById(obj, id) {
    javaex.deleteDialog(
      obj,	// obj是必须的
      {
        content: "确定要删除么",
        callback: "callback(" + id + ")"
      }
    );
  }

  function search() {
    console.log("自定义");
  }

  function callback(id) {
    javaex.optTip({
      content: "数据提交中，请稍候...",
      type: "submit"
    });

    $.ajax({
      url: "delete.json",
      type: "POST",
      dataType: "json",
      data: {
        "id": id
      },
      success: function (rtn) {
        if (rtn.code == "000000") {
          javaex.optTip({
            content: rtn.message,
            type: "success"
          });
          // 建议延迟加载
          setTimeout(function () {
            // 刷新页面
            window.location.reload();
          }, 2000);
        } else {
          javaex.optTip({
            content: rtn.message,
            type: "error"
          });
        }
      }
    });
  }
</script>
</body>

