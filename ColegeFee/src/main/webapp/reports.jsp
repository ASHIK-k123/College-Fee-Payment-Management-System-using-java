<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management | Reports Dashboard</title>
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
    .option-card {
        background: rgba(255,255,255,0.9);
        border-radius: 20px;
        padding: 20px;
        text-align: center;
        margin-bottom: 20px;
        transition: all 0.3s;
        cursor: pointer;
    }
    .option-card:hover { transform: translateY(-5px); box-shadow: 0 10px 25px rgba(0,0,0,0.2); }
    .btn-report {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        padding: 8px 20px;
        border-radius: 50px;
        color: white;
    }
    .btn-report:hover { transform: scale(1.05); }
    footer { text-align: center; color: white; margin-top: 30px; padding: 20px; }
    .report-desc { font-size: 12px; color: #666; margin-top: 5px; }
</style>
</head>
<body>

<nav class="navbar navbar-custom sticky-top">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-graduation-cap me-2"></i>College Fee Management System</span>
        <div><span class="text-muted"><i class="fas fa-chart-line"></i> Reports</span></div>
    </div>
</nav>

<div class="container">
    <a href="index.jsp" class="btn-back mt-3"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
    
    <div class="glass-card">
        <div class="text-center mb-4">
            <i class="fas fa-chart-pie fa-3x" style="color: #667eea;"></i>
            <h2 class="fw-bold mt-2">Reports Dashboard</h2>
            <p class="text-muted">Generate financial reports and analysis</p>
        </div>
        
        <div class="option-card">
            <i class="fas fa-calendar-alt fa-2x text-primary mb-2"></i>
            <h4>📅 Date Range Report</h4>
            <p>Generate report for specific date period</p>
            <div class="report-desc">Select start and end date to filter payments</div>
            <a href="report_form.jsp" class="btn-report mt-2 d-inline-block">Generate</a>
        </div>
        
        <div class="option-card">
            <i class="fas fa-exclamation-triangle fa-2x text-danger mb-2"></i>
            <h4>⚠️ Overdue Payments</h4>
            <p>Students with payments past due date</p>
            <div class="report-desc">Status = 'Pending' AND PaymentDate &lt; Current Date</div>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="overdue">
                <button type="submit" class="btn-report mt-2">View Overdue</button>
            </form>
        </div>
        
        <div class="option-card">
            <i class="fas fa-clock fa-2x text-warning mb-2"></i>
            <h4>⏳ Pending Payments</h4>
            <p>All students with pending payment status</p>
            <div class="report-desc">Status = 'Pending' (regardless of date)</div>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="notpaid">
                <button type="submit" class="btn-report mt-2">View Pending</button>
            </form>
        </div>
        
        <div class="option-card">
            <i class="fas fa-check-circle fa-2x text-success mb-2"></i>
            <h4>✅ Paid Payments</h4>
            <p>All completed payments</p>
            <div class="report-desc">Status = 'Paid'</div>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="paid">
                <button type="submit" class="btn-report mt-2">View Paid</button>
            </form>
        </div>
        
        <div class="option-card">
            <i class="fas fa-list fa-2x text-info mb-2"></i>
            <h4>📋 All Payments</h4>
            <p>Complete payment records</p>
            <div class="report-desc">All records in the database</div>
            <form action="ReportCriteriaServlet" method="post">
                <input type="hidden" name="reportType" value="all">
                <button type="submit" class="btn-report mt-2">View All</button>
            </form>
        </div>
        
        <div class="alert alert-info mt-3">
            <i class="fas fa-info-circle me-2"></i>
            <strong>Report Types Explained:</strong>
            <ul class="mt-2 mb-0">
                <li><strong>Overdue:</strong> Payments that are PENDING AND the payment date has passed</li>
                <li><strong>Pending:</strong> All payments with PENDING status (including overdue)</li>
                <li><strong>Paid:</strong> All successfully completed payments</li>
                <li><strong>Date Range:</strong> Filter payments between specific dates</li>
            </ul>
        </div>
    </div>
</div>

<footer><p><i class="fas fa-copyright"></i> 2024 College Fee Management System | Secure & Reliable</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>