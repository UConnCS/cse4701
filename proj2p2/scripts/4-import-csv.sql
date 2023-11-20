-- Book, Book_Authors, Publisher, Book_Copies, Library_Branch, Borrower, Book_Loans
LOAD DATA LOCAL INFILE '/Users/mike/cse4701/proj1p2/data/Book.csv' INTO TABLE Book FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA LOCAL INFILE '/Users/mike/cse4701/proj1p2/data/Book_Authors.csv' INTO TABLE Book_Authors FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA LOCAL INFILE '/Users/mike/cse4701/proj1p2/data/Publisher.csv' INTO TABLE Publisher FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA LOCAL INFILE '/Users/mike/cse4701/proj1p2/data/Book_Copies.csv' INTO TABLE Book_Copies FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA LOCAL INFILE '/Users/mike/cse4701/proj1p2/data/Library_Branch.csv' INTO TABLE Library_Branch FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA LOCAL INFILE '/Users/mike/cse4701/proj1p2/data/Borrower.csv' INTO TABLE Borrower FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';
LOAD DATA LOCAL INFILE '/Users/mike/cse4701/proj1p2/data/Book_Loans.csv' INTO TABLE Book_Loans FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\r\n';