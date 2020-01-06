
package com.av;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import javax.persistence.EntityManagerFactory;

import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.transform.Transformers;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.av.model.QueryDetails;
@EnableScheduling
@SpringBootApplication
public class Test {
	private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(3); 
    // ScheduledExecutorService created with 3 threads
 private static EntityManagerFactory entityManagerFactory;
    @SuppressWarnings("rawtypes")
     
  
    public static void main(String[] args) throws IOException, InterruptedException {

        SpringApplication.run(Test.class, args);
        
    }

}