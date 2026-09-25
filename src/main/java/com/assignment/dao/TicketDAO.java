package com.assignment.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.assignment.model.Ticket;
import com.assignment.model.User;
import com.assignment.util.HibernateUtil;

public class TicketDAO {

    private SessionFactory factory;

    public TicketDAO() {
        factory = HibernateUtil.getSessionFactory();
    }

    // Create ticket
    public void saveTicket(Ticket ticket) {

        Session session = null;

        try {

            session = factory.openSession();

            session.beginTransaction();

            session.persist(ticket);

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


    // Get ticket by ID
    public Ticket getTicket(int id) {

        Session session = null;

        try {

            session = factory.openSession();

            return session.get(Ticket.class, id);

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }


    // Get all tickets
    public List<Ticket> getAllTickets() {

        Session session = null;

        try {

            session = factory.openSession();

            Query<Ticket> query =
                    session.createQuery(
                        "FROM Ticket ORDER BY createdAt DESC",
                        Ticket.class
                    );

            return query.getResultList();

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }


    // Get tickets created by a student
    public List<Ticket> getTicketsByStudent(int studentId) {

        Session session = null;

        try {

            session = factory.openSession();

            Query<Ticket> query =
                    session.createQuery(
                        "FROM Ticket WHERE student.id = :studentId ORDER BY createdAt DESC",
                        Ticket.class
                    );

            query.setParameter("studentId", studentId);

            return query.getResultList();

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }


    // Get tickets assigned to staff
    public List<Ticket> getTicketsByStaff(int staffId) {

        Session session = null;

        try {

            session = factory.openSession();

            Query<Ticket> query =
                    session.createQuery(
                        "FROM Ticket WHERE assignedStaff.id = :staffId ORDER BY createdAt DESC",
                        Ticket.class
                    );

            query.setParameter("staffId", staffId);

            return query.getResultList();

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }


    // Update ticket
    public void updateTicket(Ticket ticket) {

        Session session = null;

        try {

            session = factory.openSession();

            session.beginTransaction();

            session.merge(ticket);

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


    // Get all staff users
    public List<User> getStaffUsers() {

        Session session = null;

        try {

            session = factory.openSession();

            Query<User> query =
                    session.createQuery(
                        "FROM User WHERE role = :role",
                        User.class
                    );

            query.setParameter("role", "STAFF");

            return query.getResultList();

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }
}