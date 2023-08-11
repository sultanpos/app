json:
	@dart run build_runner build --delete-conflicting-outputs

fix:
	@dart fix --apply

upgrade:
	@flutter pub upgrade

outdated:
	@flutter pub outdated

test:
	@flutter test

lint:
	@echo "analyze code"
	@dart analyze .  || (echo "Lint error"; exit 1)

protoc:
	@protoc -I=./lib/http/websocket --dart_out=./lib/http/websocket ./lib/http/websocket/message.proto