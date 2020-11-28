# Spring Framework를 이용한 게시판 형태의 CRUD 시스템

***

* **개발환경** 
  - *IDE* : Intellij 
  - *Frontend* :  HTML + CSS(Bootstrap) + Javascript(Jquery) + JSP
  - *Backend* : Spring MVC
  - *Server* : AWS EC2 (Nginx + Tomcat)
  - *Database* : AWS RDS DB (Oracle)
  - *Hosting* : AWS Route 53
  
 
* **Web Schema** 

  - www.kiberd.site 도메인을 Route 53 을 통해 실제 웹 주소로 호스팅
  - Nginx로 들어온 요청(port:22)은 Nginx 설정(reverse proxy)을 통해 WAS(tomcat) 포트(port:8181)로 맵핑
  - WAS 내의 DB 요청은 AWS RDS(Oracle) 로 연결
![Alt text](http://kiberd.dothome.co.kr/portfolio/web.png)


* **DB Schema** 

  - MEMBERS : 회원관리 테이블 
  - MVC_BOARD : 게시판 테이블
    + DELETE_MEMBER_BOARD : 멤버삭제 -> 멤버글삭제
  - MVC_COMMENT : 댓글 테이블  
    + DELETE_MEMBER_COMMENT : 멤버삭제 -> 멤버댓글삭제 , DELETE_BOARD_COMMENT : 원글삭제 -> 원글댓글삭제
  - MVC_FILE : 파일 관리 테이블 
    + DELETE_BOARD_FILE : 원글삭제 -> 원글첨부파일삭제
![Alt text](http://kiberd.dothome.co.kr/portfolio/dbmodel.PNG)
