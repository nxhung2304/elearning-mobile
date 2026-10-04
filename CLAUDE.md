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
- Controller
- Screens
2. Domain
- Use Cases
    - Add subfix UseCase for Class
3. Data
    - Add subfix Model for DTO classes (e.g. UserModel)
