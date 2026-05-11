package com.model;

import java.time.LocalDate;
import java.util.regex.Pattern;

public class FeePayment {

    private int studentId;
    private int paymentId;
    private String studentName;
    private String department;
    private String paymentDate;
    private double amount;
    private String status;
    private String validationError;

    // Getters and Setters
    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }
    
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName;
    }
    
    public String getDepartment() {
        return department;
    }

    public void setDepartment(String department) {
        this.department = department;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
    public String getValidationError() {
        return validationError;
    }
    
    public boolean validateForAdd() {
        if (studentName == null || studentName.trim().isEmpty()) {
            validationError = "Student name is required";
            return false;
        }
        String nameRegex = "^[A-Za-z\\s]{2,50}$";
        if (!Pattern.matches(nameRegex, studentName.trim())) {
            validationError = "Student name must be 2-50 characters and contain only letters and spaces";
            return false;
        }
        
        if (department == null || department.trim().isEmpty()) {
            validationError = "Department is required";
            return false;
        }
        
        if (amount < 100) {
            validationError = "Amount must be at least ₹100";
            return false;
        }
        if (amount > 500000) {
            validationError = "Amount cannot exceed ₹500,000";
            return false;
        }
        
        return true;
    }
    
    public boolean validateForUpdate() {
        if (studentId <= 0) {
            validationError = "Valid Student ID is required";
            return false;
        }
        if (studentName == null || studentName.trim().isEmpty()) {
            validationError = "Student name is required";
            return false;
        }
        if (department == null || department.trim().isEmpty()) {
            validationError = "Department is required";
            return false;
        }
        if (amount < 100) {
            validationError = "Amount must be at least ₹100";
            return false;
        }
        if (amount > 500000) {
            validationError = "Amount cannot exceed ₹500,000";
            return false;
        }
        if (status == null || status.trim().isEmpty()) {
            validationError = "Status is required";
            return false;
        }
        if (!status.equalsIgnoreCase("Paid") && !status.equalsIgnoreCase("Pending") && !status.equalsIgnoreCase("Overdue")) {
            validationError = "Status must be 'Paid', 'Pending', or 'Overdue'";
            return false;
        }
        return true;
    }
    
    public boolean validateForDelete() {
        if (studentId <= 0) {
            validationError = "Valid Student ID is required for deletion";
            return false;
        }
        return true;
    }
}