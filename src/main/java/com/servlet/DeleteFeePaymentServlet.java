package com.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import com.dao.FeePaymentDAO;

public class DeleteFeePaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String pid = req.getParameter("paymentId");

            // 🔥 Server-side validation 
            if (pid == null || pid.isEmpty()) {
                res.sendRedirect("error.jsp");
                return;
            }

            int id = Integer.parseInt(pid);

            if (id <= 0) {
                res.sendRedirect("error.jsp");
                return;
            }

            FeePaymentDAO dao = new FeePaymentDAO();
            dao.delete(id);

            // ✅ Redirect after delete
            res.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp");
        }
    }
}