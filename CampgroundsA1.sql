/********************************************************************************/
/*		COMP53 Section 101														*/
/*		Name:  Phuong Uyen Dang													*/
/*		Database topic: Campgrounds												*/
/*		One Customer may have many Reservations 								*/
/*		One Campground may have one detail 										*/
/*		Table names: customer, reservation, campground, campgroundNote 		    */
/********************************************************************************/

DROP DATABASE IF EXISTS dangCampgrounds;
CREATE DATABASE dangCampgrounds;
USE dangCampgrounds;

CREATE TABLE customer
(
	customerID					INT					PRIMARY KEY,
	custLName					VARCHAR(25),
	custFName					VARCHAR(25),
	custStreetAddress 			VARCHAR(35),
	custPhone					VARCHAR(12),
	custEmailAddress			VARCHAR(50),
	custDateOfBirth				DATE
);

INSERT INTO customer VALUES
(1, 'Jacobs', 'Nancy', '1440 West Palm Drive', '817-871-8123', 'Nancy.Jacobs@somewhere.com', '1987-07-21'),
(2, 'Foxtrot', 'Kathy', '11023 Elm Street', '972-233-6234', 'Kathy.Foxtrot@somewhere.com', '1968-01-11'),
(3, 'Hullett', 'Shawn', '13045 Flora', '972-233-6456', 'Shawn.Hullett@elsewhere.com', '1990-05-18'),
(4, 'Ranger', 'Terry', '56 East 18th Street', '512-974-4455', 'Terry.Ranger@somewhere.com','1988-03-30'),
(5, 'Tyler', 'Jenny', '14056 South Ervay Street', '972-233-6567', 'Jenny.Tyler@somewhere.com', '1994-10-15'),
(6, 'Baker', 'Susan', '456 Oak Street', '210-281-7876', 'Susan.Baker@elsewhere.com', '1996-05-23');


CREATE TABLE campground
(
	campsiteID					INT					PRIMARY KEY,	
	campsName					VARCHAR(50),
	campsAddress				VARCHAR(50),
	campsProvince				VARCHAR(20),
	campsPostalCode				VARCHAR(7)
);

INSERT INTO campground VALUES
(100, 'Tulabi Falls Campgrounds', 'MB-314 Bird River', 'Manitoba', 'R0E 0J0'),
(200, 'Kiche Manitou', 'MB-5 Glenboro', 'Manitoba', 'R0K 0X0'),	
(300, 'Blue Lakes Campground', 'MB-366 Cypress River', 'Manitoba', 'S0A 0B0'),
(400, 'Greenwater Lake Provincial Park', 'SK-38 Greenwater Lake', 'Saskatchewan', 'S0E 1H0'),
(500, 'Prince Albert National Park', '969 Lakeview Dr', 'Saskatchewan', 'S0J 2Y0'),
(600, 'Craigleith Provincial Park', '209403 Highway', 'Ontario', 'L9Y 0T6'),
(700, 'Pancake Bay Provincial Park', '17 North Batchawana Bay', 'Ontario', 'P0S 1A0');


CREATE TABLE campgroundNote
(
	campsiteID					INT					PRIMARY KEY,
	campsiteType				VARCHAR(25),
	basePrice					DECIMAL(6,2)
);

INSERT INTO campgroundNote VALUES
(100, 'Camping', 47.46),
(200, 'Car Camping', 52.55),
(300, 'Caravan camping', 49.44),
(400, 'Glamping', 59.33),
(500, 'Bike camping', 29.66),
(600, 'Canoe Camping', 53.68),
(700, 'Backpacking Camping', 23.73);


CREATE TABLE reservation
(
	reserveID					INT					PRIMARY KEY,
	resArrivalDate				DATE,
	resDepartureDate			DATE,
	resNumNights				INT,
	customerID					INT,
	CONSTRAINT	reservation_fk_customer
		FOREIGN KEY(customerID)
        REFERENCES customer(customerID),
	campsiteID					INT,		
	CONSTRAINT	reservation_fk_campground
		FOREIGN KEY(campsiteID)
        REFERENCES campground(campsiteID)
);

INSERT INTO reservation VALUES
(1001, '2015-08-12', '2015-08-14', 2, 1, 300),
(1002, '2018-02-22', '2018-02-25', 3, 1, 200),
(1003, '2019-06-21', '2019-06-22', 1, 2, 500),
(1004, '2020-08-03', '2020-08-07', 4, 2, 400),
(1005, '2021-11-30', '2021-12-03', 3, 2, 700),
(1006, '2014-05-21', '2014-05-25', 4, 3, 600),
(1007, '2015-05-10', '2015-05-13', 3, 3, 300),
(1008, '2017-07-12', '2017-07-14', 2, 3, 100),
(1009, '2016-09-01', '2016-09-06', 5, 4, 400),
(1010, '2018-10-23', '2018-10-25', 2, 4, 300),
(1011, '2019-06-18', '2019-06-21', 3, 4, 100),
(1012, '2018-07-12', '2018-07-13', 1, 5, 700),
(1013, '2020-01-15', '2020-01-20', 5, 5, 200),
(1014, '2014-05-21', '2014-05-23', 2, 6, 100),
(1015, '2019-06-11', '2019-06-14', 3, 6, 600);


SELECT *
FROM customer;

SELECT *
FROM reservation;

SELECT *
FROM campground;

SELECT * 
FROM campgroundNote;

SELECT custLName, resNumNights 
FROM customer
	INNER JOIN reservation
		ON customer.customerID = reservation.customerID;

SELECT campsName, campsiteType 
FROM campground
	INNER JOIN campgroundNote
		ON campground.campsiteID = campgroundNote.campsiteID;






