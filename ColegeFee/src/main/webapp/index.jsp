<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>College Fee Management System | Dashboard</title>

<!-- Bootstrap 5 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Animate.css -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">

<style>
    :root {
        --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        --success-gradient: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
        --danger-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
        --warning-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
        --info-gradient: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
    }
    
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }
    
    body {
        background: url('images/bg.jpg') no-repeat center center fixed;
        background-size: cover;
        font-family: 'Poppins', 'Segoe UI', sans-serif;
        min-height: 100vh;
        position: relative;
        overflow-x: hidden;
    }
    
    /* Dark overlay for better text readability */
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
    
    /* Floating animation for cards */
    @keyframes float {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(-10px); }
    }
    
    @keyframes floatReverse {
        0%, 100% { transform: translateY(0px); }
        50% { transform: translateY(10px); }
    }
    
    @keyframes slideInFromTop {
        from {
            opacity: 0;
            transform: translateY(-50px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
    
    @keyframes fadeInScale {
        from {
            opacity: 0;
            transform: scale(0.8);
        }
        to {
            opacity: 1;
            transform: scale(1);
        }
    }
    
    /* Navbar styling */
    .navbar-custom {
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(10px);
        box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        padding: 1rem 0;
        animation: slideInFromTop 0.8s ease-out;
    }
    
    .navbar-brand {
        font-size: 1.8rem;
        font-weight: 700;
        background: var(--primary-gradient);
        -webkit-background-clip: text;
        background-clip: text;
        color: transparent !important;
        letter-spacing: 1px;
    }
    
    /* Welcome section */
    .welcome-section {
        text-align: center;
        color: white;
        margin: 30px 0 50px;
        animation: slideInFromTop 0.6s ease-out;
    }
    
    .welcome-title {
        font-size: 3rem;
        font-weight: 700;
        margin-bottom: 10px;
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }
    
    .welcome-subtitle {
        font-size: 1.1rem;
        opacity: 0.95;
    }
    
    /* Card styling - Glass effect */
    .dashboard-card {
        background: rgba(255, 255, 255, 0.95);
        backdrop-filter: blur(10px);
        border-radius: 25px;
        padding: 30px 20px;
        text-align: center;
        transition: all 0.4s ease;
        border: 1px solid rgba(255,255,255,0.2);
        position: relative;
        overflow: hidden;
        cursor: pointer;
        animation: fadeInScale 0.6s ease-out;
        box-shadow: 0 8px 25px rgba(0,0,0,0.3);
        height: 100%;
    }
    
    .dashboard-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: -100%;
        width: 100%;
        height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.15), transparent);
        transition: left 0.6s ease;
    }
    
    .dashboard-card:hover::before {
        left: 100%;
    }
    
    .dashboard-card:hover {
        transform: translateY(-15px) scale(1.02);
        box-shadow: 0 20px 40px rgba(0,0,0,0.4);
    }
    
    /* Card icon styles */
    .card-icon {
        width: 80px;
        height: 80px;
        margin: 0 auto 20px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        font-size: 2.5rem;
        transition: all 0.3s ease;
        background: var(--primary-gradient);
        color: white;
    }
    
    .dashboard-card:hover .card-icon {
        transform: scale(1.1) rotate(5deg);
    }
    
    .card-title {
        font-size: 1.5rem;
        font-weight: 700;
        margin-bottom: 10px;
        color: #333;
    }
    
    .card-description {
        color: #666;
        font-size: 0.9rem;
        margin-bottom: 20px;
    }
    
    /* Button styles within cards */
    .card-btn {
        border: none;
        padding: 10px 25px;
        border-radius: 50px;
        font-weight: 600;
        transition: all 0.3s ease;
        text-decoration: none;
        display: inline-block;
        background: var(--primary-gradient);
        color: white;
    }
    
    .card-btn:hover {
        transform: scale(1.05);
        box-shadow: 0 5px 15px rgba(0,0,0,0.2);
        color: white;
    }
    
    /* Color variations for cards */
    .card-add { border-bottom: 4px solid #28a745; }
    .card-add .card-icon { background: linear-gradient(135deg, #28a745, #20c997); }
    .card-add .card-btn { background: linear-gradient(135deg, #28a745, #20c997); }
    
    .card-update { border-bottom: 4px solid #ffc107; }
    .card-update .card-icon { background: linear-gradient(135deg, #ffc107, #ff9800); }
    .card-update .card-btn { background: linear-gradient(135deg, #ffc107, #ff9800); }
    
    .card-delete { border-bottom: 4px solid #dc3545; }
    .card-delete .card-icon { background: linear-gradient(135deg, #dc3545, #c82333); }
    .card-delete .card-btn { background: linear-gradient(135deg, #dc3545, #c82333); }
    
    .card-view { border-bottom: 4px solid #17a2b8; }
    .card-view .card-icon { background: linear-gradient(135deg, #17a2b8, #00f2fe); }
    .card-view .card-btn { background: linear-gradient(135deg, #17a2b8, #00f2fe); }
    
    .card-report { border-bottom: 4px solid #6610f2; }
    .card-report .card-icon { background: linear-gradient(135deg, #6610f2, #aa00ff); }
    .card-report .card-btn { background: linear-gradient(135deg, #6610f2, #aa00ff); }
    
    /* Footer */
    footer {
        text-align: center;
        color: white;
        margin-top: 60px;
        padding: 20px;
        background: rgba(0,0,0,0.3);
        border-radius: 15px;
        backdrop-filter: blur(5px);
    }
    
    /* Responsive */
    @media (max-width: 768px) {
        .welcome-title {
            font-size: 2rem;
        }
        
        .dashboard-card {
            margin-bottom: 20px;
        }
        
        .card-icon {
            width: 60px;
            height: 60px;
            font-size: 1.8rem;
        }
        
        .card-title {
            font-size: 1.2rem;
        }
    }
    
    /* Clock/Date display */
    .datetime {
        font-size: 0.9rem;
        background: rgba(0,0,0,0.7);
        padding: 5px 15px;
        border-radius: 50px;
        display: inline-block;
        color: white;
    }
    
    /* Quick Tips Section */
    .tips-container {
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(10px);
        border: 1px solid rgba(255,255,255,0.2);
        border-radius: 15px;
        color: #333;
        margin-top: 30px;
    }
</style>

</head>

<body>

<!-- Navbar -->
<nav class="navbar navbar-custom sticky-top">
    <div class="container">
        <span class="navbar-brand">
            <i class="fas fa-graduation-cap me-2"></i>
            College Fee Management System
        </span>
        <div>
            <span class="datetime" id="datetime">
                <i class="fas fa-calendar-alt me-1"></i>
                <span id="currentDate"></span>
                <i class="fas fa-clock ms-2 me-1"></i>
                <span id="currentTime"></span>
            </span>
        </div>
    </div>
</nav>

<div class="container">
    
    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1 class="welcome-title">
            <i class="fas fa-hand-peace me-2"></i>Welcome Admin!
        </h1>
        <p class="welcome-subtitle">
            Manage student fee payments efficiently with our comprehensive dashboard
        </p>
    </div>
    
    <!-- Dashboard Cards -->
    <div class="row g-4">
        
        <!-- Add Payment Card -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card card-add">
                <div class="card-icon">
                    <i class="fas fa-plus-circle"></i>
                </div>
                <h3 class="card-title">Add Payment</h3>
                <p class="card-description">Record new fee payments for students</p>
                <a href="feepaymentadd.jsp" class="card-btn">
                    <i class="fas fa-arrow-right me-2"></i>Add New
                </a>
            </div>
        </div>
        
        <!-- Update Payment Card -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card card-update">
                <div class="card-icon">
                    <i class="fas fa-edit"></i>
                </div>
                <h3 class="card-title">Update Payment</h3>
                <p class="card-description">Modify existing payment details</p>
                <a href="feepaymentupdate.jsp" class="card-btn">
                    <i class="fas fa-arrow-right me-2"></i>Update
                </a>
            </div>
        </div>
        
        <!-- Delete Payment Card -->
        <div class="col-lg-4 col-md-6">
            <div class="dashboard-card card-delete">
                <div class="card-icon">
                    <i class="fas fa-trash-alt"></i>
                </div>
                <h3 class="card-title">Delete Payment</h3>
                <p class="card-description">Remove payment records permanently</p>
                <a href="feepaymentdelete.jsp" class="card-btn">
                    <i class="fas fa-arrow-right me-2"></i>Delete
                </a>
            </div>
        </div>
        
        <!-- View Payments Card -->
        <div class="col-lg-6 col-md-6">
            <div class="dashboard-card card-view">
                <div class="card-icon">
                    <i class="fas fa-table"></i>
                </div>
                <h3 class="card-title">View Payments</h3>
                <p class="card-description">View all fee payment records in detail</p>
                <a href="DisplayFeePaymentsServlet" class="card-btn">
                    <i class="fas fa-arrow-right me-2"></i>View All
                </a>
            </div>
        </div>
        
        <!-- Reports Card -->
        <div class="col-lg-6 col-md-6">
            <div class="dashboard-card card-report">
                <div class="card-icon">
                    <i class="fas fa-chart-bar"></i>
                </div>
                <h3 class="card-title">Reports</h3>
                <p class="card-description">Generate financial reports and analysis</p>
                <a href="reports.jsp" class="card-btn">
                    <i class="fas fa-arrow-right me-2"></i>Generate
                </a>
            </div>
        </div>
        
    </div>
    
    <!-- Quick Tips Section -->
    <div class="row mt-5">
        <div class="col-12">
            <div class="tips-container p-3">
                <div class="d-flex align-items-center">
                    <i class="fas fa-lightbulb fa-2x me-3" style="color: #ffc107;"></i>
                    <div>
                        <strong>Quick Tips:</strong><br>
                        <small>• Use the search feature to find specific student records<br>
                        • Generate reports for better financial insights<br>
                        • Double-check details before updating or deleting records</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</div>

<!-- Footer -->
<footer>
    <div class="container">
        <p class="mb-0">
            <i class="fas fa-copyright me-1"></i> 
            2024 College Fee Management System | 
            <i class="fas fa-shield-alt me-1 ms-2"></i> Secure & Reliable |
            <i class="fas fa-code me-1 ms-2"></i> Version 2.0
        </p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    // Update date and time in real-time
    function updateDateTime() {
        const now = new Date();
        
        // Format date
        const options = { year: 'numeric', month: 'long', day: 'numeric' };
        const dateString = now.toLocaleDateString('en-US', options);
        
        // Format time
        const timeString = now.toLocaleTimeString('en-US', { hour: '2-digit', minute: '2-digit', second: '2-digit' });
        
        document.getElementById('currentDate').innerText = dateString;
        document.getElementById('currentTime').innerText = timeString;
    }
    
    updateDateTime();
    setInterval(updateDateTime, 1000);
    
    // Add animation delay to cards
    document.querySelectorAll('.dashboard-card').forEach((card, index) => {
        card.style.animationDelay = `${index * 0.1}s`;
    });
    
    // Smooth scroll for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({ behavior: 'smooth' });
            }
        });
    });
    
    // Add animation class on load
    window.addEventListener('load', () => {
        document.body.classList.add('loaded');
    });
</script>

</body>
</html>