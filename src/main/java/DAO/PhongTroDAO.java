package DAO;

import Model.PhongTro;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PhongTroDAO {
    private String jdbcURL = "jdbc:mysql://localhost:3306/quan_ly_thue_phong_tro?useSSL=false";
    private String jdbcUsername = "root";
    private String jdbcPassword = "trancuong365421";
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }

    public List<PhongTro> getAllPhongTros() throws SQLException {
        List<PhongTro> phongTros = new ArrayList<>();
        String sql = "SELECT * FROM phong_tro";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                PhongTro phongTro = new PhongTro();
                phongTro.setId(rs.getInt("id"));
                phongTro.setMaPhongTro(rs.getString("ma_phong_tro"));
                phongTro.setTenNguoiThue(rs.getString("ten_nguoi_thue"));
                phongTro.setSoDienThoai(rs.getString("so_dien_thoai"));
                phongTro.setNgayBatDau(rs.getString("ngay_bat_dau"));
                phongTro.setHinhThucThanhToanId(rs.getInt("hinh_thuc_thanh_toan_id"));
                phongTro.setGhiChu(rs.getString("ghi_chu"));
                phongTros.add(phongTro);
            }
        }
        return phongTros;
    }

    public void addPhongTro(PhongTro phongTro) throws SQLException {
        String sql = "INSERT INTO phong_tro (ma_phong_tro, ten_nguoi_thue, so_dien_thoai, ngay_bat_dau, hinh_thuc_thanh_toan_id, ghi_chu) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, phongTro.getMaPhongTro());
            ps.setString(2, phongTro.getTenNguoiThue());
            ps.setString(3, phongTro.getSoDienThoai());
            ps.setString(4, phongTro.getNgayBatDau());
            ps.setInt(5, phongTro.getHinhThucThanhToanId());
            ps.setString(6, phongTro.getGhiChu());
            ps.executeUpdate();
        }
    }

    public void deletePhongTros(List<Integer> ids) throws SQLException {
        String sql = "DELETE FROM phong_tro WHERE id IN (" + String.join(",", ids.stream().map(String::valueOf).toArray(String[]::new)) + ")";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.executeUpdate();
        }
    }

    public List<PhongTro> searchPhongTros(String keyword) throws SQLException {
        List<PhongTro> phongTros = new ArrayList<>();
        String sql = "SELECT * FROM phong_tro WHERE ma_phong_tro LIKE ? OR ten_nguoi_thue LIKE ? OR so_dien_thoai LIKE ?";
        try (Connection conn = getConnection(); PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            ps.setString(3, "%" + keyword + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PhongTro phongTro = new PhongTro();
                phongTro.setId(rs.getInt("id"));
                phongTro.setMaPhongTro(rs.getString("ma_phong_tro"));
                phongTro.setTenNguoiThue(rs.getString("ten_nguoi_thue"));
                phongTro.setSoDienThoai(rs.getString("so_dien_thoai"));
                phongTro.setNgayBatDau(rs.getString("ngay_bat_dau"));
                phongTro.setHinhThucThanhToanId(rs.getInt("hinh_thuc_thanh_toan_id"));
                phongTro.setGhiChu(rs.getString("ghi_chu"));
                phongTros.add(phongTro);
            }
        }
        return phongTros;
    }
}
