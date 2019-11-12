//package com.av;
//import java.util.Date;
//
//import org.hibernate.SessionFactory;
//import org.hibernate.jpa.HibernateEntityManagerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.CommandLineRunner;
//import org.springframework.boot.SpringApplication;
//import org.springframework.boot.autoconfigure.SpringBootApplication;
//import org.springframework.boot.autoconfigure.domain.EntityScan;
//import org.springframework.boot.builder.SpringApplicationBuilder;
//import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.ComponentScan;
//import org.springframework.data.jpa.repository.config.EnableJpaRepositories;
//
//import com.model.Employee;
//import com.util.HibernateUtilConfig;
//
//@SpringBootApplication
////@ComponentScan({"com.dao.EmployeeDao"})
//@EntityScan("com.model.Employee")
//@EnableJpaRepositories("com.dao.EmployeeDao")
//public class Test implements CommandLineRunner{
//
//	@Autowired
//	private EmployeeDao employeeDao;
//
//	public static void main(String[] args) {
//		
//		SpringApplication.run(Test.class, args);
//	}
//	
//	@Override
//	public void run(String... args) throws Exception {
//		Employee employee = getEmployee();
//		employeeDao.createEmployee(employee);
//	}
//	private Employee getEmployee() {
//		Employee employee= new  Employee();
//		employee.setName("Sean Murphy");
//		employee.setSalary(80000.00);
//		employee.setDoj(new Date());
//		return employee;
//	}
//}
//
//

//
//@SpringBootApplication
//public class Test  extends SpringBootServletInitializer {
//	private EmployeeDao employeeDao;
////    @Override
////    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
////        return application.sources(Test.class);
////    }
////	
////	  public static void main(String[] args) {
////	        SpringApplication.run(Test.class, args);
////	    }
//
//
//}
package com.av;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Test {

    public static void main(String[] args) {
        SpringApplication.run(Test.class, args);
    }

}