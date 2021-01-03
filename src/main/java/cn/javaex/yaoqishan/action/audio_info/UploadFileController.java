package cn.javaex.yaoqishan.action.audio_info;

/**
 * @author kankan
 * @version 1.0
 * @created 2020-12-30 19:41 by kankan
 * @updated 2020-12-30 19:41 by kankan
 */

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cn.javaex.yaoqishan.service.audio_info.AudioInfoService;
import cn.javaex.yaoqishan.view.AudioInfo;
import org.apache.log4j.Logger;
import org.python.core.PyFunction;
import org.python.core.PyInteger;
import org.python.core.PyObject;
import org.python.util.PythonInterpreter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.alibaba.fastjson.JSONObject;
//import com.wdg.util.BuildJsonOfObject;
/*
* https://blog.csdn.net/hanjun0612/article/details/78553086?utm_medium=distribute.pc_relevant.none-task-blog-searchFromBaidu-3.control&depth_1-utm_source=distribute.pc_relevant.none-task-blog-searchFromBaidu-3.control
* https://blog.csdn.net/datouniao1/article/details/79716268/
* */
@RestController
@RequestMapping("portal/audio")
public class UploadFileController {
    @Autowired
    private AudioInfoService audioInfoService;
    private Logger log;

    public UploadFileController() {
        this.log = Logger.getLogger(this.getClass());
    }



    @RequestMapping(value = "audio.json", method = RequestMethod.POST)
    public String upload(@RequestParam("file") MultipartFile files, HttpServletRequest request, HttpServletResponse response) throws IOException {
        JSONObject json = new JSONObject();
        response.setCharacterEncoding("utf-8");

        String msg = "success";
        log.info("-------------------start upload-------------------");
        try {
            String name = files.getOriginalFilename();
            String path = this.getClass().getClassLoader().getResource("/").getPath();

            if(audioInfoService.selectByName("name")!=null){
                json.put("msg","视频已经存在");
                return JSONObject.toJSON(json).toString();
            }


                int index = path.indexOf("yaoqishan");

            path = path.substring(1, index + "yaoqishan".length()) + "/upload/";
            String python =path.substring(1, index + "yaoqishan".length()) + "/python/";
            path = path + name;
            System.out.println(path);
            File uploadFile = new File(path);
            files.transferTo(uploadFile);
            AudioInfo audioInfo =new AudioInfo();
            audioInfo.setName(name);
            audioInfo.setTemplate("edit");
            audioInfo.setTitle(name);
            audioInfo.setSort("1");
            audioInfo.setUrl(path);
            audioInfo.setResult(path);
            audioInfo.setKeywords(name);
            audioInfo.setDescription(name+"视频描述");

            /*
            *https://www.cnblogs.com/wuwuyong/p/10600749.html
            *
            * */
            PythonInterpreter interpreter = new PythonInterpreter();
            interpreter.execfile("F:\\java\\yaoqishan\\python\\test.py");
            PyFunction pyFunction = interpreter.get("add", PyFunction.class);
            int a = 5, b = 10;
            //调用函数，如果函数需要参数，在Java中必须先将参数转化为对应的“Python类型”
            PyObject pyobj = pyFunction.__call__(new PyInteger(a), new PyInteger(b));
            System.out.println("the anwser is: " + pyobj);

            audioInfoService.save(audioInfo);
            json.put("url", path);
        } catch (Exception e) {
            msg = "error";
        }
        log.info("-------------------end upload-------------------");
        json.put("msg", msg);
        return JSONObject.toJSON(json).toString();
    }

	/*private byte[] inputStreamToByte(InputStream is) throws IOException {
		ByteArrayOutputStream bAOutputStream = new ByteArrayOutputStream();
		int ch;
		while ((ch = is.read()) != -1) {
			bAOutputStream.write(ch);
		}
		byte data[] = bAOutputStream.toByteArray();
		bAOutputStream.close();
		return data;
	}*/

    @RequestMapping(value = "/uploadservlet", method = RequestMethod.POST, produces = "text/html;charset=utf-8")
    protected String uploadServlet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        JSONObject json = new JSONObject();
        response.setCharacterEncoding("utf-8");
        String msg = "添加成功";
        log.info("-------------------开始调用上传文件uploadservlet接口-------------------");
        try {
            if (request instanceof MultipartHttpServletRequest) {
                MultipartHttpServletRequest mr = (MultipartHttpServletRequest) request;
                List<MultipartFile> multipartFile = mr.getFiles("myfile");
                if (null != multipartFile && !multipartFile.isEmpty()) {
                    MultipartFile file = multipartFile.get(0);
                    String name = file.getOriginalFilename();
                    String path = this.getClass().getClassLoader().getResource("/").getPath();
                    int index = path.indexOf("Shopping");
                    path = path.substring(0, index + "Shopping".length()) + "/WebContent/resources/upload/";
                    path = path + File.separator + name;
                    File uploadFile = new File(path);
                    if (FileCopyUtils.copy(file.getInputStream(), new FileOutputStream(uploadFile)) > 0) {
                        json.put("path", path);
                    }

                }
            }
        } catch (Exception e) {
            msg = "上传失败";
        }
        log.info("-------------------结束调用上传文件uploadservlet接口-------------------");
        json.put("msg", msg);
        return JSONObject.toJSON(json).toString();
    }
}
