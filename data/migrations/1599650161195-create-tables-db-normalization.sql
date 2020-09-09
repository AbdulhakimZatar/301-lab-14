-- create new db called lab14
CREATE DATABASE lab14;

-- populate lab14 db
psql lab14 -f data/schema.sql
psql lab14 -f data/seed.sql

-- Make a copy of lab14 db
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;

-- Now working on lab14_normal

-- Creating authors table
CREATE TABLE AUTHORS (id SERIAL PRIMARY KEY, name VARCHAR(255));

-- Insert all authors name from books table to authors table and keep it uniqe
INSERT INTO authors(name) SELECT DISTINCT author FROM books;

-- Add column to books called author
ALTER TABLE books ADD COLUMN author_id INT;

-- Update author_id from books to match id column from author table when the author name match
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;

-- Drop authors column from books table
ALTER TABLE books DROP COLUMN author;

-- make author_id foreign key and refrence it to authors.id
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);