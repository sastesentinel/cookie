<%@ page import="java.util.*" %>
<%
    // Get all the cookies associated with the request
    Cookie[] cookies = request.getCookies();
    String visitorName = null;
    
    // Check if there are any cookies present
    if (cookies != null) {
        for (Cookie cookie : cookies) {
            // Check if there is a cookie with the name "username"
            if (cookie.getName().equals("username")) {
                visitorName = cookie.getValue(); // Get the stored name from the cookie
                break;
            }
        }
    }

    // If visitorName is not null, that means the user has been here before
    if (visitorName != null) {
%>
        <h1>Welcome back, <%= visitorName %>!</h1>
<%
    } else {
        // This part will execute if the user is visiting the page for the first time or cookie is not found
        String nameFromForm = request.getParameter("username");

        // If the form was submitted and a name was provided
        if (nameFromForm != null && !nameFromForm.isEmpty()) {
            visitorName = nameFromForm;

            // Create a cookie with the name "username" and the value from the form
            Cookie userCookie = new Cookie("username", visitorName);

            // Set cookie expiration (optional), e.g., for 7 days
            userCookie.setMaxAge(60 * 60 * 24 * 7); // 7 days in seconds

            // Add the cookie to the response
            response.addCookie(userCookie);
%>
            <h1>Thank you, <%= visitorName %>! Your name has been saved.</h1>
<%
        } else {
            // Show a form to collect the visitor's name if it's their first time
%>
            <form method="POST" action="">
                <label for="username">Enter your name:</label>
                <input type="text" id="username" name="username">
                <input type="submit" value="Submit">
            </form>
<%
        }
    }
%>
