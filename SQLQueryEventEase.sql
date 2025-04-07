-- DATABASE CREATION
USE master;
GO

IF EXISTS (SELECT * FROM sys.databases WHERE name = 'EventEaseDB')
DROP DATABASE EventEaseDB;
GO

CREATE DATABASE EventEaseDB;
GO

USE EventEaseDB;
GO

-- TABLE CREATION
CREATE TABLE Venue (
    VenueID INT IDENTITY(1,1) PRIMARY KEY,
    VenueName NVARCHAR(255) NOT NULL,
    Location NVARCHAR(255) NOT NULL,
    Capacity INT NOT NULL CHECK (Capacity > 0),
    ImageUrl NVARCHAR(500) NULL
);

CREATE TABLE Event (
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    EventName NVARCHAR(255) NOT NULL,
    EventDate DATETIME NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    VenueID INT NULL,
    CONSTRAINT FK_Event_Venue FOREIGN KEY (VenueID) 
        REFERENCES Venue(VenueID) ON DELETE NO ACTION  -- Changed from RESTRICT
);

CREATE TABLE Booking (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    VenueID INT NOT NULL,
    BookingDate DATETIME NOT NULL DEFAULT GETDATE(), -- Explicit default
    CONSTRAINT FK_Booking_Event FOREIGN KEY (EventID) 
        REFERENCES Event(EventID) ON DELETE CASCADE,
    CONSTRAINT FK_Booking_Venue FOREIGN KEY (VenueID) 
        REFERENCES Venue(VenueID) ON DELETE NO ACTION
);
GO

-- INSERT DATA INTO Venue TABLE
INSERT INTO Venue (VenueName, Location, Capacity, ImageUrl)
VALUES 
('Sandton Convention Centre', 'Sandton, Johannesburg', 5000, 'http://example.com/sandton.jpg'),
('Cape Town International Convention Centre', 'Cape Town', 10000, 'http://example.com/cticc.jpg'),
('Durban ICC Arena', 'Durban', 1500, 'http://example.com/durbanicc.jpg');

-- INSERT DATA INTO Event TABLE
INSERT INTO Event (EventName, EventDate, Description, VenueID)
VALUES
('Johannesburg Tech Expo', '2025-11-11 08:00:00', 'Tech exhibition showcasing innovations.', 1),
('Cape Town Jazz Festival', '2025-03-31 18:00:00', 'Africa''s annual jazz music festival.', 2),
('Durban Fashion Week', '2025-07-05 10:00:00', 'Showcasing the latest fashion trends.', 3);

-- INSERT DATA INTO Booking TABLE
INSERT INTO Booking (EventID, VenueID, BookingDate)
VALUES
(1, 1, '2024-12-01T09:00:00'),
(2, 2, '2024-09-15T10:30:00'),
(3, 3, '2025-01-20T11:15:00');
GO

-- TABLE MANIPULATION (SELECT)
SELECT * FROM Venue;
SELECT * FROM Event;
SELECT * FROM Booking;
GO

DROP TABLE Booking;

DROP TABLE Venue;
DROP TABLE Event;
