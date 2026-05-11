<%@ page import="java.util.*,com.model.FeePayment" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management | Payment Records</title>
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
        padding: 25px;
        margin: 20px 0;
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
    .status-paid { background: #28a745; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; display: inline-block; }
    .status-pending { background: #ffc107; color: black; padding: 5px 12px; border-radius: 20px; font-size: 12px; display: inline-block; }
    .status-overdue { background: #dc3545; color: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; display: inline-block; }
    .table-custom thead th { background: var(--primary-gradient); color: white; padding: 15px; }
    .table-custom tbody tr:hover { background: rgba(102,126,234,0.1); }
    footer { text-align: center; color: white; margin-top: 30px; padding: 20px; }
    @media (max-width: 768px) {
        .table-responsive { font-size: 12px; }
        .table-custom thead th, .table-custom td { padding: 8px; }
    }
    /* Stats Container */
.stats-container {
    display: flex;
    gap: 20px;
    margin: 10px 0;
}

/* Modern Stat Card */
.stat-card {
    flex: 1;
    background: linear-gradient(135deg, rgba(255,255,255,0.15), rgba(255,255,255,0.05));
    backdrop-filter: blur(10px);
    border-radius: 20px;
    padding: 20px;
    position: relative;
    overflow: hidden;
    transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    border: 1px solid rgba(255,255,255,0.2);
    cursor: pointer;
}

.stat-card::before {
    content: '';
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
    transform: rotate(45deg);
    transition: all 0.6s ease;
    opacity: 0;
}

.stat-card:hover::before {
    opacity: 1;
    transform: rotate(0deg);
}

.stat-card:hover {
    transform: translateY(-10px) scale(1.02);
    box-shadow: 0 20px 40px rgba(0,0,0,0.3);
}

/* Students Card */
.stat-card-students {
    background: linear-gradient(135deg, rgba(23,162,184,0.25), rgba(23,162,184,0.1));
    border-bottom: 3px solid #17a2b8;
}

.stat-card-students:hover {
    box-shadow: 0 20px 40px rgba(23,162,184,0.3);
}

/* Collection Card */
.stat-card-collection {
    background: linear-gradient(135deg, rgba(40,167,69,0.25), rgba(40,167,69,0.1));
    border-bottom: 3px solid #28a745;
}

.stat-card-collection:hover {
    box-shadow: 0 20px 40px rgba(40,167,69,0.3);
}

/* Card Icon */
.stat-icon {
    position: absolute;
    top: 15px;
    right: 15px;
    font-size: 3rem;
    opacity: 0.3;
    transition: all 0.3s ease;
}

.stat-card:hover .stat-icon {
    opacity: 0.8;
    transform: scale(1.1) rotate(5deg);
}

/* Card Content */
.stat-content {
    position: relative;
    z-index: 1;
}

.stat-label {
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 2px;
    font-weight: 600;
    margin-bottom: 10px;
    display: inline-block;
    padding: 5px 12px;
    border-radius: 20px;
    background: rgba(0,0,0,0.3);
}

.stat-number {
    font-size: 2.5rem;
    font-weight: 800;
    margin: 10px 0;
    line-height: 1;
}

.stat-subtitle {
    font-size: 0.8rem;
    opacity: 0.8;
    margin-top: 10px;
}

/* Students specific colors */
.stat-card-students .stat-label {
    color: #17a2b8;
    background: rgba(23,162,184,0.2);
}

.stat-card-students .stat-number {
    color: #17a2b8;
}

/* Collection specific colors */
.stat-card-collection .stat-label {
    color: #28a745;
    background: rgba(40,167,69,0.2);
}

.stat-card-collection .stat-number {
    color: #28a745;
}

/* Animation */
@keyframes countUp {
    from {
        opacity: 0;
        transform: translateY(20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

.stat-number {
    animation: countUp 0.8s ease-out;
}

/* Responsive */
@media (max-width: 768px) {
    .stats-container {
        flex-direction: column;
        gap: 15px;
    }
    
    .stat-number {
        font-size: 1.8rem;
    }
}
</style>
</head>
<body>

<%
List<FeePayment> list = (List<FeePayment>)request.getAttribute("list");
Double totalCollection = (Double)request.getAttribute("total");
Integer count = (Integer)request.getAttribute("count");
String searchValue = (String)request.getAttribute("searchValue");

if(totalCollection == null) totalCollection = 0.0;
if(count == null) count = 0;
%>

<nav class="navbar navbar-custom sticky-top">
    <div class="container">
        <span class="navbar-brand"><i class="fas fa-graduation-cap me-2"></i>College Fee Management System</span>
        <div><span class="text-muted"><i class="fas fa-chart-line"></i> Payment Records</span></div>
    </div>
</nav>

<div class="container">
    <a href="index.jsp" class="btn-back mt-3"><i class="fas fa-arrow-left me-2"></i>Back to Dashboard</a>
    
    <div class="glass-card">
        <h3 class="text-center mb-4">📋 Payment Records</h3>
        
        <div class="row mb-4">
            <div class="col-md-6 mx-auto">
                <form action="DisplayFeePaymentsServlet" method="get" class="d-flex">
                    <input type="text" name="search" class="form-control me-2" placeholder="Search by name..." value="<%= searchValue != null ? searchValue : "" %>">
                    <button type="submit" class="btn btn-primary">Search</button>
                </form>
            </div>
        </div>
        <div class="stats-container">
    <!-- Students Card -->
    <div class="stat-card stat-card-students">
        <div class="stat-icon">
            <i class="fas fa-users"></i>
        </div>
        <div class="stat-content">
            <div class="stat-label">
                <i class="fas fa-user-graduate me-1"></i> TOTAL STUDENTS
            </div>
            <div class="stat-number">
                <%= count %>
            </div>
            <div class="stat-subtitle">
                <i class="fas fa-chart-line me-1"></i> Active Records
            </div>
        </div>
    </div>
    
    <!-- Collection Card -->
    <div class="stat-card stat-card-collection">
        <div class="stat-icon">
            <i class="fas fa-coins"></i>
        </div>
        <div class="stat-content">
            <div class="stat-label">
                <i class="fas fa-rupee-sign me-1"></i> TOTAL COLLECTION
            </div>
            <div class="stat-number">
                ₹<%= String.format("%.2f", totalCollection) %>
            </div>
            <div class="stat-subtitle">
                <i class="fas fa-calendar-alt me-1"></i> Lifetime Revenue
            </div>
        </div>
    </div>
</div>
        <div class="table-responsive">
            <table class="table table-bordered table-custom">
                <thead>
                    <tr>
                        <th>Payment ID</th>
                        <th>Student ID</th>
                        <th>Student Name</th>
                        <th>Department</th>
                        <th>Payment Date</th>
                        <th>Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% if(list != null && !list.isEmpty()) {
                        for(FeePayment f : list) { %>
                            <tr>
                                <td><%= f.getPaymentId() %></td>
                                <td><%= f.getStudentId() %></td>
                                <td><%= f.getStudentName() %></td>
                                <td><%= f.getDepartment() %></td>
                                <td><%= f.getPaymentDate() %></td>
                                <td>₹<%= String.format("%.2f", f.getAmount()) %></td>
                                <td>
                                    <% if("Paid".equalsIgnoreCase(f.getStatus())) { %>
                                        <span class="status-paid"><i class="fas fa-check-circle"></i> Paid</span>
                                    <% } else if("Pending".equalsIgnoreCase(f.getStatus())) { %>
                                        <span class="status-pending"><i class="fas fa-clock"></i> Pending</span>
                                    <% } else if("Overdue".equalsIgnoreCase(f.getStatus())) { %>
                                        <span class="status-overdue"><i class="fas fa-exclamation-triangle"></i> Overdue</span>
                                    <% } else { %>
                                        <span><%= f.getStatus() %></span>
                                    <% } %>
                                </td>
                            </tr>
                    <%   }
                    } else { %>
                        <tr><td colspan="7" class="text-center">No records found</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>
        

        </div>
    </div>
</div>

<footer><p><i class="fas fa-copyright"></i> 2024 College Fee Management System | Secure & Reliable</p></footer>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>