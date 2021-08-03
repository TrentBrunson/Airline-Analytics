SELECT * FROM codes_carrier;

SELECT carrier_code || ': ' || carrier_desc FROM codes_carrier;

SELECT CONCAT(carrier_code, ': ', carrier_desc) AS display_carrier
	FROM codes_carrier;

SELECT carrier_code,
		carrier_desc,
		SUBSTRING(carrier_desc, 1, 8) AS carrier_display
	FROM codes_carrier;

SELECT carrier_code,
		carrier_desc,
		REPLACE(SUBSTRING(carrier_desc, 1, 8), ' ', '') AS carrier_display
	FROM codes_carrier;

SELECT carrier_code,
		carrier_desc,
		UPPER(REPLACE(SUBSTRING(carrier_desc, 1, 8), ' ', '')) AS carrier_display
	FROM codes_carrier;







