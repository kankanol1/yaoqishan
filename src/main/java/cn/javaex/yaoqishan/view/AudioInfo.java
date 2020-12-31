package cn.javaex.yaoqishan.view;

/**
 * 频道栏目表
 * 
 * @author 陈霓清
 */
public class AudioInfo {
	private String id;			// 主键
	private String name;		// 名称
	private String url;		    // 路径
	private String result;		// 结果集下载
	private String images;		// 结果集下载
	private String sort;		// 排序用
	private String template;	// 模板文件名
	private String title;		// 标题
	private String keywords;	// 关键字
	private String description;	// 描述
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getImages() {
		return images;
	}
	public void setImages(String images) {
		this.images = images;
	}
	public String getResult() {
		return result;
	}
	public void setResult(String result) {
		this.result = result;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getTemplate() {
		return template;
	}
	public void setTemplate(String template) {
		this.template = template;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}

	public AudioInfo() {
	}
}
