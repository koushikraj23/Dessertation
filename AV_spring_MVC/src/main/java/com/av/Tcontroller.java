package com.av;

import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.stream.Collectors;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.av.model.QueryDetails;
import com.av.model.QueryPair;
import com.av.model.QueryData;
import com.av.service.QueryService;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONString;
@Controller

public class Tcontroller {
	@Autowired
	private QueryService queryService;
	@GetMapping({ "/graph" })
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	ResponseEntity<List<data>> 
	public String QueryDetails( Model model, @RequestParam(value = "type", required = false, defaultValue = "0") String type,@RequestParam(value = "r_id", required = false, defaultValue = "1") String r_id) {
        
		List<QueryDetails> queryList = queryService.getQueryList();
		QueryPair data = queryService.getQueryData(r_id);
		model.addAttribute("list", queryList);
		model.addAttribute("data", data);

		switch (type) {
		case "1":
			return "bar";
		case "2":
			return "areaChart";
		case "3":
			return "bubble";
		case "4":
			return "scatter";
		case "5":
			return "histrogram";
		case "6":
			return "column";
		case "7":
			return "pie";
		case "8":
			return "donut";
		default:
			return "table";

		}

	}
	
	
	@GetMapping({ "/predict" })
//	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	ResponseEntity<List<data>> 
	public String PredictDetails( Model model, @RequestParam(value = "type", required = false, defaultValue = "0") String type,@RequestParam(value = "r_id", required = false, defaultValue = "1") String r_id) {
     
		QueryPair   predict=queryService.getPredictData(r_id);
		//QueryPair pr =new QueryPair(predict, data.getQueryDetails());
	
		model.addAttribute("data", predict);

		switch (type) {
		case "1":
			return "bar";
		case "2":
			return "areaChart";
		case "3":
			return "bubble";
		case "4":
			return "scatter";
		case "5":
			return "histrogram";
		case "6":
			return "column";
		case "7":
			return "pie";
		case "8":
			return "donut";
		default:
			return "table";

		}

	}
	

	   @GetMapping("/graphs")
	    public String graphPage(Model model, @RequestParam(value = "type", required = false, defaultValue = "0") String type,@RequestParam(value = "r_id", required = false, defaultValue = "1") String r_id) {
	       model.addAttribute("id",r_id);
	       model.addAttribute("type",type);
	        return "graphPage";
	    }
	   @GetMapping("/predicts")
	    public String predictPage(Model model, @RequestParam(value = "type", required = false, defaultValue = "0") String type,@RequestParam(value = "r_id", required = false, defaultValue = "1") String r_id) {
	       model.addAttribute("id",r_id);
	       model.addAttribute("type",type);
	        return "predictPage";
	    }
	   @GetMapping("/")
	    public String homePage(Model model) {
			List<String> result = queryService.getTableList();
			model.addAttribute("table", result);
	        return "index";
	    }
	   @GetMapping("/addquery")
	    public String addquery(Model model) {
			List<String> result = queryService.getTableList();
			model.addAttribute("table", result);
	        return "addquery";
	    }
	      
	 @PostMapping("/saveDetails")
	  public ModelAndView queryAdd(@ModelAttribute QueryDetails queryDetails) {
		 
		 queryService.insert(queryDetails);
		 System.out.print(queryDetails.getSql_query());
//	    return "addquery";
		 return new ModelAndView("redirect:/");
	  }
	 
	 @GetMapping("/allQuery")
	  public String allqueryList( Model model) {
			List<QueryDetails> queryList = queryService.getQueryList();
			model.addAttribute("list", queryList);
			
	    return "allQueryList";
	  }
	 
	@GetMapping({ "/1", "/hi" })
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
	
	
	
	
	
	@PostMapping("/search")
    public ResponseEntity<?> getSearchResultViaAjax(
            @Valid @RequestBody String search, Errors errors) {

        List<String> result = queryService.getColumnList(search);


        return ResponseEntity.ok(result);

    }
	
	@PostMapping("/testing")
    public  ResponseEntity<?> getquery(
            @Valid @RequestBody String jsonObj, Errors errors) {
		JSONObject queryDetails = new JSONObject(jsonObj);
//		JSONObject json = (JSONObject) parser.parse(myObj);
		Iterator keys = queryDetails.keys();
		System.out.println(queryDetails);
		
		List<String> tableList = new ArrayList();
		
		while(keys.hasNext()) {
//		    // loop to get the dynamic key
		    String currentDynamicKey = (String)keys.next();
//		    // get the value of the dynamic key
		    JSONArray getArray =  queryDetails.getJSONArray(currentDynamicKey);
//		    JSONArray getArray = getObject.getJSONArray("JArray1");
		    System.out.println(currentDynamicKey);
		    tableList.add(currentDynamicKey);
		   /* for(int i = 0; i < getArray.length(); i++)
		    {
		          String objects = (String) getArray.get(i);
		        		  System.out.println(objects);
		          //Iterate through the elements of the array i.
		          //Get thier value.
		          //Get the value for the first element and the value for the last element.
		    }
*/
		}
		
		List<String> result=queryService.getFK(tableList);
		return ResponseEntity.ok(result);
    }
	
	
	
	
}
//package com.controller;

//import java.util.List;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.GetMapping;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//
//import com.av.model.UserDetails;
//import com.av.model.data;
//import com.av.service.UserService;

//@Controller
//public class Tcontroller {
//	
//	@Autowired
//	private UserService userService;
//	@GetMapping({ "/", "/hello" })
////	@RequestMapping(value = "/list", method = RequestMethod.GET)
//	public ResponseEntity<List<data>> userDetails() {
//        
//		List<data> data = userService.getUserDetails();
//		return new ResponseEntity<List<data>>(data, HttpStatus.OK);
//	}
//
//}
