<%@ page import="java.sql.*"%>
<%
   String userName = request.getParameter("userName");    
    String password = request.getParameter("password");
    String firstName = request.getParameter("firstName");
    String lastName = request.getParameter("lastName");
    String email = request.getParameter("email");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://my-mysql:3306/cicd","root", "password");
    Statement st = con.createStatement();
    int i = st.executeUpdate("insert into USER_DETAILS(firstname, lastname, email, username, password, lastupdated) values ('" + firstName + "','"
    + lastName + "','" + email + "','" + userName + "','" + password + "', CURDATE())");
    if (i > 0) {
        response.sendRedirect("landingPage.jsp");
        
    } else {
        response.sendRedirect("index.jsp");
    }
%>
