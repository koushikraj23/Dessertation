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
}
