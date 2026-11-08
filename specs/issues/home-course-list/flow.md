# Home / Course list — Flow

## Related
- [Original issue](./issue.md)
- [Implementation plan](./implement.md)
- [Testcases](./testcases.md)

Ghi chú suy nghĩ của anh Hung về luồng trạng thái của controller. Các chỗ đánh dấu "(em bổ sung)" hoặc "(giả định)" là phần Claude thêm, cần anh xác nhận hoặc sửa.

## Trạng thái
Mỗi dòng một trạng thái màn hình có thể ở.

| Trạng thái                  | Màn hình hiển thị gì    | Dữ liệu cần giữ                                                                                                               |
| --------------------------- | ----------------------- | ----------------------------------------------------------------------------------------------------------------------------- |
| Đang tải lần đầu            | Skeleton loading        | các bộ lọc đang chọn, isLoading                                                                                               |
| Có dữ liệu                  | Danh sách khoá học      | danh sách khoá học đã tải (em bổ sung), trang hiện tại, tổng số trang và các bộ lọc đang chọn (danh mục, cấp độ, từ khoá)    |
| Trống (chưa có khoá học)    | Text: Chưa có khoá học  | các bộ lọc đang chọn (đều trống)                                                                                              |
| Không có kết quả (đang lọc) | Không có kết quả        | các bộ lọc đang chọn (ít nhất một bộ lọc có giá trị)                                                                          |
| Lỗi trang đầu               | Không tải được khoá học | trạng thái lỗi, các bộ lọc đang chọn (em bổ sung, để bấm thử lại đúng bộ lọc)                                                 |
| Đang tải thêm               | Hiển thị loading        | danh sách khoá học đã tải (em bổ sung, nếu không giữ thì danh sách biến mất), trang hiện tại, tổng số trang, các bộ lọc, isLoading |
| Lỗi tải thêm                | Hiển thị lỗi            | danh sách khoá học đã tải, trang hiện tại, tổng số trang, các bộ lọc, trạng thái lỗi (em bổ sung)                             |

## Sự kiện
Mỗi dòng một thứ có thể xảy ra.

| Sự kiện | Ai gây ra |
|---|---|
| Mở màn | người dùng |
| Kéo làm mới | người dùng |
| Cuộn tới cuối | người dùng |
| Đổi bộ lọc (danh mục, cấp độ) | người dùng |
| Gõ tìm kiếm | người dùng |
| Bấm thử lại | người dùng |
| Xoá bộ lọc | người dùng |
| API trả về thành công / lỗi | hệ thống |

## Chuyển trạng thái

