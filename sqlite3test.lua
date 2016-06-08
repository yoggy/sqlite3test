#!/usr/bin/lua
--
-- sqlite3test.lua
--
-- how to use:
--   $ sudo apt-get install luarocks
--   $ sudo luarocks install luasql-sqlite3
--   $ sudo luarocks install inspect
--   $ lua ./sqlite3test.lua
--
inspect = require('inspect')

luasql = require("luasql.sqlite3")
env    = luasql.sqlite3()
conn   = env:connect("./test.db")

conn:execute([[
  CREATE TABLE test (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at DATETIME DEFAULT (DATETIME('now','localtime')),
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    tel TEXT);
]])

conn:execute("CREATE INDEX test_email ON test(email);")

for i=1, 5 do
  local name  = string.format("test%03d", i)
  local email = name .. "@test.example.com"
  local tel   = string.format("%011d", math.random(1, 99999999999))

  local res = conn:execute(string.format([[
    INSERT INTO test (name, email, tel) VALUES ('%s', '%s', '%s');
  ]], name, email, tel))

  print(res)

  os.execute("sleep 1")
end

conn:execute("DELETE FROM test WHERE strftime('%s', DATETIME('now', 'localtime')) - strftime('%s', test.created_at) >= 3;")

cur,err = conn:execute("SELECT * FROM test;")
row = cur:fetch({}, "a")

while row do
  print(inspect(row))
  row = cur:fetch({}, "a")
end

-- close
cur:close()
conn:close()
env:close()

