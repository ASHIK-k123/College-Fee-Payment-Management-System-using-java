<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Fee Management System</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* 🌄 Background Image */
body {
    background: url('images/bg.jpg') no-repeat center center/cover;
    font-family: 'Segoe UI', sans-serif;
    height: 100vh;
}

/* 🌫️ Overlay */
.overlay {
    background: rgba(0,0,0,0.5);
    min-height: 100vh;
    padding: 40px;
}

/* 🧊 Glass Card */
.glass {
    background: rgba(255, 255, 255, 0.15);
    backdrop-filter: blur(10px);
    border-radius: 15px;
    padding: 25px;
    color: white;
    text-align: center;
    box-shadow: 0 8px 25px rgba(0,0,0,0.3);
    transition: 0.3s;
}

/* Hover Effect */
.glass:hover {
    transform: translateY(-5px);
}

/* 🏷️ Title */
.title-box {
    background: rgba(255,255,255,0.8);
    color: #333;
    border-radius: 15px;
    padding: 20px;
    text-align: center;
    margin-bottom: 30px;
}

/* 🔘 Buttons */
.btn-custom {
    background: linear-gradient(45deg, #6a11cb, #2575fc);
    border: none;
    color: white;
    padding: 8px 20px;
    border-radius: 20px;
    margin-top: 10px;
}

.btn-custom:hover {
    opacity: 0.9;
}

/* Layout spacing */
.row-gap {
    row-gap: 20px;
}

</style>

</head>

<body>

<div class="overlay">

<div class="container">

    <!-- 🏠 Title -->
    <div class="title-box">
        <h2>🏫 Fee Management System</h2>
        <p>Manage student fee records efficiently</p>
    </div>

    <!-- 📦 Cards -->
    <div class="row text-center row-gap">

        <!-- Add -->
        <div class="col-md-4">
            <div class="glass">
                <h4>➕ Add Payment</h4>
                <p>Add new fee records</p>
                <a href="feepaymentadd.jsp" class="btn btn-custom">Add</a>
            </div>
        </div>

        <!-- Update -->
        <div class="col-md-4">
            <div class="glass">
                <h4>✏️ Update Payment</h4>
                <p>Modify payment details</p>
                <a href="feepaymentupdate.jsp" class="btn btn-custom">Update</a>
            </div>
        </div>

        <!-- Delete -->
        <div class="col-md-4">
            <div class="glass">
                <h4>🗑 Delete Payment</h4>
                <p>Remove payment record</p>
                <a href="feepaymentdelete.jsp" class="btn btn-custom">Delete</a>
            </div>
        </div>

        <!-- Display -->
        <div class="col-md-6">
            <div class="glass">
                <h4>📋 View Payments</h4>
                <p>See all payment details</p>
                <a href="DisplayFeePaymentsServlet" class="btn btn-custom">View</a>
            </div>
        </div>

        <!-- Reports -->
        <div class="col-md-6">
            <div class="glass">
                <h4>📊 Reports</h4>
                <p>Generate reports & analysis</p>
                <a href="reports.jsp" class="btn btn-custom">Reports</a>
            </div>
        </div>

    </div>

</div>

</div>

</body>
</html>