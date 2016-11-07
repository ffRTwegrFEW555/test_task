package com.gamaliev.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping(value = "/")
public class DefaultController {

    // Start webapp with redirect to /users
    @RequestMapping(value = "/")
    public String redirect() {
        return "redirect:/users";
    }
}
