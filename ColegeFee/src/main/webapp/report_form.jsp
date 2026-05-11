<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management | Date Range Report</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    :root { --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%); }
    body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
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
        max-width: 500px;
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
    .btn-generate {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        padding: 12px;
        font-weight: 600;
        border-radius: 50px;
        color: white;
        width: 100%;
    }
    .btn-generate:hover { transform: scale(1.02); }
    .form-control { border-radius: 15px; padding: 12px 15px; }
    footer { text-align: center; color: white; margin-top: 30px; padding: 20px; }
</style>
<script>
    function validateForm() {
        let from = document.getElementById("fromDate").value;
        let to = document.getElementById("toDate").value;
        if (from === "" || to === "") {
            alert("Please select both dates!");
            return false;
        }
        if (from > to) {
            alert("From Date cannot be greater than To Date!");
            return false;
        }
        return true;
    }
</script>
</head>
<body>

<nav class="navbar navbar-custom sticky-top">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-graduation-cap me-2"></i>College Fee Management System</span>
        <div><span class="text-muted"><i class="fas fa-calendar"></i> Date Range Report</span></div>
    </div>
</nav>

<div class="container">
    <a href="reports.jsp" class="btn-back mt-3"><i class="fas fa-arrow-left me-2"></i>Back to Reports</a>
    
    <div class="glass-card">
        <div class="text-center mb-4">
            <i class="fas fa-calendar-alt fa-3x" style="color: #667eea;"></i>
            <h2 class="fw-bold mt-2">Date Range Report</h2>
            <p class="text-muted">Generate report for specific date period</p>
        </div>
        
        <form action="ReportCriteriaServlet" method="post" onsubmit="return validateForm()">
            <input type="hidden" name="reportType" value="date">
            
            <div class="mb-3">
                <label class="form-label fw-bold">From Date</label>
                <input type="date" id="fromDate" name="fromDate" class="form-control" required>
            </div>
            
            <div class="mb-3">
                <label class="form-label fw-bold">To Date</label>
                <input type="date" id="toDate" name="toDate" class="form-control" required>
            </div>
            
            <button type="submit" class="btn-generate mt-3"><i class="fas fa-chart-line me-2"></i>Generate Report</button>
        </form>
    </div>
</div>

<footer><p><i class="fas fa-copyright"></i> 2024 College Fee Management System | Secure & Reliable</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>