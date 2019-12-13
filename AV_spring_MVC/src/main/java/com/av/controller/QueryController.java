package com.av.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.av.model.QueryDetails;
import com.av.model.QueryPair;
import com.av.model.QueryData;
import com.av.service.QueryService;

@Controller
public class QueryController {
	
	@Autowired
	private QueryService queryService;
	
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public ResponseEntity<QueryPair> userDetails() {
String r="";
QueryPair data = queryService.getQueryData(r);
		return new ResponseEntity<QueryPair>(data, HttpStatus.OK);
	}

}

