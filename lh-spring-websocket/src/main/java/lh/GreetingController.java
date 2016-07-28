package lh;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.messaging.simp.annotation.SendToUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by lh on 2016/3/10.
 */
@Controller
public class GreetingController {
    @Autowired
    private SimpMessagingTemplate simpMessagingTemplate;

    @RequestMapping("/helloSocket")
    public String index() {
        return "index";
    }

    @MessageMapping("/change-notice")
    public void greeting(String value){
        this.simpMessagingTemplate.convertAndSend("/topic/notice",value);
    }

//    @MessageMapping("/change-notice")
//    @SendTo("/topic/notice")
//    public String greeting(String value){
//        return value;
//    }
}
