# MVP Mobile — Checklist theo thứ tự triển khai

## 1. Shared / Bootstrap
- [x] Splash / Auth check (route guard go_router)

## 2. Auth
- [x] Register
    - [x] After re-install app, remove token in flutter_secure_storage
    - [ ] Validate validate expiration in flutter_secure_storage
- [ ] Login

## 3. Course browsing
- [ ] Home / Course list (filter: category, level, search)
- [ ] Course detail (sections + lessons, nút Enroll)

## 4. Lesson
- [ ] Lesson player (video/text, theo lesson_type)
- [ ] Lesson resources (danh sách file đính kèm, nếu API expose)

## 5. Profile
- [ ] Profile view
- [ ] Profile edit
- [ ] Logout

## 6. Enrollment & Progress (chỉ làm nếu backend có API cùng Week 24-25)
- [ ] My enrolled courses
- [ ] Course progress (progress bar, completed lessons)
