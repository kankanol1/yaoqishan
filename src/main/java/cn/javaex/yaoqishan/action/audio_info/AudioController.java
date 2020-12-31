package cn.javaex.yaoqishan.action.audio_info;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Iterator;

/**
 * @author kankan
 * @version 1.0
 * @created 2020-12-30 17:11 by kankan
 * @updated 2020-12-30 17:11 by kankan
 */

@Controller
@RequestMapping("portal/audios")
public class AudioController {

    @RequestMapping(value = "audio.json", method = RequestMethod.POST)
    public String fileUpload(HttpServletRequest request,@RequestParam( value="files",required=false)MultipartFile multipartFile) throws IllegalStateException, IOException {
        // 设置上下方文
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());

        // 检查form是否有enctype="multipart/form-data"
        if (multipartResolver.isMultipart(request)) {
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {

                // 由CommonsMultipartFile继承而来,拥有上面的方法.
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    String fileName = "demoUpload" + file.getOriginalFilename();
                    String path = "D:/" + fileName;
                    File localFile = new File(path);
                    file.transferTo(localFile);
                }

            }
        }
        return "dataSuccess";
    }

    @RequestMapping(value = "audios.json", method = RequestMethod.POST)
    public String fileUpload2(HttpServletRequest request) throws IllegalStateException, IOException {
        // 设置上下方文
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());

        // 检查form是否有enctype="multipart/form-data"
        if (multipartResolver.isMultipart(request)) {
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;

            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {

                // 由CommonsMultipartFile继承而来,拥有上面的方法.
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    String fileName = "demoUpload" + file.getOriginalFilename();
                    String path = "D:/" + fileName;
                    File localFile = new File(path);
                    file.transferTo(localFile);
                }

            }
        }
        return "dataSuccess";
    }



}
