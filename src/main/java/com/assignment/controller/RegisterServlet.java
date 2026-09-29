package com.assignment.controller;

import java.io.IOException;

import com.assignment.dao.UserDAO;
import com.assignment.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private UserDAO userDAO;

    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        // Basic validation
        if (name == null || name.isBlank()
                || email == null || email.isBlank()
                || password == null || password.isBlank()
                || confirmPassword == null || confirmPassword.isBlank()) {

            response.sendRedirect("register.jsp?error=1");
            return;
        }

        name = name.trim();
        email = email.trim();

        // Check password confirmation
        if (!password.equals(confirmPassword)) {
            response.sendRedirect("register.jsp?error=1");
            return;
        }

        // Check minimum password length
        if (password.length() < 6) {
            response.sendRedirect("register.jsp?error=1");
            return;
        }

        try {

            // Check duplicate email
            if (userDAO.emailExists(email)) {
                response.sendRedirect("register.jsp?error=exists");
                return;
            }

            User user = new User();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);

            // Self-registration is only allowed for students
            user.setRole("STUDENT");

            userDAO.saveUser(user);

            // Registration successful
            response.sendRedirect("login.jsp?registered=1");

        } catch (Exception e) {

            e.printStackTrace();

            response.sendRedirect("register.jsp?error=1");
        }
    }
}