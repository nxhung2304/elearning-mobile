# Design rules

## Style
Mirrors the running app. Paper background, ink text, sharp 4px corners, underline text fields, one small tilted highlighter square as the only decoration. System font.

## File design của dự án
App code is the source: `lib/core/theme/app_colors.dart` and the shared widgets in `lib/`. When the app style changes, update `specs/designs/tokens.css` in the same change.

| File | Holds |
|---|---|
| `specs/designs/tokens.css` | Every color, font, size, radius, spacing the app uses |
| `specs/designs/components.css` | Components built only from `var(--...)` |
| `specs/designs/components.html` | Showcase of each component and its states |

## Always
- Colors come only from `tokens.css` (mirrors `AppColors`).
- Touch targets at least 48dp.
- Build screens with Material 3 widget structure (`SearchBar`, `FilterChip`, `Card`, `NavigationBar`), re-skinned with the app style.
- Draw every data screen's loading, empty and error states.
- Reuse an existing component before making a new one.

## Never
- Never add a custom font or a color that is not in `AppColors`, without changing the app first.
- Never use a raw hex value in a wireframe; use `var(--...)`.

## Components (from code)
| Component | App source |
|---|---|
| Underline text field | `lib/features/auth/presentation/widgets/auth_line_text_field.dart` |
| Primary button with highlighter mark | `lib/features/auth/presentation/screens/sign_in_screen.dart:134-177` |
| Outline button | `lib/features/auth/presentation/widgets/auth_outline_button.dart` |
| Mini link | `lib/features/auth/presentation/widgets/auth_mini_link.dart` |
| Password strength meter | `lib/features/auth/presentation/widgets/auth_password_strength_meter.dart` |
| Loading overlay | `lib/shared/widgets/loading/loading_overlay.dart` |
| Divider with text | `lib/features/auth/presentation/screens/sign_in_screen.dart:178-196` |

## Open questions
- Dark mode: the app has none. Not drafted.
- Headline size: the app uses `Theme.of(context).textTheme.headlineSmall` (`sign_in_screen.dart:83`, `splash_screen.dart:21`) and sets no size, so no heading token exists.
- Shadow: no shadow in code. Not drafted.
- Bottom bar: `main_shell_screen.dart:13-26` uses Material `NavigationBar` with default theme. The Home wireframe styles it with `AppColors` (paper background, `--ink-tint` indicator, outlined icons), which needs a `NavigationBarTheme`; the app has no theme yet.
- Home tints are derived from `AppColors` in `tokens.css` (`--sand-tint`, `--teal-tint`, `--ink-tint`). In Flutter, build them with `Color.alphaBlend(<color>.withValues(alpha: <percent>), AppColors.paper)` using the same percentages (`paperLine` 50%, `teal` 14%, `ink` 8%); do not add new colors to `AppColors`.
- Primary button, outline button and text field exist only as auth widgets (`Auth*` names) or inline in `sign_in_screen.dart`; no shared version outside auth.
- `profile_screen.dart:32` uses a default `ElevatedButton`, not the auth primary button style.

## Mismatches: app vs old wireframes
| # | App | Wireframe |
|---|---|---|
| 1 | No font declared (`app.dart:9`, `MaterialApp.router` without theme; `pubspec.yaml` has no fonts) | Resolved: `auth-flow/style.css` now uses `var(--font-family)` and no longer loads Lora / IBM Plex Sans |
| 2 | Headline: `headlineSmall` (`sign_in_screen.dart:83`) | Resolved: 24px in `auth-flow/style.css`. Assumption: Flutter's default `headlineSmall` is 24px (not confirmed by running the app) |
| 3 | Splash wordmark: `headlineSmall` (`splash_screen.dart:21`) | Resolved: 24px in `auth-flow/style.css` (same assumption as row 2) |
| 4 | Colors: `app_colors.dart:6-12` only | `auth-flow/style.css:9` adds `--highlighter-soft` |
| 5 | Error message: default `SnackBar` (`sign_in_screen.dart:60-61`) | Resolved: `.toast` in `auth-flow/style.css` now imitates the default Material `SnackBar` (dark bar `#322F35`, text `#F5EFF7`, full width at the bottom). These two values are an assumption of Material 3 defaults, not `AppColors`; they are mock-only |
| 6 | Bottom bar: default `NavigationBar` (`main_shell_screen.dart:13-26`) | `course-browsing/style.css:234-254` styled with `AppColors` |
| 7 | No chip, card, search bar or bottom sheet widget in `lib/` | `course-browsing/style.css:9,50,76,83,161` |
| 8 | Colors `app_colors.dart:6-12` only | Resolved: `course-browsing/style.css` now uses `--sand-tint`, `--teal-tint`, `--ink-tint` derived from `AppColors`. Mock-only values remain for the fake keyboard and sheet dim (`style.css:160,202-221`) |

## Decision log
- Mirrored from the existing app (no new style); no demos.
- Home placeholder tints derived from existing colors instead of adding to `AppColors`.
