postgres:
	docker run --name banky-cont -p 5432:5432 -e POSTGRES_USER=eugeneobazee -e POSTGRES_PASSWORD=eugene_admin -d postgres:16-alpine3.20 

createdb:
	docker exec -ti banky-cont createdb -U eugeneobazee banky-cont1

dropdb:
	docker exec -it postgres16 dropdb banky

migrateup:
	migrate -path db/migration -database "postgresql://eugeneobazee@localhost:5432/banky?sslmode=disable" -verbose up 

migrateup1:
	migrate -path db/migration -database "postgresql://eugeneobazee@localhost:5432/banky?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://eugeneobazee@localhost:5432/banky?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://eugeneobazee@localhost:5432/banky?sslmode=disable" -verbose down 1 

sqlc:
	sqlc generate

runserver:
	go run main.go

test: 
	go test -v -cover ./...

mock:
	mockgen -package mockdb -destination db/mock/store.go github.com/techschool/simplebank/db/sqlc Store

.PHONY: postgres createdb dropdb migrateup migrateup1 migratedown migratedown1 test runserver mock