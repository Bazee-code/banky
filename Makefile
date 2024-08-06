postgres:
	docker run --name postgres16 -p 5432:5432 -e POSTGRES_USER=YOUR_USER -e POSTGRES_PASSWORD=YOUR_PASSWORD -d postgres:16-alpine3.20 

createdb:
	docker exec -it postgres16 createdb --username=YOUR_USER --owner=YOUR_USER banky

dropdb:
	docker exec -it postgres16 dropdb banky

migrateup:
	migrate -path db/migration -database "postgresql://YOUR_USER@localhost:5432/banky?sslmode=disable" -verbose up 

migratedown:
	migrate -path db/migration -database "postgresql://YOUR_USER@localhost:5432/banky?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown

# REPLACE YOUR_USER with your postgres user