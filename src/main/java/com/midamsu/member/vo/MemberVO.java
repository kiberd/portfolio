package com.midamsu.member.vo;

import lombok.Builder;
import lombok.Data;
import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

@Data
public class MemberVO {

    @NotEmpty
    @Email
    private String memId;

    @NotEmpty
    // 영문, 숫자 ,특수문자 최소 1회씩 (8~20)
    @Pattern(regexp = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$")
    private String memPw;

    @NotEmpty
    //@Size(min = 1, max = 10)
    private String memName;

    @NotEmpty
    private String memPhone;

    @NotEmpty
    private String memAddress;

    private String social;
    private String authStatus;
    private String authkey;


}
