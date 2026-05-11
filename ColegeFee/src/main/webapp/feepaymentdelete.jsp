<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management | Delete Payment</title>
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
        max-width: 700px;
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
    .btn-delete {
        background: linear-gradient(135deg, #dc3545, #c82333);
        border: none;
        padding: 12px;
        font-weight: 600;
        border-radius: 50px;
        color: white;
        width: 100%;
    }
    .btn-delete:hover { transform: scale(1.02); }
    .btn-search {
        background: linear-gradient(135deg, #28a745, #20c997);
        border: none;
        padding: 12px 20px;
        font-weight: 600;
        border-radius: 50px;
        color: white;
        margin-left: 10px;
        transition: all 0.3s;
    }
    .btn-search:hover { 
        transform: scale(1.02);
        background: linear-gradient(135deg, #218838, #1aa179);
    }
    .form-control, .form-select { border-radius: 15px; padding: 12px 15px; }
    .student-info {
        background: linear-gradient(135deg, rgba(102,126,234,0.2), rgba(118,75,162,0.2));
        border-radius: 15px;
        padding: 20px;
        margin: 20px 0;
        border-left: 4px solid rgb(128, 255, 0);
        color: rgb(128, 0, 64);
    }
    .student-info strong { color: rgb(0, 128, 255); }
    .search-option {
        display: flex;
        gap: 15px;
        margin-bottom: 25px;
        border-bottom: 1px solid rgba(255,255,255,0.2);
        padding-bottom: 15px;
    }
    .search-option .nav-link {
        color: #333;
        background: #f0f0f0;
        cursor: pointer;
        padding: 12px 30px;
        border-radius: 50px;
        transition: all 0.3s;
        font-weight: 600;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .search-option .nav-link.active {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: white;
        box-shadow: 0 4px 10px rgba(102,126,234,0.4);
    }
    .search-option .nav-link:hover:not(.active) {
        background: #e0e0e0;
        transform: translateY(-2px);
    }
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
    .warning-text {
        color: #ff6b6b;
        font-weight: bold;
    }
    .badge-paid { background: #28a745; padding: 5px 12px; border-radius: 20px; }
    .badge-pending { background: #ffc107; color: #333; padding: 5px 12px; border-radius: 20px; }
    .badge-overdue { background: #dc3545; padding: 5px 12px; border-radius: 20px; }
    
    /* Input group styling */
    .input-group-custom {
        display: flex;
        gap: 10px;
        align-items: center;
    }
    .input-group-custom .form-control {
        flex: 1;
    }
</style>
</head>
<body>

<div id="loading" class="loading"><div class="spinner"></div></div>

<nav class="navbar navbar-custom sticky-top">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-graduation-cap me-2"></i>College Fee Management System</span>
        <div><span class="text-muted"><i class="fas fa-trash-alt"></i> Delete Payment</span></div>
    </div>
</nav>

<div class="container">
    <a href="index.jsp" class="btn-back mt-3"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
    
    <div class="glass-card">
        <div class="text-center mb-4">
            <i class="fas fa-trash-alt fa-3x" style="color: #dc3545;"></i>
            <h2 class="fw-bold mt-2" style="color: #dc3545;">Delete Payment</h2>
            <p class="text-muted">Search by Student ID or Name to delete a payment record</p>
        </div>
        
        <% if(request.getAttribute("errorMsg") != null) { %>
            <div class="alert alert-danger"><%= request.getAttribute("errorMsg") %></div>
        <% } %>
        <% if(request.getAttribute("successMsg") != null) { %>
            <div class="alert alert-success"><%= request.getAttribute("successMsg") %></div>
        <% } %>
        
        <!-- Search Options Tabs - IMPROVED VISIBILITY -->
        <div class="search-option">
            <div class="nav-link active" onclick="switchSearch('id')">
                <i class="fas fa-id-card me-2"></i>Search by Student ID
            </div>
            <div class="nav-link" onclick="switchSearch('name')">
                <i class="fas fa-user me-2"></i>Search by Student Name
            </div>
        </div>
        
        <!-- Search by ID -->
        <div id="searchByIdDiv">
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-id-card me-2 text-primary"></i>Enter Student ID</label>
                <div class="input-group-custom">
                    <input type="number" id="searchStudentId" class="form-control" placeholder="Enter Student ID" style="border-radius: 15px;">
                    <button type="button" class="btn-search" onclick="searchById()">
                        <i class="fas fa-search me-2"></i>Search
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Search by Name -->
        <div id="searchByNameDiv" style="display: none;">
            <div class="mb-3">
                <label class="form-label fw-bold"><i class="fas fa-user me-2 text-primary"></i>Enter Student Name</label>
                <div class="input-group-custom">
                    <input type="text" id="searchStudentName" class="form-control" placeholder="Enter Student Name">
                    <button type="button" class="btn-search" onclick="searchByName()">
                        <i class="fas fa-search me-2"></i>Search
                    </button>
                </div>
            </div>
        </div>
        
        <!-- Search Results / Student Details -->
        <div id="studentInfo" class="student-info" style="display: none;">
            <h6 class="mb-3"><i class="fas fa-user-graduate me-2"></i>Payment Details</h6>
            <div class="row">
                <div class="col-md-6 mb-2"><strong>🆔 Payment ID:</strong> <span id="displayPaymentId"></span></div>
                <div class="col-md-6 mb-2"><strong>🎓 Student ID:</strong> <span id="displayStudentId"></span></div>
                <div class="col-md-6 mb-2"><strong>👤 Student Name:</strong> <span id="displayStudentName"></span></div>
                <div class="col-md-6 mb-2"><strong>🏢 Department:</strong> <span id="displayDepartment"></span></div>
                <div class="col-md-6 mb-2"><strong>📅 Payment Date:</strong> <span id="displayPaymentDate"></span></div>
                <div class="col-md-6 mb-2"><strong>💰 Amount:</strong> <span id="displayAmount"></span></div>
                <div class="col-md-6 mb-2"><strong>📌 Status:</strong> <span id="displayStatus"></span></div>
            </div>
            <div class="alert alert-danger mt-3">
                <i class="fas fa-exclamation-triangle me-2"></i>
                <strong>Warning:</strong> This action cannot be undone. The payment record will be permanently deleted.
            </div>
            <button class="btn-delete mt-2" onclick="confirmDelete()">
                <i class="fas fa-trash-alt me-2"></i>Delete Permanently
            </button>
        </div>
        
        <div class="alert alert-info mt-3" style="background: rgba(102,126,234,0.2); border: none; color: white;">
            <i class="fas fa-info-circle me-2"></i>
            <strong>How to delete:</strong> Search by Student ID or Name → Verify details → Click Delete
        </div>
    </div>
</div>

<footer><p><i class="fas fa-copyright"></i> 2024 College Fee Management System | Secure & Reliable</p></footer>

<script>
    let currentStudentId = null;
    let currentPaymentId = null;
    
    function showLoading() { document.getElementById('loading').style.display = 'flex'; }
    function hideLoading() { document.getElementById('loading').style.display = 'none'; }
    
    function switchSearch(type) {
        const idDiv = document.getElementById('searchByIdDiv');
        const nameDiv = document.getElementById('searchByNameDiv');
        const tabs = document.querySelectorAll('.search-option .nav-link');
        
        if (type === 'id') {
            idDiv.style.display = 'block';
            nameDiv.style.display = 'none';
            tabs[0].classList.add('active');
            tabs[1].classList.remove('active');
        } else {
            idDiv.style.display = 'none';
            nameDiv.style.display = 'block';
            tabs[0].classList.remove('active');
            tabs[1].classList.add('active');
        }
        // Hide student info when switching
        document.getElementById('studentInfo').style.display = 'none';
        currentStudentId = null;
        currentPaymentId = null;
    }
    
    function searchById() {
        let studentId = document.getElementById('searchStudentId').value;
        if (studentId === "" || parseInt(studentId) <= 0) {
            alert("Please enter a valid Student ID!");
            return;
        }
        fetchStudentDetails('id', studentId);
    }
    
    function searchByName() {
        let studentName = document.getElementById('searchStudentName').value.trim();
        if (studentName === "") {
            alert("Please enter a Student Name!");
            return;
        }
        fetchStudentDetails('name', studentName);
    }
    
    function fetchStudentDetails(searchType, searchValue) {
        showLoading();
        
        var xhr = new XMLHttpRequest();
        var url = "DeleteFeePaymentServlet?action=getDetails&searchType=" + searchType + "&searchValue=" + encodeURIComponent(searchValue);
        
        xhr.onreadystatechange = function() {
            if (xhr.readyState === 4) {
                hideLoading();
                if (xhr.status === 200) {
                    try {
                        var data = JSON.parse(xhr.responseText);
                        if (data.found) {
                            // Display payment details including Payment ID
                            document.getElementById('displayPaymentId').innerHTML = data.paymentId;
                            document.getElementById('displayStudentId').innerHTML = data.studentId;
                            document.getElementById('displayStudentName').innerHTML = data.studentName;
                            document.getElementById('displayDepartment').innerHTML = data.department;
                            document.getElementById('displayPaymentDate').innerHTML = data.paymentDate;
                            document.getElementById('displayAmount').innerHTML = '₹' + parseFloat(data.amount).toFixed(2);
                            
                            let statusHtml = '';
                            if (data.status === 'Paid') statusHtml = '<span class="badge-paid">✅ Paid</span>';
                            else if (data.status === 'Pending') statusHtml = '<span class="badge-pending">⏳ Pending</span>';
                            else if (data.status === 'Overdue') statusHtml = '<span class="badge-overdue">⚠️ Overdue</span>';
                            else statusHtml = data.status;
                            document.getElementById('displayStatus').innerHTML = statusHtml;
                            
                            document.getElementById('studentInfo').style.display = 'block';
                            currentStudentId = data.studentId;
                            currentPaymentId = data.paymentId;
                        } else {
                            document.getElementById('studentInfo').style.display = 'none';
                            alert(data.message || "No student found!");
                            currentStudentId = null;
                            currentPaymentId = null;
                        }
                    } catch(e) {
                        alert("Error: " + e.message);
                    }
                } else {
                    alert("Error fetching student details!");
                }
            }
        };
        xhr.open("GET", url, true);
        xhr.send();
    }
    
    function confirmDelete() {
        if (!currentStudentId) {
            alert("No student selected to delete!");
            return;
        }
        
        let confirmMsg = "⚠️ PERMANENT DELETION WARNING ⚠️\n\n";
        confirmMsg += "Are you absolutely sure you want to delete this payment record?\n\n";
        confirmMsg += "Payment ID: " + currentPaymentId + "\n";
        confirmMsg += "Student ID: " + document.getElementById('displayStudentId').innerHTML + "\n";
        confirmMsg += "Student Name: " + document.getElementById('displayStudentName').innerHTML + "\n";
        confirmMsg += "Department: " + document.getElementById('displayDepartment').innerHTML + "\n";
        confirmMsg += "Amount: " + document.getElementById('displayAmount').innerHTML + "\n\n";
        confirmMsg += "This action CANNOT be undone!";
        
        if (confirm(confirmMsg)) {
            // Proceed with deletion
            showLoading();
            
            var xhr = new XMLHttpRequest();
            xhr.onreadystatechange = function() {
                if (xhr.readyState === 4) {
                    hideLoading();
                    if (xhr.status === 200) {
                        try {
                            var data = JSON.parse(xhr.responseText);
                            if (data.success) {
                                alert("✅ " + data.message);
                                location.reload();
                            } else {
                                alert("❌ " + data.message);
                            }
                        } catch(e) {
                            alert("Error: " + e.message);
                        }
                    } else {
                        alert("Error deleting record!");
                    }
                }
            };
            xhr.open("POST", "DeleteFeePaymentServlet", true);
            xhr.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
            xhr.send("action=delete&studentId=" + currentStudentId);
        }
    }
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>