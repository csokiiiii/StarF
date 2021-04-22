--
-- PostgreSQL database dump
--

-- Dumped from database version 12.6
-- Dumped by pg_dump version 12.6

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
-- Name: kiado; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kiado (
    nev character(20) NOT NULL,
    cim character(200),
    alapitas date
);


ALTER TABLE public.kiado OWNER TO postgres;

--
-- Name: videojatek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.videojatek (
    jatekid integer NOT NULL,
    nev character(20) NOT NULL,
    kategoria character(20),
    fejleszto character(20),
    kiado character(20)
);


ALTER TABLE public.videojatek OWNER TO postgres;

--
-- Name: videojatek_jatekid_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.videojatek_jatekid_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.videojatek_jatekid_seq OWNER TO postgres;

--
-- Name: videojatek_jatekid_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.videojatek_jatekid_seq OWNED BY public.videojatek.jatekid;


--
-- Name: videojatek jatekid; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videojatek ALTER COLUMN jatekid SET DEFAULT nextval('public.videojatek_jatekid_seq'::regclass);


--
-- Data for Name: kiado; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kiado (nev, cim, alapitas) FROM stdin;
WowKiado            	1013 Petofi Sandor utca 2                                                                                                                                                                               	2002-02-02
CodKiado            	1013 Petofi Sandor utca 1                                                                                                                                                                               	2017-03-14
NFSKiado            	1013 Petofi Sandor utca 3                                                                                                                                                                               	2003-03-04
jatek4Kiado         	1013 Petofi Sandor utca 4                                                                                                                                                                               	2002-02-02
\.


--
-- Data for Name: videojatek; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.videojatek (jatekid, nev, kategoria, fejleszto, kiado) FROM stdin;
2	Worldofwarcraft     	FPS                 	WowFejleszto        	WowKiado            
1	Call of Duty        	FPS                 	CodFejleszto        	CodKiado            
3	Need for Speed      	Open World racing   	NFSFejleszto        	NFSKiado            
4	JatekNev4           	RPG                 	jatek4Fefleszto     	jatek4Kiado         
5	JatekNev5           	RPG                 	jatek5Fefleszto     	jatek4Kiado         
\.


--
-- Name: videojatek_jatekid_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.videojatek_jatekid_seq', 1, false);


--
-- Name: kiado kiado_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kiado
    ADD CONSTRAINT kiado_pkey PRIMARY KEY (nev);


--
-- Name: videojatek videojatek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videojatek
    ADD CONSTRAINT videojatek_pkey PRIMARY KEY (jatekid);


--
-- Name: videojatek fk_kiado; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.videojatek
    ADD CONSTRAINT fk_kiado FOREIGN KEY (kiado) REFERENCES public.kiado(nev);


--
-- PostgreSQL database dump complete
--

