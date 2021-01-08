package cn.javaex.yaoqishan.action.portal;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import cn.javaex.yaoqishan.service.audio_info.AudioInfoService;
import cn.javaex.yaoqishan.util.StatusDict;
import cn.javaex.yaoqishan.view.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import cn.javaex.yaoqishan.exception.QingException;
import cn.javaex.yaoqishan.service.channel_info.ChannelInfoService;
import cn.javaex.yaoqishan.service.field_info.FieldInfoService;
import cn.javaex.yaoqishan.service.media_info.MediaInfoService;
import cn.javaex.yaoqishan.service.nav_info.NavInfoService;
import cn.javaex.yaoqishan.service.seo_info.SeoInfoService;
import cn.javaex.yaoqishan.service.template_info.TemplateInfoService;
import cn.javaex.yaoqishan.service.type_info.TypeInfoService;
import cn.javaex.yaoqishan.service.user_info.UserInfoService;
import cn.javaex.yaoqishan.service.video_info.VideoInfoService;
import cn.javaex.yaoqishan.service.web_info.WebInfoService;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("portal")
public class PortalAction {

    @Autowired
    private VideoInfoService videoInfoService;
    @Autowired
    private MediaInfoService mediaInfoService;
    @Autowired
    private FieldInfoService fieldInfoService;
    @Autowired
    private NavInfoService navInfoService;
    @Autowired
    private ChannelInfoService channelInfoService;
    @Autowired
    private WebInfoService webInfoService;
    @Autowired
    private SeoInfoService seoInfoService;
    @Autowired
    private UserInfoService userInfoService;
    @Autowired
    private TemplateInfoService templateInfoService;
    @Autowired
    private TypeInfoService typeInfoService;
    @Autowired
    private AudioInfoService audioInfoService;

    /**
     * 跳转首页
     *
     * @return
     */
    @RequestMapping("index.action")
    public String index(ModelMap map, HttpServletRequest request) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 网站首页seo
        SeoInfo seoInfo = seoInfoService.selectByType("index");
        map.put("seoInfo", seoInfo);

        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        for (NavInfo navInfo : navlist) {
            // 判断是否是首页
            if ("1".equals(navInfo.getIsIndex())) {
                // 判断该链接是否是系统内置的（或者是频道）
                if ("system".equals(navInfo.getType())) {
                    // 系统默认首页
                    if ("portal/index.action".equals(navInfo.getLink())) {
                        map.put("active", navInfo.getLink());
                        return "portal/pc/template/" + templatePC + "/index";
                    } else {
                        // 频道
                        String channelId = navInfo.getChannelId();
                        map.put("active", "portal/portal.action?channelId=" + channelId);
                        ChannelInfo channelInfo = channelInfoService.selectById(channelId);
                        return "portal/pc/template/" + templatePC + "/channel/" + channelInfo.getTemplate();
                    }
                } else {
                    // 自定义链接
                    map.put("active", navInfo.getLink());
                    return "redirect:" + navInfo.getLink();
                }
            }
        }

