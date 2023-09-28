-- Create Tables, references textbook exercise 8.18
CREATE TABLE IF NOT EXISTS Book (
    Book_id VARCHAR(2) NOT NULL,
    Title VARCHAR(255) NOT NULL,
    Publisher_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Book_id)
);

CREATE TABLE IF NOT EXISTS Book_Authors (
    Book_id VARCHAR(2) NOT NULL,
    Author_name VARCHAR(255) NOT NULL,
    PRIMARY KEY (Book_id, Author_name),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id)
);

CREATE TABLE IF NOT EXISTS Publisher (
    `Name` VARCHAR(255) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    Phone VARCHAR(14) NOT NULL,
    PRIMARY KEY (`Name`, `Address`)
);

CREATE TABLE IF NOT EXISTS Book_Copies (
    Book_id VARCHAR(2) NOT NULL,
    Branch_id VARCHAR(3) NOT NULL,
    No_of_copies INT NOT NULL,
    PRIMARY KEY (Book_id),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id)
);

CREATE TABLE IF NOT EXISTS Library_Branch (
    Branch_id VARCHAR(3) NOT NULL,
    Branch_name VARCHAR(255) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    PRIMARY KEY (Branch_id)
);

CREATE TABLE IF NOT EXISTS Borrower (
    Card_no VARCHAR(2) NOT NULL,
    `Name` VARCHAR(255) NOT NULL,
    `Address` VARCHAR(255) NOT NULL,
    Phone VARCHAR(14) NOT NULL,
    PRIMARY KEY (Card_no)
);

CREATE TABLE IF NOT EXISTS Book_Loans (
    Book_id VARCHAR(2) NOT NULL,
    Branch_id VARCHAR(3) NOT NULL,
    Card_no VARCHAR(2) NOT NULL,
    Date_out DATE NOT NULL,
    Due_date DATE NOT NULL,
    PRIMARY KEY (Book_id, Branch_id, Card_no),
    FOREIGN KEY (Book_id) REFERENCES Book(Book_id),
    FOREIGN KEY (Branch_id) REFERENCES Library_Branch(Branch_id),
    FOREIGN KEY (Card_no) REFERENCES Borrower(Card_no)
);

-- Insert Data into created tables
INSERT INTO Book (Book_id, Title, Publisher_name) VALUES ('B1', 'The Lost Tribe', 'Picador');
INSERT INTO Book (Book_id, Title, Publisher_name) VALUES ('B2', 'It', 'Simon & Schuster');
INSERT INTO Book (Book_id, Title, Publisher_name) VALUES ('B3', 'Event Horizon', 'Tom Doherty Assoc Llc');

INSERT INTO Book_Authors (Book_id, Author_name) VALUES ('B1', 'Mark Lee');
INSERT INTO Book_Authors (Book_id, Author_name) VALUES ('B2', 'Stephen King');
INSERT INTO Book_Authors (Book_id, Author_name) VALUES ('B3', 'Steven McDonald');

INSERT INTO Publisher (`Name`, `Address`, Phone) VALUES ('Picador', '4300 Turkey Pen Road', '(223) 444-5521');
INSERT INTO Publisher (`Name`, `Address`, Phone) VALUES ('Simon & Schuster', '4096 Emerson Road', '(421) 540-1675');
INSERT INTO Publisher (`Name`, `Address`, Phone) VALUES ('Tom Doherty Assoc Llc', '4321 Walnut Hill Drive', '(345) 623-0356');

INSERT INTO Book_Copies (Book_id, Branch_id, No_of_copies) VALUES ('B1', 'BR1', 15);
INSERT INTO Book_Copies (Book_id, Branch_id, No_of_copies) VALUES ('B2', 'BR2', 10);
INSERT INTO Book_Copies (Book_id, Branch_id, No_of_copies) VALUES ('B3', 'BR3', 20);

INSERT INTO Library_Branch (Branch_id, Branch_name, `Address`) VALUES ('BR1', 'Sharpstown', '9 Bow Ridge Street Sharpstown');
INSERT INTO Library_Branch (Branch_id, Branch_name, `Address`) VALUES ('BR2', 'Beloit', '3 West Rd. Beloit');
INSERT INTO Library_Branch (Branch_id, Branch_name, `Address`) VALUES ('BR3', 'Drive Lake Charles', '824 Rock Maple Drive Lake Charles');

INSERT INTO Borrower (Card_no, `Name`, `Address`, Phone) VALUES ('C1', 'John Smith', '731 Fondren, Houston, TX', '(206) 342-8631');
INSERT INTO Borrower (Card_no, `Name`, `Address`, Phone) VALUES ('C2', 'Franklin Wong', '638 Voss, Houston, TX', '(717) 550-1675');
INSERT INTO Borrower (Card_no, `Name`, `Address`, Phone) VALUES ('C3', 'Alicia Zelaya', '3321 Castle, Spring, TX', '(248) 762-0356');

INSERT INTO Book_Loans (Book_id, Branch_id, Card_no, Date_out, Due_date) VALUES ('B1', 'BR1', 'C1', '2023-01-05', '2023-02-05');
INSERT INTO Book_Loans (Book_id, Branch_id, Card_no, Date_out, Due_date) VALUES ('B2', 'BR2', 'C2', '2022-12-06', '2023-01-06');
INSERT INTO Book_Loans (Book_id, Branch_id, Card_no, Date_out, Due_date) VALUES ('B3', 'BR3', 'C2', '2023-01-29', '2023-03-01');