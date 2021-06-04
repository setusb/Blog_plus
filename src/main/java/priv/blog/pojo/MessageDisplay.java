package priv.blog.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 17:30
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class MessageDisplay {
    private String name;
    private String content;
    private String date;
}
