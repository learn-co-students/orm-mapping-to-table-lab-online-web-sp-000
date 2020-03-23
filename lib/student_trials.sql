-- sqlite3 db/students.db < lib/student_trials.sql

.headers on 
.mode column
.width auto 

CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT);

INSERT INTO students (id, name, grade) VALUES (1, "M", "9th");
INSERT INTO students (id, name, grade) VALUES (2, "l", "10th");
INSERT INTO students (id, name, grade) VALUES (3, "B", "11th");

SELECT * FROM students;
SELECT id FROM students DESC LIMIT 1;   





DROP TABLE IF EXISTS students;