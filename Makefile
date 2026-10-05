run-dev:
	IP=$$(ipconfig getifaddr en0 || ipconfig getifaddr en1); \
	fvm flutter run --dart-define=API_BASE_URL=http://$$IP:3000/api/v1
