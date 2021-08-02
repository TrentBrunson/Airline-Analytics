-- To restore DB on new system/location...
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2
-- Dumped by pg_dump version 11.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE airlines;
--
-- Name: airlines; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE airlines WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE airlines OWNER TO postgres;

\connect airlines

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: codes_cancellation; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codes_cancellation (
    cancellation_code character varying(2),
    cancel_desc character varying(45)
);


ALTER TABLE public.codes_cancellation OWNER TO postgres;

--
-- Name: codes_carrier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.codes_carrier (
    carrier_code character varying(2),
    carrier_desc character varying(45)
);


ALTER TABLE public.codes_carrier OWNER TO postgres;

--
-- Name: perform_feb; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.perform_feb (
    fl_date date,
    mkt_carrier character varying(2),
    mkt_carrier_fl_num character varying(4),
    origin character varying(3),
    origin_city_name character varying(45),
    origin_state_abr character varying(2),
    dest character varying(3),
    dest_city_name character varying(45),
    dest_state_abr character varying(2),
    dep_delay_new numeric,
    arr_delay_new numeric,
    cancelled numeric,
    cancellation_code character varying(2),
    diverted numeric,
    carrier_delay numeric,
    weather_delay numeric,
    nas_delay numeric,
    security_delay numeric,
    late_aircraft_delay numeric
);


ALTER TABLE public.perform_feb OWNER TO postgres;

--
-- Name: performance; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.performance (
    fl_date date,
    mkt_carrier character varying(2),
    mkt_carrier_fl_num character varying(4),
    origin character varying(3),
    origin_city_name character varying(45),
    origin_state_abr character varying(2),
    dest character varying(3),
    dest_city_name character varying(45),
    dest_state_abr character varying(2),
    dep_delay_new numeric,
    arr_delay_new numeric,
    cancelled numeric,
    cancellation_code character varying(2),
    diverted numeric,
    carrier_delay numeric,
    weather_delay numeric,
    nas_delay numeric,
    security_delay numeric,
    late_aircraft_delay numeric
);


ALTER TABLE public.performance OWNER TO postgres;

--
-- Data for Name: codes_cancellation; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.codes_cancellation (cancellation_code, cancel_desc) FROM stdin;
\.
COPY public.codes_cancellation (cancellation_code, cancel_desc) FROM '$$PATH$$/3136.dat';

--
-- Data for Name: codes_carrier; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.codes_carrier (carrier_code, carrier_desc) FROM stdin;
\.
COPY public.codes_carrier (carrier_code, carrier_desc) FROM '$$PATH$$/3137.dat';

--
-- Data for Name: perform_feb; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.perform_feb (fl_date, mkt_carrier, mkt_carrier_fl_num, origin, origin_city_name, origin_state_abr, dest, dest_city_name, dest_state_abr, dep_delay_new, arr_delay_new, cancelled, cancellation_code, diverted, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay) FROM stdin;
\.
COPY public.perform_feb (fl_date, mkt_carrier, mkt_carrier_fl_num, origin, origin_city_name, origin_state_abr, dest, dest_city_name, dest_state_abr, dep_delay_new, arr_delay_new, cancelled, cancellation_code, diverted, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay) FROM '$$PATH$$/3138.dat';

--
-- Data for Name: performance; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.performance (fl_date, mkt_carrier, mkt_carrier_fl_num, origin, origin_city_name, origin_state_abr, dest, dest_city_name, dest_state_abr, dep_delay_new, arr_delay_new, cancelled, cancellation_code, diverted, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay) FROM stdin;
\.
COPY public.performance (fl_date, mkt_carrier, mkt_carrier_fl_num, origin, origin_city_name, origin_state_abr, dest, dest_city_name, dest_state_abr, dep_delay_new, arr_delay_new, cancelled, cancellation_code, diverted, carrier_delay, weather_delay, nas_delay, security_delay, late_aircraft_delay) FROM '$$PATH$$/3135.dat';

--
-- PostgreSQL database dump complete
--

