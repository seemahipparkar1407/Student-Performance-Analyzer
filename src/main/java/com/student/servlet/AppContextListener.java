package com.student.servlet;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;

@WebListener
public class AppContextListener implements ServletContextListener {

	@Override
	public void contextInitialized(ServletContextEvent sce) {
		// Runs when your web app starts up
	}

	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// Runs when your web app stops or reloads
		try {
			// Explicitly tear down the MySQL background cleanup thread
			AbandonedConnectionCleanupThread.checkedShutdown();
			System.out.println("MySQL AbandonedConnectionCleanupThread stopped successfully.");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
