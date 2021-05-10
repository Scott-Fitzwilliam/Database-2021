-- Scott Fitzwilliam, 103116463, Group 2.

-- TOUR (TourName, Description)
-- PRIMARY KEY (TourName)

-- Client(ClientID, Surname, GivenName, Gender)
-- PRIMARY KEY(ClientID)

-- Event(TourName, EventYear, EventMonth, EventDay, Fee)
-- PRIMARY KEY(TourName, EventYear, EventMonth, EventDay)
-- FOREIGN KEY(TourName) REFERENCES TOUR

-- Booking(ClientID, TourName, EventYear, EventMonth, EventDay, DateBooked, Payment)
-- PRIMARY KEY(ClientID, TourName, EventYear, EventMonth, EventDay)
-- FOREIGN KEY(ClientID) REFERENCES Client
-- FOREIGN KEY(TourName, EventYear, EventMonth, EventDay) REFERENCES Event

USE Assessment10_05_2021
-- The drop order has to be reversed due to data integrity
IF OBJECT_ID('Booking') IS NOT NULL
DROP TABLE Booking;
IF OBJECT_ID('Event') IS NOT NULL
DROP TABLE [Event];
IF OBJECT_ID('Client') IS NOT NULL
DROP TABLE Client;
IF OBJECT_ID('TOUR') IS NOT NULL
DROP TABLE TOUR;

GO
CREATE TABLE TOUR(
  TourName NVARCHAR(100)
, [Description] NVARCHAR(500)
, PRIMARY KEY (TourName)
);

CREATE TABLE CLIENT(
  ClientID INT
, Surname NVARCHAR(100) NOT NULL
, GivenName NVARCHAR(100) NOT NULL
, Gender NVARCHAR(1) CHECK (Gender IN ('M','F','I')) 
, PRIMARY KEY (ClientID)
);

CREATE TABLE [Event](
  TourName NVARCHAR(100)
, EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', '[Dec]'))
, EventDay INT CHECK (EventDay >= 1 and EventDay <= 31)
, EventYear INT CHECK (EventYear between 0000 AND 9999)
, Fee MONEY NOT NULL, CHECK (Fee > 0)
, PRIMARY KEY (TourName, EventYear, EventMonth, EventDay)
, FOREIGN KEY (TourName) REFERENCES TOUR
);

CREATE TABLE Booking(
  ClientID INT
, TourName NVARCHAR(100)
, EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', '[Dec]'))
, EventDay INT CHECK (EventDay >= 1 and EventDay <= 31)
, EventYear INT CHECK (EventYear between 0000 AND 9999)
, Payment MONEY CHECK (Payment > 0) 
, DateBooked DATE NOT NULL
, PRIMARY KEY (ClientID, TourName, EventYear, EventMonth, EventDay)
, FOREIGN KEY (ClientID) REFERENCES Client
, FOREIGN KEY (TourName, EventYear, EventMonth, EventDay) REFERENCES [Event]
);

-- select table_name from information_schema.tables;

INSERT INTO TOUR (TourName, [Description]) VALUES
('North',	'Tour of wineries and outlets of the Bedigo and Castlemaine region'),
('South',	'Tour of wineries and outlets of Mornington Penisula'),
('West',	'Tour of wineries and outlets of the Geelong and Otways region');


INSERT INTO Client(ClientID, Surname, GivenName, Gender) VALUES
(1,	'Price',	'Taylor',	'M'),
(2,	'Gamble',	'Ellyse',	'F'),
(3,	'Tan',	'Tilly',	'F'),
(103116463,	'Fitwilliam',	'Scott', 'M');


INSERT INTO Event(TourName, EventMonth, EventDay, EventYear, Fee) VALUES
('North', 'Jan',	9,	2016,	200),
('North',	'Feb',	13,	2016,	225),
('South', 'Jan',	9,	2016,	200),
('South', 'Jan',	16,	2016,	200),
('West', 'Jan',	29,	2016,	225);

-- 103 is the british/french style (aka the only correct way of doing time) to get dd/mm/yyyy
INSERT INTO Booking(ClientID, TourName, EventMonth, EventDay, EventYear, Payment, DateBooked) VALUES
(1,	'North', 'Jan', 9, 2016, 200, CONVERT(date, '10/12/2015', 103)),
(2,	'North', 'Jan', 9, 2016, 200, CONVERT(date, '16/12/2015', 103)),
(1,	'North', 'Feb', 13, 2016, 225, CONVERT(date, '8/01/2016', 103)),
(2,	'North', 'Feb', 13, 2016, 125, CONVERT(date, '14/01/2016', 103)),
(3,	'North', 'Feb', 13, 2016, 225, CONVERT(date, '3/02/2016', 103)),
(1,	'South', 'Jan', 9, 2016, 200, CONVERT(date, '10/12/2015', 103)),
(2,	'South', 'Jan', 16, 2016, 200, CONVERT(date, '18/12/2015', 103)),
(3,	'South', 'Jan', 16, 2016, 200, CONVERT(date, '9/01/2016', 103)),
(2,	'West',	'Jan', 29, 2016, 225,	CONVERT(date, '17/12/2015', 103)),
(3,	'West',	'Jan', 29, 2016, 200,	CONVERT(date, '18/12/2015', 103));

SELECT *
FROM CLIENT