package com.servlet;

import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/AddFeePaymentServlet")
public class AddFeePaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String name = req.getParameter("studentName");
            String department = req.getParameter("department");
            String amt = req.getParameter("amount");
            String status = req.getParameter("status");

            if (name == null || department == null || amt == null ||
                name.trim().isEmpty() || department.trim().isEmpty() || amt.trim().isEmpty()) {
                req.setAttribute("errorMsg", "All fields (Student Name, Department, Amount) are required!");
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
                return;
            }

            // Validate Student Name
            String trimmedName = name.trim();
            if (!trimmedName.matches("^[A-Za-z\\s]{2,50}$")) {
                req.setAttribute("errorMsg", "Student name must be 2-50 characters and contain only letters and spaces!");
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
                return;
            }
            
            // Validate Department
            String trimmedDept = department.trim();
            if (trimmedDept.length() < 2 || trimmedDept.length() > 50) {
                req.setAttribute("errorMsg", "Department must be between 2 and 50 characters!");
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
                return;
            }

            // Validate Amount
            double amount;
            try {
                amount = Double.parseDouble(amt);
            } catch (NumberFormatException e) {
                req.setAttribute("errorMsg", "Invalid amount format!");
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
                return;
            }

            if (amount < 100) {
                req.setAttribute("errorMsg", "Amount must be at least ₹100!");
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
                return;
            }
            
            if (amount > 500000) {
                req.setAttribute("errorMsg", "Amount cannot exceed ₹500,000!");
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
                return;
            }

            FeePayment f = new FeePayment();
            f.setStudentName(trimmedName);
            f.setDepartment(trimmedDept);
            f.setPaymentDate(LocalDate.now().toString()); // Auto-set to current date
            f.setAmount(amount);
            f.setStatus(status != null ? status : "Pending");

            FeePaymentDAO dao = new FeePaymentDAO();
            String result = dao.add(f);
            
            if (result.startsWith("SUCCESS")) {
                req.setAttribute("successMsg", result);
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
            } else {
                req.setAttribute("errorMsg", result.replace("ERROR: ", ""));
                req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Something went wrong! Please try again.");
            req.getRequestDispatcher("feepaymentadd.jsp").forward(req, res);
        }
    }
}