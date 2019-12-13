package com.av.dao;

import java.util.List;

import com.av.model.QueryDetails;
import com.av.model.QueryData;
import com.av.model.QueryPair;


public interface QueryDao {
	
	QueryPair getQueryData(String r_id);
	List<QueryDetails> getQueryList();
//	int setQuery(QueryDetails queryDetails);
	int insert(QueryDetails queryDetails);
	QueryPair getPredictData(String r_id);
}
