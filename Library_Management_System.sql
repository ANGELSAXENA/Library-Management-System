
-- =========================================
-- LIBRARY MANAGEMENT SYSTEM
-- Database: LibraryDB
-- =========================================

DROP DATABASE IF EXISTS LibraryDB;
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- =========================================
-- 1. STUDENTS TABLE
-- =========================================

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    course VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15)
);

-- =========================================
-- 2. BOOKS TABLE
-- =========================================

CREATE TABLE Books (
    book_id INT PRIMARY KEY,
    book_title VARCHAR(150) NOT NULL,
    author VARCHAR(100),
    category VARCHAR(50),
    quantity INT NOT NULL,
    available_quantity INT NOT NULL
);

-- =========================================
-- 3. BOOK ISSUE TABLE
-- =========================================

CREATE TABLE Book_Issue (
    issue_id INT PRIMARY KEY,
    student_id INT,
    book_id INT,
    issue_date DATE,
    return_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (student_id)
        REFERENCES Students(student_id),
    FOREIGN KEY (book_id)
        REFERENCES Books(book_id)
);

-- =========================================
-- 4. INSERT STUDENT RECORDS
-- =========================================

INSERT INTO Students VALUES
(1, 'Aarav Sharma', 'BTech CSE', 'aarav@gmail.com', '9876543210'),
(2, 'Priya Verma', 'BCA', 'priya@gmail.com', '9876543211'),
(3, 'Rahul Singh', 'BTech IT', 'rahul@gmail.com', '9876543212'),
(4, 'Sneha Gupta', 'BBA', 'sneha@gmail.com', '9876543213'),
(5, 'Karan Mehta', 'BTech CSE', 'karan@gmail.com', '9876543214');

-- =========================================
-- 5. INSERT BOOK RECORDS
-- =========================================

INSERT INTO Books VALUES
(101, 'Database System Concepts', 'Silberschatz', 'DBMS', 5, 4),
(102, 'Operating System Concepts', 'Galvin', 'OS', 4, 3),
(103, 'Computer Networks', 'Tanenbaum', 'Networking', 3, 3),
(104, 'Python Programming', 'Guido van Rossum', 'Programming', 6, 5),
(105, 'Let Us C', 'Yashavant Kanetkar', 'Programming', 5, 5),
(106, 'Data Structures', 'Seymour Lipschutz', 'DSA', 4, 3),
(107, 'Artificial Intelligence', 'Stuart Russell', 'AI', 3, 3),
(108, 'Java Programming', 'Herbert Schildt', 'Programming', 5, 4),
(109, 'Software Engineering', 'Ian Sommerville', 'SE', 4, 4),
(110, 'Computer Organization', 'Morris Mano', 'COA', 3, 3);

-- =========================================
-- 6. INSERT BOOK ISSUE RECORDS
-- =========================================

INSERT INTO Book_Issue VALUES
(1, 1, 101, '2026-10-20', NULL, 'Issued'),
(2, 2, 102, '2026-10-21', NULL, 'Issued'),
(3, 3, 104, '2026-10-22', NULL, 'Issued'),
(4, 4, 106, '2026-10-23', NULL, 'Issued'),
(5, 5, 108, '2026-10-24', NULL, 'Issued');

-- =========================================
-- 7. REQUIRED PROJECT QUERIES
-- =========================================

-- Display all students
SELECT * FROM Students;

-- Display all books
SELECT * FROM Books;

-- Display all issued books
SELECT * FROM Book_Issue;

-- Display available books
SELECT * FROM Books
WHERE available_quantity > 0;

-- Display details of a particular student
SELECT * FROM Students
WHERE student_id = 1;

-- Display books issued to a particular student
SELECT
    Students.student_name,
    Books.book_title,
    Book_Issue.issue_date,
    Book_Issue.return_date,
    Book_Issue.status
FROM Book_Issue
JOIN Students
    ON Book_Issue.student_id = Students.student_id
JOIN Books
    ON Book_Issue.book_id = Books.book_id
WHERE Students.student_id = 1;

-- Display all students with their issued books
SELECT
    Students.student_name,
    Books.book_title,
    Book_Issue.status
FROM Book_Issue
JOIN Students
    ON Book_Issue.student_id = Students.student_id
JOIN Books
    ON Book_Issue.book_id = Books.book_id;

-- Count total students
SELECT COUNT(*) AS Total_Students
FROM Students;

-- Count total books
SELECT SUM(quantity) AS Total_Book_Copies
FROM Books;
