PYTHON=python3

.PHONY: build
## バックエンド+Swaggerのコンテナのビルド
build:
	docker-compose -f ./docker/docker-compose.yaml build

.PHONY: up
## バックエンド+Swaggerのコンテナの起動
up:
	docker-compose -f ./docker/docker-compose.yaml up -d

.PHONY: down
## バックエンド+Swaggerのコンテナの終了
down:
	docker-compose -f ./docker/docker-compose.yaml down

.PHONY: exec
## バックエンドのコンテナに入る
exec:
	docker-compose -f ./docker/docker-compose.yaml exec backend bash

.PHONY: format
## Pythonのフォーマット
format:
	docker-compose -f ./docker/docker-compose.yaml exec backend pysen run format

.PHONY: lint
## Pythonの構文チェック
lint:
	docker-compose -f ./docker/docker-compose.yaml exec backend pysen run lint

.PHONY: test
## Pythonコードのテスト
test:
	docker-compose -f ./docker/docker-compose.yaml exec backend pytest -svv --cov=. tests/

.PHONY: lambda-test
## ローカルに立ち上げたlambdaサーバーにbase64データをリクエストする
lambda-test:
	curl -H "Content-Type: application/json" -d "{'key': 'aaa'}" http://localhost:8001/2015-03-31/functions/function/invocations

.PHONY: help
## help
help:
	@cat $(MAKEFILE_LIST) | ${PYTHON} -u -c 'import sys; import re; from itertools import tee,chain; rx = re.compile(r"^[a-zA-Z0-9\-_]+:"); xs, ys = tee(sys.stdin); xs = chain([""], xs); [print(f"""\x1b[36m{line.split(":", 1)[0]:20s}\x1b[0m\t{prev.lstrip("# ").rstrip() if prev.startswith("##") else "" }""") for prev, line in zip(xs, ys) if rx.search(line)]'