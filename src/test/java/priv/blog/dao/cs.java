package priv.blog.dao;

import cn.hutool.core.convert.Convert;
import org.apache.commons.io.FileUtils;
import org.junit.Test;
import oshi.SystemInfo;
import priv.blog.pojo.Article;
import priv.blog.pojo.Page;
import priv.blog.service.impl.ArticleServiceImpl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

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

    @Test
    public void ts2() throws Exception {
/*        int a = 1;
        long b = 1;

        String c = "1";
        String d = "1";
        Integer a1 = a;

        System.out.println(true);

        System.out.println("Collection");
        Vector vector = new Vector(10);
        vector.add("123");
        System.out.println(vector.get(0));;*/

        LinkedList<String> list = new LinkedList<>();
        list.add(0, "a");
        list.add(1, "ab");
        System.out.println(list.get(1));
        int[] arr = {1, 2, 3, 4};

        try {
            Thread.sleep(1000);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void eq() {
        String a = "123";
        System.out.println(a.equals(new String("123")));

        System.out.println(a.hashCode() == new String("124").hashCode());

        System.out.println(a.hashCode());
        System.out.println(new String("124").hashCode());

        Integer b = 1;
        double b1 = 1;

        System.out.println(b == b1);

        System.out.println(b1);

        System.out.println(b instanceof Integer);
    }
}
