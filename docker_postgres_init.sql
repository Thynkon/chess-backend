CREATE USER chess_test WITH PASSWORD 'chess_testpw' CREATEDB;
CREATE DATABASE chess_test
    WITH 
    OWNER = chess_test
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
