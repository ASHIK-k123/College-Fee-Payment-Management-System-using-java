<%@ page import="java.util.*,com.model.FeePayment" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management | Report Results</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root { --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    body {
        background: url('images/bg.jpg') no-repeat center center fixed;
        background-size: cover;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    }
    body::before {
        content: '';
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.65);
        z-index: -1;
    }
    .navbar-custom {
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(10px);
        padding: 1rem 0;
    }
    .navbar-brand {
        font-size: 1.5rem;
        font-weight: 700;
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent !important;
    }
    .glass-card {
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(10px);
        border-radius: 30px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        padding: 25px;
        margin: 20px 0;
    }
    .btn-back {
        background: rgba(255,255,255,0.2);
        border: 1px solid rgba(255,255,255,0.3);
        color: white;
        border-radius: 50px;
        padding: 10px 25px;
        text-decoration: none;
        display: inline-block;
    }
    .btn-back:hover { background: rgba(255,255,255,0.3); color: white; }
    .btn-print {
        background: rgba(255,255,255,0.2);
        border: 1px solid rgba(255,255,255,0.3);
        color: white;
        border-radius: 50px;
        padding: 10px 25px;
        margin-left: 10px;
    }
    .status-paid { background: #28a745; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; }
    .status-pending { background: #ffc107; color: black; padding: 5px 12px; border-radius: 20px; font-size: 12px; }
    .status-overdue { background: #dc3545; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; }
    .table-custom thead th { background: var(--primary-gradient); color: white; padding: 15px; }
    footer { text-align: center; color: white; margin-top: 30px; padding: 20px; }
    @media print { .no-print { display: none; } body { background: white; } .glass-card { background: white; } }
</style>
</head>
<body>

<%
List<FeePayment> list = (List<FeePayment>)request.getAttribute("list");
Double totalAmount = (Double)request.getAttribute("totalAmount");
Integer count = (Integer)request.getAttribute("count");
String reportType = (String)request.getAttribute("reportType");

if(totalAmount == null) totalAmount = 0.0;
if(count == null) count = 0;
%>

<nav class="navbar navbar-custom sticky-top no-print">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-graduation-cap me-2"></i>College Fee Management System</span>
        <div><span class="text-muted"><i class="fas fa-chart-line"></i> Report Results</span></div>
    </div>
</nav>

<div class="container">
    <div class="no-print">
        <a href="reports.jsp" class="btn-back mt-3"><i class="fas fa-arrow-left me-2"></i>Back to Reports</a>
        <button onclick="window.print()" class="btn-print mt-3"><i class="fas fa-print me-2"></i>Print</button>
    </div>
    
    <div class="glass-card">
        <h3 class="text-center mb-4">📊 Report Results</h3>
        <p class="text-center text-muted">Generated on: <%= new java.util.Date() %></p>
        
        <div class="row mb-4">
            <div class="col-md-4"><div class="alert alert-success text-center"><h5>Total Records</h5><h3><%= count %></h3></div></div>
            <div class="col-md-4"><div class="alert alert-info text-center"><h5>Total Amount</h5><h3>₹<%= String.format("%.2f", totalAmount) %></h3></div></div>
            <div class="col-md-4"><div class="alert alert-primary text-center"><h5>Report Type</h5><h3><%= reportType != null ? reportType.toUpperCase() : "N/A" %></h3></div></div>
        </div>
        
        <div class="table-responsive">
            <table class="table table-bordered table-custom">
                <thead>
                    <tr><th>ID</th><th>Student Name</th><th>Department</th><th>Payment Date</th><th>Amount</th><th>Status</th></tr>
                </thead>
                <tbody>
                    <% if(list != null && !list.isEmpty()) {
                        for(FeePayment f : list) { %>
                            <tr>
                                <td><%= f.getStudentId() %></td>
                                <td><%= f.getStudentName() %></td>
                                <td><%= f.getDepartment() %></td>
                                <td><%= f.getPaymentDate() %></td>
                                <td>₹<%= String.format("%.2f", f.getAmount()) %></td>
                                <td><span class="status-<%= f.getStatus().toLowerCase() %>"><%= f.getStatus() %></span></td>
                            </tr>
                    <%   }
                    } else { %>
                        <tr><td colspan="6" class="text-center">No records found</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>
</div>

<footer class="no-print"><p><i class="fas fa-copyright"></i> 2024 College Fee Management System | Secure & Reliable</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>