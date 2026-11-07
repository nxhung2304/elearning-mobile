# Design roadmap

Thứ tự vẽ wireframe cho các màn còn lại, lấy từ `specs/story.md`. Chỉ ghi thứ tự, không có mốc thời gian.

## Nguyên tắc (mobile)
- Vùng chạm tối thiểu 48dp cho mọi thứ bấm được; chip hiển thị 32dp nhưng vùng chạm đủ 48dp.
- Dùng cấu trúc widget Material 3 (`SearchBar`, `FilterChip`, `Card`, `NavigationBar`) với màu `AppColors`, font hệ thống, bo góc 4px.
- Thao tác chính nằm ở nửa dưới màn hình, vừa tầm ngón cái.
- Mỗi màn có dữ liệu từ API đều vẽ đủ trạng thái: đang tải, trống, lỗi (và "không có kết quả" nếu có lọc).
- Nền: wireframe dùng lại `auth-flow/style.css`, chỉ ghi đè phần khác với app (xem mục Design trong `CLAUDE.md`).

## Đã có wireframe
| Nhóm | Thư mục | Ghi chú |
|---|---|---|
| Auth (splash, đăng nhập, đăng ký, quên mật khẩu, xác thực mã, đặt lại mật khẩu, thành công) | `auth-flow/` | Còn dùng font Lora / IBM Plex Sans, lệch app (chưa sửa) |
| Home / Course list | `course-browsing/` | 6 màn: danh sách, đang tải, trống, không có kết quả, lỗi, lỗi tải thêm |

## Cần vẽ (theo thứ tự trong story)
| # | Màn | Trạng thái cần vẽ (đề xuất) |
|---|---|---|
| 1 | Course detail (các section và bài học, nút Enroll) | có dữ liệu, đang tải, lỗi, đã enroll / chưa enroll |
| 2 | Lesson player (video hoặc văn bản, theo loại bài học) | video, văn bản, đang tải, lỗi |
| 3 | Lesson resources (file đính kèm, nếu API có) | có file, không có file, lỗi |
| 4 | Profile view | có dữ liệu, đang tải (nút đăng xuất đã có trong app) |
| 5 | Profile edit | đang sửa, lỗi nhập, đang lưu, lưu thành công |
| 6 | My enrolled courses (chỉ khi backend có API) | có dữ liệu, trống, đang tải, lỗi |
| 7 | Course progress (thanh tiến độ, bài đã học; chỉ khi backend có API) | có dữ liệu, 0%, 100% |

## Thành phần dùng chung
Vẽ một lần ở Home, các màn sau dùng lại:
- Thẻ khoá học (Home, My enrolled courses)
- Chip lọc
- Ô tìm kiếm
- Khối trạng thái trống / lỗi (biểu tượng, tiêu đề, mô tả, nút)
- Thanh tab dưới (`NavigationBar`)
- Lớp phủ đang tải (đã có trong app: `lib/shared/widgets/loading/loading_overlay.dart`)

## Quy trình mỗi màn
1. Đọc API và story liên quan.
2. Vẽ wireframe vào thư mục theo nhóm, mỗi trạng thái một file.
3. Anh duyệt.
4. Commit thiết kế lên `master` trước (một commit tài liệu riêng), rồi tạo issue và dán link tới thiết kế. Nếu cần người khác duyệt thiết kế, mở một PR chỉ chứa tài liệu, merge xong mới tạo issue.
5. Code.
6. Nếu style của app đổi, cập nhật `specs/rules/design.md`, `tokens.css` và các wireframe bị ảnh hưởng.
