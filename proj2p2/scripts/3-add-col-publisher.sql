-- Add a column called City, type: VARCHAR(255) to the Publisher table.
ALTER TABLE Publisher ADD COLUMN City VARCHAR(255) NOT NULL;

-- Show the new schema
DESCRIBE Publisher;