#!python2.6
# -*- coding: utf-8 -*-
#
#  sqlite3test.py
#    see also... http://docs.python.jp/2/library/sqlite3.html
#
import os
import sqlite3
import random
import time

dbfile = os.path.join(os.path.dirname(__file__), 'test.db')

# connect
conn = sqlite3.connect(dbfile)

# create table
conn.execute(u"""
CREATE TABLE test (
  id   INTEGER PRIMARY KEY AUTOINCREMENT,
  created_at DATETIME DEFAULT (DATETIME('now','localtime')),
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  tel  TEXT 
);""")

conn.execute(u"CREATE INDEX test_email ON test(email);")

# insert
for i in range(5):
  name  = u"name%03d" % i
  email = name + u"@test.example.com"
  tel   = u"{0:011d}".format(random.randint(0, 99999999999))

  conn.execute(u"INSERT INTO test(name, email, tel) VALUES(?,?,?);", (name, email, tel))

  time.sleep(1)

conn.commit()

# select
c = conn.cursor()
c.execute(u"SELECT * FROM test ORDER BY created_at DESC;")

for row in c:
  print row

# delete
conn.execute(u"DELETE FROM test WHERE strftime('%s', DATETIME('now', 'localtime')) - strftime('%s', test.created_at) >= 3")

# vacuum
conn.execute("VACUUM;")

conn.close()
