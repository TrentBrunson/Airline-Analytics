-- Performance table includes on-time statistics. 

CREATE TABLE performance
(
	fl_date date,
	mkt_carrier VARCHAR(2),
	mkt_carrier_fl_num VARCHAR(4),
	origin VARCHAR(3),
	origin_city_name VARCHAR(45),
	origin_state_abr VARCHAR(2),
	dest VARCHAR(3),
	dest_city_name VARCHAR(45),
	dest_state_abr VARCHAR(2),
	dep_delay_new numeric,
	arr_delay_new numeric,
	cancelled numeric,
	cancellation_code VARCHAR(2),
	diverted numeric,
	carrier_delay numeric,
	weather_delay numeric,
	nas_delay numeric,
	security_delay numeric,
	late_aircraft_delay numeric
);

-- This code creates the empty table.  To populate the table with the contents of the OntimeCarrier.csv file, copy and paste the code below into pgAdmin.  Change the FROM clause (highlighted below) t

COPY public.performance (fl_date, mkt_carrier, mkt_carrier_fl_num, origin, origin_city_name, origin_state_abr, dest, dest_city_name, dest_state_abr, dep_delay_new, arr_delay_new, cancelled, cancellation_code, diverted, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay) 
FROM '/Users/Downloads/OntimeCarrier.csv' 
DELIMITER ',' 
CSV HEADER ENCODING 'UTF8' 
QUOTE '"' 
ESCAPE '''';

 
-- The codes_cancellation table is a lookup table that lists the cancellation codes that exist in the data, along with the meaning behind each code.

CREATE TABLE codes_cancellation
(
	cancellation_code VARCHAR(2),
           cancel_desc VARCHAR(45)
);

INSERT INTO codes_cancellation (cancellation_code, cancel_desc)
VALUES
	('A','Carrier'),
	('B','Weather'),
	('C','National Air System'),
	('D','Security');


-- The codes_carrier table is a lookup table that lists the air carrier codes that exist in the data, along with the full name of each airline

CREATE TABLE codes_carrier
(
	carrier_code VARCHAR(2),
	carrier_desc VARCHAR(45)
);

INSERT INTO codes_carrier (carrier_code, carrier_desc)
VALUES
	('AA','American Airlines'),
	('AS','Alaska Airlines'),
	('B6','JetBlue Airways'),
	('DL','Delta Air Lines'),
	('F9','Frontier Airlines'),
	('G4','Allegiant Air'),
	('HA','Hawaiian Airlines'),
	('NK','Spirit Air Lines'),
	('UA','United Air Lines'),
	('VX','Virgin America'),
	('WN','Southwest Airlines');
