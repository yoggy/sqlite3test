#!/usr/bin/ruby
# coding: utf-8
#
#  sqlite3test.rb
#
#  how to use:
#    $ sudo apt-get install ruby-sqlite3
#    $ ruby ./sqlite3test.rb
# 
#  see also:
#    https://github.com/sparklemotion/sqlite3-ruby
#
require 'sqlite3'
require 'pp'

Dir.chdir(File.dirname($0))

db = SQLite3::Database.new "./test.db"

db.execute <<-SQL
  CREATE TABLE test (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    created_at DATETIME DEFAULT (DATETIME('now','localtime')),
    name TEXT NOT NULL,
    email TEXT NOT NULL,
    tel TEXT);
SQL

db.execute "CREATE INDEX test_email ON test(email);"

(1..5).each do |i|
  name  = sprintf("test%04d", i)
  email = name + "@test.example.com"
  tel   = sprintf("%011d", Random.rand(1..99999999999))

  db.execute("INSERT INTO test (name, email, tel) VALUES (?,?,?);", [name, email, tel])
end

db.execute("DELETE FROM test WHERE strftime('%s', DATETIME('now', 'localtime')) - strftime('%s', test.created_at) >= 3;")

db.execute("SELECT * FROM test;") do |row|
  pp row
end


