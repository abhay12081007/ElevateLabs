-- Create database
CREATE DATABASE library_db;
USE library_db;

-- Members
CREATE TABLE members (
    member_id INT PRIMARY KEY,
    name VARCHAR(100),
    join_date DATE
);

-- Books
CREATE TABLE books (
    book_id INT PRIMARY KEY,
    title VARCHAR(200),
    author VARCHAR(100),
    genre VARCHAR(50),
    price DECIMAL(10,2)
);

-- Borrow Records
CREATE TABLE borrow (
    borrow_id INT PRIMARY KEY,
    member_id INT,
    book_id INT,
    borrow_date DATE,
    return_date DATE,
    FOREIGN KEY (member_id) REFERENCES members(member_id),
    FOREIGN KEY (book_id) REFERENCES books(book_id)
);

-- Members
INSERT INTO members VALUES
(1, 'Ravi Kumar', '2023-01-01'),
(2, 'Meena Sharma', '2023-02-01'),
(3, 'Amit Singh', '2023-03-01');

-- Books
INSERT INTO books VALUES
(101, 'The Alchemist', 'Paulo Coelho', 'Fiction', 300.00),
(102, 'Atomic Habits', 'James Clear', 'Self-help', 450.00),
(103, 'Clean Code', 'Robert C. Martin', 'Programming', 600.00),
(104, 'Wings of Fire', 'A.P.J. Abdul Kalam', 'Biography', 350.00);

-- Borrow records
INSERT INTO borrow VALUES
(1, 1, 101, '2023-03-01', '2023-03-10'),
(2, 2, 103, '2023-03-05', '2023-03-20'),
(3, 3, 102, '2023-03-10', NULL),
(4, 1, 104, '2023-03-15', NULL);


-- 1. Count of total books
SELECT COUNT(*) AS total_books FROM books;

-- 2. Total borrowed books
SELECT COUNT(*) AS borrowed_books FROM borrow;

-- 3. Currently borrowed (not returned)
SELECT * FROM borrow WHERE return_date IS NULL;

-- 4. Books borrowed by each member
SELECT m.name, COUNT(b.book_id) AS books_borrowed
FROM borrow b
JOIN members m ON b.member_id = m.member_id
GROUP BY m.name;

-- 5. Most borrowed book
SELECT bo.title, COUNT(b.book_id) AS times_borrowed
FROM borrow b
JOIN books bo ON b.book_id = bo.book_id
GROUP BY bo.title
ORDER BY times_borrowed DESC
LIMIT 1;

-- 6. Late returns (assuming 7 days due)
SELECT * FROM borrow
WHERE DATEDIFF(return_date, borrow_date) > 7;

select * from borrow;





