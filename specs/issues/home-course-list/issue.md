# Home / Course list

## Related
- [Investigation](./investigate.md)
- [Implementation plan](./implement.md)
- [Testcases](./testcases.md)
- [Handoff to backend](./handoff-backend.md)

---

## Mô tả
Làm màn hình Home của app mobile: hiển thị danh sách khoá học đã xuất bản, có lọc theo danh mục, cấp độ và tìm theo tên. Dữ liệu lấy từ API khoá học và danh mục đã hoàn thành ở backend (issue https://github.com/nxhung2304/elearning/issues/78).

## Thiết kế
- Thư mục wireframe 11 màn: https://github.com/nxhung2304/elearning-mobile/tree/master/specs/designs/course-browsing
- Quy tắc thiết kế chung: https://github.com/nxhung2304/elearning-mobile/blob/master/specs/rules/design.md
- Để xem cả 11 màn, tải repo về và mở file `index.html` trong thư mục wireframe bằng trình duyệt (GitHub chỉ hiện mã nguồn của file HTML).

## Phạm vi
- Danh sách khoá học: tải thêm khi cuộn xuống (20 khoá mỗi lần), kéo xuống để làm mới.
- Mỗi khoá học hiển thị: tên khoá học, tên giáo viên, danh mục, cấp độ, số bài học, giá (giá 0 hiển thị "Free"). Chưa có ảnh nên dùng hình thay thế.
- Bộ lọc: danh mục (chỉ danh mục gốc, dạng nút ngang), cấp độ, ô tìm theo tên (đợi khoảng 400ms sau khi người dùng ngừng gõ).
- Chọn danh mục cha thì hiện cả khoá học của danh mục con.
- Bộ lọc giữ nguyên khi chuyển tab, mất khi tắt app.
- Chạm vào khoá học chưa làm gì (làm ở task Course detail).

## Trạng thái giao diện
- Đang tải lần đầu: hiện khung chờ hoặc vòng quay.
- Chưa có khoá học nào: hiện thông báo trống.
- Không có kết quả với bộ lọc hiện tại: hiện thông báo kèm nút xoá bộ lọc.
- Lỗi khi tải trang đầu: hiện lỗi toàn màn hình kèm nút thử lại.
- Lỗi khi tải thêm: hiện dòng thử lại ở cuối danh sách.
- Kéo làm mới bị lỗi: giữ danh sách cũ và hiện thanh thông báo có nút thử lại.

## Tiêu chí hoàn thành
- [x] Có thiết kế (wireframe) cho danh sách và các trạng thái ở trên.
- [ ] Danh sách hiển thị đúng dữ liệu từ API thật, tải thêm và làm mới hoạt động.
- [ ] Lọc theo danh mục (kể cả danh mục cha), cấp độ và tìm theo tên hoạt động, kết hợp được với nhau.
- [ ] Giá "0.0" hiển thị "Free"; giáo viên không có tên không làm lỗi giao diện.
- [ ] Đủ các trạng thái: tải lần đầu, trống, không có kết quả, lỗi trang đầu, lỗi tải thêm.
- [ ] Bộ lọc giữ nguyên khi đổi tab.
- [ ] Có test cho phần dữ liệu và bộ điều khiển, dùng response mẫu thật.

## Phụ thuộc
- Backend: issue https://github.com/nxhung2304/elearning/issues/78 (API khoá học và danh mục), đã xong.
