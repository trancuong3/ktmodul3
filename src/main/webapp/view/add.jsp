<%@ page import="java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Phòng Trọ</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .container {
            margin-top: 20px;
        }
    </style>
</head>
<body>
<div class="container">
    <h1 class="mt-4">Thêm Phòng Trọ</h1>

    <!-- Form thêm phòng trọ -->
    <form action="/phong-tro/insert" method="post">
        <div class="form-group">
            <label for="maPhongTro">Mã phòng trọ:</label>
            <input type="text" id="maPhongTro" name="maPhongTro" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="tenNguoiThue">Tên người thuê:</label>
            <input type="text" id="tenNguoiThue" name="tenNguoiThue" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="soDienThoai">Số điện thoại:</label>
            <input type="text" id="soDienThoai" name="soDienThoai" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="ngayBatDau">Ngày bắt đầu:</label>
            <input type="date" id="ngayBatDau" name="ngayBatDau" class="form-control" required>
        </div>
        <div class="form-group">
            <label for="hinhThucThanhToanId">Hình thức thanh toán111login:</label>
            <select id="hinhThucThanhToanId" name="hinhThucThanhToanId" class="form-control" required>
                <option value="1">Theo tháng</option>
                <option value="2">Theo quý</option>
                <option value="3">Theo năm</option>
            </select>
        </div>
        <div class="form-group">
            <label for="ghiChu">Ghi chú:</label>
            <textarea id="ghiChu" name="ghiChu" class="form-control" rows="3"></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Thêm</button>
        <a href="listPhongTro" class="btn btn-secondary">Hủy</a>
    </form>
</div>
</body>
</html>
