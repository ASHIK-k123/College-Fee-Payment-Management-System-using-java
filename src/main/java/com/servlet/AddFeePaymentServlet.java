package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import com.dao.*;
import com.model.*;

public class AddFeePaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {

            // 🔹 Get parameters safely
            String sid = req.getParameter("studentId");
            String name = req.getParameter("studentName");
            String date = req.getParameter("paymentDate");
            String amt = req.getParameter("amount");
            String status = req.getParameter("status");

            // 🔥 Server-side validation 
            if (sid == null || name == null || date == null || amt == null ||
                sid.isEmpty() || name.isEmpty() || date.isEmpty() || amt.isEmpty()) {

                res.sendRedirect("error.jsp");
                return;
            }

            int studentId = Integer.parseInt(sid);
            double amount = Double.parseDouble(amt);

            if (amount <= 0) {
                res.sendRedirect("error.jsp");
                return;
            }

            // 🔹 Set model
            FeePayment f = new FeePayment();
            f.setStudentId(studentId);
            f.setStudentName(name);
            f.setPaymentDate(date);
            f.setAmount(amount);
            f.setStatus(status);

            // 🔹 Insert into DB
            FeePaymentDAO dao = new FeePaymentDAO();
            dao.add(f);

            // 🔹 Success
            req.getRequestDispatcher("success.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp"); // cleaner than printing error
        }
    }
}