<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách phòng trọ</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<div class="container">
    <h1 class="my-4">Danh sách phòng trọ</h1>

    <form action="phong-tro" method="get" style="margin-top: 30px !important;">
        <div class="form-group">
            <input type="text" name="searchQuery" class="form-control" placeholder="Tìm kiếm...">
        </div>
        <button type="submit" class="btn btn-primary">Tìm kiếm</button>
        <a href="phong-tro?action=add" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#exampleModal">Tạo mới</a>
        <button type="button" class="btn btn-danger" onclick="deleteAll()">Xóa đã chọn</button>
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
                <td>${phongTro.hinhThucThanhToanId}</td>
                <td>${phongTro.ghiChu}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="container">
                    <h1 class="mt-4">Thêm Phòng Trọ</h1>

                    <!-- Form thêm phòng trọ -->
                    <form action="" method="post" onsubmit="return checkInsert()">
<%--                        <div class="form-group">--%>
<%--                            <label for="maPhongTro">Mã phòng trọ:</label>--%>
<%--                            <input type="text" id="maPhongTro" name="maPhongTro" class="form-control" required>--%>
<%--                        </div>--%>
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
                            <label for="hinhThucThanhToanId">Hình thức thanh toán:</label>
                            <select id="hinhThucThanhToanId" name="hinhThucThanhToanId" class="form-control" required>
                                <option value="theo tháng">Theo tháng</option>
                                <option value="theo quý">Theo quý</option>
                                <option value="theo năm">Theo năm</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="ghiChu">Ghi chú:</label>
                            <textarea id="ghiChu" name="ghiChu" class="form-control" rows="3"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary">Thêm</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<script>
    function checkInsert(){
        var ghichu = document.getElementById("ghiChu").value
        if(ghichu.length > 200){
            alert("Độ dài ghi chú không được quá 200 ký tự");
            return false;
        }
        var sdt = document.getElementById("soDienThoai").value
        const phoneRegex = /^\d{10}$/;
        if (phoneRegex.test(sdt) == false){
            alert("Số điện thoại phải là 10 ký tự số");
            return false;
        }

        const inputDateElement = document.getElementById('ngayBatDau');
        const inputDateString = inputDateElement.value;

        if (!inputDateString) {
            alert("Vui lòng chọn ngày bắt đầu")
            return false;
        }
        const inputDate = new Date(inputDateString);
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        if (inputDate < today) {
            alert("Ngày bắt đầu thuê không hợp lệ (không được là quá khứ)")
            return false;
        }
    }

    function deleteAll(){
        const checkboxes = document.querySelectorAll('input[name="ids"]:checked');
        const selectedValues = [];
        checkboxes.forEach((checkbox) => {
            selectedValues.push(checkbox.value);
        });
        if(selectedValues.length == 0){
            alert("Chưa có phòng nào được chọn");
            return
        }
        var con = confirm("Chấp nhận xóa hết?");
        if(con == false){
            return;
        }
        var chuyentrang = 'phong-tro?action=delete';
        for(i=0; i<selectedValues.length; i++){
            chuyentrang += '&ids='+selectedValues[i];
        }
        window.location.href = chuyentrang
    }
</script>
</html>
