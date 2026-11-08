# Courses API

Base path: `/api/v1`

Source: backend issue #78 (`../elearning/specs/issues/78-api-courses-and-course-categories-for-home.md`), response samples captured with `curl` on the backend development server.

Both endpoints require `Authorization: Bearer <access_token>`.

Error body format: `{ "errors": [{ "code": "<code>", "message": "<message>" }] }`.

## GET /courses

Lists published, non-discarded courses for every role. 20 items per page, newest `published_at` first (ties: higher `id` first).

**Query parameters**

| Param               | Type    | Required | Notes |
|---------------------|---------|----------|-------|
| page                | integer | no       | Default 1, must be >= 1. Past the last page returns `data: []` with `meta`, status 200. |
| q[category_id_eq]   | integer | no       | A parent category includes its whole subtree (server expands it). Unknown category returns `data: []`, status 200. |
| q[level_eq]         | integer | no       | `0` beginner, `1` intermediate, `2` advanced. Send the number, not the name. |
| q[title_i_cont]     | string  | no       | Title contains the text, case-insensitive. |

Other `q[...]` fields are not supported.

**Item fields**

| Field          | Type           | Notes |
|----------------|----------------|-------|
| id             | integer        | |
| title          | string         | |
| slug           | string         | |
| level          | string         | Name: `beginner`, `intermediate`, `advanced`. Differs from the filter, which takes a number. |
| price          | string         | Decimal as string, e.g. `"99.99"`, `"0.0"` (free). |
| total_lessons  | integer        | |
| category       | object         | `{ id, name }` |
| teacher        | object         | `{ id, name }`; `name` can be `null`. |

**Success — 200 OK** (two courses, one with `price` > 0 and one free)

```json
{
  "data": [
    {
      "id": 150,
      "title": "Free Intro to Web Development",
      "slug": "free-intro-to-web-development",
      "level": "intermediate",
      "price": "0.0",
      "total_lessons": 5,
      "category": { "id": 3, "name": "Web Development" },
      "teacher": { "id": 2, "name": "Teacher User" }
    },
    {
      "id": 1,
      "title": "Ruby on Rails for Beginners",
      "slug": "ruby-on-rails-for-beginners",
      "level": "beginner",
      "price": "99.99",
      "total_lessons": 12,
      "category": { "id": 1, "name": "Programming" },
      "teacher": { "id": 2, "name": "Teacher User" }
    }
  ],
  "meta": { "page": 1, "per_page": 20, "total_pages": 1, "total_count": 2 }
}
```

**Empty — 200 OK** (no filter match, unknown category)

```json
{ "data": [], "meta": { "page": 1, "per_page": 20, "total_pages": 1, "total_count": 0 } }
```

**Past the last page — 200 OK** (`page=999`)

```json
{ "data": [], "meta": { "page": 999, "per_page": 20, "total_pages": 1, "total_count": 1 } }
```

**Errors**
- `401` — missing or invalid token: `{ "errors": [{ "code": "unauthorized", "message": "Unauthorized" }] }`.
- `422` — invalid `q[level_eq]`: `{ "errors": [{ "code": "invalid_params", "message": "q[level_eq] does not have a valid value" }] }`.
- `422` — invalid `page` (e.g. `0`, `abc`): `{ "errors": [{ "code": "invalid_params", "message": "page does not have a valid value" }] }`.

Known gap: the backend notes say `q[level_eq]=advanced` (a name) is silently treated as `0` (not re-verified by mobile). Always send `0`, `1` or `2`.

## GET /course_categories

Flat list of all non-discarded categories, ordered by `position`. No pagination. The mobile app shows only root categories (`parent_id` is `null`) as chips.

**Success — 200 OK**

```json
{
  "data": [
    { "id": 3, "name": "Web Development", "parent_id": 1 },
    { "id": 2, "name": "Mobile Development", "parent_id": null },
    { "id": 1, "name": "Programming", "parent_id": null }
  ]
}
```

**Errors**
- `401` — missing or invalid token (same body as above).

## Not captured yet
- `401` for an expired token on these endpoints (shared auth mechanism is tested on the backend).
