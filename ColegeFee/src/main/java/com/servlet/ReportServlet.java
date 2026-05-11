package com.servlet;

import java.io.IOException;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        List<FeePayment> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String from = req.getParameter("fromDate");
            String to = req.getParameter("toDate");

            // ✅ Validation - Both dates are required
            if (from == null || to == null || from.trim().isEmpty() || to.trim().isEmpty()) {
                req.setAttribute("errorMsg", "Please select both From Date and To Date.");
                req.getRequestDispatcher("report_form.jsp").forward(req, res);
                return;
            }

            String fromDateTrimmed = from.trim();
            String toDateTrimmed = to.trim();
            
            // 🔒 Validate date format
            LocalDate fromDateObj = null;
            LocalDate toDateObj = null;
            
            try {
                fromDateObj = LocalDate.parse(fromDateTrimmed);
                toDateObj = LocalDate.parse(toDateTrimmed);
            } catch (Exception e) {
                req.setAttribute("errorMsg", "Invalid date format! Please use YYYY-MM-DD format.");
                req.getRequestDispatcher("report_form.jsp").forward(req, res);
                return;
            }
            
            // 🔒 Validate From Date is not after To Date
            if (fromDateObj.isAfter(toDateObj)) {
                req.setAttribute("errorMsg", "From Date cannot be greater than To Date.");
                req.getRequestDispatcher("report_form.jsp").forward(req, res);
                return;
            }
            
            // 🔒 Validate date range (Cannot exceed 1 year for performance)
            if (fromDateObj.plusYears(1).isBefore(toDateObj)) {
                req.setAttribute("errorMsg", "Date range cannot exceed 1 year. Please select a smaller range.");
                req.getRequestDispatcher("report_form.jsp").forward(req, res);
                return;
            }
            
            // 🔒 Validate To Date is not in the future
            LocalDate today = LocalDate.now();
            if (toDateObj.isAfter(today)) {
                req.setAttribute("errorMsg", "To Date cannot be in the future.");
                req.getRequestDispatcher("report_form.jsp").forward(req, res);
                return;
            }

            // 🔗 DB connection
            FeePaymentDAO dao = new FeePaymentDAO();
            con = dao.getConnection();

            String sql = "SELECT * FROM FeePayments WHERE PaymentDate BETWEEN ? AND ? ORDER BY PaymentDate ASC, StudentID ASC";
            ps = con.prepareStatement(sql);

            ps.setDate(1, java.sql.Date.valueOf(fromDateTrimmed));
            ps.setDate(2, java.sql.Date.valueOf(toDateTrimmed));

            rs = ps.executeQuery();

            // 📊 Calculate statistics
            double runningTotal = 0;
            int paidCount = 0;
            int pendingCount = 0;
            int overdueCount = 0;
            double paidAmount = 0;
            double pendingAmount = 0;
            double overdueAmount = 0;

            while (rs.next()) {
                FeePayment f = new FeePayment();
                
                f.setStudentId(rs.getInt("StudentID"));
                f.setPaymentId(rs.getInt("PaymentID"));
                f.setStudentName(rs.getString("StudentName"));
                f.setDepartment(rs.getString("Department"));
                f.setPaymentDate(rs.getString("PaymentDate"));
                f.setAmount(rs.getDouble("Amount"));
                f.setStatus(rs.getString("Status"));
                
                list.add(f);
                
                // Calculate statistics
                runningTotal += f.getAmount();
                if (f.getStatus().equalsIgnoreCase("Paid")) {
                    paidCount++;
                    paidAmount += f.getAmount();
                } else if (f.getStatus().equalsIgnoreCase("Pending")) {
                    pendingCount++;
                    pendingAmount += f.getAmount();
                } else if (f.getStatus().equalsIgnoreCase("Overdue")) {
                    overdueCount++;
                    overdueAmount += f.getAmount();
                }
            }

            // 📦 Send data to JSP
            req.setAttribute("list", list);
            req.setAttribute("count", list.size());
            req.setAttribute("fromDate", fromDateTrimmed);
            req.setAttribute("toDate", toDateTrimmed);
            
            // 📊 Send statistics
            req.setAttribute("runningTotal", runningTotal);
            req.setAttribute("paidCount", paidCount);
            req.setAttribute("pendingCount", pendingCount);
            req.setAttribute("overdueCount", overdueCount);
            req.setAttribute("paidAmount", paidAmount);
            req.setAttribute("pendingAmount", pendingAmount);
            req.setAttribute("overdueAmount", overdueAmount);
            
            // 📊 Calculate average amount
            double averageAmount = list.isEmpty() ? 0 : runningTotal / list.size();
            req.setAttribute("averageAmount", averageAmount);
            
            // ✅ Success/Info message
            if (list.isEmpty()) {
                req.setAttribute("infoMsg", "No payment records found between " + fromDateTrimmed + " and " + toDateTrimmed);
            } else {
                req.setAttribute("successMsg", "Found " + list.size() + " payment record(s) between " + fromDateTrimmed + " and " + toDateTrimmed);
            }

            req.getRequestDispatcher("report_result.jsp").forward(req, res);

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Database error: " + e.getMessage());
            req.getRequestDispatcher("report_form.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Error generating report. Please try again.");
            req.getRequestDispatcher("error.jsp").forward(req, res);
        } finally {
            // 🔒 Close resources properly
            try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (ps != null) ps.close(); } catch (SQLException e) { e.printStackTrace(); }
            try { if (con != null) con.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        // Handle GET requests - redirect to report form
        req.setAttribute("errorMsg", "Please use the report form to generate date range reports.");
        req.getRequestDispatcher("report_form.jsp").forward(req, res);
    }
}