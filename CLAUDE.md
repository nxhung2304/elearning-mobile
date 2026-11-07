## Into this repository
- A mobile app (ios + Android) for Elearning
- I will deep learning riverpod, go_router and feature-first + clean architecture

## Tech stacks
- State manager: riverpod
- Routing: go_router
- HTTP Client: dio

## Relationship
- Backend repository at ../elearning

## Design
- See at ./specs/designs
- Design rules, tokens and component showcase: `specs/rules/design.md`, `specs/designs/tokens.css`, `specs/designs/components.html`. Read the rules before drawing a new screen.
- The running app is the source of truth for look and feel. A wireframe must match it; where they differ, the app wins. The current style is described in `specs/rules/design.md`.
- New wireframe: reuse `auth-flow/style.css` and override only what differs from the app style. Reuse existing widgets before creating a new one.
- Wireframes are mobile-first. Screen order and shared components are in `specs/designs/roadmap.md`.
- When the app style changes (font, theme, shared widget), update `specs/rules/design.md`, `tokens.css` and the affected wireframes in the same change.
- When a design rule changes, update `tokens.css`, `components.css`/`components.html` and every affected wireframe in the same change, then open the showcase for review. Skip if the change is wording only.

## Architecture
- Use feature-first structure
- It will have 3 layer:
    - presentation: screens / viewmodel
    - Domain: Entities, repository abtracts and use cases
    - Data: Api clients, service, DTO/models, repository implement and data sources
- Entity vs Model: only split into a separate domain Entity and a data Model when there is business logic. Otherwise, use the Model directly across layers (e.g. AuthSessionModel).

## Folder naming
1. Presentation
- Controller
- Screens
2. Domain
- Use Cases
    - Add subfix UseCase for Class
3. Data
    - Add subfix Model for DTO classes (e.g. UserModel)
