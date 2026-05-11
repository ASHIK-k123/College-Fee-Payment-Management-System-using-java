<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management | Update Payment</title>
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
        max-width: 750px;
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
    .btn-update {
        background: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        border: none;
        padding: 12px;
        font-weight: 600;
        border-radius: 50px;
        color: white;
        width: 100%;
    }
    .btn-update:hover { transform: scale(1.02); }
    .btn-fetch {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        padding: 12px 20px;
        font-weight: 600;
        border-radius: 50px;
        color: white;
        margin-left: 10px;
    }
    .btn-fetch:hover { transform: scale(1.02); }
    .form-control, .form-select { border-radius: 15px; padding: 12px 15px; }
    .student-info {
        background: linear-gradient(135deg, rgba(102,126,234,0.15), rgba(118,75,162,0.15));
        border-radius: 15px;
        padding: 15px;
        margin: 15px 0;
        border-left: 4px solid rgb(255, 0, 0);
        color: rgb(128, 0, 64)55, 0, 0)28, 0, 255);
    }
    .student-info strong { color: rgb(0, 128, 255); }
    footer { text-align: center; color: white; margin-top: 30px; padding: 20px; }
    .loading {
        display: none;
        position: fixed;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        z-index: 9999;
    }
    .spinner {
        width: 40px;
        height: 40px;
        border: 4px solid rgba(102,126,234,0.3);
        border-top-color: #667eea;
        border-radius: 50%;
        animation: spin 1s linear infinite;
    }
    @keyframes spin {
        to { transform: rotate(360deg); }
    }
    .auto-id-field {
        background-color: #e9ecef;
        font-weight: bold;
    }
</style>
</head>
<body>

<div id="loading" class="loading"><div class="spinner"></div></div>

<nav class="navbar navbar-custom sticky-top">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-graduation-cap me-2"></i>College Fee Management System</span>
        <div><span class="text-muted"><i class="fas fa-edit"></i> Update Payment</span></div>
    </div>
</nav>

<div class="container">
    <a href="index.jsp" class="btn-back mt-3"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
    
    <div class="glass-card">
        <div class="text-center mb-4">
            <i class="fas fa-edit fa-3x" style="color: #fa709a;"></i>
            <h2 class="fw-bold mt-2">Update Payment</h2>
            <p class="text-muted">Enter Student ID to fetch and update details</p>
        </div>
        
        <% if(request.getAttribute("errorMsg") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMsg") %></div>
        <% } %>
        <% if(request.getAttribute("successMsg") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("successMsg") %></div>
        <% } %>
        
        <div class="mb-4">
            <label class="form-label fw-bold">Enter Student ID <span class="text-danger">*</span></label>
            <div class="d-flex">
                <input type="number" id="studentId" class="form-control" placeholder="Enter Student ID">
                <button type="button" class="btn-fetch" onclick="fetchStudentDetails()">
                    <i class="fas fa-search"></i> Fetch Details
                </button>
            </div>
        </div>
        
        <div id="studentInfo" class="student-info" style="display: none;">
            <h6 class="mb-2"><i class="fas fa-info-circle me-2"></i>Current Information</h6>
            <div class="row">
                <div class="col-md-6 mb-1"><strong>🆔 Payment ID:</strong> <span id="currentPaymentIdDisplay"></span></div>
                <div class="col-md-6 mb-1"><strong>🎓 Student ID:</strong> <span id="currentStudentIdDisplay"></span></div>
                <div class="col-md-6 mb-1"><strong>👤 Name:</strong> <span id="currentNameDisplay"></span></div>
                <div class="col-md-6 mb-1"><strong>🏢 Department:</strong> <span id="currentDeptDisplay"></span></div>
                <div class="col-md-4 mb-1"><strong>📅 Date:</strong> <span id="currentDateDisplay"></span></div>
                <div class="col-md-4 mb-1"><strong>💰 Amount:</strong> <span id="currentAmountDisplay"></span></div>
                <div class="col-md-4 mb-1"><strong>📌 Status:</strong> <span id="currentStatusDisplay"></span></div>
            </div>
        </div>
        
        <form id="updateForm" action="UpdateFeePaymentServlet" method="post" onsubmit="return validateForm()" style="display: none;">
            <input type="hidden" name="studentId" id="hiddenStudentId">
            
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-user me-2"></i>Student Name</label>
                <input type="text" id="studentName" name="studentName" class="form-control" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-building me-2"></i>Department</label>
                <select id="department" name="department" class="form-select" required>
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
            
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-calendar me-2"></i>Payment Date</label>
                <input type="date" id="paymentDate" name="paymentDate" class="form-control" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-rupee-sign me-2"></i>Amount</label>
                <input type="number" id="amount" name="amount" class="form-control" step="0.01" min="100" max="500000" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-tag me-2"></i>Status</label>
                <select id="status" name="status" class="form-select" onchange="updateStatusIcon()" required>
                    <option value="">-- Select Status --</option>
                    <option value="Paid">✅ Paid</option>
                    <option value="Pending">⏳ Pending</option>
                    <option value="Overdue">⚠️ Overdue</option>
                </select>
            </div>
            
            <button type="submit" class="btn-update"><i class="fas fa-save me-2"></i>Update Payment</button>
        </form>
    </div>
