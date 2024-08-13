postgres:
	docker run --name banky-cont -p 5432:5432 -e POSTGRES_USER=eugeneobazee -e POSTGRES_PASSWORD=eugene_admin -d postgres:16-alpine3.20 

createdb:
	docker exec -ti banky-cont createdb -U eugeneobazee banky-cont1

dropdb:
	docker exec -it postgres16 dropdb banky

migrateup:
	migrate -path db/migration -database "postgresql://eugeneobazee:eugene_admin@localhost:5432/banky?sslmode=disable" -verbose up 

migratedown:
	migrate -path db/migration -database "postgresql://eugeneobazee@localhost:5432/banky?sslmode=disable" -verbose down

sqlc:
	sqlc generate

test: 
	go test -v -cover ./...

.PHONY: postgres createdb dropdb migrateup migratedown test

# REPLACE YOUR_USER with your postgres user