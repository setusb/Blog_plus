package priv.blog.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/5/25 16:15
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class CritiqueDisplay {
    private int uuidUser;
    private int commentId;
    private String nickName;
    private String userName;
    private String critiqueContent;
    private Date critiqueDate;
}
