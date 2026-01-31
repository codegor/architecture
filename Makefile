ifneq (,$(wildcard .env.local))
	include .env.local
else ifneq (,$(wildcard .env))
	include .env
endif

.PHONY: run stop up down prod-build prod-run

run:
	docker compose up

up:
	docker compose up -d

down:
	docker compose down

stop:
	docker compose stop

prod-build:
	docker build . -f Dockerfile.prod -t architecture

prod-run:
	docker run --env KROKI_BASE_URL=https://kroki.io -p ${prod_port}:3000 architecture
