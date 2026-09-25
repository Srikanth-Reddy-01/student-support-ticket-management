package com.assignment.dao;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.query.Query;

import com.assignment.model.Ticket;
import com.assignment.model.TicketActivity;
import com.assignment.model.User;
import com.assignment.util.HibernateUtil;

public class TicketActivityDAO {

    private SessionFactory factory;

    public TicketActivityDAO() {
        factory = HibernateUtil.getSessionFactory();
    }

    // Save activity
    public void saveActivity(TicketActivity activity) {

        Session session = null;

        try {
            session = factory.openSession();

            session.beginTransaction();

            session.persist(activity);

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


    // Get activity history for a ticket
    public List<TicketActivity> getActivitiesByTicket(int ticketId) {

        Session session = null;

        try {

            session = factory.openSession();

            Query<TicketActivity> query =
                session.createQuery(
                    "FROM TicketActivity " +
                    "WHERE ticket.id = :ticketId " +
                    "ORDER BY createdAt DESC",
                    TicketActivity.class
                );

            query.setParameter("ticketId", ticketId);

            return query.getResultList();

        } finally {

            if (session != null) {
                session.close();
            }
        }
    }
}