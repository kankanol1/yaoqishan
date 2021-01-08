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
<%--  <script src="${pageContext.request.contextPath}/static/default/javaex/pc/lib/jquery-1.7.2.min.js"></script>--%>
<%--  <script src="/static/default/js/javaex/pc/js/javaex.min.js"></script>--%>

  <link rel="stylesheet" href="/static/default/css/common.css">
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

    .box-title {
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
      display: inline-block;
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
      width: calc(100% - 120px);
      display: none;
      padding: 20px;
      box-shadow: 0 0 8px 1px #e4e5e6;
      z-index: 10000;
      position: fixed;
      top: 60px;
      background-color: #ffffff;
    }

    #close-button {
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
          <div class="operation-wrap">
            <div class="buttons-wrap" style="margin-bottom: 10px">
              <%--<a href="edit.action">
              <button class="button blue"><span class="icon-plus"></span> 添加</button>
              </a>--%>
              <a href="${pageContext.request.contextPath}/portal/results.action?status=1">
                <button class="button blue">未编译</button>
              </a>
              <a href="${pageContext.request.contextPath}/portal/results.action?status=2">
                <button class="button yellow">编译中</button>
              </a>
              <a href="${pageContext.request.contextPath}/portal/results.action?status=3">
                <button class="button green">编译成功</button>
              </a>
              <a href="${pageContext.request.contextPath}/portal/results.action?status=4">
                <button class="button red">编译失败</button>
              </a>
              <a href="${pageContext.request.contextPath}/portal/results.action">
                <button class="button navy">全部</button>
              </a>
            </div>
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
                <th>编译状态</th>
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

                        <c:if test="${entity.status=='3'}" var="rtn" scope="page">
                          <button class="button blue"
                                  onclick="showImages('${entity.name}','${entity.images}','${entity.imagesc}')">对比
                          </button>
                        </c:if>
                        <c:if test="${entity.status!='3'}" var="rtn" scope="page">
                          待编译
                        </c:if>
                      </td>
                      <td>
                        <c:if test="${entity.status=='3'}" var="rtn" scope="page">
                          <a href="${entity.result}" download="result" target="_blank" style="color:blue">下载</a>
                        </c:if>
                        <c:if test="${entity.status!='3'}" var="rtn" scope="page">
                          待编译
                        </c:if>
                      </td>

                      <td>
                        <c:if test="${entity.status=='1'}" var="rtn" scope="page">
                          <button onclick="computerById('${entity.id}')"
                                  class="button blue">${obj[entity.status]}</button>
                        </c:if>
                        <c:if test="${entity.status==2}" var="rtn" scope="page">
                          <button onclick="toast1(this)" class="button yellow">${obj[entity.status]}</button>
                        </c:if>
                        <c:if test="${entity.status==3}" var="rtn" scope="page">
                          <button onclick="computer('${entity.id}')"
                                  class="button green">${obj[entity.status]}</button>
                        </c:if>
                        <c:if test="${entity.status==4}" var="rtn" scope="page">
                          <button onclick="computer('${entity.id}')"
                                  class="button red">${obj[entity.status]}</button>
                        </c:if>
                      </td>
                      <td>
                          <%--<a href="${pageContext.request.contextPath}/portal/edit.action?id=${entity.id}">
                            <button class="button wathet"><span class="icon-edit-2"></span>编辑</button>
                          </a>--%>
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
<%--            <button class="button pink" onclick="goPython(12)">测试</button>--%>
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
        <div class="box-images" id="loadingImage">
          <div id="images">
            <%-- <div class="image-item" style="display: inline-block">
               <img src="http://eways.gl-data.com:10009/test/1.jpg" alt="">
             </div>
             <div class="image-item" style="display: inline-block">
               <img src="http://eways.gl-data.com:10009/test/2.jpg" alt="">
             </div>
             <div class="image-item" style="display: inline-block">
               <img src="http://eways.gl-data.com:10009/test/3.jpg" alt="">
             </div>
             <div class="image-item" style="display: inline-block">
               <img src="http://eways.gl-data.com:10009/test/4.jpg" alt="">
             </div>--%>
          </div>
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
    var baseurl = "http://eways.gl-data.com:10009/";
    var imagesBox = document.getElementById("images");
    var imagescBox = document.getElementById("imagesc");
    var model = document.getElementById("model");
    var loadingImage = document.getElementById("loadingImage");

    var images = [];
    var imagesc = [];
    var flag = 0;
    var str1 = "";
    var str2 = "";
    var name = "";

    function showImages(names, params1, params2) {
      name = names;
      if (params1.length > 0 && params2.length > 0) {
        images = params1.split(',');
        imagesc = params2.split(',');
        showImage(flag);
        closeModel("block");
      } else {
        alert("编译中，请稍候...")
      }
    }

    function toast1(obj) {
      javaex.optTip({
        content: "视频编译中,请勿重新操作",
        type: "info"
      });
    }

    loadingImageFun();

    /*图片加载*/
    function loadingImageFun() {
      loadingImage.addEventListener('scroll', function (e) {
        console.log(e);
        if ((flag >= images.length || flag >= imagesc.length) && (e.target.scrollTop + e.target.offsetHeight > e.target.scrollHeight - 50)) {
          javaex.optTip({
            content: "加载完毕",
            type: "success"
          });
        } else {
          //滚动懒加载
          if (e.target.scrollTop + e.target.offsetHeight > e.target.scrollHeight - 50) {
            showImage(flag);
          }
        }
      })
    }

    /*图片懒加载*/
    function showImage(num) {
      var baseurl1 = baseurl + name + "/input/";
      var baseurl2 = baseurl + name + "/predict/";
      for (var i = num; i < num + 1; i++) {
        var oDiv1 = createDiv();
        var oDiv2 = createDiv();
        oDiv1.innerHTML = '<img src="' + baseurl1 + images[i] + '" alt=""><p style=text-align: center>' + images[i] + '</p>';
        oDiv2.innerHTML = '<img src="' + baseurl2 + imagesc[i] + '" alt=""><p style=text-align: center>' + images[i] + '</p>';
      }
      flag = flag + 1;
      imagesBox.appendChild(oDiv1);
      imagescBox.appendChild(oDiv2);
    }

    /*创建元素*/
    function createDiv() {
      var oDiv1 = document.createElement('div');
      oDiv1.classList.add("image-item");
      return oDiv1;
    }


    /*关闭弹窗*/
    function closeModel(str) {
      model.style.display = str;
    }

    javaex.loading();

    /*删除*/
    function deleteById(obj, id) {
      javaex.deleteDialog(
        obj,	// obj是必须的
        {
          content: "确定要删除么",
          callback: 'callback(' + id + ')'
        }
      );
    }

    /*编译*/
    function computer(id) {
      javaex.confirm({
        content: "确定要重新编译么?",
        callback: 'resetCom(' + id + ')'
      })
    }

    function computerById(id) {
      javaex.confirm({
        content: "确定要编译该视频吗?",
        callback: 'resetCom(' + id + ')'
      })
    }


    function search() {
      console.log("自定义");
    }

    function resetCom(id) {
      javaex.optTip({
        content: "数据提交中，请稍候...",
        type: "submit"
      });
      $.ajax({
        url: "${pageContext.request.contextPath}/portal/audio/status.json",
        type: "POST",
        dataType: "json",
        data: {
          "id": id
        },
        success: function (rtn) {
          if (rtn.code == "000000") {
            javaex.optTip({
              content: rtn.msg,
              type: "success"
            });
           /* // 建议延迟加载
            setTimeout(function () {
              // 刷新页面
              window.location.reload();
            }, 2000);*/
          }else if(rtn.code=="000001"){
            javaex.optTip({
              content: rtn.msg,
              type: "success"
            });
            goPython(id);

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
      })
    }

    function goPython(id){
      var data ={
        "id": id,
        "params1":1,
        "params2":1.2323,
      }
      $.ajax({
        url: "http://106.52.105.214:5001/api",
        // url: "http://localhost:5000/api",
        type: "POST",
        contentType: "application/json;charset=utf-8",
        data : JSON.stringify(data),
        success: function (rtn) {
          if (rtn.code == "000000") {
            javaex.optTip({
              content: rtn.msg,
              type: "error"
            });
          }else if (rtn.code == "000001") {
            javaex.optTip({
              content: rtn.msg,
              type: "success"
            });
          }else  {
            javaex.optTip({
              content: rtn.msg,
              type: "error"
            });
          }
        }
      })
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

