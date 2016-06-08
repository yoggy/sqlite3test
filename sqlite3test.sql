CREATE TABLE test (id INTEGER PRIMARY KEY AUTOINCREMENT, created_at DATETIME DEFAULT (DATETIME('now','localtime')), name TEXT NOT NULL, email TEXT NOT NULL, tel TEXT);

.tables

.schema test

CREATE INDEX test_email ON test(email);

INSERT INTO test(name, email, tel) VALUES('test001', 'test001@test.example.com', '123456789');
INSERT INTO test(name, email, tel) VALUES('test002', 'test002@test.example.com', '123456789');
INSERT INTO test(name, email, tel) VALUES('test003', 'test003@test.example.com', '123456789');
INSERT INTO test(name, email, tel) VALUES('test004', 'test004@test.example.com', '123456789');
INSERT INTO test(name, email, tel) VALUES('test005', 'test005@test.example.com', '123456789');

SELECT * FROM test;

DELETE FROM test WHERE strftime('%s', DATETIME('now', 'localtime')) - strftime('%s', test.created_at) >= 3;

SELECT * FROM test;

VACUUM;
