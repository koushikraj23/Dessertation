package com.av;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Controller

public class Tcontroller {
	@GetMapping({ "/", "/hello" })
	public String hello(Model model, @RequestParam(value = "type", required = false, defaultValue = "0") String type) {
		model.addAttribute("type", type);
		switch (type) {
		case "1":
			return "bar";
		case "2":
			return "areaChart";
		case "3":
			return "bubble";
		case "4":
			return "scatter";
		default:
			return "hello";

		}

	}
}