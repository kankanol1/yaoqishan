package cn.javaex.yaoqishan.util;

import java.util.HashMap;
import java.util.Map;

/**
 * @author kankan
 * @version 1.0
 * @created 2021-01-07 12:55 by kankan
 * @updated 2021-01-07 12:55 by kankan
 */
public class StatusDict {


    public   static  Map<String, String> getDict() {
        Map<String, String> map = new HashMap<String, String>();
        map.put("1","编译");
        map.put("2","编译中");
        map.put("3","成功");
        map.put("4","失败");
        return map;
    }
}
