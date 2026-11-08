# Home / Course list — Implement

## Related
- [Original issue](./issue.md)
- [Investigation](./investigate.md)
- [Testcases](./testcases.md)
- [Flow](./flow.md)
- [Handoff to backend](./handoff-backend.md)

## Steps
0. Backend: xong (issue backend #78). Contract thật ở [specs/api/courses.md](../../api/courses.md)
1. Wireframe `specs/designs/course-browsing/`: xong, 11 màn (danh sách, đang tải, trống, không có kết quả, lỗi, lỗi tải thêm, chọn cấp độ, đang lọc, kéo làm mới, đang gõ tìm kiếm, kéo làm mới bị lỗi). đã được duyệt. Quy tắc thiết kế: `specs/rules/design.md`
2. Gọi API thật một lần để đối chiếu `specs/api/courses.md` (nhánh backend cục bộ chưa chắc là bản đã merge)
3. Data layer:
   - `CourseModel` (`price` parse từ string sang decimal; `teacher.name` nullable; `level` map từ tên)
   - `CourseCategoryModel`
   - `CoursePageModel` hoặc tương đương cho `data` + `meta`
   - Remote data source, repository (abstract + impl)
4. Controller (riverpod):
   - Paging theo `page` và `meta.total_pages`
   - Filter state: category, level, search
   - Debounce search 400ms
   - Query gửi: `q[category_id_eq]`, `q[level_eq]` (số 0 / 1 / 2), `q[title_i_cont]`
5. `HomeScreen`: chip category gốc (lọc `parent_id == null`), ô search, filter level, list, các trạng thái UI
6. Test (dùng response mẫu trong `specs/api/courses.md`)

## Mapping level
| Tên (response) | Số (filter `q[level_eq]`) |
|---|---|
| beginner | 0 |
| intermediate | 1 |
| advanced | 2 |

## Risks
- `ApiClient` map lỗi 400/500 thành `NetworkException` → UI không phân biệt được lỗi. Lỗi 401 và 422 của API mới vẫn được xử lý
- `price` là string: bỏ qua parse hoặc parse sai sẽ hiện sai giá; `"0.0"` phải hiện Free
- Gửi tên level thay vì số: backend ghi nhận bị coi là `0` mà không báo lỗi (chưa kiểm chứng) → luôn gửi số
- `teacher.name` null → card cần xử lý trường hợp thiếu tên
