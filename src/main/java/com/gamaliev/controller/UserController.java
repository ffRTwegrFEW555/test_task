package com.gamaliev.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.gamaliev.helper.UserHelper;
import com.gamaliev.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import com.gamaliev.service.UserService;


@Controller
@RequestMapping(value = "users")
public class UserController {

    private UserService userService;

    @Autowired
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    // First load page
    @RequestMapping(value = "",
                    method = RequestMethod.GET)
    public String listUsers(@RequestParam(required = false) Integer itemsPerPage,
                            @RequestParam(required = false) Integer numberOfPage,
                            @RequestParam(required = false) String textFilter,
                            Model model) {
        UserHelper.getUserList(userService, itemsPerPage, numberOfPage, textFilter, model);
        return "users";
    }

    // Update users table
    @RequestMapping(value = "",
                    method = RequestMethod.POST,
                    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public String listObjects(@RequestParam(required = false) Integer itemsPerPage,
                              @RequestParam(required = false) Integer numberOfPage,
                              @RequestParam(required = false) String textFilter,
                              Model model) {

        UserHelper.getUserList(userService, itemsPerPage, numberOfPage, textFilter, model);

        try {
            return new ObjectMapper().writeValueAsString(model);
        } catch (JsonProcessingException e) {
            System.out.println("Error Map to Json");
        }

        return null;
    }

    // Remove user by id
    @RequestMapping(value = "remove",
                    method = RequestMethod.POST,
                    produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public String removeUser(@RequestParam(required = false) Integer id) {

        try {
            userService.removeById(id);
        } catch (Exception e) {
            return "{\"removed\":0}";
        }

        return "{\"removed\":1}";
    }

    // Add user
    @RequestMapping(value = "add",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public User addUser(@RequestBody User user) {

        if (user == null) {
            return new User();
        }

        try {
            userService.add(user);
        } catch (Exception e) {
            return new User();
        }

        return user;
    }

    // Get user by id
    @RequestMapping(value = "get",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public User getUser(@RequestParam(required = false) Integer id) {

        User user;

        if (id == null) {
            return new User();
        }

        try {
            user = userService.getById(id);
        } catch (Exception e) {
            return new User();
        }

        return user;
    }

    // Update user
    @RequestMapping(value = "update",
            method = RequestMethod.POST,
            produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public User updateUser(@RequestBody User user) {

        if (user == null) {
            return new User();
        }

        try {
            userService.update(user);
        } catch (Exception e) {
            return new User();
        }

        return user;
    }
}
