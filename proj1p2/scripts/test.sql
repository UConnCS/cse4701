-- create a constraint on the Book_Loans table which ensures the Due_date column cannot be set to something earlier than the Date_out column
ALTER TABLE Book_Loans ADD CONSTRAINT chk_due_date CHECK (Due_date >= Date_out);