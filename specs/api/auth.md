# Auth API

Base path: `/api/v1`

## POST /sign_up

Creates a user with the `student` role.

**Request body**

| Field                   | Type   | Required | Notes |
|-------------------------|--------|----------|-------|
| email                   | string | yes      | |
| password                | string | yes      | |
| password_confirmation   | string | yes      | |
| name                    | string | no       | |

**Success — 201 Created**
```json
{
  "token": "<jwt>",
  "user": {
    "id": "...",
    "created_at": "2026-10-04T00:00:00Z",
    "updated_at": "2026-10-04T00:00:00Z",
    "name": "New Student",
    "email": "new_student@example.com",
    "status": "..."
  }
}
```

**Errors**
- `400 Bad Request` — missing required param (Grape param validation).
- `422 Unprocessable Entity` — validation failed (e.g. duplicate email, password confirmation mismatch), body: `{ "errors": ["Email has already been taken"] }`.

## POST /sign_in

**Request body**

| Field    | Type   | Required |
|----------|--------|----------|
| email    | string | yes      |
| password | string | yes      |

**Success — 200 OK**
```json
{
  "token": "<jwt>",
  "user": {
    "id": "...",
    "created_at": "2026-10-04T00:00:00Z",
    "updated_at": "2026-10-04T00:00:00Z",
    "name": "...",
    "email": "...",
    "status": "..."
  }
}
```

**Errors**
- `400 Bad Request` — missing required param.
- `422 Unprocessable Entity` — invalid credentials, suspended user, or discarded (soft-deleted) user. Body is always the generic `{ "errors": ["Invalid email or password"] }` — does not reveal whether the email exists.

## DELETE /sign_out

Revokes the JWT via denylist (`Warden::JWTAuth::TokenRevoker`).

**Headers**

| Header        | Required | Format |
|---------------|----------|--------|
| Authorization | yes      | `Bearer <jwt>` |

**Success — 200 OK**
```json
{ "message": "Signed out successfully" }
```

**Errors**
- `400 Bad Request` — Authorization header/token missing.
- `401 Unauthorized` — token is malformed / fails to decode.

## Notes for client implementation

- JWT is returned in the response body (not a cookie) — store it and send as `Authorization: Bearer <token>` on authenticated requests.
- `user.status` reflects account state (e.g. suspended); check the `User` model / `status` enum in the backend if the mobile app needs to branch on it.
- Source: `app/grape/api/v1/auth.rb`, `app/services/api/v1/auth/{sign_up,sign_in,application_service}.rb`, `app/entities/{base_entity,user_entity}.rb`, `test/integration/api/v1/auth_test.rb` in the `elearning` backend repo.
