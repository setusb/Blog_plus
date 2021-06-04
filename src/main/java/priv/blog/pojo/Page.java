package priv.blog.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/5/24 18:23
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Page {
    /**
     * 页码数字
     */
    private int page;
}
