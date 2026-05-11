package com.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/DisplayFeePaymentsServlet")
public class DisplayFeePaymentsServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            FeePaymentDAO dao = new FeePaymentDAO();
            List<FeePayment> list;

            String search = req.getParameter("search");
            
            if (search != null && !search.trim().isEmpty()) {
                String searchTerm = search.trim();
                
                if (searchTerm.length() > 50) {
                    req.setAttribute("errorMsg", "Search term is too long!");
                    req.getRequestDispatcher("feepaymentdisplay.jsp").forward(req, res);
                    return;
                }
                
                list = dao.searchByName(searchTerm);
                req.setAttribute("searchValue", searchTerm);
            } else {
                list = dao.getAll();
            }

            if (list == null) {
                list = java.util.Collections.emptyList();
            }

            req.setAttribute("list", list);

            double total = 0;
            try {
                total = dao.getTotalCollection();
                if (total < 0) total = 0;
            } catch (Exception e) {
                total = 0;
            }
            req.setAttribute("total", total);
            
            double pendingAmount = 0;
            try {
                pendingAmount = dao.getPendingAmount();
                if (pendingAmount < 0) pendingAmount = 0;
            } catch (Exception e) {
                pendingAmount = 0;
            }
            req.setAttribute("pendingAmount", pendingAmount);
            
            req.setAttribute("count", list.size());

            req.getRequestDispatcher("feepaymentdisplay.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Unable to load data. Please try again.");
            req.setAttribute("list", java.util.Collections.emptyList());
            req.setAttribute("total", 0);
            req.setAttribute("count", 0);
            req.getRequestDispatcher("feepaymentdisplay.jsp").forward(req, res);
        }
    }
}