# Handoff to backend: Courses API for mobile Home

## Related
- [Original issue](./issue.md)
- [Investigation](./investigate.md)
- [Implementation plan](./implement.md)

## Goal
Create an issue spec in this backend repo for two mobile-facing API endpoints, so the mobile app can build its Home / Course list screen.
Output: one issue spec file following this repo's own issue format and conventions (check `specs/issues/` and `specs/story.md`). Do not implement the API yet.

## Endpoints
- `GET /api/v1/courses`
- `GET /api/v1/course_categories`

Both require a Bearer token (same as the existing Auth API).

## Rules already decided
- Only courses with status `published` and not discarded, for every role.
- Filter `kept` before pagination. The web `IndexableResource` filters `.kept` after `pagy`, so a page can have fewer than 20 items. Do not copy that.
- 20 items per page (`Pagy::DEFAULT[:limit]`).
- Fixed sort: `published_at` newest first.
- Filters: `category_id` (a parent category includes its whole subtree), `level`, `q` (title contains).
- Course has no thumbnail. Do not add one.
- Mobile card shows: title, teacher name, category name, level, `total_lessons`, price.
- Mobile category chips show root categories only.

## Contract: illustrative only, not confirmed
Decide the real shape in the issue. This is the mobile side's guess:
- Courses query: `page`, `category_id`, `level`, `q`
- Courses response: `{ data: [{ id, title, slug, level, price, total_lessons, category: {id, name}, teacher: {id, name} }], meta: { page, per_page, total_pages, total_count } }`
- Categories response: flat list `{ id, name, parent_id }`

## Open questions for the issue to answer
- Format of pagination `meta`.
- Categories: flat list or tree.
- Is `price` serialized as a string or a number.
- Error bodies for invalid `level` or `page` (existing Auth API uses `{ "error": "..." }` for param errors and `{ "errors": [...] }` for business errors).

## Required in the issue
Real example responses, copied from an actual call (`curl` or swagger), not hand-written:
- Courses: one with data (include a `price` > 0 and a `price` = 0), one empty, one where filters match nothing.
- Categories: one with a parent and a child.
- Errors: 401 (missing or expired token), 422 (invalid param, e.g. bad `level`).

The mobile side uses these to fix its data model types and write tests.

## Existing code to read first
- `app/grape/api/v1/base.rb`, `app/grape/api/v1/auth.rb` (how Grape endpoints are mounted)
- `app/models/course.rb`, `app/models/course_category.rb`
- `app/models/ability.rb` (student can read published courses)
- `app/controllers/concerns/indexable_resource.rb` (the filter-after-pagy pitfall)
- `specs/story.md` Phase 5, Week 22-23 ("API: Courses, Sections, Lessons")

## How to start
In this repo, run `claude`, then paste:

> Read /Users/rightsvn-hunga/Dev/personal/elearning_mobile/specs/issues/home-course-list/handoff-backend.md and create the issue spec it describes, following this repo's issue conventions.
