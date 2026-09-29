package com.assignment.dao;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.assignment.model.User;
import com.assignment.util.HibernateUtil;

public class UserDAO {

    private SessionFactory factory;

    public UserDAO() {
        factory = HibernateUtil.getSessionFactory();
    }

    // Save user
    public void saveUser(User user) {

        Session session = null;

        try {

            session = factory.openSession();

            session.beginTransaction();

            session.persist(user);

            session.getTransaction().commit();

        } catch (Exception e) {

            e.printStackTrace();

            if (session != null &&
                session.getTransaction().isActive()) {

                session.getTransaction().rollback();
            }

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }

    // Login
    public User login(String email, String password) {

        Session session = null;

        try {

            session = factory.openSession();

            String hql =
                "FROM User WHERE email = :email AND password = :password";

            Query<User> query =
                session.createQuery(hql, User.class);

            query.setParameter("email", email);
            query.setParameter("password", password);

            return query.uniqueResult();

        } catch (Exception e) {

            e.printStackTrace();
            return null;

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }

    // Get user by ID
    public User getUserById(int id) {

        Session session = null;

        try {

            session = factory.openSession();

            return session.get(User.class, id);

        } catch (Exception e) {

            e.printStackTrace();
            return null;

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }

    // Check whether email already exists
    public boolean emailExists(String email) {

        Session session = null;

        try {

            session = factory.openSession();

            String hql =
                "SELECT COUNT(u) FROM User u WHERE u.email = :email";

            Long count =
                session.createQuery(hql, Long.class)
                       .setParameter("email", email)
                       .uniqueResult();

            return count != null && count > 0;

        } catch (Exception e) {

            e.printStackTrace();
            return false;

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }
}