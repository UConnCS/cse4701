-- Show all table schemas
SHOW CREATE TABLE Book;
DESCRIBE Book;

SHOW CREATE TABLE Book_Authors;
DESCRIBE Book_Authors;

SHOW CREATE TABLE Publisher;
DESCRIBE Publisher;

SHOW CREATE TABLE Book_Copies;
DESCRIBE Book_Copies;

SHOW CREATE TABLE Library_Branch;
DESCRIBE Library_Branch;

SHOW CREATE TABLE Borrower;
DESCRIBE Borrower;

SHOW CREATE TABLE Book_Loans;
DESCRIBE Book_Loans;

-- Show all table values
SELECT * FROM Book;
SELECT * FROM Book_Authors;
SELECT * FROM Publisher;
SELECT * FROM Book_Copies;
SELECT * FROM Library_Branch;
SELECT * FROM Borrower;
SELECT * FROM Book_Loans;