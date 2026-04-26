<%@ page import="java.util.*,com.model.FeePayment" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Results</title>

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #f4f6f9;
}

.table th {
    background: #0d6efd;
    color: white;
}

.badge-paid {
    background: #28a745;
}

.badge-other {
    background: #dc3545;
}
</style>

</head>

<body>

<div class="container mt-5">

<a href="reports.jsp" class="btn btn-secondary mb-3">Back</a>

<h4 class="text-primary mb-3">Report Results</h4>

<div class="table-responsive">
<table class="table table-bordered table-hover text-center">

<tr>
<th>ID</th>
<th>Name</th>
<th>Amount</th>
<th>Status</th>
</tr>

<%
List<FeePayment> list = (List<FeePayment>)request.getAttribute("list");

if(list != null && !list.isEmpty()){
    for(FeePayment f : list){
%>

<tr>
<td><%=f.getPaymentId()%></td>
<td><%=f.getStudentName()%></td>
<td>Rs. <%= String.format("%.2f", f.getAmount()) %></td>
<td>
<% if("Paid".equalsIgnoreCase(f.getStatus())){ %>
    <span class="badge badge-paid">Paid</span>
<% } else { %>
    <span class="badge badge-other"><%=f.getStatus()%></span>
<% } %>
</td>
</tr>

<%
    }
} else {
%>

<tr>
<td colspan="4">No Records Found</td>
</tr>

<%
}
%>

</table>
</div>

</div>

</body>
</html>