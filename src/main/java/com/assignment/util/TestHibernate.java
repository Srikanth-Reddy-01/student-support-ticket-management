package com.assignment.util;

import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class TestHibernate {

    public static void main(String[] args) {

        SessionFactory factory = null;
        Session session = null;

        try {

            factory = HibernateUtil.getSessionFactory();

            session = factory.openSession();

            System.out.println("=================================");
            System.out.println("Hibernate connected successfully!");
            System.out.println("=================================");

        } catch (Exception e) {

            e.printStackTrace();

        } finally {

            if (session != null) {
                session.close();
            }

            if (factory != null) {
                factory.close();
            }
        }
    }
}