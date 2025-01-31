/**
 * 
 */
package com.av.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.av.dao.QueryDao;
import com.av.model.QueryDetails;
import com.av.model.QueryData;
import com.av.service.QueryService;
import com.av.model.QueryPair;
@Service
public class QueryServiceImpl implements QueryService {
	
	@Autowired
	private QueryDao queryDao;

	public QueryPair getQueryData(String r_id) {
		return queryDao.getQueryData( r_id);

	}
	public List<QueryDetails> getQueryList() {
		return queryDao.getQueryList();

	}
	
public void insert(QueryDetails queryDetails){
	
	queryDao.insert( queryDetails);
}
@Override
public QueryPair  getPredictData(String r_id) {
	// TODO Auto-generated method stub
	return queryDao.getPredictData( r_id);

}

public List<String> getColumnList(String table){
	
	return queryDao.getColumnList(table);
	
}
public List<String> getTableList() {
	return queryDao.getTableList();
}
public  List<String> getFK(List<String> tables) {
	return queryDao.getFK(tables);
}
@Override
public QueryDetails getQueryDetails(int r_id) {
	// TODO Auto-generated method stub
	return queryDao.getQueryDetails( r_id);
}
@Override
public List<Integer> getPredictionList() {
	// TODO Auto-generated method stub
	return queryDao.getPredictionList();
}
}
