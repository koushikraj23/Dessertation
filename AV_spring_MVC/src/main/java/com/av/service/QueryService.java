/**
 * 
 */
package com.av.service;

import java.util.List;

import com.av.model.QueryDetails;
import com.av.model.QueryPair;
import com.av.model.QueryData;

public interface QueryService {

	QueryPair getQueryData(String r_id);
	List<QueryDetails> getQueryList() ;
	void insert(QueryDetails queryDetails);
	QueryPair  getPredictData(String r_id);
	List<String> getColumnList(String table);
	List<String> getTableList();
	List<String> getFK(List<String> table); 
}
