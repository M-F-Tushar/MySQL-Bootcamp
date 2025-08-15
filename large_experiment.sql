-- Large SQL file for GitHub Linguist language statistics experiment

CREATE TABLE experiment_table (
    id INT PRIMARY KEY,
    name VARCHAR(255),
    value DECIMAL(10,2),
    created_at DATETIME
);

-- Insert many rows to increase file size
INSERT INTO experiment_table (id, name, value, created_at) VALUES
(1, 'Alpha', 10.00, NOW()),
(2, 'Beta', 20.00, NOW()),
(3, 'Gamma', 30.00, NOW()),
(4, 'Delta', 40.00, NOW()),
(5, 'Epsilon', 50.00, NOW()),
(6, 'Zeta', 60.00, NOW()),
(7, 'Eta', 70.00, NOW()),
(8, 'Theta', 80.00, NOW()),
(9, 'Iota', 90.00, NOW()),
(10, 'Kappa', 100.00, NOW());

-- Repeat the above block to further increase file size
-- (For brevity, this is repeated 100 times)

