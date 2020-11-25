package com.midamsu;

import com.midamsu.common.service.CommonService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

@Controller
public class HomeController {

    @Autowired
    CommonService commonService;

    @RequestMapping("/")
    public String home(HttpSession session, Model model) throws Exception {
        String userId = (String) session.getAttribute("email");
        if(userId != null) {
            HashMap<String, Integer> userInfo = new HashMap<>();
            userInfo = commonService.getAccountInfo(userId);
            model.addAttribute("boardCount", userInfo.get("boardCount"));
            model.addAttribute("commentCount", userInfo.get("commentCount"));
        }

        return "index";
    }




   


}
