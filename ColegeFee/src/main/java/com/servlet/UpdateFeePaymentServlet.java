package com.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.FeePaymentDAO;
import com.model.FeePayment;

@WebServlet("/UpdateFeePaymentServlet")
public class UpdateFeePaymentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        
        String action = req.getParameter("action");
        
        if ("getDetails".equals(action)) {
            String studentIdParam = req.getParameter("studentId");
            res.setContentType("application/json");
            res.setCharacterEncoding("UTF-8");
            PrintWriter out = res.getWriter();
            
            try {
                int studentId = Integer.parseInt(studentIdParam);
                FeePaymentDAO dao = new FeePaymentDAO();
                FeePayment payment = dao.getPaymentByStudentId(studentId);  // Fixed method name
                
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
                    String json = "{\"found\": false, \"message\": \"Student not found with ID: " + studentId + "\"}";
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
        
        req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        try {
            String sid = req.getParameter("studentId");
            String name = req.getParameter("studentName");
            String department = req.getParameter("department");
            String date = req.getParameter("paymentDate");
            String amt = req.getParameter("amount");
            String status = req.getParameter("status");

            if (sid == null || name == null || department == null || date == null || amt == null || status == null ||
                sid.trim().isEmpty() || name.trim().isEmpty() || department.trim().isEmpty() || 
                date.trim().isEmpty() || amt.trim().isEmpty() || status.trim().isEmpty()) {
                req.setAttribute("errorMsg", "All fields are required!");
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }

            int studentId = Integer.parseInt(sid.trim());
            String studentName = name.trim();
            String departmentName = department.trim();
            String paymentDate = date.trim();
            double amount = Double.parseDouble(amt.trim());
            String properStatus = status.trim();

            if (studentId <= 0) {
                req.setAttribute("errorMsg", "Invalid Student ID!");
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }
            
            if (studentName.length() < 2 || studentName.length() > 50) {
                req.setAttribute("errorMsg", "Student name must be between 2 and 50 characters!");
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }
            
            if (departmentName.length() < 2 || departmentName.length() > 50) {
                req.setAttribute("errorMsg", "Department must be between 2 and 50 characters!");
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }
            
            try {
                LocalDate selectedDate = LocalDate.parse(paymentDate);
                LocalDate today = LocalDate.now();
                if (selectedDate.isAfter(today)) {
                    req.setAttribute("errorMsg", "Payment date cannot be in the future!");
                    req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                    return;
                }
            } catch (Exception e) {
                req.setAttribute("errorMsg", "Invalid date format! Please use YYYY-MM-DD.");
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }

            if (amount < 100) {
                req.setAttribute("errorMsg", "Amount must be at least ₹100!");
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }
            
            if (amount > 500000) {
                req.setAttribute("errorMsg", "Amount cannot exceed ₹500,000!");
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }

            FeePaymentDAO dao = new FeePaymentDAO();
            FeePayment existingPayment = dao.getPaymentByStudentId(studentId);  // Fixed method name
            
            if (existingPayment == null) {
                req.setAttribute("errorMsg", "No payment record found with Student ID: " + studentId);
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
                return;
            }

            String result = dao.updateWithAllFields(studentId, studentName, departmentName, paymentDate, amount, properStatus);
            
            if (result.startsWith("SUCCESS")) {
                String successMsg = "<strong>✅ Payment updated successfully!</strong><br><br>";
                successMsg += "<strong>Changes made:</strong><br>";
                successMsg += "• Payment ID: " + existingPayment.getPaymentId() + "<br>";
                successMsg += "• Name: " + existingPayment.getStudentName() + " → " + studentName + "<br>";
                successMsg += "• Department: " + existingPayment.getDepartment() + " → " + departmentName + "<br>";
                successMsg += "• Date: " + existingPayment.getPaymentDate() + " → " + paymentDate + "<br>";
                successMsg += "• Amount: ₹" + String.format("%.2f", existingPayment.getAmount()) + " → ₹" + String.format("%.2f", amount) + "<br>";
                successMsg += "• Status: " + existingPayment.getStatus() + " → " + properStatus;
                
                req.setAttribute("successMsg", successMsg);
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
            } else {
                req.setAttribute("errorMsg", result.replace("ERROR: ", ""));
                req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
            }

        } catch (NumberFormatException e) {
            req.setAttribute("errorMsg", "Invalid number format!");
            req.getRequestDispatcher("feepaymentupdate.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMsg", "Update failed! Please try again.");
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