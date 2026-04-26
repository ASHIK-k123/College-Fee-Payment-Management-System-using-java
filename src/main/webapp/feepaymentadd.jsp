<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Payment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
.card {
    max-width: 500px;
    margin: auto;
}
body {
    background: linear-gradient(135deg, #89f7fe, #66a6ff);
}
</style>

<script>
function validateForm() {
    let id = document.forms["form"]["studentId"].value;
    let name = document.forms["form"]["studentName"].value;
    let date = document.forms["form"]["paymentDate"].value;
    let amount = document.forms["form"]["amount"].value;

    if (id === "" || name === "" || date === "" || amount === "") {
        alert("All fields are required!");
        return false;
    }

    if (amount <= 0) {
        alert("Amount must be greater than 0");
        return false;
    }

    return true;
}
</script>

</head>

<body class="bg-light">

<nav class="navbar navbar-dark bg-primary">
    <div class="container">
        <span class="navbar-brand">Add Fee Payment</span>
    </div>
</nav>

<div class="container mt-4">

<a href="index.jsp" class="btn btn-secondary mb-3">← Back</a>

<div class="card p-4 shadow-sm">

<h4 class="mb-3 text-center">Enter Payment Details</h4>

<form name="form" action="AddFeePaymentServlet" method="post" onsubmit="return validateForm()">

<div class="mb-2">
<label>Student ID</label>
<input type="number" name="studentId" class="form-control" required>
</div>

<div class="mb-2">
<label>Student Name</label>
<input type="text" name="studentName" class="form-control" required>
</div>

<div class="mb-2">
<label>Payment Date</label>
<input type="date" name="paymentDate" class="form-control" required>
</div>

<div class="mb-2">
<label>Amount</label>
<input type="number" name="amount" class="form-control" required>
</div>

<div class="mb-3">
<label>Status</label>
<select name="status" class="form-control" required>
<option value="">-- Select Status --</option>
<option value="Paid">Paid</option>
<option value="Overdue">Overdue</option>
<option value="Not Paid">Not Paid</option>
</select>
</div>

<button class="btn btn-success w-100">Submit Payment</button>

</form>
</div>
</div>

</body>
</html>