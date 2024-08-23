<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách phòng trọ</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>
<body>
<div class="container">
    <h1 class="my-4">Danh sách phòng trọ</h1>

    <form action="phong-tro" method="get">
        <div class="form-group">
            <input type="text" name="searchQuery" class="form-control" placeholder="Tìm kiếm...">
        </div>
        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        <a href="phong-tro?action=add" class="btn btn-success">Tạo mới</a>
        <button type="submit" class="btn btn-danger" formaction="phong-tro?action=delete">Xóa đã chọn</button>
    </form>

    <table class="table table-striped mt-3">
        <thead>
        <tr>
            <th>Chọn</th>
            <th>Mã phòng trọ</th>
            <th>Tên người thuê</th>
            <th>Số điện thoại</th>
            <th>Ngày bắt đầu</th>
            <th>Hình thức thanh toán</th>
            <th>Ghi chú</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="phongTro" items="${listPhongTro}">
            <tr>
                <td><input type="checkbox" name="ids" value="${phongTro.id}"></td>
                <td>${phongTro.maPhongTro}</td>
                <td>${phongTro.tenNguoiThue}</td>
                <td>${phongTro.soDienThoai}</td>
                <td>${phongTro.ngayBatDau}</td>
                <td>
                    <c:choose>
                        <c:when test="${phongTro.hinhThucThanhToanId == 1}">Theo tháng</c:when>
                        <c:when test="${phongTro.hinhThucThanhToanId == 2}">Theo quý</c:when>
                        <c:otherwise>Theo năm</c:otherwise>
                    </c:choose>
                </td>
                <td>${phongTro.ghiChu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
