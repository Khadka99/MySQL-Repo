USE revision;

SELECT * FROM movies;

-- UPPER/LOWER case
SELECT name,UPPER(name),LOWER(name) FROM movies;

-- CONCAT/CONCAT_WS--CONCAT WITH SEPERATOR
SELECT name,CONCAT(name,' ',director,' ',star) FROM movies;
 SELECT name,CONCAT_WS('-',name,director,star) FROM movies;
 SELECT name,CONCAT_WS('+',name,director,star) FROM movies;
 
 -- SUBSTR(string_input,position_input,num_of_char_input)
 SELECT name,SUBSTR(name,1,5) FROM movies; -- returns 5 charecters.
 SELECT name,SUBSTR(name,1) FROM movies;
 SELECT name,SUBSTR(name,5,5) FROM movies;
 SELECT name,SUBSTR(name,-1) FROM movies;
 SELECT name,SUBSTR(name,-5) FROM movies;
SELECT name,SUBSTR(name,-5,1) FROM movies;

-- REPLACE
SELECT name, REPLACE(name,"man","women"),REPLACE(name,"Man","Women") FROM movies
WHERE name LIKE '%man%';

-- CHAR_LENGTH Vs LENGTH
SELECT name,LENGTH(name),CHAR_LENGTH(name) FROM movies;
SELECT name,LENGTH(name),CHAR_LENGTH(name) FROM movies
WHERE LENGTH(name) != CHAR_LENGTH(name); -- check theory(documentation)

-- INSERT(STRING,POSITION,LENGTH, NEW-STRING)
SELECT INSERT("hello world",7,0,"nepal");
SELECT INSERT("hello world",7,5,"nepal");

-- LEFT/RIGHT
SELECT name,LEFT(name,3) FROM movies;
SELECT name,RIGHT(name,3) FROM movies;

-- REPEAT
SELECT name, REPEAT(name,3) FROM movies;

-- TRIM/LTRIM/RTRIM
SELECT TRIM("     ASHISH      ");
SELECT TRIM(BOTH '.' FROM ".......ASHISH......");
SELECT TRIM(LEADING '.' FROM ".......ASHISH......");
SELECT TRIM(TRAILING '.' FROM ".......ASHISH......");
SELECT LENGTH(LTRIM("     ASHISH      ")); -- TO CHECK.
SELECT RTRIM("     ASHISH      ");

-- SUBSTRING_INDEX()..It works like split.
SELECT 'www.campusx.in', SUBSTRING_INDEX('www.campusx.in','.',1);
SELECT 'www.campusx.in', SUBSTRING_INDEX('www.campusx.in','.',2);
SELECT 'www.campusx.in', SUBSTRING_INDEX('www.campusx.in','.',-1);

/* STRCMP()
The STRCMP() function returns an integer that indicates the
relationship between the two strings:
○ If str1 is less than str2, the function returns a negative integer.
If str1 is greater than str2, the function returns a positive
integer.
○

○ If str1 is equal to str2, the function returns 0.
*/
SELECT STRCMP("Dhangadhi","Kathmandu");
SELECT STRCMP("Kathmandu","Dhangadhi");
SELECT STRCMP("Kathmandu","KATHMANDU");

-- LOCATE()
SELECT LOCATE("w","hello world");-- its searching for 'w' postion, its on 7th position.
SELECT LOCATE("w","hello world",4);

-- LPAD/RPAD()
SELECT LPAD('3068971234',12,'+1');
SELECT RPAD('3068971234',12,'+1');














 
 
 
 
 
 
 
 
 