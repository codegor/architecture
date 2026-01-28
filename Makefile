.PHONY: run stop up down

run:
	docker compose up

up:
	docker compose up -d

down:
	docker compose down

stop:
	docker compose stop
