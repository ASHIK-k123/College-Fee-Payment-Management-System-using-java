<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Generate Report</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: linear-gradient(135deg, #e0eafc, #cfdef3);
}

.card {
    max-width: 450px;
    margin: auto;
    margin-top: 80px;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.1);
}
</style>

</head>

<body>

<div class="container">

<a href="reports.jsp" class="btn btn-secondary mt-4">← Back</a>

<div class="card">

<h4 class="text-center text-primary mb-3">Generate Report</h4>

<form action="ReportCriteriaServlet" method="post">

<label>Report Type</label>
<select name="reportType" class="form-control mb-3" required>
<option value="">-- Select --</option>
<option value="overdue">Overdue</option>
<option value="notpaid">Not Paid</option>
<option value="date">Date Range</option>
</select>

<label>From Date</label>
<input type="date" name="fromDate" class="form-control mb-2">

<label>To Date</label>
<input type="date" name="toDate" class="form-control mb-3">

<button class="btn btn-primary w-100">Generate Report</button>

</form>

</div>
</div>

</body>
</html>