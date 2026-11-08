# Home / Course list — Investigate

## Related
- [Original issue](./issue.md)
- [Implementation plan](./implement.md)
- [Testcases](./testcases.md)
- [Handoff to backend](./handoff-backend.md)

## Current state — Confirmed
Mobile:
- `HomeScreen` chỉ là placeholder: `lib/features/home/presentation/screens/home_screen.dart`
- Route: `lib/app/router/routes.dart` — `StatefulShellRoute.indexedStack`, 2 branch (home, profile)
- `ApiClient` map mọi lỗi khác 401/422 thành `NetworkException`: `lib/core/network/api_client.dart` (`_mapDioException`)
- Chưa có design cho Home: `specs/designs/` chỉ có `auth-flow`

Backend `../elearning`:
- Grape chỉ mount `Health` và `Auth`: `app/grape/api/v1/base.rb`. Chưa có API courses / categories
- `Course` không có thumbnail attachment. Field: title, slug, description, level (beginner/intermediate/advanced), language, price, total_lessons, status (draft/published/archived), published_at, discarded_at, category, teacher: `app/models/course.rb`, `db/schema.rb:68`
- `CourseCategory` dùng ancestry (cha/con) + position + discard: `app/models/course_category.rb`
- Web `CoursesController` lọc bằng ransack: `teacher_id_eq`, `category_id_eq`, `title_cont`, `status_eq`. Form web không có filter level: `app/views/courses/index.html.erb:15-28`
- `IndexableResource` lọc `.kept` sau khi `pagy`, nên một trang có thể ít hơn 20 item: `app/controllers/concerns/indexable_resource.rb:13-17`. API mới phải lọc `kept` trước khi phân trang
- Pagy mặc định 20/trang: `config/initializers/pagy.rb:3`
- Student chỉ đọc course `published`: `app/models/ability.rb:22`

## Decisions (đã chốt)
1. Backend API làm trước (issue backend riêng, do anh Hung làm). Mobile gọi API thật; mock chỉ dùng trong test
2. Bắt buộc Bearer token
3. Chỉ hiện course `published` và chưa discard, mọi role
4. Wireframe HTML ở `specs/designs/course-browsing/`, dùng lại `auth-flow/style.css`; có trạng thái loading, empty, error
5. Card: title, teacher, category, level, `total_lessons`, price (0 → "Free"). Dùng placeholder thay thumbnail; không thêm thumbnail vào backend lúc này
6. Infinite scroll + pull-to-refresh, 20 item/trang
7. Filter chỉ gồm category, level, search title
8. Chọn category cha → lấy cả subtree. UI: chip ngang, chỉ category gốc
9. Search ở server (`title_cont`), debounce ~400ms, không đặt số ký tự tối thiểu
10. Sort cố định `published_at` mới nhất
11. Tap card chưa làm gì (route `/courses/:id` thuộc story Course detail)
12. Không tạo UseCase; controller gọi repository. Dùng `CourseModel` / `CourseCategoryModel` xuyên layer (không tách Entity)
13. UI state:
    - Load đầu: skeleton/spinner
    - Empty có 2 kiểu: chưa có course; không có kết quả theo filter (kèm nút xoá filter)
    - Lỗi trang đầu: full-screen + Retry
    - Lỗi load-more: dòng Retry cuối list
14. Filter giữ khi đổi tab, mất khi tắt app

## Backend contract
Backend xong (issue backend #78). Contract đầy đủ và response mẫu: [specs/api/courses.md](../../api/courses.md). Nguồn là spec + mẫu `curl` của backend; mobile chưa gọi API thật.
- Filter: `q[category_id_eq]` (server tự lấy subtree), `q[level_eq]` (số), `q[title_i_cont]`; phân trang `page`
- `level` response là tên (`beginner`, `intermediate`, `advanced`), filter nhận số `0` / `1` / `2` theo cùng thứ tự
- `price` là string (`"99.99"`, `"0.0"` = Free); `teacher.name` có thể `null`
- `meta`: `page`, `per_page`, `total_pages`, `total_count`
- Categories: danh sách phẳng `{ id, name, parent_id }` trong `data`; mobile tự lọc `parent_id == null` để lấy chip gốc
- Lỗi: `{ "errors": [{ "code", "message" }] }`; 401 `unauthorized`, 422 `invalid_params`

## Open questions
- Map lỗi 400/500 trong `ApiClient` (hiện đều thành `NetworkException`) — Confirmed ở `api_client.dart`; chưa quyết có sửa trong issue này không
- Nhánh backend cục bộ chưa chắc là bản đã merge — Unconfirmed; nên gọi API thật để đối chiếu `specs/api/courses.md`
- Spec backend mâu thuẫn về `q[level_eq]=9` (Notes: không lỗi; mẫu: 422) — Unconfirmed, cần gọi thật
- Course thiếu thumbnail nên card dùng placeholder — đã chốt, không còn mở