| Đang ở           | Gặp sự kiện                                        | Chuyển sang                                                                            | Ghi chú |
| ---------------- | -------------------------------------------------- | -------------------------------------------------------------------------------------- | ------- |
| (chưa có)        | Mở màn                                             | Đang tải lần đầu                                                                       | em bổ sung |
| Đang tải lần đầu | API thành công, có khoá học                        | Có dữ liệu: danh sách các khoá học trên màn hình                                       |         |
| Đang tải lần đầu | API thành công, danh sách rỗng, không có bộ lọc    | Trống: text thông báo không có khoá học                                                | em tách từ dòng cũ, vì wireframe 03 và 04 khác nhau |
| Đang tải lần đầu | API thành công, danh sách rỗng, đang có bộ lọc     | Không có kết quả: kèm nút xoá bộ lọc                                                   | em bổ sung |
| Đang tải lần đầu | API lỗi                                            | Lỗi trang đầu: hiển thị tin nhắn lỗi, có nút thử lại                                   |         |
| Có dữ liệu       | Cuộn tới cuối, còn trang                           | Đang tải thêm: hiển thị loading và gọi api                                             |         |
| Có dữ liệu       | Cuộn tới cuối, hết trang                           | Có dữ liệu: giữ nguyên, không gọi api                                                  |         |
| Đang tải thêm    | Cuộn tới cuối                                      | Đang tải thêm: bỏ qua, không gọi thêm lần nữa                                          | em bổ sung, theo câu trả lời "như trên" |
| Đang tải thêm    | API thành công                                     | Có dữ liệu: nối danh sách item mới vào cuối danh sách                                  |         |
| Đang tải thêm    | API lỗi                                            | Lỗi tải thêm: hiển thị message lỗi, có nút thử lại                                     |         |
| Lỗi tải thêm     | Bấm thử lại                                        | Đang tải thêm: danh sách khoá học + loading, gọi lại đúng trang đang lỗi               |         |
| Có dữ liệu       | Đổi bộ lọc                                         | Đang tải lần đầu: về trang 1, skeleton thay danh sách cũ                               | đã chốt: skeleton thay danh sách cũ |
| Có dữ liệu       | Kéo làm mới                                        | Có dữ liệu: giữ danh sách cũ, loading và gọi api lại; thành công thì thay bằng dữ liệu mới | theo câu trả lời bên dưới |
| Có dữ liệu       | Kéo làm mới, API lỗi                               | Có dữ liệu: giữ danh sách cũ, báo lỗi                                                  | báo bằng thanh thông báo có nút Thử lại (wireframe 11) |
| Đang tải thêm    | Đổi bộ lọc                                         | Đang tải lần đầu: bỏ kết quả của yêu cầu tải thêm cũ                                   | em bổ sung |
| Lỗi tải thêm     | Đổi bộ lọc                                         | Đang tải lần đầu                                                                       | em bổ sung |
| Trống            | Đổi bộ lọc                                         | Đang tải lần đầu                                                                       | em bổ sung |
| Không có kết quả | Đổi bộ lọc, Gõ tìm kiếm, hoặc Xoá bộ lọc           | Đang tải lần đầu                                                                       | em bổ sung |
| Lỗi trang đầu    | Bấm thử lại                                        | Đang tải lần đầu                                                                       | em bổ sung |
| Lỗi trang đầu    | Đổi bộ lọc                                         | Đang tải lần đầu                                                                       | em bổ sung |
| Trống, Không có kết quả, Lỗi trang đầu | Kéo làm mới         | Đang tải lần đầu                                                                       | giả định, em bổ sung |
| Có dữ liệu       | Gõ tìm kiếm                                        | Đang tải lần đầu: sau khoảng 400ms không gõ thêm, gửi yêu cầu cho giá trị cuối         | em bổ sung |
| Có dữ liệu       | Xoá bộ lọc                                         | Đang tải lần đầu: về trang 1, bộ lọc trống                                             | em bổ sung |

## Câu hỏi còn mở
- Đổi bộ lọc khi yêu cầu cũ chưa xong thì xử lý thế nào?
	- Debounce lại đến khi có kết quả + có timeout
	- Em đề xuất: debounce chỉ áp dụng cho ô tìm kiếm (400ms). Đổi danh mục hoặc cấp độ gửi yêu cầu ngay. Khi có yêu cầu mới thì bỏ kết quả của yêu cầu cũ (kết quả cũ về muộn không được ghi đè). Timeout là việc riêng: `api_client.dart` đang đặt 10 giây cho kết nối và nhận dữ liệu.
- Cuộn tới cuối khi đang tải thì xử lý thế nào?
	- Như trên
	- Em đề xuất: bỏ qua sự kiện (một cờ chặn), không dùng debounce.
- Khi kéo làm mới, có giữ danh sách cũ trong lúc tải không?
	- Có, đề phòng gọi api bị lỗi thì vẫn hiển thị danh sách cũ
- Kéo làm mới bị lỗi thì báo lỗi thế nào? Đã chốt: thanh thông báo có nút Thử lại, giữ danh sách cũ (wireframe 11).
- Đổi bộ lọc: giữ danh sách cũ trong lúc tải hay thay bằng skeleton? Đã chốt: skeleton thay danh sách cũ.
