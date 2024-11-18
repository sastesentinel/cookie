<%-- 
    Document   : newjsp
    Created on : 14-Oct-2024, 7:33:24 pm
    Author     : MISAREE
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*, javax.servlet.http.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visitor Page</title>
    </head>
    <body>
        <%
            // Check if the user has a name cookie
            Cookie[] cookies = request.getCookies();
            String storedName = null;

            // Search for the 'username' cookie
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (cookie.getName().equals("username")) {
                        storedName = cookie.getValue();
                    }
                }
            }

            String inputName = request.getParameter("name");

            if (inputName != null) {
                // If the user entered a name
                if (storedName != null && storedName.equals(inputName)) {
                    // If the entered name matches the cookie, greet the user
                    out.println("<h1>Welcome back, " + inputName + "!</h1>");
                } else {
                    // If the entered name is different or no cookie exists, store the new name in a cookie
                    Cookie nameCookie = new Cookie("username", inputName);
                    nameCookie.setMaxAge(60*60*24*30); // Cookie lasts for 30 days
                    response.addCookie(nameCookie);
                    out.println("<h1>Thank you, " + inputName + "!</h1>");
                    out.println("<p>Your name has been stored for future visits.</p>");
                }
            } else {
                // If no name has been entered yet, prompt for the name
        %>
                <h1>Welcome, please enter your name</h1>
                <form method="POST" action="newjsp.jsp">
                    <label for="name">Enter your name:</label>
                    <input type="text" id="name" name="name" required>
                    <button type="submit">Submit</button>
                </form>
        <%
            }
        %>
    </body>
</html>
