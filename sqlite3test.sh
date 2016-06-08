#!/bin/bash

cd `dirname $0`

rm -rf ./test.db

sqlite3 ./test.db "CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT, created_at DATETIME DEFAULT (DATETIME('now','localtime')), name TEXT NOT NULL, email TEXT NOT NULL, tel TEXT);"

sqlite3 ./test.db ".tables"

sqlite3 ./test.db ".schema test"

sqlite3 ./test.db "CREATE INDEX test_email ON test(email);"

sqlite3 ./test.db "INSERT INTO test(name, email, tel) VALUES('test001', 'test001@test.example.com', '123456789');"
sleep 1
sqlite3 ./test.db "INSERT INTO test(name, email, tel) VALUES('test002', 'test002@test.example.com', '123456789');"
sleep 1
sqlite3 ./test.db "INSERT INTO test(name, email, tel) VALUES('test003', 'test003@test.example.com', '123456789');"
sleep 1
sqlite3 ./test.db "INSERT INTO test(name, email, tel) VALUES('test004', 'test004@test.example.com', '123456789');"
sleep 1
sqlite3 ./test.db "INSERT INTO test(name, email, tel) VALUES('test005', 'test005@test.example.com', '123456789');"

#sqlite3 ./test.db "SELECT * FROM test;"

sqlite3 ./test.db "DELETE FROM test WHERE strftime('%s', DATETIME('now', 'localtime')) - strftime('%s', test.created_at) >= 3;"

sqlite3 ./test.db "SELECT * FROM test;"

sqlite3 ./test.db "VACUUM;"

