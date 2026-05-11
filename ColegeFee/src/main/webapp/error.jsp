<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Error | College Fee Management System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
    body {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .error-card {
        background: rgba(255,255,255,0.95);
        backdrop-filter: blur(10px);
        border-radius: 30px;
        box-shadow: 0 20px 60px rgba(0,0,0,0.3);
        padding: 40px;
        text-align: center;
        max-width: 500px;
        margin: 20px;
    }
    .btn-home {
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        border: none;
        padding: 12px 30px;
        border-radius: 50px;
        color: white;
        text-decoration: none;
        display: inline-block;
    }
    .btn-home:hover { transform: scale(1.02); color: white; }
</style>
</head>
<body>
<div class="error-card">
    <i class="fas fa-exclamation-triangle fa-4x" style="color: #dc3545;"></i>
    <h2 class="mt-3">Oops! Something went wrong</h2>
    <p class="text-muted">We encountered an error while processing your request.</p>
    
    <% if(request.getAttribute("errorMsg") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("errorMsg") %></div>
    <% } else if(exception != null) { %>
        <div class="alert alert-danger"><%= exception.getMessage() %></div>
    <% } else { %>
        <div class="alert alert-danger">An unexpected error occurred. Please try again.</div>
    <% } %>
    
    <a href="index.jsp" class="btn-home mt-3"><i class="fas fa-home me-2"></i>Back to Home</a>
</div>
</body>
</html>