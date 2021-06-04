package priv.blog.dao;

import cn.hutool.core.convert.Convert;
import com.alibaba.fastjson.JSON;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import oshi.SystemInfo;
import priv.blog.pojo.Article;
import priv.blog.pojo.Page;
import priv.blog.pojo.User;
import priv.blog.service.UserService;
import priv.blog.service.impl.ArticleServiceImpl;

import java.sql.Array;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.jar.JarEntry;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/5/24 18:08
 */
public class cs {

    public static String arrayToString(int[] arr) {
        StringBuffer sb = new StringBuffer();
        sb.append("[");
        for (int i = 0; i < arr.length; i++) {
            if (i == arr.length - 1) {
                sb.append(arr[i] + "]");
            } else {
                sb.append(arr[i]).append(",");
            }
        }
        return sb.toString();
    }

    @Test
    public void s() {
        float num = 9;
        float b = 5;
        float a = num / b;

        List<Page> list = new ArrayList<>();

        for (int i = 0; i < Math.ceil(a); i++) {
            Page p = new Page();
            p.setPage(i);
            list.add(p);
        }

/*        for (int i = 0; i < p.getPage(); i++) {
            System.out.println(i+1);
        }*/

        for (Page page : list) {
            System.out.println(page.getPage());
        }

        System.out.println(list.size());

    }

    @Test
    public void abc() {
        ArticleServiceImpl articleService = new ArticleServiceImpl();
        Article article = articleService.selectByPrimaryKey(3);
        Date date = article.getArticleDate();
        System.out.println(date);
    }

    @Test
    public void acc() throws Exception {
        SystemInfo sys = new SystemInfo();
/*        for(OSProcess p : sys.getOperatingSystem().getProcesses(10, OperatingSystem.ProcessSort.MEMORY)) {
            System.out.println(p.getProcessID() + " " + p.getName());
        }*/
        System.out.println(FileUtils.byteCountToDisplaySize(sys.getHardware().getMemory().getSwapTotal()));
        System.out.println(FileUtils.byteCountToDisplaySize(sys.getHardware().getMemory().getTotal()));


        System.out.println(FileUtils.byteCountToDisplaySize(sys.getHardware().getMemory().getAvailable()));
        int s = Convert.toInt(FileUtils.byteCountToDisplaySize(sys.getHardware().getMemory().getTotal()));
        int i = Convert.toInt(FileUtils.byteCountToDisplaySize(sys.getHardware().getMemory().getAvailable()));


        System.out.println(s - i);

        System.out.println(sys.getHardware().getProcessor().getName());

    }

    @Test
    public void sb() {

        int[] array = {1, 2, 3};

        /*        ArrayList<int[]> arrayList = new ArrayList<>();
        arrayList.add(array);
        System.out.println(JSON.toJSONString(arrayList));*/
        System.out.println(arrayToString(array));
        /*[6,22,56,31]*/
    }

/*    {
        "code": 0,
            "msg": "",
            "count": 1000,
            "data": [
        {
            "id": 10000,
                "username": "user-0",
                "sex": "女",
                "city": "城市-0",
                "sign": "签名-0",
                "experience": 255,
                "logins": 24,
                "wealth": 82830700,
                "classify": "作家",
                "score": 57
        },*/

    @Test
    public void ts1() {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String sd = sdf.format(new Date(Long.parseLong("1621872000000")));
        System.out.println(sd);
    }
}
