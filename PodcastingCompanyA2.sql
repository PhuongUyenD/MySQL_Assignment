/********************************************************************************/
/*		COMP53 Section 101														*/																
/*		Assignment 2 - Create a database for a podcasting company 				*/
/*		Date:  18/03/2022														*/							
/*		Name:  Phuong Uyen Dang													*/
/********************************************************************************/

DROP DATABASE IF EXISTS A2PhuongUyen;
CREATE DATABASE A2PhuongUyen;
USE A2PhuongUyen;

CREATE TABLE guest
(
	guestID						INT					PRIMARY KEY,
	guestLName					VARCHAR(25),
	guestFName					VARCHAR(25),
	guestPhone					VARCHAR(12),
	guestEmailAddress			VARCHAR(50),
	guestDateOfBirth			DATE
);

INSERT INTO guest VALUES
(1, 'Jacobs', 	'Nancy', '817-871-8123', 'Nancy.Jacobs@somewhere.com', 	'1987-07-21'),
(2, 'Foxtrot', 	'Kathy', '972-233-6234', 'Kathy.Foxtrot@somewhere.com', '1968-01-11'),
(3, 'Hullett', 	'Shawn', '972-233-6456', 'Shawn.Hullett@elsewhere.com', '1990-05-18'),
(4, 'Ranger', 	'Terry', '512-974-4455', 'Terry.Ranger@somewhere.com',	'1988-03-30'),
(5, 'Tyler', 	'Jenny', '972-233-6567', 'Jenny.Tyler@somewhere.com', 	'1994-10-15');

CREATE TABLE podcast
(
	podcastID					INT 				PRIMARY KEY,
    podcastTitle				VARCHAR(100),
    podcastHost					VARCHAR(100),
    podcastYearRel				YEAR
);

INSERT INTO podcast VALUES
(10, 'Happier with Gretchen Rubin', 'Gretchen Rubin', 							 2015),
(20, 'The School of Greatness', 	'Lewis Howes', 								 2013),
(30, 'Tony Robbins Podcast', 		'Tony Robbins', 							 2016),
(40, 'The Minimalists', 			'Joshua Fields Millburn and Ryan Nicodemus', 2016),
(50, 'Where should we begin?', 		'Esther Perel', 							 2017),
(60, 'Optimal Living Daily', 		'Justine Malik', 							 2013);

-- one - one table
CREATE TABLE podcastNote
(
	podcastID					INT 				PRIMARY KEY,
    podcastType			 		VARCHAR(100),
	podcastPrice				DECIMAL(9,2),
    
     FOREIGN KEY(podcastID)
		REFERENCES podcast(podcastID)   
);

INSERT INTO podcastNote VALUES
(10, 'Happiness', 					 	23.45),
(20, 'Passion and Motivation', 			20.21),
(30, 'Succeed In Life and Business', 	35.12),
(40, 'Minimalism', 						16.43),
(50, 'Relationship', 					10.65),
(60, 'Personal Development', 			28.74); 

CREATE TABLE guestPodcast
(
	podcastID					INT,
    guestID						INT,
	favoritePod					BOOLEAN,
    
	PRIMARY KEY(guestID, podcastID),  -- composite PK, declared at table level
    
    FOREIGN KEY(guestID) -- is saying that this column in the table is the foreign key
		REFERENCES guest(guestID),  
        
	FOREIGN KEY(podcastID)
		REFERENCES podcast(podcastID)
);

INSERT INTO guestPodcast VALUES
(10, 1, FALSE),
(40, 1, TRUE),
(20, 4, TRUE),
(50, 5, TRUE),
(50, 2, FALSE),
(60, 3, TRUE);


/*
-- 1
SELECT podcastTitle, podcastHost, podcastType, podcastPrice
FROM podcast p
	JOIN podcastNote n
	ON p.podcastID = n.podcastID
WHERE podcastType LIKE 'P%';

-- 2
SELECT podcastID, podcastPrice * .7 AS discountedPrice
FROM podcastNote
ORDER BY discountedPrice DESC;

-- 3
SELECT podcastTitle
FROM podcast p
	LEFT JOIN guestPodcast gp
		ON p.podcastID = gp.podcastID
	LEFT JOIN guest g
		ON g.guestID = gp.guestID 
WHERE guestFName IS NULL;

-- 3 better, should use it
SELECT podcastTitle
FROM podcast p
	LEFT OUTER JOIN guestPodcast gp
		ON p.podcastID = gp.podcastID
WHERE guestID IS NULL;

-- 4
SELECT podcastTitle, podcastHost, podcastType, guestLName 
FROM podcast p
	INNER JOIN guestPodcast gp
		ON p.podcastID = gp.podcastID
	INNER JOIN guest g
		ON g.guestID = gp.guestID
	INNER JOIN podcastNote n
		ON p.podcastID = n.podcastID
ORDER BY p.podcastID;




