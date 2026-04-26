package com.dao;

import java.sql.*;
import java.util.*;
import com.model.FeePayment;

public class FeePaymentDAO {

    Connection con;

    public Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/college_fee","root","ak@12345");
        return con;
    }

    // ADD
    public void add(FeePayment f) throws Exception {
        String sql = "INSERT INTO FeePayments(StudentID,StudentName,PaymentDate,Amount,Status) VALUES (?,?,?,?,?)";

        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(sql);

        ps.setInt(1,f.getStudentId());
        ps.setString(2,f.getStudentName());
        ps.setDate(3, java.sql.Date.valueOf(f.getPaymentDate()));
        ps.setDouble(4,f.getAmount());
        ps.setString(5,f.getStatus());

        ps.executeUpdate();

        ps.close();
        con.close();
    }
    // UPDATE
    public void update(FeePayment f) throws Exception {
        String sql = "UPDATE FeePayments SET Amount=?, Status=? WHERE PaymentID=?";
        PreparedStatement ps = getConnection().prepareStatement(sql);

        ps.setDouble(1,f.getAmount());
        ps.setString(2,f.getStatus());
        ps.setInt(3,f.getPaymentId());

        ps.executeUpdate();
    }

    // DELETE
    public void delete(int id) throws Exception {
        String sql = "DELETE FROM FeePayments WHERE PaymentID=?";
        PreparedStatement ps = getConnection().prepareStatement(sql);
        ps.setInt(1,id);
        ps.executeUpdate();
    }
    public List<FeePayment> searchByName(String name) throws Exception {

        List<FeePayment> list = new ArrayList<>();
        String sql = "SELECT * FROM FeePayments WHERE StudentName LIKE ?";

        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, "%" + name + "%");

        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            FeePayment f = new FeePayment();
            f.setPaymentId(rs.getInt("PaymentID"));
            f.setStudentName(rs.getString("StudentName"));
            f.setAmount(rs.getDouble("Amount"));
            f.setStatus(rs.getString("Status"));
            list.add(f);
        }

        return list;
    }
    public double getTotalCollection() throws Exception {

        double total = 0;
        String sql = "SELECT SUM(Amount) FROM FeePayments";

        Connection con = getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        if(rs.next()){
            total = rs.getDouble(1);
        }

        return total;
    }

    // DISPLAY
    public List<FeePayment> getAll() throws Exception {
        List<FeePayment> list = new ArrayList<>();
        String sql = "SELECT * FROM FeePayments";

        PreparedStatement ps = getConnection().prepareStatement(sql);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            FeePayment f = new FeePayment();

            f.setPaymentId(rs.getInt("PaymentID"));
            f.setStudentId(rs.getInt("StudentID"));   
            f.setStudentName(rs.getString("StudentName"));
            f.setPaymentDate(rs.getString("PaymentDate")); 
            f.setAmount(rs.getDouble("Amount"));
            f.setStatus(rs.getString("Status"));

            list.add(f);
        }
        return list;
    }
}
