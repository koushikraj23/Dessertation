
package com.av;

import java.io.IOException;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import java.util.concurrent.TimeUnit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Test {
	private static final ScheduledExecutorService scheduler = Executors.newScheduledThreadPool(3); 
    // ScheduledExecutorService created with 3 threads
 
    @SuppressWarnings("rawtypes")
    public static void beepForAnHour() {
         
        final Runnable beeper = new Runnable() {
            public void run() { 
            	try {
            			
            	String command = "C:\\Users\\91984\\Anaconda3\\pythonw.exe F:\\Dessertation\\Time_series\\fits\\lstm.py 2";
					Process p = Runtime.getRuntime().exec(command  );
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

                System.out.println("Raj :: " + new Date() ); }
        }; // Creating a new runnable task which will be passed as an argument to scheduler 
         
        ScheduledFuture beeperHandleAtFixedRate = scheduler.scheduleAtFixedRate(beeper, 1, 35,TimeUnit.MINUTES);
        // Creates and executes a ScheduledFuture that becomes enabled after 5 seconds and gets executed with fixed rate of 5 seconds
         
       
//        scheduler.schedule(new Runnable() {
//            public void run() { beeperHandleAtFixedRate.cancel(true); } // Attempts to cancel execution of task beeperHandleAtFixedRate after one hour
//        }, 60 * 60, TimeUnit.MINUTES); // Creates and executes a one-shot action that becomes enabled after the given delay.
//         
// 
    }
     
  
    public static void main(String[] args) {
    	  beepForAnHour();
        SpringApplication.run(Test.class, args);
    }

}