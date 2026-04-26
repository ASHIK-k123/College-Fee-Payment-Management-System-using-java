<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Payment</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* 🎨 UPDATE THEME (Blue Mixed Gradient) */
body {
    background: linear-gradient(135deg, #a1c4fd, #c2e9fb);
}

/* Card */
.card {
    max-width: 450px;
    margin: auto;
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

</style>

<script>
function validateForm(){
    let id = document.forms["form"]["paymentId"].value;
    let amount = document.forms["form"]["amount"].value;

    if(id === "" || amount === ""){
        alert("All fields are required");
        return false;
    }

    if(amount <= 0){
        alert("Amount must be greater than 0");
        return false;
    }

    return true;
}
</script>

</head>

<body>

<div class="container mt-5">

<a href="index.jsp" class="btn btn-secondary mb-3">← Back</a>

<div class="card p-4">

<h4 class="text-center text-primary mb-3">Update Fee Payment</h4>

<form name="form" action="UpdateFeePaymentServlet" method="post" onsubmit="return validateForm()">

<div class="mb-2">
<label>Payment ID</label>
<input type="number" name="paymentId" class="form-control" required>
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

<button class="btn btn-primary w-100">Update Payment</button>

</form>

</div>
</div>

</body>
</html>