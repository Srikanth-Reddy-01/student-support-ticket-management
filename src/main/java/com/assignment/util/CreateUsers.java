package com.assignment.util;

import com.assignment.dao.UserDAO;
import com.assignment.model.User;

public class CreateUsers {

    public static void main(String[] args) {

        UserDAO dao = new UserDAO();

        User student = new User();
        student.setName("Student One");
        student.setEmail("student@gmail.com");
        student.setPassword("student123");
        student.setRole("STUDENT");

        dao.saveUser(student);


        User staff = new User();
        staff.setName("Staff One");
        staff.setEmail("staff@gmail.com");
        staff.setPassword("staff123");
        staff.setRole("STAFF");

        dao.saveUser(staff);


        User manager = new User();
        manager.setName("Manager One");
        manager.setEmail("manager@gmail.com");
        manager.setPassword("manager123");
        manager.setRole("MANAGER");

        dao.saveUser(manager);

        System.out.println("Users created successfully!");
    }
}