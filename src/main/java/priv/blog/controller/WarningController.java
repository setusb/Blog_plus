package priv.blog.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * @author setusb
 * @version 1.0
 * @date 2021/6/1 20:07
 */
@Controller
public class WarningController {

    @GetMapping("/pageNotFound")
    public String pageNotFound() {
        return "warning/404";
    }

    @GetMapping("/insufficientpermissions")
    public String insufficientPermissions() {
        return "warning/405";
    }

    @GetMapping("/unknownmistake")
    public String unknownMistake() {
        return "warning/101";
    }
}
