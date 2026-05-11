package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/DeleteFeePaymentServlet")
public class DeleteFeePaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        // Handle AJAX request to get student details
        if ("getDetails".equals(action)) {
            String searchType = req.getParameter("searchType");
            String searchValue = req.getParameter("searchValue");
            
            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            PrintWriter out = res.getWriter();
            
            try {
                FeePaymentDAO dao = new FeePaymentDAO();
                FeePayment payment = null;
                
                if ("id".equals(searchType)) {
                    int studentId = Integer.parseInt(searchValue);
                    payment = dao.getPaymentByStudentId(studentId);  // Fixed method name
                } else if ("name".equals(searchType)) {
                    // Search by name - get first match
                    java.util.List<FeePayment> list = dao.searchByName(searchValue);
                    if (list != null && !list.isEmpty()) {
                        payment = list.get(0);
                    }
                }
                
                if (payment != null) {
                    String json = "{";
                    json += "\"found\": true,";
                    json += "\"studentId\": " + payment.getStudentId() + ",";
                    json += "\"paymentId\": " + payment.getPaymentId() + ",";
                    json += "\"studentName\": \"" + escapeJson(payment.getStudentName()) + "\",";
                    json += "\"department\": \"" + escapeJson(payment.getDepartment()) + "\",";
                    json += "\"paymentDate\": \"" + payment.getPaymentDate() + "\",";
                    json += "\"amount\": " + payment.getAmount() + ",";
                    json += "\"status\": \"" + payment.getStatus() + "\"";
                    json += "}";
                    out.print(json);
                } else {
                    String json = "{\"found\": false, \"message\": \"No student found with " + searchType + ": " + searchValue + "\"}";
                    out.print(json);
                }
            } catch (Exception e) {
                e.printStackTrace();
                String json = "{\"found\": false, \"message\": \"Error: " + e.getMessage() + "\"}";
                out.print(json);
            }
            out.flush();
            return;
        }
        
        // Show the delete page
        req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        res.setContentType("application/json");
        PrintWriter out = res.getWriter();
        
        if ("delete".equals(action)) {
            String studentIdParam = req.getParameter("studentId");
            
            try {
                int studentId = Integer.parseInt(studentIdParam);
                
                if (studentId <= 0) {
                    String json = "{\"success\": false, \"message\": \"Invalid Student ID!\"}";
                    out.print(json);
                    out.flush();
                    return;
                }
                
                FeePaymentDAO dao = new FeePaymentDAO();
                FeePayment existingPayment = dao.getPaymentByStudentId(studentId);  // Fixed method name
                
                if (existingPayment == null) {
                    String json = "{\"success\": false, \"message\": \"No payment record found with Student ID: " + studentId + "\"}";
                    out.print(json);
                    out.flush();
                    return;
                }
                
                String result = dao.delete(studentId);
                
                if (result.startsWith("SUCCESS")) {
                    String json = "{\"success\": true, \"message\": \"Payment record for " + existingPayment.getStudentName() + " (Student ID: " + studentId + ", Payment ID: " + existingPayment.getPaymentId() + ") deleted successfully!\"}";
                    out.print(json);
                } else {
                    String json = "{\"success\": false, \"message\": \"" + result.replace("ERROR: ", "") + "\"}";
                    out.print(json);
                }
            } catch (Exception e) {
                e.printStackTrace();
                String json = "{\"success\": false, \"message\": \"Error: " + e.getMessage() + "\"}";
                out.print(json);
            }
            out.flush();
            return;
        }
        
        // Default POST handling
        try {
            String sid = req.getParameter("studentId");
            
            if (sid == null || sid.trim().isEmpty()) {
                req.setAttribute("errorMsg", "Student ID is required!");
                req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, res);
                return;
            }
            
            int studentId = Integer.parseInt(sid.trim());
            
            if (studentId <= 0) {
                req.setAttribute("errorMsg", "Invalid Student ID!");
                req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, res);
                return;
            }
            
            FeePaymentDAO dao = new FeePaymentDAO();
            FeePayment existingPayment = dao.getPaymentByStudentId(studentId);  // Fixed method name
            
            if (existingPayment == null) {
                req.setAttribute("errorMsg", "No payment record found with Student ID: " + studentId);
                req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, res);
                return;
            }
            
            String result = dao.delete(studentId);
            
            if (result.startsWith("SUCCESS")) {
                req.setAttribute("successMsg", "Payment record for " + existingPayment.getStudentName() + " (Student ID: " + studentId + ") deleted successfully!");
                req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, res);
            } else {
                req.setAttribute("errorMsg", result.replace("ERROR: ", ""));
                req.getRequestDispatcher("feepaymentdelete.jsp").forward(req, res);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Something went wrong. Please try again.");
            req.getRequestDispatcher("error.jsp").forward(req, res);
        }
    }
    
    private String escapeJson(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("\"", "\\\"")
                  .replace("\n", "\\n")
                  .replace("\r", "\\r")
                  .replace("\t", "\\t");
    }
}