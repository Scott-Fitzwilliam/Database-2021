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
, EventYear INT CHECK (EventYear between 0000 AND 9999)
, EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', '[Dec]'))
, EventDay INT CHECK (EventDay >= 1 and EventDay <= 31)
, Fee MONEY NOT NULL, CHECK (Fee > 0)
, PRIMARY KEY (TourName, EventYear, EventMonth, EventDay)
, FOREIGN KEY (TourName) REFERENCES TOUR
);

CREATE TABLE Booking(
  ClientID INT
, TourName NVARCHAR(100)
, EventYear INT CHECK (EventYear between 0000 AND 9999)
, EventMonth NVARCHAR(3) CHECK (EventMonth IN ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', '[Dec]'))
, EventDay INT CHECK(EventDay >= 1 and EventDay <= 31)
, DateBooked DATE NOT NULL
, Payment MONEY CHECK (Payment > 0) 
, PRIMARY KEY (ClientID, TourName, EventYear, EventMonth, EventDay)
, FOREIGN KEY (ClientID) REFERENCES Client
, FOREIGN KEY (TourName, EventYear, EventMonth, EventDay) REFERENCES [Event]
);

select table_name from information_schema.tables;