</div>

<footer><p><i class="fas fa-copyright"></i> 2024 College Fee Management System | Secure & Reliable</p></footer>

<script>
    function showLoading() { 
        document.getElementById('loading').style.display = 'flex'; 
    }
    
    function hideLoading() { 
        document.getElementById('loading').style.display = 'none'; 
    }
    
    function updateStatusIcon() {
        let status = document.getElementById("status");
        let icon = document.getElementById("statusIcon");
        
        if (status && icon) {
            let statusValue = status.value;
            if (statusValue === "Paid") {
                icon.className = "fas fa-check-circle";
                icon.style.color = "#28a745";
            } else if (statusValue === "Pending") {
                icon.className = "fas fa-clock";
                icon.style.color = "#ffc107";
            } else if (statusValue === "Overdue") {
                icon.className = "fas fa-exclamation-triangle";
                icon.style.color = "#dc3545";
            } else {
                icon.className = "fas fa-question-circle";
                icon.style.color = "#6c757d";
            }
        }
    }
    
    function fetchStudentDetails() {
        let studentId = document.getElementById("studentId").value;
        if (studentId === "" || parseInt(studentId) <= 0) {
            alert("Please enter a valid Student ID!");
            return;
        }
        showLoading();
        
        var xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                hideLoading();
                if (xhr.status === 200) {
                    try {
                        var data = JSON.parse(xhr.responseText);
                        if (data.found) {
                            // Display current info including Payment ID
                            document.getElementById("currentPaymentIdDisplay").innerHTML = data.paymentId;
                            document.getElementById("currentStudentIdDisplay").innerHTML = data.studentId;
                            document.getElementById("currentNameDisplay").innerHTML = data.studentName;
                            document.getElementById("currentDeptDisplay").innerHTML = data.department;
                            document.getElementById("currentDateDisplay").innerHTML = data.paymentDate;
                            document.getElementById("currentAmountDisplay").innerHTML = '₹' + parseFloat(data.amount).toFixed(2);
                            document.getElementById("currentStatusDisplay").innerHTML = data.status;
                            
                            // Show the info box and form
                            document.getElementById("studentInfo").style.display = "block";
                            document.getElementById("updateForm").style.display = "block";
                            
                            // Pre-fill form fields
                            document.getElementById("studentName").value = data.studentName;
                            document.getElementById("department").value = data.department;
                            document.getElementById("paymentDate").value = data.paymentDate;
                            document.getElementById("amount").value = data.amount;
                            document.getElementById("status").value = data.status;
                            
                            // Set hidden student ID
                            document.getElementById("hiddenStudentId").value = studentId;
                            
                            // Update status icon
                            updateStatusIcon();
                        } else {
                            document.getElementById("studentInfo").style.display = "none";
                            document.getElementById("updateForm").style.display = "none";
                            alert(data.message || "No student found with ID: " + studentId);
                        }
                    } catch(e) {
                        alert("Error parsing response: " + e.message);
                    }
                } else {
                    alert("Error fetching student details! Status: " + xhr.status);
                }
            }
        };
        xhr.open("GET", "UpdateFeePaymentServlet?action=getDetails&studentId=" + studentId, true);
        xhr.send();
    }
    
    function validateForm() {
        let name = document.getElementById("studentName").value.trim();
        let department = document.getElementById("department").value;
        let date = document.getElementById("paymentDate").value;
        let amount = document.getElementById("amount").value;
        let status = document.getElementById("status").value;
        
        if (name === "" || name.length < 2) {
            alert("Valid student name is required!");
            return false;
        }
        if (department === "") {
            alert("Please select a department!");
            return false;
        }
        if (date === "") {
            alert("Payment date is required!");
            return false;
        }
        if (amount === "" || parseFloat(amount) < 100) {
            alert("Amount must be at least ₹100!");
            return false;
        }
        if (parseFloat(amount) > 500000) {
            alert("Amount cannot exceed ₹500,000!");
            return false;
        }
        if (status === "") {
            alert("Please select a status!");
            return false;
        }
        
        let confirmMsg = "Are you sure you want to update this payment?\n\n";
        confirmMsg += "Payment ID: " + document.getElementById("currentPaymentIdDisplay").innerHTML + "\n";
        confirmMsg += "Student ID: " + document.getElementById("studentId").value + "\n";
        confirmMsg += "Name: " + name + "\n";
        confirmMsg += "Department: " + department + "\n";
        confirmMsg += "Date: " + date + "\n";
        confirmMsg += "Amount: ₹" + parseFloat(amount).toFixed(2) + "\n";
        confirmMsg += "Status: " + status;
        
        return confirm(confirmMsg);
    }
    
    // Add event listener for status change
    function attachStatusListener() {
        var statusSelect = document.getElementById("status");
        if (statusSelect) {
            statusSelect.removeEventListener("change", updateStatusIcon);
            statusSelect.addEventListener("change", updateStatusIcon);
        }
    }
    
    document.addEventListener("DOMContentLoaded", function() {
        attachStatusListener();
        updateStatusIcon();
    });
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>