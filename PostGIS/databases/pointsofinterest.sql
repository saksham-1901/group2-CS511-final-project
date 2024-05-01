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
-- Name: pointsofinterest; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pointsofinterest (
    pid bigint NOT NULL,
    osm_id bigint,
    vertex_id bigint,
    edge_id bigint,
    side character(1),
    fraction double precision,
    length_m double precision,
    tag_name text,
    tag_value text,
    name text,
    the_geom public.geometry(Point,4326),
    new_geom public.geometry(Point,4326)
)
WITH (autovacuum_enabled='false');


ALTER TABLE public.pointsofinterest OWNER TO postgres;

--
-- Name: pointsofinterest_pid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pointsofinterest_pid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.pointsofinterest_pid_seq OWNER TO postgres;

--
-- Name: pointsofinterest_pid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pointsofinterest_pid_seq OWNED BY public.pointsofinterest.pid;


--
-- Name: pointsofinterest pid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pointsofinterest ALTER COLUMN pid SET DEFAULT nextval('public.pointsofinterest_pid_seq'::regclass);


--
-- Data for Name: pointsofinterest; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pointsofinterest (pid, osm_id, vertex_id, edge_id, side, fraction, length_m, tag_name, tag_value, name, the_geom, new_geom) FROM stdin;
\.


--
-- Name: pointsofinterest_pid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pointsofinterest_pid_seq', 1, false);


--
-- Name: pointsofinterest pointsofinterest_osm_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pointsofinterest
    ADD CONSTRAINT pointsofinterest_osm_id_key UNIQUE (osm_id);


--
-- Name: pointsofinterest pointsofinterest_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pointsofinterest
    ADD CONSTRAINT pointsofinterest_pkey PRIMARY KEY (pid);


--
-- Name: pointsofinterest_the_geom_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX pointsofinterest_the_geom_idx ON public.pointsofinterest USING gist (the_geom);


--
-- PostgreSQL database dump complete
--

