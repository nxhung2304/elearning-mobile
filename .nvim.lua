require("flutter-tools").setup_project({
	{ name = "Dev", flavor = "dev", target = "lib/main_dev.dart" },
	{ name = "Prod", flavor = "prod", target = "lib/main_prod.dart" },
})