        return "portal/pc/template/" + templatePC + "/index";
    }

    @RequestMapping("indexs.action")
    public String indexs(ModelMap map, HttpServletRequest request) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 网站首页seo
        SeoInfo seoInfo = seoInfoService.selectByType("index");
        map.put("seoInfo", seoInfo);

        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        for (NavInfo navInfo : navlist) {
            // 判断是否是首页
            if ("1".equals(navInfo.getIsIndex())) {
                // 判断该链接是否是系统内置的（或者是频道）
                if ("system".equals(navInfo.getType())) {
                    // 系统默认首页
                    if ("portal/index.action".equals(navInfo.getLink())) {
                        map.put("active", navInfo.getLink());
                        return "portal/pc/template/" + templatePC + "/index";
                    } else {
                        // 频道
                        String channelId = navInfo.getChannelId();
                        map.put("active", "portal/portal.action?channelId=" + channelId);
                        ChannelInfo channelInfo = channelInfoService.selectById(channelId);
                        return "portal/pc/template/" + templatePC + "/channel/" + channelInfo.getTemplate();
                    }
                } else {
                    // 自定义链接
                    map.put("active", navInfo.getLink());
                    return "redirect:" + navInfo.getLink();
                }
            }
        }

        return "portal/pc/template/" + templatePC + "/indexs";
    }

    /**
     * 跳转频道页面
     *
     * @return
     */
    @RequestMapping("portal.action")
    public String portal(ModelMap map,
                         HttpServletRequest request,
                         @RequestParam(value = "channelId") String channelId) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 判断合法性
        try {
            Integer.parseInt(channelId);
        } catch (Exception e) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        ChannelInfo channelInfo = channelInfoService.selectById(channelId);
        if (channelInfo == null) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        map.put("channelInfo", channelInfo);

        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        map.put("active", "portal.action?channelId=" + channelId);

        return "portal/pc/template/" + templatePC + "/channel/" + channelInfo.getTemplate();
    }

    /**
     * 跳转到播放页面
     *
     * @param videoId 视频主键
     * @return
     */
    @RequestMapping("play.action")
    public String play(ModelMap map,
                       HttpServletRequest request,
                       @RequestParam(value = "videoId") String videoId) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 判断合法性
        try {
            Integer.parseInt(videoId);
        } catch (Exception e) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        // 获取该视频的信息
        VideoInfo videoInfo = videoInfoService.selectByIdWithPortal(videoId);
        if (videoInfo == null) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        if ("0".equals(videoInfo.getStatus())) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        map.put("videoInfo", videoInfo);

        // 视频播放页seo
        SeoInfo seoInfo = seoInfoService.selectByType("play");
        map.put("seoInfo", seoInfo);

        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        // 根据主键，获取媒体信息
        Map<String, Object> mediaInfo = null;
        try {
            mediaInfo = mediaInfoService.selectByMediaId(videoInfo.getMediaId());
            map.put("mediaInfo", mediaInfo);
        } catch (QingException e) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }

        // 电脑端获取播放页模板
        TypeInfo typeInfo = typeInfoService.selectById(mediaInfo.get("type_id").toString());

        map.put("videoId", videoId);

        return "portal/pc/template/" + templatePC + "/play/" + typeInfo.getPlayTemplate();
    }

    /**
     * 跳转到媒体详情页面
     *
     * @param mediaId 视频主键
     * @return
     */
    @RequestMapping("profile.action")
    public String profile(ModelMap map,
                          HttpServletRequest request,
                          @RequestParam(value = "mediaId") String mediaId) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 判断合法性
        try {
            Integer.parseInt(mediaId);
        } catch (Exception e) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        // 根据主键，获取媒体信息
        Map<String, Object> mediaInfo = null;
        try {
            mediaInfo = mediaInfoService.selectByMediaId(mediaId);
            map.put("mediaInfo", mediaInfo);
        } catch (QingException e) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }

        // 网站首页seo
        SeoInfo seoInfo = seoInfoService.selectByType("profile");
        map.put("seoInfo", seoInfo);

        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        // 电脑端获取详情页模板
        TypeInfo typeInfo = typeInfoService.selectById(mediaInfo.get("type_id").toString());
        String profileTemplate = typeInfo.getProfileTemplate();
        if (StringUtils.isEmpty(profileTemplate)) {
            // 404（该分类没有详情页面）
            return "portal/pc/template/" + templatePC + "/error/404";
        }

        map.put("mediaId", mediaId);

        return "portal/pc/template/" + templatePC + "/profile/" + profileTemplate;
    }

    /**
     * 跳转到搜索结果页面
     *
     * @param keyWord 视频主键
     * @return
     */
    @RequestMapping("search.action")
    public String search(ModelMap map,
                         HttpServletRequest request,
                         @RequestParam(value = "keyWord") String keyWord) {

        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        map.put("keyWord", keyWord);

        return "portal/pc/template/" + templatePC + "/search/search";
    }

    /**
     * 跳转到分类检索页面
     *
     * @param typeId 视频主键
     * @return
     */
    @RequestMapping("list.action")
    public String list(ModelMap map,
                       HttpServletRequest request,
                       @RequestParam(value = "typeId") String typeId,
                       @RequestParam(required = false, value = "name") String fieldName,
                       @RequestParam(required = false, value = "value") String fieldValue) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 判断合法性
        try {
            Integer.parseInt(typeId);
        } catch (Exception e) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        List<FieldInfo> list = fieldInfoService.getListField(typeId, fieldName, fieldValue);
        if (list == null) {
            // 404
            return "portal/pc/template/" + templatePC + "/error/404";
        }
        map.put("list", list);

        // 分类检索页seo
        SeoInfo seoInfo = seoInfoService.selectByType("list");
        map.put("seoInfo", seoInfo);

        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        map.put("typeId", typeId);
        map.put("fieldName", fieldName);
        map.put("fieldValue", fieldValue);

        return "portal/pc/template/" + templatePC + "/list/list";
    }

    /**
     * 跳转注册页面
     *
     * @return
     */
    @RequestMapping("register.action")
    public String register(ModelMap map) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        return "portal/pc/template/" + templatePC + "/user/register_page";
    }

    /**
     * 跳转视频编译
     *
     * @return
     */
    @RequestMapping("audio.action")
    public String audio(ModelMap map, HttpServletRequest request) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);
        // 网站首页seo
        SeoInfo seoInfo = seoInfoService.selectByType("index");
        map.put("seoInfo", seoInfo);
        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);
        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);
        return "portal/pc/template/" + templatePC + "/audio/audio";
    }

    @RequestMapping("edit.action")
    public String edit(ModelMap map,
                       HttpServletRequest request,
                       @RequestParam(required = false, value = "id") String id) {

        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);
        // 网站首页seo
        SeoInfo seoInfo = seoInfoService.selectByType("index");
        map.put("seoInfo", seoInfo);
        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);
        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        AudioInfo audioInfo = audioInfoService.selectById(id);
        map.put("audioInfo", audioInfo);

        map.put("id", id);
        // 获取所选模板
        Map<String, String> templateMap = null;
        List<Map<String, String>> templateList = new ArrayList<Map<String, String>>();

        String path = request.getSession().getServletContext().getRealPath("/WEB-INF/page/portal/pc/template/" + templatePC + "/audio");

        File file = new File(path);
        // 获得该文件夹内的所有文件名
        File[] arr = file.listFiles();
        if (arr != null && arr.length > 0) {
            for (int i = 0; i < arr.length; i++) {
                templateMap = new HashMap<String, String>();
                // 获取文件夹名（即模板名称）
                String templateName = arr[i].getName().replace(".jsp", "");

                templateMap.put("value", templateName);
                templateMap.put("name", templateName);
                templateList.add(templateMap);
            }
        }
        map.put("templateList", templateList);

        return "portal/pc/template/" + templatePC + "/audio/edit";

