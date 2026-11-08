# Home / Course list — Test cases

## Related
- [Original issue](./issue.md)
- [Investigation](./investigate.md)
- [Implementation plan](./implement.md)
- [Flow](./flow.md)

Dữ liệu mẫu cho test: các response trong [specs/api/courses.md](../../api/courses.md). Chưa có code nên chưa có debug trigger nào; cách mô phỏng dự kiến ghi ở cuối file.

## Test tự động (unit, widget, mock)

### Model và dữ liệu
- [ ] Parse khoá học mẫu: `price` là chuỗi `"99.99"`, `level` là tên `"beginner"`.
- [ ] `teacher.name` là `null` không làm lỗi parse.
- [ ] Giá `"0.0"` hiển thị "Free"; `"99.99"` hiển thị đúng giá.
- [ ] Đổi cấp độ tên sang số để lọc: beginner 0, intermediate 1, advanced 2.
- [ ] Parse `meta` (`page`, `per_page`, `total_pages`, `total_count`).
- [ ] Parse danh mục; chỉ lấy danh mục gốc khi `parent_id` là `null`.

### Gọi API (mock)
- [ ] Tham số gửi đúng tên: `page`, `q[category_id_eq]`, `q[level_eq]` (số), `q[title_i_cont]`.
- [ ] Không gửi tham số của bộ lọc đang trống.
- [ ] Lỗi 401 thành lỗi chưa đăng nhập; lỗi 422 thành lỗi tham số; mất mạng thành lỗi mạng.
- [ ] Trang vượt cuối (`data: []` kèm `meta`) không gây lỗi.

### Bộ điều khiển (controller)
- [ ] Tải lần đầu thành công: có danh sách, trang 1.
- [ ] Tải lần đầu, danh sách rỗng, không có bộ lọc: trạng thái "chưa có khoá học".
- [ ] Tải lần đầu, danh sách rỗng, đang có bộ lọc: trạng thái "không có kết quả".
- [ ] Tải lần đầu lỗi: trạng thái lỗi toàn màn hình, thử lại tải lại trang 1.
- [ ] Tải thêm nối thêm vào danh sách; dừng khi `page` bằng `total_pages`.
- [ ] Tải thêm lỗi: giữ nguyên danh sách đã có, hiện dòng thử lại; thử lại tải đúng trang đang lỗi.
- [ ] Không gọi tải thêm khi đang tải (gọi hai lần liên tiếp chỉ ra một yêu cầu).
- [ ] Tải thêm lỗi rồi thử lại thành công: danh sách nối đúng trang, không lặp và không mất item.
- [ ] Hết trang (`page` bằng `total_pages`): cuộn tới cuối không gọi API.
- [ ] Kéo để làm mới: giữ danh sách cũ trong lúc tải, thành công thì thay bằng dữ liệu mới và về trang 1.
- [ ] Kéo để làm mới lỗi: giữ nguyên danh sách cũ, hiện thanh thông báo có nút Thử lại.
- [ ] Đổi bộ lọc: về trang 1, hiện trạng thái đang tải lần đầu.
- [ ] Đổi bộ lọc khi yêu cầu cũ chưa xong: kết quả của yêu cầu cũ về muộn không được ghi đè kết quả mới.
- [ ] Đổi bộ lọc khi đang tải thêm: bỏ kết quả của yêu cầu tải thêm cũ, về trang 1.
- [ ] Đổi danh mục hoặc cấp độ gửi yêu cầu ngay, không chờ debounce.
- [ ] Gõ tìm kiếm: chỉ gửi một yêu cầu cho giá trị cuối sau ~400ms.
- [ ] Xoá bộ lọc: về danh sách đầy đủ, trang 1.
- [ ] Từ trạng thái trống, không có kết quả, lỗi trang đầu: đổi bộ lọc hoặc bấm thử lại chuyển sang đang tải lần đầu.
- [ ] Yêu cầu quá 10 giây (theo `api_client.dart`) trả về lỗi mạng, và controller chuyển sang trạng thái lỗi tương ứng (lỗi trang đầu hoặc lỗi tải thêm).
- [ ] Bộ lọc còn nguyên sau khi rời và quay lại màn (provider không bị huỷ).

### Giao diện (widget)
- [ ] Mỗi trạng thái hiển thị đúng: đang tải, trống, không có kết quả, lỗi trang đầu, lỗi tải thêm.
- [ ] Chọn chip danh mục và chọn cấp độ trong bảng chọn cập nhật bộ lọc.
- [ ] Thẻ khoá học hiển thị đủ: tên, giáo viên (có dự phòng khi thiếu tên), danh mục, cấp độ, số bài, giá.
- [ ] Chạm vào thẻ không làm gì (không điều hướng).
- [ ] Kéo làm mới lỗi: hiện thanh thông báo có nút Thử lại; bấm Thử lại gọi API lại.
- [ ] Vùng chạm của chip, nút, dòng thử lại không nhỏ hơn 48dp.

## Test cần máy thật hoặc môi trường thật
- [ ] Gọi API thật với token thật: danh sách khớp dữ liệu backend.
- [ ] Chọn danh mục cha: hiện cả khoá học của danh mục con (mẫu: danh mục 1 gồm khoá ở danh mục 3).
- [ ] Token hết hạn giữa chừng: tự làm mới token và tải tiếp, không văng ra màn đăng nhập.
- [ ] Kiểm chứng `q[level_eq]` với tên (ví dụ `advanced`): backend ghi là bị coi như 0, chưa kiểm chứng.
- [ ] Kiểm chứng `q[level_eq]=9`: spec backend mâu thuẫn (Notes: không lỗi; mẫu: 422).
- [ ] Cử chỉ kéo làm mới và cuộn vô hạn có mượt trên máy thật, kích hoạt đúng lúc gần cuối danh sách.
- [ ] Bàn phím mở: bố cục không vỡ, thanh tab ẩn đúng.
- [ ] Bật chế độ máy bay: trang đầu hiện lỗi mạng, tải thêm hiện dòng thử lại.
- [ ] Mạng chậm: hiện trạng thái đang tải đủ lâu để thấy được.
- [ ] Đổi tab rồi quay lại: giữ bộ lọc và vị trí cuộn; tắt app mở lại: bộ lọc mất.
- [ ] Thanh tab dưới trên iOS và Android khác wireframe vì app chưa có theme (xem `specs/rules/design.md`).

## Cách mô phỏng dự kiến (thêm sau khi có code)
Các mục dưới đây giúp không phải dựng backend lỗi. Dùng tiền tố `[DEBUG-home-list]` và gỡ trước khi commit.
- Ép repository trả lỗi trang đầu, lỗi tải thêm, danh sách rỗng, danh sách rỗng khi có bộ lọc: một công tắc hằng số.
- Làm chậm repository vài giây để xem trạng thái đang tải.
- Ép `teacher.name` là `null` và giá `"0.0"` trong dữ liệu giả.

Không mô phỏng được bằng mã, cần máy thật hoặc dịch vụ thật: token hết hạn, cử chỉ kéo và cuộn, chế độ máy bay, bàn phím thật, giao diện iOS và Android, dữ liệu backend thật.
