package com.av.model;

import com.av.model.QueryDetails;

import java.util.List;

import com.av.model.QueryData;

public class QueryPair {

	private List<QueryData> queryData;
	private QueryDetails queryDetails;
	public QueryPair(List<QueryData> queryData, QueryDetails queryDetails) {
		super();
		this.queryData = queryData;
		this.queryDetails = queryDetails;
	}
	public List<QueryData> getQueryData() {
		return queryData;
	}
	public void setQueryData(List<QueryData> queryData) {
		this.queryData = queryData;
	}
	public QueryDetails getQueryDetails() {
		return queryDetails;
	}
	public void setQueryDetails(QueryDetails queryDetails) {
		this.queryDetails = queryDetails;
	}
	
	
	
	
	
}
