package cn.javaex.yaoqishan.action.audio_info;

import cn.javaex.yaoqishan.service.audio_info.AudioInfoService;
import cn.javaex.yaoqishan.service.template_info.TemplateInfoService;
import cn.javaex.yaoqishan.util.StatusDict;
import cn.javaex.yaoqishan.view.AudioInfo;
import cn.javaex.yaoqishan.view.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("audio_info")
public class AudioInfoAction {

	@Autowired
	private AudioInfoService audioInfoService;
	@Autowired
	private TemplateInfoService templateInfoService;
	
	/**
	 * 查询所有
	 */
	@RequestMapping("list.action")
	public String list(ModelMap map) {
		List<AudioInfo> list = audioInfoService.list();
		map.put("obj", StatusDict.getDict());
		return "admin/audio_info/list";
	}

/*	@RequestMapping("status.action")
	public String list(ModelMap map,
					   HttpServletRequest request,
					   @RequestParam(required=false, value="status") String status) {
		List<AudioInfo> list = audioInfoService.selectByStatus(status);
		map.put("list", list);
		map.put("obj", objMap());
		return "admin/audio_info/list";
	}*/

	/**
	 * 通过编译状态查询
	 */
//	@RequestMapping("status.action")


/*	public Map<String,String> objMap(){
		Map<String,String> obj= new HashMap<String, String>();
		obj.put("1","编译");
		obj.put("2","编译中");
		obj.put("3","编译成功");
		obj.put("4","编译失败");
		return  obj;
	}*/

	
	/**
	 * 编辑
	 */
	@RequestMapping("edit.action")
	public String edit(ModelMap map,
			HttpServletRequest request,
			@RequestParam(required=false, value="id") String id) {
		
		// 获取所选模板
		String templatePC = templateInfoService.selectNameByType("pc");
		
		Map<String, String> templateMap = null;
		List<Map<String, String>> templateList = new ArrayList<Map<String, String>>();
		
		String path = request.getSession().getServletContext().getRealPath("/WEB-INF/page/portal/pc/template/"+templatePC+"/audio");
		
		File file = new File(path);
		// 获得该文件夹内的所有文件名
		File[] arr = file.listFiles();
		if (arr!=null && arr.length>0) {
			for (int i=0; i<arr.length; i++) {
				templateMap = new HashMap<String, String>();
				// 获取文件夹名（即模板名称）
				String templateName = arr[i].getName().replace(".jsp", "");

				templateMap.put("value", templateName);
				templateMap.put("name", templateName);
				templateList.add(templateMap);
			}
		}
		map.put("templateList", templateList);
		
		AudioInfo audioInfo = audioInfoService.selectById(id);
		map.put("audioInfo", audioInfo);
		
		map.put("id", id);
		
		return "admin/audio_info/edit";
	}
	
	/**
	 * 保存
	 */
	@RequestMapping("save.json")
	@ResponseBody
	public Result save(AudioInfo audioInfo) {
		
		audioInfoService.save(audioInfo);
		return Result.success();
	}
	
	/**
	 * 删除
	 */
	@RequestMapping("delete.json")
	@ResponseBody
	public Result delete(@RequestParam(required=false, value="id") String id) {
		AudioInfo audioInfo = audioInfoService.selectById(id);
		audioInfoService.delete(id);
		try {
			File file = new File(audioInfo.getUrl());
			System.out.println(audioInfo.getUrl());
			System.out.println(file.exists());
			if(file.exists()) {
				file.delete();
				System.out.println("删除成功");
			}
		}catch (Exception e){
			e.printStackTrace();
		}
		return Result.success();
	}
}
