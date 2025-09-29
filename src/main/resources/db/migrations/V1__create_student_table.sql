CREATE SEQUENCE student_sequence START 1;

CREATE TABLE student (
                         id BIGINT PRIMARY KEY DEFAULT nextval('student_sequence'),
                         name VARCHAR(255) NOT NULL,
                         email VARCHAR(255) NOT NULL UNIQUE,
                         gender VARCHAR(50) NOT NULL
);



DROP TABLE student;
DROP SEQUENCE student_sequence;


/*
 # Apply migrations
mvn flyway:migrate

# Check which migrations have been applied
mvn flyway:info

# Undo last migration (requires undo scripts)
mvn flyway:undo

# Clean database (drops all tables) - be careful!
mvn flyway:clean

 */