//        return "admin/audio_info/edit";
    }

    @RequestMapping("save.json")
    @ResponseBody
    public Result save(AudioInfo audioInfo) {

        audioInfoService.save(audioInfo);
        /*
         *
         * */

        return Result.success();
    }

    /**
     * 删除频道
     */
    @RequestMapping("delete.json")
    @ResponseBody
    public Result delete(
            @RequestParam(required = false, value = "id") String id) {
        audioInfoService.delete(id);
        return Result.success();
    }

    /**
     * 跳转结果集
     *
     * @return
     */

    @RequestMapping("results.action")
    public String results(ModelMap map, HttpServletRequest request, @RequestParam(required = false, value = "status") String status, @RequestParam(required = false, value = "id") String id) {

// 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);
        // 网站首页seo
        SeoInfo seoInfo = seoInfoService.selectByType("index");
        map.put("seoInfo", seoInfo);
        // 获取用户信息
        UserInfo userInfo = userInfoService.getUserInfo(request);
        map.put("userInfo", userInfo);
        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        // 获取可用导航
        List<NavInfo> navlist = navInfoService.listIsUse();
        map.put("navlist", navlist);

        if (id != null) {
            AudioInfo audioInfo = audioInfoService.selectById(id);
            audioInfo.setStatus("2");
            audioInfoService.save(audioInfo);
        }
        List<AudioInfo> list;

        if (status != null) {
            list = audioInfoService.selectByStatus(status);
        } else {
            list = audioInfoService.list();
        }
        map.put("list", list);
        map.put("obj", StatusDict.getDict());
        return "portal/pc/template/" + templatePC + "/audio/results";
    }

    /**
     * 打开登录弹出层
     *
     * @return
     */
    @RequestMapping("login.action")
    public String login() {
        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        return "portal/pc/template/" + templatePC + "/user/login";
    }

    /**
     * 跳转登录页面
     *
     * @return
     */
    @RequestMapping("login_page.action")
    public String loginPage(ModelMap map) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        return "portal/pc/template/" + templatePC + "/user/login_page";
    }

    /**
     * 跳转到找回密码页面
     *
     * @return
     */
    @RequestMapping("find_pwd.action")
    public String findPwd(ModelMap map) {
        // 站点信息
        WebInfo webInfo = webInfoService.select();
        map.put("webInfo", webInfo);

        // 获取所选模板
        String templatePC = templateInfoService.selectNameByType("pc");

        return "portal/pc/template/" + templatePC + "/user/find_pwd";
    }
}
