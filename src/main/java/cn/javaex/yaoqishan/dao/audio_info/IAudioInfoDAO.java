package cn.javaex.yaoqishan.dao.audio_info;

import cn.javaex.yaoqishan.view.AudioInfo;

import java.util.List;

public interface IAudioInfoDAO {

	/**
	 * 查询频道栏目列表
	 */
	List<AudioInfo> list();
	List<AudioInfo> selectByStatus(String status);


	/**
	 * 插入新的频道栏目
	 * @param audioInfo
	 * @return
	 */
	int insert(AudioInfo audioInfo);
	
	/**
	 * 更新频道栏目
	 * @param audioInfo
	 * @return
	 */
	int update(AudioInfo audioInfo);

	/**
	 * 根据主键查询频道信息
	 * @param id
	 * @return
	 */
	AudioInfo selectById(String id);
	AudioInfo selectByName(String name);

	/**
	 * 删除频道
	 * @param id
	 * @return
	 */
	int delete(String id);

}