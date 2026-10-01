# elearning_mobile

- Flutter app (iOS + Android) for an Elearning system.
- Backend at https://github.com/nxhung2304/elearning (Rails API).

## Tech stack
- State manager: Riverpod
- Routing: go_router
- HTTP Client: Dio

## Architecture
Feature-first + Clean Architecture, 3 layers per feature:
- `presentation/` — View / ViewModel
- `domain/` — Entities, repository abstracts, use cases
- `data/` — API clients, DTO/models, repository implementations, data sources

## Docs
- Project conventions: [CLAUDE.md](./CLAUDE.md)
- MVP screens checklist: [specs/story.md](./specs/story.md)

## Getting Started
```
fvm flutter pub get
fvm flutter run
```
