run-dev:
	fvm flutter run --flavor dev -t lib/main_dev.dart

run-prod:
	fvm flutter run --flavor prod -t lib/main_prod.dart

watch:
	fvm dart run build_runner watch

build:
	fvm dart run build_runner build --delete-conflicting-outputs
