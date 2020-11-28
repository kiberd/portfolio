# Spring Framework를 이용한 게시판 형태의 CRUD 시스템

***

* **개발환경** 
  - *IDE* : Intellij 
  - *Frontend* :  HTML + CSS(Bootstrap) + Javascript(Jquery) + JSP
  - *Backend* : Spring MVC
  - *Server* : AWS EC2 (Nginx + Tomcat)
  - *Database* : AWS RDS DB (Oracle)
  - *Hosting* : AWS Route 53
  
*** 
 
* **Web Schema** 

  - www.kiberd.site 도메인을 Route 53 을 통해 실제 웹 주소로 호스팅
  - Nginx로 들어온 요청(port:22)은 Nginx 설정(reverse proxy)을 통해 WAS(tomcat) 포트(port:8181)로 맵핑
  - WAS 내의 DB 요청은 AWS RDS(Oracle) 로 연결
![Alt text](http://kiberd.dothome.co.kr/portfolio/web.png)

***

* **DB Schema** 

  - MEMBERS : 회원관리 테이블 
  - MVC_BOARD : 게시판 테이블
    + DELETE_MEMBER_BOARD : 멤버삭제 -> 멤버글삭제
  - MVC_COMMENT : 댓글 테이블  
    + DELETE_MEMBER_COMMENT : 멤버삭제 -> 멤버댓글삭제 
    + DELETE_BOARD_COMMENT : 원글삭제 -> 원글댓글삭제
  - MVC_FILE : 파일 관리 테이블 
    + DELETE_BOARD_FILE : 원글삭제 -> 원글첨부파일삭제
![Alt text](http://kiberd.dothome.co.kr/portfolio/dbmodel.PNG)

***

* **회원관리 기능** 

   - email을 id로 사용하는 회원관리 시스템 
   - 구글, 네이버, 카카오 3가지 플랫폼 소셜 로그인 제공
   - 로그인 흐름도
   
   
   ![Alt text](http://kiberd.dothome.co.kr/portfolio/로그인로직.png)

***

* **게시판 기능** 

   - 회원일 경우에만 글 쓰기, 수정, 삭제 가능
   - 해당 글 작성자일 경우에만, 해당 글 수정, 삭제 가능
   - Paging 기능 (앞, 뒤 4개까지)  
   - 내가 쓴 게시물(글, 댓글) 보기 기능 
   - 텍스트 에디터 중 하나인 SummerNote 사용
   - 파일첨부 기능
   
   ![Alt text](http://kiberd.dothome.co.kr/portfolio/paging.PNG)
   ![Alt text](http://kiberd.dothome.co.kr/portfolio/mycontent.PNG)
***

* **댓글 기능** 

   - 회원일 경우에만 댓글 등록 가능 
   - 댓글 작성자만 댓글 수정, 삭제 가능 
   - 댓글의 대댓글 (계층형 댓글) 기능 구현 
   - 대댓글인 경우 intent값에 따라 들여쓰기 적용
   - 댓글 등록시간이 24시간 이내면 new 표시
   - ajax이용 댓글 리스트 실시간 업데이트 
   - 만약 자식노드(대댓글)가 존재하면 삭제 불가 -> 비공개처리 (deleteFlag)
   
   ![Alt text](http://kiberd.dothome.co.kr/portfolio/대댓글.png)

***

* **예외 처리**

   - web.xml의 errorpage 설정을 통한 404, 400, 500 에러 처리
   - 파일첨부의 경우 MultipartResolver 의 Execption을 통한 예외처리 
