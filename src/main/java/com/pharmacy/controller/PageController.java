package com.pharmacy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PageController {

    @GetMapping("/")
    public String index() {
        return "home";
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @GetMapping("/signup")
    public String signup() {
        return "signup";
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "dashboard";
    }

    @GetMapping("/inventory")
    public String inventory() {
        return "inventory";
    }

    @GetMapping("/billing")
    public String billing() {
        return "billing";
    }

    @GetMapping("/suppliers")
    public String suppliers() {
        return "suppliers";
    }
}
