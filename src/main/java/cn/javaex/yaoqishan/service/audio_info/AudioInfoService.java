package cn.javaex.yaoqishan.service.audio_info;

import cn.javaex.yaoqishan.dao.audio_info.IAudioInfoDAO;
import cn.javaex.yaoqishan.dao.nav_info.INavInfoDAO;
import cn.javaex.yaoqishan.view.AudioInfo;
import cn.javaex.yaoqishan.view.NavInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;

@Service("AudioInfoService")
public class AudioInfoService {
    @Autowired
    private IAudioInfoDAO iAudioInfoDAO;
    @Autowired
    private INavInfoDAO iNavInfoDAO;

    /**
     * 查询视频列表
     */
    public List<AudioInfo> list() {
        return iAudioInfoDAO.list();
    }

    /**
     * 根据主键查询视频信息
     *
     * @param id 主键
     * @return
     */
    public AudioInfo selectById(String id) {
        if (StringUtils.isEmpty(id)) {
            return null;
        }

        return iAudioInfoDAO.selectById(id);
    }

    /**
     * 根据名称查询视频信息
     *
     * @param name 主键
     * @return
     */
    public AudioInfo selectByName(String name) {
        if (StringUtils.isEmpty(name)) {
            return null;
        }
        return iAudioInfoDAO.selectByName(name);
    }

    /**
     * 根据编译状态查询视频信息
     *
     * @param status 主键
     * @return
     */
    public List<AudioInfo> selectByStatus(String status) {
        if (StringUtils.isEmpty(status)) {
            return null;
        }
        return iAudioInfoDAO.selectByStatus(status);
    }

    /**
     * 保存视频内容
     *
     * @param audioInfo
     */
    public void save(AudioInfo audioInfo) {
        // 判断是新增还是更新
        if (StringUtils.isEmpty(audioInfo.getId())) {
            // 新增
            iAudioInfoDAO.insert(audioInfo);

            // 添加进导航
//			NavInfo navInfo = new NavInfo();
//			navInfo.setSort("1");
//			navInfo.setName(audioInfo.getName());
//			navInfo.setLink("portal/portal.action?audioId="+audioInfo.getId());
//			navInfo.setIsIndex("0");
//			navInfo.setIsUse("1");
//			navInfo.setType("system");
//			navInfo.setChannelId(audioInfo.getId());

//			iNavInfoDAO.insert(navInfo);
        } else {
            // 更新
            iAudioInfoDAO.update(audioInfo);

            // 更新导航
//			NavInfo navInfo = new NavInfo();
//			navInfo.setName(audioInfo.getName());
//			navInfo.setChannelId(audioInfo.getId());

//			iNavInfoDAO.updateByChannel(navInfo);
        }
    }

    /**
     * 删除视频
     *
     * @param id
     */
    public void delete(String id) {
        // 删除视频
        iAudioInfoDAO.delete(id);

        // 删除导航中对应的链接
//		iNavInfoDAO.deleteByChannelId(id);
    }

}
