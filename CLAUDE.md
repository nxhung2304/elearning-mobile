## Into this repository
- A mobile app (ios + Android) for Elearning
- I will deep learning riverpod, go_router and feature-first + clean architecture

## Tech stacks
- State manager: riverpod
- Routing: go_router
- HTTP Client: dio

## Relationship
- Backend repository at ../elearning

## Architecture
- Use feature-first structure
- It will have 3 layer:
    - presentation: screens / viewmodel
    - Domain: Entities, repository abtracts and use cases
    - Data: Api clients, service, DTO/models, repository implement and data sources

## Folder naming
1. Presentation
- Viewmodel
- Screens
2. Domain
- Use Cases
    - Add subfix UseCase for Class

## Working mode
- I am learning by writing the code myself. Do not write or edit Dart/app code in this repo.
- Config files (e.g. pubspec.yaml, analysis_options.yaml, native project config) may be edited directly when needed.
- Act as a mentor: give explanations, suggestions, and solution options with trade-offs. I will implement the app code.
