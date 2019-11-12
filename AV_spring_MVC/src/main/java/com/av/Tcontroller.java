package com.av;

//import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestParam;
//import org.springframework.web.bind.annotation.RestController;
//
//@Controller
//
//public class Tcontroller {
//	@GetMapping({ "/", "/hello" })
//	public String hello(Model model, @RequestParam(value = "type", required = false, defaultValue = "0") String type) {
//		model.addAttribute("type", type);
//		switch (type) {
//		case "1":
//			return "bar";
//		case "2":
//			return "areaChart";
//		case "3":
//			return "bubble";
//		case "4":
//			return "scatter";
//		default:
//			return "hello";
//
//		}
//
//	}
//}
//package com.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.av.model.UserDetails;
import com.av.model.data;
import com.av.service.UserService;

@Controller
public class Tcontroller {
	
	@Autowired
	private UserService userService;
	@GetMapping({ "/", "/hello" })
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<List<data>> userDetails() {
        
		List<data> data = userService.getUserDetails();
		return new ResponseEntity<List<data>>(data, HttpStatus.OK);
	}

}
