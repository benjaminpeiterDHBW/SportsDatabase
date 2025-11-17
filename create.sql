CREATE TABLE IF NOT EXISTS sport(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
)

CREATE TABLE IF NOT EXISTS player(
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    birth_date DATE,
    nationality VARCHAR(50)
)

CREATE TABLE IF NOT EXISTS team(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    club VARCHAR(100),
    country INT
)

CREATE TABLE IF NOT EXISTS venue(
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    location VARCHAR(100),
    capacity INT
)