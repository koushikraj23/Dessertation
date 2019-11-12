package com.av.dao.impl;

import java.util.List;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.av.dao.UserDao;
import com.av.model.data;

import javax.persistence.EntityManagerFactory;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

@Component
public class UserDaoImpl implements UserDao {

	@Autowired
	private EntityManagerFactory entityManagerFactory;

	public List getUserDetails() {
		Session session = entityManagerFactory.unwrap(SessionFactory.class).openSession();
		
		
		
		Transaction tx = session.beginTransaction();
		SQLQuery query = session.createSQLQuery("SELECT id,firstName,LastName FROM userdetails;");
		@SuppressWarnings("deprecation")
		List<Object[]> rows = query.list();
		for(Object[] row : rows){
			data emp = new data();
			emp.setCol_1("1");
			emp.setCol_2(row[1].toString());
			emp.setCol_3(row[2].toString());
			System.out.println(emp);
		}
//		CriteriaBuilder builder = session.getCriteriaBuilder();
//		CriteriaQuery criteria = builder.createQuery("SELECT `userdetails`.`id`,\n" + 
//				"    `userdetails`.`firstName`,\n" + 
//				"    `userdetails`.`LastName`,\n" + 
//				"    `userdetails`.`email`,\n" + 
//				"    `userdetails`.`password`\n" + 
//				"FROM `sys`.`userdetails`;");
//		Root contactRoot = criteria.from(UserDetails.class);
//		criteria.select(contactRoot);
//		return session.createQuery(criteria).getResultList();
		return rows;
	}

}
