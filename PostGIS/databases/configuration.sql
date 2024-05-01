--
-- PostgreSQL database dump
--

-- Dumped from database version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.11 (Ubuntu 14.11-0ubuntu0.22.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: configuration; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.configuration (
    id integer NOT NULL,
    tag_id integer,
    tag_key text,
    tag_value text,
    priority double precision,
    maxspeed double precision,
    maxspeed_forward double precision,
    maxspeed_backward double precision,
    force character(1)
)
WITH (autovacuum_enabled='false');


ALTER TABLE public.configuration OWNER TO postgres;

--
-- Name: configuration_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.configuration_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.configuration_id_seq OWNER TO postgres;

--
-- Name: configuration_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.configuration_id_seq OWNED BY public.configuration.id;


--
-- Name: configuration id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuration ALTER COLUMN id SET DEFAULT nextval('public.configuration_id_seq'::regclass);


--
-- Data for Name: configuration; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.configuration (id, tag_id, tag_key, tag_value, priority, maxspeed, maxspeed_forward, maxspeed_backward, force) FROM stdin;
1	201	cycleway	lane	\N	40	40	40	N
2	204	cycleway	opposite	\N	40	40	40	N
3	203	cycleway	opposite_lane	\N	40	40	40	N
4	202	cycleway	track	\N	40	40	40	N
5	120	highway	bridleway	\N	40	40	40	N
6	116	highway	bus_guideway	\N	40	40	40	N
7	121	highway	byway	\N	40	40	40	N
8	118	highway	cycleway	\N	40	40	40	N
9	119	highway	footway	\N	40	40	40	N
10	111	highway	living_street	\N	40	40	40	N
11	101	highway	motorway	\N	40	40	40	N
12	103	highway	motorway_junction	\N	40	40	40	N
13	102	highway	motorway_link	\N	40	40	40	N
14	117	highway	path	\N	40	40	40	N
15	114	highway	pedestrian	\N	40	40	40	N
16	106	highway	primary	\N	40	40	40	N
17	107	highway	primary_link	\N	40	40	40	N
18	110	highway	residential	\N	40	40	40	N
19	100	highway	road	\N	40	40	40	N
20	108	highway	secondary	\N	40	40	40	N
21	124	highway	secondary_link	\N	40	40	40	N
22	112	highway	service	\N	40	40	40	N
23	115	highway	services	\N	40	40	40	N
24	122	highway	steps	\N	40	40	40	N
25	109	highway	tertiary	\N	40	40	40	N
26	125	highway	tertiary_link	\N	40	40	40	N
27	113	highway	track	\N	40	40	40	N
28	104	highway	trunk	\N	40	40	40	N
29	105	highway	trunk_link	\N	40	40	40	N
30	123	highway	unclassified	\N	40	40	40	N
31	401	junction	roundabout	\N	40	40	40	N
32	301	tracktype	grade1	\N	40	40	40	N
33	302	tracktype	grade2	\N	40	40	40	N
34	303	tracktype	grade3	\N	40	40	40	N
35	304	tracktype	grade4	\N	40	40	40	N
36	305	tracktype	grade5	\N	40	40	40	N
\.


--
-- Name: configuration_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.configuration_id_seq', 36, true);


--
-- Name: configuration configuration_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT configuration_pkey PRIMARY KEY (id);


--
-- Name: configuration configuration_tag_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.configuration
    ADD CONSTRAINT configuration_tag_id_key UNIQUE (tag_id);


--
-- PostgreSQL database dump complete
--

