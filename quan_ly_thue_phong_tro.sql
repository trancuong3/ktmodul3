

CREATE TABLE `hinh_thuc_thanh_toan` (
  `ten_hinh_thuc` varchar(500) NOT NULL
) ;

--
-- Đang đổ dữ liệu cho bảng `hinh_thuc_thanh_toan`
--

INSERT INTO `hinh_thuc_thanh_toan` (`ten_hinh_thuc`) VALUES
('theo năm'),
('theo quý'),
('theo tháng');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `phong_tro`
--

CREATE TABLE `phong_tro` (
  `id` int NOT NULL,
  `ma_phong_tro` varchar(500) DEFAULT NULL,
  `ten_nguoi_thue` varchar(500) DEFAULT NULL,
  `so_dien_thoai` varchar(12) DEFAULT NULL,
  `ngay_bat_dau` varchar(50) DEFAULT NULL,
  `hinh_thuc_thanh_toan_id` varchar(500) DEFAULT NULL,
  `ghi_chu` varchar(500) DEFAULT NULL
) ;

--
-- Đang đổ dữ liệu cho bảng `phong_tro`
--

INSERT INTO `phong_tro` (`id`, `ma_phong_tro`, `ten_nguoi_thue`, `so_dien_thoai`, `ngay_bat_dau`, `hinh_thuc_thanh_toan_id`, `ghi_chu`) VALUES
(6, 'PT-2024000006', 'john me', '0982378234', '2024-08-23', 'theo quý', 'oke\r\n'),
(8, 'PT-2024000008', 'đqư', '0982378234', '2024-08-25', 'theo năm', 'dwqd');

--
-- Bẫy `phong_tro`
--
DELIMITER $$
CREATE TRIGGER `set_ma_phong` BEFORE INSERT ON `phong_tro` FOR EACH ROW BEGIN
    DECLARE current_year VARCHAR(4);
    DECLARE new_id INT;
    DECLARE new_ma_pt VARCHAR(255);
    
    -- Lấy năm hiện tại
    SET current_year = YEAR(CURDATE());
    
    
    SET @lastID = (SELECT id FROM phong_tro ORDER BY id DESC LIMIT 1);
    IF @lastID IS NULL OR @lastID = '' THEN
        SET @lastID = 0;
    END IF;
    SET @lastID = @lastID +1;
   
    SET new_id = @lastID;
    
 
    SET new_ma_pt = CONCAT('PT-', current_year, LPAD(new_id, 6, '0'));
        
 
    SET NEW.ma_phong_tro = new_ma_pt;
END
$$
DELIMITER ;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `hinh_thuc_thanh_toan`
--
ALTER TABLE `hinh_thuc_thanh_toan`
  ADD PRIMARY KEY (`ten_hinh_thuc`);

--
-- Chỉ mục cho bảng `phong_tro`
--
ALTER TABLE `phong_tro`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_name` (`hinh_thuc_thanh_toan_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `phong_tro`
--
ALTER TABLE `phong_tro`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `phong_tro`
--
ALTER TABLE `phong_tro`
  ADD CONSTRAINT `fk_name` FOREIGN KEY (`hinh_thuc_thanh_toan_id`) REFERENCES `hinh_thuc_thanh_toan` (`ten_hinh_thuc`);

