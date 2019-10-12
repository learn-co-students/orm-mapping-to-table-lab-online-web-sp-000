require 'bundler'
Bundler.require

require_relative '../lib/student'
require 'sqlite3'

DB = {:conn => SQLite3::Database.new("db/students.db")}
