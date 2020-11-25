package com.midamsu.common.controller;

import com.midamsu.common.service.CommonService;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.activation.CommandMap;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

@Controller
public class CommonController {

    @Autowired
    CommonService commonService;

    private static final Logger logger = LoggerFactory.getLogger(CommonController.class);

    @GetMapping("/common/downloadFile.do")
    public void downloadFile(@RequestParam int fId, HttpServletResponse response) throws Exception{
        Map<String, Object> resultMap = null;
        String storedFileName;
        String originalFileName;
        byte fileByte[] = null;

        resultMap = commonService.selectFileInfo(fId);
        storedFileName = (String) resultMap.get("STORED_FILE_NAME");
        originalFileName = (String) resultMap.get("ORIGINAL_FILE_NAME");

        try {
            fileByte = FileUtils.readFileToByteArray(new File("/usr/local/tomcat/webapps/upload/" + storedFileName));
        }
        catch (Exception e) {
            logger.error("Cannot read file from path" , e);
        }


        response.setContentType("application/octet-stream");
        response.setContentLength(fileByte.length);
        response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(originalFileName, "UTF-8") + "\";");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.getOutputStream().write(fileByte);
        response.getOutputStream().flush();
        response.getOutputStream().close();

    }


}
