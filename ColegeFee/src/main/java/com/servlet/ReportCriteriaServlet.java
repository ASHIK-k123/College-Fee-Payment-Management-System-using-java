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

@WebServlet("/ReportCriteriaServlet")
public class ReportCriteriaServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("reportType");
        List<FeePayment> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            FeePaymentDAO dao = new FeePaymentDAO();
            con = dao.getConnection();

            if (type == null || type.trim().isEmpty()) {
                request.setAttribute("errorMsg", "Please select a report type.");
                request.getRequestDispatcher("reports.jsp").forward(request, response);
                return;
            }

            String trimmedType = type.trim().toLowerCase();
            
            // 📊 1. OVERDUE - Show records where Status = 'Overdue'
            if ("overdue".equalsIgnoreCase(trimmedType)) {
                String sql = "SELECT * FROM FeePayments WHERE Status = 'Overdue' ORDER BY PaymentDate ASC";
                ps = con.prepareStatement(sql);
                request.setAttribute("reportTitle", "Overdue Payments Report");
            }
            // 📊 2. NOT PAID - Show records where Status = 'Pending'
            else if ("notpaid".equalsIgnoreCase(trimmedType)) {
                String sql = "SELECT * FROM FeePayments WHERE Status = 'Pending' ORDER BY PaymentDate ASC";
                ps = con.prepareStatement(sql);
                request.setAttribute("reportTitle", "Pending Payments Report");
            }
            // 📊 3. PAID - Show records where Status = 'Paid'
            else if ("paid".equalsIgnoreCase(trimmedType)) {
                String sql = "SELECT * FROM FeePayments WHERE Status = 'Paid' ORDER BY PaymentDate DESC";
                ps = con.prepareStatement(sql);
                request.setAttribute("reportTitle", "Paid Payments Report");
            }
            // 📊 4. DATE RANGE
            else if ("date".equalsIgnoreCase(trimmedType)) {
                String from = request.getParameter("fromDate");
                String to = request.getParameter("toDate");

                if (from == null || to == null || from.trim().isEmpty() || to.trim().isEmpty()) {
                    request.setAttribute("errorMsg", "Please select both dates.");
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
                    return;
                }

                String fromDateTrimmed = from.trim();
                String toDateTrimmed = to.trim();
                
                LocalDate fromDateObj = LocalDate.parse(fromDateTrimmed);
                LocalDate toDateObj = LocalDate.parse(toDateTrimmed);
                
                if (fromDateObj.isAfter(toDateObj)) {
                    request.setAttribute("errorMsg", "From Date cannot be greater than To Date.");
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
                    return;
                }
                
                String sql = "SELECT * FROM FeePayments WHERE PaymentDate BETWEEN ? AND ? ORDER BY PaymentDate ASC";
                ps = con.prepareStatement(sql);
                ps.setDate(1, Date.valueOf(fromDateTrimmed));
                ps.setDate(2, Date.valueOf(toDateTrimmed));
                request.setAttribute("reportTitle", "Date Range Report");
                request.setAttribute("fromDate", fromDateTrimmed);
                request.setAttribute("toDate", toDateTrimmed);
            }
            // 📊 5. ALL RECORDS
            else if ("all".equalsIgnoreCase(trimmedType)) {
                String sql = "SELECT * FROM FeePayments ORDER BY StudentID DESC";
                ps = con.prepareStatement(sql);
                request.setAttribute("reportTitle", "All Payments Report");
            }

            if (ps != null) {
                rs = ps.executeQuery();
            } else {
                request.setAttribute("errorMsg", "Failed to prepare report query.");
                request.getRequestDispatcher("reports.jsp").forward(request, response);
                return;
            }

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
            }

            double totalAmount = 0;
            for (FeePayment f : list) {
                totalAmount += f.getAmount();
            }
            
            request.setAttribute("list", list);
            request.setAttribute("count", list.size());
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("reportType", trimmedType);

            request.getRequestDispatcher("report_result.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMsg", "Error generating report. Please try again.");
            request.getRequestDispatcher("reports.jsp").forward(request, response);
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String type = req.getParameter("reportType");
        if (type != null && !type.trim().isEmpty()) {
            doPost(req, resp);
        } else {
            resp.sendRedirect("reports.jsp");
        }
    }
}