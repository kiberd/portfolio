package com.midamsu.common.utill;

import com.midamsu.board.vo.BoardVO;
import org.springframework.stereotype.Repository;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Repository
public class FileUtils {
    //private static final String filePath = "C:\\dev\\file\\";
    private static final String filePath = "/usr/local/tomcat/webapps/upload/";

    public List<Map<String, Object>> parseInsertFileInfo(BoardVO boardVO, HttpServletRequest request) throws Exception {
        MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
        Iterator<String> iterator = multipartHttpServletRequest.getFileNames();

        MultipartFile multipartFile = null;
        String originalFileName = null;
        String originalFileExtension = null;
        String storedFileName = null;

        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        Map<String, Object> listMap = null;

        String bId = String.valueOf(boardVO.getBId());

        File file = new File(filePath);
        if (file.exists() == false) {
            file.mkdirs();
        }
        while (iterator.hasNext()) {
            multipartFile = multipartHttpServletRequest.getFile(iterator.next());
            if (multipartFile.isEmpty() == false) {
                originalFileName = multipartFile.getOriginalFilename();
                originalFileExtension = originalFileName.substring(originalFileName.lastIndexOf("."));
                storedFileName = CommonUtils.getRandomString() + originalFileExtension;
                file = new File(filePath + storedFileName);
                multipartFile.transferTo(file);
                listMap = new HashMap<String, Object>();
                listMap.put("BID", bId);
                listMap.put("ORIGINAL_FILE_NAME", originalFileName);
                listMap.put("STORED_FILE_NAME", storedFileName);
                listMap.put("FILE_SIZE", multipartFile.getSize());
                list.add(listMap);
            }
        }
        return list;
    }


}
