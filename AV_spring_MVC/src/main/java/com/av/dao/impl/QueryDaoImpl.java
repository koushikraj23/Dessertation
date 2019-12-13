package com.av.dao.impl;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.transform.Transformers;
import org.hibernate.type.FloatType;
import org.hibernate.type.IntegerType;
import org.hibernate.type.StringType;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Component;

import com.av.dao.QueryDao;
import com.av.model.PredictData;
import com.av.model.QueryData;
import com.av.model.QueryDetails;
import com.av.model.QueryPair;
import com.av.service.QueryService;
import javax.persistence.EntityManagerFactory;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.sql.DataSource;

@Component
public class QueryDaoImpl implements QueryDao {

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	@SuppressWarnings("deprecation")
	public List<QueryDetails> getQueryList() {
		Session session = entityManagerFactory.unwrap(SessionFactory.class).openSession();

		Transaction tx = session.beginTransaction();
		@SuppressWarnings("rawtypes")
		
		
		String queryString="SELECT id ,title,sql_query, col_no,col_name,col_type FROM querytable ;";
		

	
		SQLQuery query = session.createSQLQuery(queryString);
		
		List<QueryDetails> queryDetails = (List<QueryDetails>) query
				.setResultTransformer(Transformers.aliasToBean(QueryDetails.class)).list();
		
		session.close();
	
	
		
		
//		List<QueryData> result = new ArrayList<QueryData>();
		
		
		
		
		return queryDetails;
	}
	
	@SuppressWarnings("deprecation")
	public QueryPair getQueryData(String r_id) {
		Session session = entityManagerFactory.unwrap(SessionFactory.class).openSession();
		
//		String qry = "SELECT password as Col_1,firstName as Col_2,LastName as Col_3 FROM userdetails;";
//		SQLQuery sqlQuery = session.createSQLQuery(qry);
//
//		sqlQuery.addEntity(QueryData.class);
//
//		List list = sqlQuery.list();
		Transaction tx = session.beginTransaction();
		@SuppressWarnings("rawtypes")
		
		
		String queryString="SELECT id ,title,sql_query, col_no,col_name,col_type FROM querytable where id="+r_id+";";
		

	
		SQLQuery query = session.createSQLQuery(queryString);
		
		QueryDetails queryDetails = (QueryDetails) query
				.setResultTransformer(Transformers.aliasToBean(QueryDetails.class)).uniqueResult();
		System.out.println(queryDetails.getSql_query());
	
		 query = session.createSQLQuery(queryDetails.getSql_query());

		@SuppressWarnings("deprecation")
	//	query.addEntity(QueryData.class);
		
		List<QueryData> result = (List<QueryData>) query
		.setResultTransformer(Transformers.aliasToBean(QueryData.class))
.list();
		

		session.disconnect();

		
		
//		List<QueryData> result = new ArrayList<QueryData>();
		
		QueryPair queryPair=new QueryPair(result, queryDetails);
		
		return queryPair;
	}
	 SimpleJdbcInsert simpleJdbcInsert;
	 
	    @Autowired
	    public void MessageRepositorySimpleJDBCInsert(DataSource dataSource) {
	        simpleJdbcInsert = new SimpleJdbcInsert(dataSource)
	          .withTableName("querytable").usingGeneratedKeyColumns("id");
	    }
	    
	    public int insert(QueryDetails queryDetails) {
	        Map<String, Object> parameters = new HashMap<>(1);
//	        parameters.put("id", queryDetails.getId());
	        parameters.put("col_name", queryDetails.getCol_name());
	        parameters.put("col_no", queryDetails.getCol_no());
	        parameters.put("col_type", queryDetails.getCol_type());
	        parameters.put("sql_query", queryDetails.getSql_query());
	        parameters.put("title", queryDetails.getTitle());
	  
	        Number newId = simpleJdbcInsert.executeAndReturnKey(parameters);
	        
	        int a=((BigInteger) newId).intValue();
	        System.out.println(a);
	        return (int) a;
	    }

