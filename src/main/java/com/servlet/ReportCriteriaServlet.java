package com.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.*;
import javax.servlet.http.*;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

public class ReportCriteriaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String type = request.getParameter("reportType");

        List<FeePayment> list = new ArrayList<>();

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {

            // 🔗 Get DB connection
            con = new FeePaymentDAO().getConnection();

            // ⚠️ Validation
            if (type == null || type.isEmpty()) {
                response.getWriter().println("Invalid Report Type");
                return;
            }

            // 📊 Overdue Report
            if ("overdue".equalsIgnoreCase(type)) {

                String sql = "SELECT * FROM FeePayments WHERE Status = ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, "Overdue");

            }

            // 📊 Not Paid Report
            else if ("notpaid".equalsIgnoreCase(type)) {

                String sql = "SELECT * FROM FeePayments WHERE Status != ?";
                ps = con.prepareStatement(sql);
                ps.setString(1, "Paid");

            }

            // 📊 Date Range Report
            else if ("date".equalsIgnoreCase(type)) {

                String from = request.getParameter("fromDate");
                String to = request.getParameter("toDate");

                // ⚠️ Date validation
                if (from == null || to == null || from.isEmpty() || to.isEmpty()) {
                    response.getWriter().println("Please select both From and To dates");
                    return;
                }

                String sql = "SELECT * FROM FeePayments WHERE PaymentDate BETWEEN ? AND ?";
                ps = con.prepareStatement(sql);

                ps.setDate(1, Date.valueOf(from));
                ps.setDate(2, Date.valueOf(to));
            }

            // 🚀 Execute query
            rs = ps.executeQuery();

            // 🔁 Convert ResultSet → List
            while (rs.next()) {

                FeePayment f = new FeePayment();

                f.setPaymentId(rs.getInt("PaymentID"));
                f.setStudentName(rs.getString("StudentName"));
                f.setAmount(rs.getDouble("Amount"));
                f.setStatus(rs.getString("Status"));

                list.add(f);
            }

            // 📦 Send data to JSP
            request.setAttribute("list", list);

            RequestDispatcher rd = request.getRequestDispatcher("report_result.jsp");
            rd.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());

        } finally {

            // 🔒 Close resources (VERY IMPORTANT for marks)
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (ps != null) ps.close(); } catch (Exception e) {}
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
    }
}