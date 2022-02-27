package com.jbmb.jbmb_coreserver.account.controller;

import com.jbmb.jbmb_coreserver.account.dto.JoinForm;
import com.jbmb.jbmb_coreserver.account.service.MemberService;
import jdk.internal.dynalink.MonomorphicCallSite;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("user/account/")
public class MemberController {

    @Autowired
    private MemberService memberService;

    @GetMapping("check-duplicate/id/{id}/")
    public Boolean isAlreadyID(@RequestParam String id){
        return memberService.checkIdAlready(id);
    }

    @PostMapping("signup/")
    public Boolean joinInJBMB(@RequestBody JoinForm joinForm){
        return memberService.checkSignUp(joinForm.getID(), joinForm.getPW());
    }

}