		@Override
		public QueryPair getPredictData(String r_id) {
			Session session = entityManagerFactory.unwrap(SessionFactory.class).openSession();

			Transaction tx = session.beginTransaction();
			@SuppressWarnings("rawtypes")
			
			
			String queryString="SELECT id ,sql_id,p_dates, p_values,IFNULL(p_values_2,0) as p_values_2,IFNULL(p_values_3,0) as p_values_3,IFNULL(p_values_4,0) as p_values_4,IFNULL(p_values_5,0) as p_values_5 FROM prediction where id=5 ;";
			

		
			SQLQuery query = session.createSQLQuery(queryString);
			
			PredictData predict = (PredictData) query
					.setResultTransformer(Transformers.aliasToBean(PredictData.class)).uniqueResult();
			
			
			 queryString="SELECT id ,title,sql_query, col_no,col_name,col_type FROM querytable where id="+r_id+";";
			

			
			 query = session.createSQLQuery(queryString);
			
			QueryDetails queryDetails = (QueryDetails) query
					.setResultTransformer(Transformers.aliasToBean(QueryDetails.class)).uniqueResult();
			
			List<QueryData> result = new ArrayList<QueryData>();
			
			List<String> dates = Arrays.asList(predict.getP_dates().split("\\s*,\\s*"));
			List<String> datas = null,datas2= null,datas3= null,datas4= null,datas5=null;
			if(predict.getP_values()!="0") {
			 datas = Arrays.asList(predict.getP_values().split("\\s*,\\s*"));
			
			}
			
			 if(!predict.getP_values_2().equalsIgnoreCase("0")) {
				datas2 = Arrays.asList(predict.getP_values_2().split("\\s*,\\s*"));}
			
			 if(!predict.getP_values_3().equalsIgnoreCase("0")) {
				datas3 = Arrays.asList(predict.getP_values_3().split("\\s*,\\s*"));}
			
			 if(!predict.getP_values_4().equalsIgnoreCase("0")) {
				 datas4 = Arrays.asList(predict.getP_values_4().split("\\s*,\\s*"));}
			
			 if(!predict.getP_values_5().equalsIgnoreCase("0")) {
				datas5 = Arrays.asList(predict.getP_values_5().split("\\s*,\\s*"));}
		
			for(int i=0;i<dates.size();i++) {
				 QueryData q= new QueryData();
				 q.setId(predict.getSql_id());
				 q.setCol_1(dates.get(i));
				 if(!predict.getP_values().equalsIgnoreCase("0")) {
				 q.setD2(Double.valueOf(datas.get(i)).longValue());
				 }
				 if(!predict.getP_values_2().equalsIgnoreCase("0")) {
					 
					 q.setD3(Double.valueOf(datas2.get(i)).longValue());
					 }
				 if(!predict.getP_values_3().equalsIgnoreCase("0")) {
					 q.setD4(Double.valueOf(datas3.get(i)).longValue());
					 }
				 if(!predict.getP_values_4().equalsIgnoreCase("0")) {
					 q.setD5(Double.valueOf(datas4.get(i)).longValue());
					 }
				 if(!predict.getP_values_5().equalsIgnoreCase("0")) {
					 q.setD6(Double.valueOf(datas5.get(i)).longValue());
					 }
				 System.out.println(q);
				 result.add(q);
			}
			session.close();
		
		
			
			
//			List<QueryData> result = new ArrayList<QueryData>();
			
			
			
			
			QueryPair predictPair=new QueryPair(result, queryDetails);
			
			return predictPair;	
			
		}

	
	     
//	@Override
//	public int setQuery(QueryDetails queryDetails) {
//		// TODO Auto-generated method stub
//		 SimpleJdbcInsert jdbcInsert;
//		jdbcInsert = new SimpleJdbcInsert(dataSource).withTableName("Student");
//		Map<String,Object> parameters = new HashMap<String,Object>();
//
//		parameters.put("name", name);
//		parameters.put("age", age);
//		jdbcInsert.execute(parameters);
//		
//		KeyHolder holder = new GeneratedKeyHolder();
//		SqlParameterSource parameters = new MapSqlParameterSource()
//				.addValue("name", user.getName())
//				.addValue("address", user.getAddress())
//				.addValue("email", user.getEmail());
//		namedParameterJdbcTemplate.update(INSERT_SQL, parameters, holder);
//		user.setId(holder.getKey().intValue());
//		return 0;
//
//		return 0;
//	}


}
