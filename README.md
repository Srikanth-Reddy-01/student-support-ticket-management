# Student Support & Ticket Management System

## 1. Project Overview

The Student Support & Ticket Management System is a web-based application for managing student support requests such as technical issues, fees, attendance, ID cards, documents, certificates, and other student services.

The system provides separate workflows for Students, Support Staff, and Managers.

### Main Workflow

Student raises a ticket → Staff processes and manages the ticket → Manager monitors tickets, SLA and ageing.

---

## 2. Key Features

### Student
- Login
- Create support tickets
- Select category and priority
- View submitted tickets
- Track ticket status

### Support Staff
- View all support tickets
- View assigned tickets
- Assign tickets to staff
- Update ticket status
- Add/update resolution details
- View SLA status
- View ticket activity history

### Manager
- View overall ticket statistics
- Monitor Open, In Progress, Pending and Resolved tickets
- Monitor overdue tickets
- View ticket assignment
- Monitor SLA status

### Activity History
The system records important ticket activities such as:
- Ticket assignment
- Status changes
- Resolution updates

---

## 3. Technology Stack

- Java 21
- Jakarta Servlets
- JSP
- Hibernate ORM 6.6.1
- PostgreSQL
- Maven
- Apache Tomcat 10.1.36
- HTML
- CSS
- JavaScript
- MVC Architecture

---

## 4. Architecture

The application follows an MVC-based layered architecture.

```text
Browser
   |
   v
JSP / HTML / CSS
   |
   v
Servlet Controllers
   |
   v
Service Layer
   |
   v
DAO Layer
   |
   v
Hibernate ORM
   |
   v
PostgreSQL