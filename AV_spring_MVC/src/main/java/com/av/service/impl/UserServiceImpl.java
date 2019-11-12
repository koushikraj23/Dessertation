/**
 * 
 */
package com.av.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.av.dao.UserDao;
import com.av.model.UserDetails;
import com.av.model.data;
import com.av.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	
	@Autowired
	private UserDao userDao;

	public List<data> getUserDetails() {
		return userDao.getUserDetails();

	}

}
