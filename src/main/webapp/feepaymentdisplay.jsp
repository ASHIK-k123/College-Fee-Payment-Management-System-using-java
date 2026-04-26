<%@ page import="java.util.*,com.model.FeePayment" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Payments</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>

/* 🎨 DISPLAY THEME (Cool Blue Mix) */
body {
    background: linear-gradient(135deg, #89f7fe, #66a6ff);
}

/* Card */
.card {
    border-radius: 12px;
    box-shadow: 0 8px 20px rgba(0,0,0,0.15);
}

/* Table Header */
.table th {
    background-color: #343a40;
    color: white;
}

/* Status colors */
.status-paid {
    color: green;
    font-weight: bold;
}

.status-other {
    color: red;
    font-weight: bold;
}

</style>

</head>

<body>

<div class="container mt-5">

<a href="index.jsp" class="btn btn-secondary mb-3">Back</a>

<div class="card p-4">

<h4 class="mb-3 text-center">All Fee Payments</h4>

<!-- 🔍 Search -->
<form action="DisplayFeePaymentsServlet" method="get" class="mb-3 d-flex">
<input type="text" name="search" class="form-control me-2" placeholder="Search by name">
<button class="btn btn-primary">Search</button>
</form>

<!-- 📊 Table -->
<table class="table table-bordered text-center">

<tr>
<th>ID</th>
<th>Name</th>
<th>Amount</th>
<th>Status</th>
</tr>

<%
List<FeePayment> list=(List<FeePayment>)request.getAttribute("list");

if(list!=null && !list.isEmpty()){
for(FeePayment f:list){
%>

<tr>
<td><%=f.getPaymentId()%></td>
<td><%=f.getStudentName()%></td>
<td>Rs. <%=String.format("%.2f", f.getAmount())%></td>
<td>
<% if("Paid".equalsIgnoreCase(f.getStatus())){ %>
<span class="status-paid">Paid</span>
<% } else { %>
<span class="status-other"><%=f.getStatus()%></span>
<% } %>
</td>
</tr>

<%
}
}else{
%>

<tr>
<td colspan="4">No Records Found</td>
</tr>

<%
}
%>

</table>

<!-- 💰 Total -->
<%
Double total = (Double)request.getAttribute("total");
if(total == null) total = 0.0;
%>

<h5 class="text-end text-success mt-3">
Total Collection: Rs. <%=String.format("%.2f", total)%>
</h5>

</div>
</div>

</body>
</html>