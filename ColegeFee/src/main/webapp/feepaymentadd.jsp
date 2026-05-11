<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.dao.FeePaymentDAO, com.model.FeePayment, java.util.*, java.time.LocalDate" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management | Add Payment</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root { --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    body {
        background: url('images/bg.jpg') no-repeat center center fixed;
        background-size: cover;
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
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
        padding: 30px;
        margin: 20px auto;
        max-width: 600px;
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
    .btn-gradient {
        background: var(--primary-gradient);
        border: none;
        padding: 12px;
        font-weight: 600;
        border-radius: 50px;
        color: white;
        width: 100%;
    }
    .btn-gradient:hover { transform: scale(1.02); }
    .form-control, .form-select { border-radius: 15px; padding: 12px 15px; }
    footer { text-align: center; color: white; margin-top: 30px; padding: 20px; }
    .auto-id-field { background-color: #e9ecef; font-weight: bold; color: #667eea; }
</style>
<script>
    function updateStatusIcon() {
        let status = document.getElementById("status").value;
        let icon = document.getElementById("statusIcon");
        if (status === "Paid") icon.className = "fas fa-check-circle";
        else if (status === "Pending") icon.className = "fas fa-clock";
        else if (status === "Overdue") icon.className = "fas fa-exclamation-triangle";
        else icon.className = "fas fa-question-circle";
    }
    
    function validateForm() {
        let name = document.getElementById("studentName").value.trim();
        let department = document.getElementById("department").value;
        let amount = document.getElementById("amount").value;
        let status = document.getElementById("status").value;
        let errorMsg = "";
        
        if (name === "") errorMsg = "Student name is required!";
        else if (name.length < 2 || name.length > 50) errorMsg = "Name must be 2-50 characters!";
        else if (!/^[A-Za-z\s]+$/.test(name)) errorMsg = "Name can only contain letters and spaces!";
        else if (department === "") errorMsg = "Department is required!";
        
        if (!errorMsg && amount === "") errorMsg = "Amount is required!";
        else if (!errorMsg && parseFloat(amount) < 100) errorMsg = "Amount must be at least ₹100!";
        else if (!errorMsg && parseFloat(amount) > 500000) errorMsg = "Amount cannot exceed ₹500,000!";
        else if (!errorMsg && status === "") errorMsg = "Please select payment status!";
        
        if (errorMsg) {
            document.getElementById("errorBox").innerHTML = "⚠️ " + errorMsg;
            document.getElementById("errorBox").style.display = "block";
            return false;
        }
        return true;
    }
</script>
</head>
<body>

<%
FeePaymentDAO dao = new FeePaymentDAO();
int nextStudentId = dao.getNextStudentId();  // This gets the correct next Student ID
int nextPaymentId = dao.getNextPaymentId();
%>

<nav class="navbar navbar-custom sticky-top">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-graduation-cap me-2"></i>College Fee Management System</span>
        <div><span class="text-muted"><i class="fas fa-user-graduate"></i> Welcome, Admin</span></div>
    </div>
</nav>

<div class="container">
    <a href="index.jsp" class="btn-back mt-3"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
    
    <div class="glass-card">
        <div class="text-center mb-4">
            <i class="fas fa-plus-circle fa-3x" style="color: #667eea;"></i>
            <h2 class="fw-bold mt-2">Add New Payment</h2>
            <p class="text-muted">Fill in the details to register a new fee payment</p>
        </div>
        
        <% if(request.getAttribute("errorMsg") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMsg") %></div>
        <% } %>
        <% if(request.getAttribute("successMsg") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("successMsg") %></div>
        <% } %>
        
        <div id="errorBox" class="alert alert-danger" style="display: none;"></div>
        
        <form action="AddFeePaymentServlet" method="post" onsubmit="return validateForm()">
            <!-- Payment ID - Auto generated, NOT modifiable -->
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-receipt me-2"></i>Payment ID</label>
                <input type="text" class="form-control auto-id-field" value="<%= nextPaymentId %>" disabled readonly style="background:#e9ecef; font-weight:bold;">
            </div>
            
            <!-- Student ID - Auto generated by MySQL, NOT modifiable -->
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-id-card me-2"></i>Student ID</label>
                <input type="text" class="form-control auto-id-field" value="<%= nextStudentId %>" disabled readonly style="background:#e9ecef;">
            </div>
            
            <!-- Student Name -->
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-user me-2"></i>Student Name <span class="text-danger">*</span></label>
                <input type="text" id="studentName" name="studentName" class="form-control" placeholder="Enter full name">
            </div>
            
            <!-- Department -->
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-building me-2"></i>Department <span class="text-danger">*</span></label>
                <select id="department" name="department" class="form-select">
                    <option value="">-- Select Department --</option>
                    <option value="Computer Science">Computer Science</option>
                    <option value="Information Technology">Information Technology</option>
                    <option value="Electronics">Electronics</option>
                    <option value="Mechanical">Mechanical</option>
                    <option value="Civil">Civil</option>
                    <option value="Electrical">Electrical</option>
                    <option value="Chemical">Chemical</option>
                </select>
            </div>
            
            <!-- Payment Date - Auto set to current date, NOT editable -->
            <div class="mb-3">
    <label class="form-label fw-bold"><i class="fas fa-calendar me-2"></i>Payment Date</label>
    <input type="text" class="form-control auto-id-field" value="<%= java.time.format.DateTimeFormatter.ofPattern("dd-MM-yyyy").format(LocalDate.now()) %>" disabled readonly style="background:#e9ecef;">
    <input type="hidden" name="paymentDate" value="<%= LocalDate.now() %>">
</div>
            
            <!-- Amount -->
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-rupee-sign me-2"></i>Amount <span class="text-danger">*</span></label>
                <input type="number" id="amount" name="amount" class="form-control" step="0.01" min="100" max="500000" placeholder="Enter amount in ₹">
            </div>
            
            <!-- Status -->
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-tag me-2"></i>Payment Status <span class="text-danger">*</span></label>
                <div class="input-group">
                    <span class="input-group-text"><i id="statusIcon" class="fas fa-question-circle"></i></span>
                    <select id="status" name="status" class="form-select" onchange="updateStatusIcon()">
                        <option value="">-- Select Status --</option>
                        <option value="Paid">✅ Paid</option>
                        <option value="Pending">⏳ Pending</option>
                        <option value="Overdue">⚠️ Overdue</option>
                    </select>
                </div>
            </div>
            
            <button type="submit" class="btn-gradient mt-3"><i class="fas fa-paper-plane me-2"></i>Submit Payment</button>
        </form>
        
        <div class="alert alert-info mt-3" style="background: rgba(102,126,234,0.1); border: none;">
            <i class="fas fa-info-circle me-2"></i>
            <strong>Note:</strong> Payment ID and Student ID are auto-generated. Payment Date is automatically set to today's date.
        </div>
    </div>
</div>

<footer><p><i class="fas fa-copyright"></i> 2024 College Fee Management System | Secure & Reliable</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
<script>updateStatusIcon();</script>
</body>
</html>