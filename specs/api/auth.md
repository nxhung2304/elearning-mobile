# Auth API

Base path: `/api/v1/auth`

All auth success responses (`sign_up`, `sign_in`, `refresh`) share the same body:

```json
{
  "access_token": "<jwt>",
  "refresh_token": "<opaque token>",
  "expires_in": 86400,
  "user": {
    "id": 1,
    "created_at": "2026-10-04T00:00:00Z",
    "updated_at": "2026-10-04T00:00:00Z",
    "name": "New Student",
    "email": "new_student@example.com",
    "status": "active"
  }
}
```

| Field         | Notes |
|---------------|-------|
| access_token  | JWT, send as `Authorization: Bearer <access_token>`. |
| refresh_token | Opaque string, valid 30 days, **single-use** — each `refresh` call revokes it and returns a new one. |
| expires_in    | Access token lifetime in seconds (currently 1 day). |

Error body formats:
- Missing/invalid param (Grape validation): `{ "error": "refresh_token is missing" }` — singular `error`, string.
- Business errors: `{ "errors": ["..."] }` — plural `errors`, array.

## POST /sign_up

Creates a user with the `student` role.

**Request body**

| Field                   | Type   | Required |
|-------------------------|--------|----------|
| email                   | string | yes      |
| password                | string | yes      |
| password_confirmation   | string | yes      |
| name                    | string | no       |

**Success — 201 Created** — auth body (see above).

**Errors**
- `422` — missing required param, body: `{ "error": "password is missing, password_confirmation is missing" }`.
- `422` — validation failed (e.g. duplicate email, password confirmation mismatch), body: `{ "errors": ["Email has already been taken"] }`.

## POST /sign_in

**Request body**

| Field    | Type   | Required |
|----------|--------|----------|
| email    | string | yes      |
| password | string | yes      |

**Success — 201 Created** — auth body (see above).

**Errors**
- `422` — missing required param, body: `{ "error": "... is missing" }`.
- `422` — invalid credentials, suspended user, or discarded (soft-deleted) user. Body is always the generic `{ "errors": ["Invalid email or password"] }` — does not reveal whether the email exists.

## POST /refresh

Exchanges a refresh token for a new access token + new refresh token. Does **not** require the `Authorization` header — works after the access token has expired.

**Request body**

| Field         | Type   | Required |
|---------------|--------|----------|
| refresh_token | string | yes      |

**Success — 201 Created** — auth body (see above). The old refresh token is revoked.

**Errors**
- `401` — refresh token unknown, expired, already used/revoked (including after `sign_out`), or user is suspended/discarded. Body: `{ "errors": ["Invalid or expired token"] }`.
- `422` — `refresh_token` param missing, body: `{ "error": "refresh_token is missing" }`.
- `422` — server failed to rotate the token, body: `{ "errors": ["Token rotation failed"] }`.

## DELETE /sign_out

Revokes the access token (JWT denylist) and the given refresh token. Other devices' refresh tokens are not affected.

**Headers**

| Header        | Required | Format |
|---------------|----------|--------|
| Authorization | yes      | `Bearer <access_token>` |

**Request body**

| Field         | Type   | Required |
|---------------|--------|----------|
| refresh_token | string | yes      |

**Success — 200 OK**
```json
{ "message": "Signed out successfully" }
```

An unknown or already-revoked `refresh_token` still returns `200` (the access token is revoked anyway).

**Errors**
- `401` — Authorization header missing, access token malformed, expired, or already revoked. Body: `{ "error": "401 Unauthorized" }`.
- `422` — `refresh_token` param missing, body: `{ "error": "refresh_token is missing" }`. Param validation runs before the auth check, so a request missing both the header and `refresh_token` also gets `422`.

## Notes for client implementation

- Tokens are returned in the response body (not a cookie). Store both `access_token` and `refresh_token` in secure storage.
- After every successful `refresh`, replace **both** stored tokens — the old refresh token no longer works.
- When an authenticated request returns `401`, call `refresh` once, then retry the request with the new access token. If `refresh` returns `401`, clear tokens and send the user to sign in.
- Only run one `refresh` at a time: if two requests refresh with the same token concurrently, one succeeds and the other gets `401`. Queue other requests until the in-flight refresh finishes.
- `user.status` reflects account state (e.g. `active`, `suspended`); check the `User` model / `status` enum in the backend if the mobile app needs to branch on it.
- Source: `app/grape/api/v1/auth.rb`, `app/services/api/v1/auth/{sign_up,sign_in,refresh,application_service}.rb`, `app/models/refresh_token.rb`, `app/entities/{base_entity,auth_entity,user_entity}.rb`, `test/integration/api/v1/auth_test.rb` in the `elearning` backend repo.
