package com.servlet;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

public class UpdateFeePaymentServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {

            String pid = req.getParameter("paymentId");
            String amt = req.getParameter("amount");
            String status = req.getParameter("status");

            // 🔥 Server-side validation
            if (pid == null || amt == null || status == null ||
                pid.isEmpty() || amt.isEmpty() || status.isEmpty()) {

                res.sendRedirect("error.jsp");
                return;
            }

            int paymentId = Integer.parseInt(pid);
            double amount = Double.parseDouble(amt);

            if (paymentId <= 0 || amount <= 0) {
                res.sendRedirect("error.jsp");
                return;
            }

            // 🔹 Set model
            FeePayment f = new FeePayment();
            f.setPaymentId(paymentId);
            f.setAmount(amount);
            f.setStatus(status);

            // 🔹 Update
            FeePaymentDAO dao = new FeePaymentDAO();
            dao.update(f);

            res.sendRedirect("index.jsp");

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp");
        }
    }
}