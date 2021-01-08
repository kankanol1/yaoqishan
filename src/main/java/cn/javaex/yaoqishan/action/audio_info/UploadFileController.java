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
import org.springframework.ui.ModelMap;
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
            String[] arr = name.split("\\.");
            if (audioInfoService.selectByName(arr[0]) != null) {
                json.put("msg", "视频已经存在");
                return JSONObject.toJSON(json).toString();
            }
            String basePath = "/var/www/website/upload/" + arr[0] + "/";
            String path = basePath + name;
            File file1 = new File( basePath);
            File file2 = new File(basePath + "input/");
            File file3 = new File(basePath + "output/");
            if (!file1.exists()) {
                file1.mkdirs();//多层目录需要调用mkdirs
            }if (!file2.exists()) {
                file2.mkdirs();
            }if (!file3.exists()) {
                file3.mkdirs();
            }
            File uploadFile = new File(path);
            files.transferTo(uploadFile);
            AudioInfo audioInfo = new AudioInfo();
            audioInfo.setName(arr[0]);
            audioInfo.setTemplate("edit");
            audioInfo.setTitle(name);
            audioInfo.setSort("1");
            audioInfo.setStatus("1");
            audioInfo.setUrl(path);
            audioInfo.setResult(path);
            audioInfo.setKeywords(name);
            audioInfo.setDescription(name + "视频描述");
            audioInfoService.save(audioInfo);

            json.put("url", path);
        } catch (Exception e) {
            msg = "error";
        }
        log.info("-------------------end upload-------------------");
        json.put("msg", msg);
        return JSONObject.toJSON(json).toString();
    }

    @RequestMapping(value = "status.json", method = RequestMethod.POST)
    public String status(@RequestParam(required = false, value = "id") String id, HttpServletRequest request, HttpServletResponse response) {
        List<AudioInfo> audioInfo = audioInfoService.selectByStatus("2");
        JSONObject json = new JSONObject();
        response.setCharacterEncoding("utf-8");
        if (audioInfo.size() > 0) {
            json.put("msg", "已有视频在编译中，请稍后重试...");
            json.put("code", "000000");
        } else {
            AudioInfo audioInfo1 = audioInfoService.selectById(id);
            audioInfo1.setStatus("2");
            audioInfoService.save(audioInfo1);
            json.put("msg", "视频进入编译阶段，请稍后查看...");
            json.put("code", "000001");
        }
        return JSONObject.toJSON(json).toString();
    }

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
