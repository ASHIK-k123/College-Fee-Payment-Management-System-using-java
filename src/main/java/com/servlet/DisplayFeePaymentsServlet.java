package com.servlet;

import java.io.IOException;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

public class DisplayFeePaymentsServlet extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {

            FeePaymentDAO dao = new FeePaymentDAO();

            String search = req.getParameter("search");
            List<FeePayment> list;

            // 🔍 Search handling
            if (search != null && !search.trim().isEmpty()) {
                list = dao.searchByName(search.trim());
            } else {
                list = dao.getAll();
            }

            // Set data
            req.setAttribute("list", list);

            double total = dao.getTotalCollection();
            req.setAttribute("total", total);

            RequestDispatcher rd = req.getRequestDispatcher("feepaymentdisplay.jsp");
            rd.forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("error.jsp"); // clean handling
        }
    }
}