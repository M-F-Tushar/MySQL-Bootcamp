CREATE DATABASE my_database;
USE my_database;

-- Create the table
CREATE TABLE Tweets (
    Username VARCHAR(15),
    Content VARCHAR(140),
    Favorites INT
);

-- Insert the rows
INSERT INTO Tweets (Username, Content, Favorites)
VALUES
    ('coolguy', 'my first tweet!', 1),
    ('guitar_queen', 'I love music :)', 10),
    ('lonely_heart', 'still looking 4 love', 0);
