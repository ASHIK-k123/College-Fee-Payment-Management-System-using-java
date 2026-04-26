<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Delete Payment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* 🎨 DELETE THEME (Soft Red Mix) */
body {
    background: linear-gradient(135deg, #ff9a9e, #fecfef);
}

/* Card */
.card {
    max-width: 400px;
    margin: auto;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

</style>

<script>
function confirmDelete(){
    return confirm("Are you sure you want to delete this payment?");
}
</script>

</head>

<body>

<div class="container mt-5">

<a href="index.jsp" class="btn btn-secondary mb-3">← Back</a>

<div class="card p-4">

<h4 class="text-center text-danger mb-3">Delete Fee Payment</h4>

<form action="DeleteFeePaymentServlet" method="post" onsubmit="return confirmDelete()">

<div class="mb-3">
<label>Payment ID</label>
<input type="number" name="paymentId" class="form-control" required>
</div>

<button class="btn btn-danger w-100">Delete</button>

</form>

</div>
</div>

</body>
</html>