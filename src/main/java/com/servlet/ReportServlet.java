package com.servlet;

import java.io.IOException;
import java.sql.*;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import com.dao.FeePaymentDAO;
import com.model.FeePayment;

public class ReportServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String from = req.getParameter("fromDate");
            String to = req.getParameter("toDate");

            Connection con = new FeePaymentDAO().getConnection();

            String sql = "SELECT * FROM FeePayments WHERE PaymentDate BETWEEN ? AND ?";
            PreparedStatement ps = con.prepareStatement(sql);

        
            ps.setDate(1, java.sql.Date.valueOf(from));
            ps.setDate(2, java.sql.Date.valueOf(to));

            ResultSet rs = ps.executeQuery();

            List<FeePayment> list = new ArrayList<>();

            while(rs.next()){
                FeePayment f = new FeePayment();

                f.setStudentName(rs.getString("StudentName"));
                f.setAmount(rs.getDouble("Amount"));

                list.add(f);
            }

            req.setAttribute("list", list);
            req.getRequestDispatcher("report_result.jsp").forward(req, res);

        } catch(Exception e){
            e.printStackTrace();
        }
    }
}