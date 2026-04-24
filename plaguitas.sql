--
-- PostgreSQL database dump
--

\restrict KiH9H01rdsp9lYBQMex9BzkH5xW5fCFn2r5hQiYe9sUBLcRP1F6M3OUYCTOyWEh

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: diagnostico; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.diagnostico (
    id_diagnostico integer NOT NULL,
    id_lectura integer NOT NULL,
    id_tipo_plaga integer NOT NULL,
    nivel_riesgo character varying(20) NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL,
    sincronizado boolean DEFAULT false,
    CONSTRAINT diagnostico_nivel_riesgo_check CHECK (((nivel_riesgo)::text = ANY (ARRAY[('bajo'::character varying)::text, ('medio'::character varying)::text, ('alto'::character varying)::text])))
);


ALTER TABLE public.diagnostico OWNER TO postgres;

--
-- Name: diagnostico_id_diagnostico_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.diagnostico_id_diagnostico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.diagnostico_id_diagnostico_seq OWNER TO postgres;

--
-- Name: diagnostico_id_diagnostico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.diagnostico_id_diagnostico_seq OWNED BY public.diagnostico.id_diagnostico;


--
-- Name: incidencia_plaga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.incidencia_plaga (
    id_incidencia integer NOT NULL,
    id_surco integer NOT NULL,
    id_tipo_plaga integer NOT NULL,
    id_usuario integer NOT NULL,
    cantidad_plaga integer NOT NULL,
    fecha timestamp without time zone NOT NULL,
    comentarios text NOT NULL,
    foto_url character varying(1000) NOT NULL
);


ALTER TABLE public.incidencia_plaga OWNER TO postgres;

--
-- Name: incidencia_plaga_id_incidencia_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.incidencia_plaga_id_incidencia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.incidencia_plaga_id_incidencia_seq OWNER TO postgres;

--
-- Name: incidencia_plaga_id_incidencia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.incidencia_plaga_id_incidencia_seq OWNED BY public.incidencia_plaga.id_incidencia;


--
-- Name: lectura_sensor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.lectura_sensor (
    id_lectura integer NOT NULL,
    id_surco integer NOT NULL,
    id_usuario integer NOT NULL,
    humedad_tierra numeric(5,2) NOT NULL,
    temperatura_tierra numeric(5,2) NOT NULL,
    ph_suelo numeric(4,2) NOT NULL,
    temperatura_ambiental numeric(5,2) NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL,
    sincronizado boolean DEFAULT false,
    humedad_ambiental numeric(5,2),
    nitrogeno numeric(5,2),
    fosforo numeric(5,2),
    potasio numeric(5,2),
    fotoperiodo numeric(5,2),
    tipo_suelo character varying(50),
    tipo_clima character varying(50)
);


ALTER TABLE public.lectura_sensor OWNER TO postgres;

--
-- Name: lectura_sensor_id_lectura_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.lectura_sensor_id_lectura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.lectura_sensor_id_lectura_seq OWNER TO postgres;

--
-- Name: lectura_sensor_id_lectura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.lectura_sensor_id_lectura_seq OWNED BY public.lectura_sensor.id_lectura;


--
-- Name: rancho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rancho (
    id_rancho integer NOT NULL,
    nombre_rancho character varying(50) NOT NULL
);


ALTER TABLE public.rancho OWNER TO postgres;

--
-- Name: rancho_id_rancho_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rancho_id_rancho_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rancho_id_rancho_seq OWNER TO postgres;

--
-- Name: rancho_id_rancho_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rancho_id_rancho_seq OWNED BY public.rancho.id_rancho;


--
-- Name: rango_condicion_plaga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rango_condicion_plaga (
    id_rango integer NOT NULL,
    id_tipo_plaga integer NOT NULL,
    humedad_tierra_min numeric(5,2),
    humedad_tierra_max numeric(5,2),
    temp_tierra_min numeric(5,2),
    temp_tierra_max numeric(5,2),
    ph_min numeric(5,2),
    ph_max numeric(5,2),
    temp_ambiente_min numeric(5,2),
    temp_ambiente_max numeric(5,2),
    humedad_ambiente_min numeric(5,2),
    humedad_ambiente_max numeric(5,2),
    nitrogeno_min numeric(5,2),
    nitrogeno_max numeric(5,2),
    fosforo_min numeric(5,2),
    fosforo_max numeric(5,2),
    potasio_min numeric(5,2),
    potasio_max numeric(5,2),
    fotoperiodo_min numeric(5,2),
    fotoperiodo_max numeric(5,2),
    tipo_suelo character varying(50),
    tipo_clima character varying(50)
);


ALTER TABLE public.rango_condicion_plaga OWNER TO postgres;

--
-- Name: rango_condicion_plaga_id_rango_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rango_condicion_plaga_id_rango_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rango_condicion_plaga_id_rango_seq OWNER TO postgres;

--
-- Name: rango_condicion_plaga_id_rango_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rango_condicion_plaga_id_rango_seq OWNED BY public.rango_condicion_plaga.id_rango;


--
-- Name: surco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.surco (
    id_surco integer NOT NULL,
    numero_surco integer NOT NULL,
    tipo_cultivo character varying(50) NOT NULL,
    id_tunel integer NOT NULL
);


ALTER TABLE public.surco OWNER TO postgres;

--
-- Name: surco_id_surco_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.surco_id_surco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.surco_id_surco_seq OWNER TO postgres;

--
-- Name: surco_id_surco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.surco_id_surco_seq OWNED BY public.surco.id_surco;


--
-- Name: tipo_plaga; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tipo_plaga (
    id_tipo_plaga integer NOT NULL,
    nombre_plaga character varying(50) NOT NULL,
    descripcion text NOT NULL
);


ALTER TABLE public.tipo_plaga OWNER TO postgres;

--
-- Name: tipo_plaga_id_tipo_plaga_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tipo_plaga_id_tipo_plaga_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tipo_plaga_id_tipo_plaga_seq OWNER TO postgres;

--
-- Name: tipo_plaga_id_tipo_plaga_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tipo_plaga_id_tipo_plaga_seq OWNED BY public.tipo_plaga.id_tipo_plaga;


--
-- Name: tunel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tunel (
    id_tunel integer NOT NULL,
    numero_tunel integer NOT NULL,
    id_rancho integer NOT NULL
);


ALTER TABLE public.tunel OWNER TO postgres;

--
-- Name: tunel_id_tunel_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tunel_id_tunel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tunel_id_tunel_seq OWNER TO postgres;

--
-- Name: tunel_id_tunel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tunel_id_tunel_seq OWNED BY public.tunel.id_tunel;


--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre character varying(30) NOT NULL,
    apellidos character varying(30) NOT NULL,
    "contraeña" character varying(255) NOT NULL,
    rol character varying(50) NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuario_id_usuario_seq OWNER TO postgres;

--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- Name: usuario_rancho; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_rancho (
    id_usuario integer NOT NULL,
    id_rancho integer NOT NULL
);


ALTER TABLE public.usuario_rancho OWNER TO postgres;

--
-- Name: diagnostico id_diagnostico; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnostico ALTER COLUMN id_diagnostico SET DEFAULT nextval('public.diagnostico_id_diagnostico_seq'::regclass);


--
-- Name: incidencia_plaga id_incidencia; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia_plaga ALTER COLUMN id_incidencia SET DEFAULT nextval('public.incidencia_plaga_id_incidencia_seq'::regclass);


--
-- Name: lectura_sensor id_lectura; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectura_sensor ALTER COLUMN id_lectura SET DEFAULT nextval('public.lectura_sensor_id_lectura_seq'::regclass);


--
-- Name: rancho id_rancho; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rancho ALTER COLUMN id_rancho SET DEFAULT nextval('public.rancho_id_rancho_seq'::regclass);


--
-- Name: rango_condicion_plaga id_rango; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rango_condicion_plaga ALTER COLUMN id_rango SET DEFAULT nextval('public.rango_condicion_plaga_id_rango_seq'::regclass);


--
-- Name: surco id_surco; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.surco ALTER COLUMN id_surco SET DEFAULT nextval('public.surco_id_surco_seq'::regclass);


--
-- Name: tipo_plaga id_tipo_plaga; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_plaga ALTER COLUMN id_tipo_plaga SET DEFAULT nextval('public.tipo_plaga_id_tipo_plaga_seq'::regclass);


--
-- Name: tunel id_tunel; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tunel ALTER COLUMN id_tunel SET DEFAULT nextval('public.tunel_id_tunel_seq'::regclass);


--
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- Data for Name: diagnostico; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.diagnostico (id_diagnostico, id_lectura, id_tipo_plaga, nivel_riesgo, fecha, sincronizado) FROM stdin;
1	4	1	medio	2026-04-18 17:31:47.603168	f
2	3	1	alto	2026-04-18 17:31:47.603168	f
3	25	2	alto	2026-04-18 17:31:47.603168	f
4	26	2	medio	2026-04-18 17:31:47.603168	f
5	27	2	alto	2026-04-18 17:31:47.603168	f
6	57	2	medio	2026-04-18 17:31:47.603168	f
7	28	2	alto	2026-04-18 17:31:47.603168	f
8	52	3	alto	2026-04-18 17:31:47.603168	f
9	85	3	medio	2026-04-18 17:31:47.603168	f
10	50	3	alto	2026-04-18 17:31:47.603168	f
11	51	3	medio	2026-04-18 17:31:47.603168	f
12	49	3	alto	2026-04-18 17:31:47.603168	f
\.


--
-- Data for Name: incidencia_plaga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.incidencia_plaga (id_incidencia, id_surco, id_tipo_plaga, id_usuario, cantidad_plaga, fecha, comentarios, foto_url) FROM stdin;
1	1	1	1	12	2026-04-16 13:04:58.242061	Presencia detectada en envés de hojas jóvenes.	http://sistema-agricola.com/fotos/pulgon01.jpg
2	1	2	1	8	2026-04-15 13:04:58.242061	Puntos amarillos y telarañas finas en el cultivo.	http://sistema-agricola.com/fotos/arana02.jpg
3	1	3	1	5	2026-04-14 13:04:58.242061	Manchas aceitosas debido a la alta humedad ambiental.	n/a
\.


--
-- Data for Name: lectura_sensor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.lectura_sensor (id_lectura, id_surco, id_usuario, humedad_tierra, temperatura_tierra, ph_suelo, temperatura_ambiental, fecha, sincronizado, humedad_ambiental, nitrogeno, fosforo, potasio, fotoperiodo, tipo_suelo, tipo_clima) FROM stdin;
3	1	1	71.91	23.11	6.42	20.39	2026-04-16 13:01:59.321308	t	73.01	36.74	66.53	26.77	13.66	Franco	Templado
4	1	1	20.63	27.71	7.20	26.09	2026-04-16 12:01:59.321308	t	48.74	92.65	84.01	92.53	13.58	Franco	Templado
5	1	1	22.12	18.14	7.28	18.86	2026-04-16 11:01:59.321308	t	37.79	83.50	91.93	83.27	10.79	Franco	Templado
6	1	1	70.59	28.33	5.69	26.50	2026-04-16 10:01:59.321308	t	40.65	19.29	14.56	89.88	8.39	Franco	Templado
7	1	1	72.84	26.32	7.29	29.11	2026-04-16 09:01:59.321308	t	66.69	57.96	18.30	15.08	12.56	Franco	Templado
8	1	1	73.73	23.85	6.00	28.45	2026-04-16 08:01:59.321308	t	80.53	23.20	15.87	77.31	12.89	Franco	Templado
9	1	1	62.21	23.76	5.91	29.46	2026-04-16 07:01:59.321308	t	74.73	53.57	61.59	60.70	8.47	Franco	Templado
10	1	1	76.26	17.65	6.02	28.07	2026-04-16 06:01:59.321308	t	52.10	55.93	34.20	68.63	12.28	Franco	Templado
11	1	1	40.60	22.97	5.65	22.79	2026-04-16 05:01:59.321308	t	36.71	32.40	57.29	11.21	8.08	Franco	Templado
12	1	1	24.62	15.44	6.00	27.46	2026-04-16 04:01:59.321308	t	83.28	43.06	12.81	84.51	10.65	Franco	Templado
13	1	1	49.93	19.14	5.99	26.12	2026-04-16 03:01:59.321308	t	65.09	74.46	33.39	72.73	8.53	Franco	Templado
14	1	1	30.63	29.73	6.39	18.31	2026-04-16 02:01:59.321308	t	55.55	23.16	67.48	28.82	10.48	Franco	Templado
15	1	1	45.83	29.44	6.14	31.10	2026-04-16 01:01:59.321308	t	73.76	80.14	12.41	37.84	10.79	Franco	Templado
16	1	1	42.05	19.35	7.29	21.87	2026-04-16 00:01:59.321308	t	75.91	29.80	87.03	12.04	11.84	Franco	Templado
17	1	1	78.63	28.69	6.94	22.94	2026-04-15 23:01:59.321308	t	84.62	38.80	58.34	86.71	12.50	Franco	Templado
18	1	1	54.17	22.51	6.77	20.92	2026-04-15 22:01:59.321308	t	49.16	78.60	62.38	46.02	9.97	Franco	Templado
19	1	1	78.22	22.39	7.05	26.03	2026-04-15 21:01:59.321308	t	70.08	38.93	32.09	22.11	13.46	Franco	Templado
20	1	1	54.42	17.65	7.48	19.04	2026-04-15 20:01:59.321308	t	85.95	24.44	70.17	48.04	9.31	Franco	Templado
21	1	1	70.42	18.79	7.36	34.84	2026-04-15 19:01:59.321308	t	57.59	47.34	83.67	85.95	9.34	Franco	Templado
22	1	1	61.94	26.18	7.31	24.03	2026-04-15 18:01:59.321308	t	63.82	12.56	95.56	70.96	12.88	Franco	Templado
23	1	1	68.49	22.17	6.14	25.66	2026-04-15 17:01:59.321308	t	55.77	66.55	72.26	54.85	12.19	Franco	Templado
24	1	1	26.37	26.01	5.62	33.62	2026-04-15 16:01:59.321308	t	89.02	53.74	54.35	35.83	10.87	Franco	Templado
25	1	1	64.31	21.76	7.22	34.53	2026-04-15 15:01:59.321308	t	72.34	54.11	93.08	35.00	13.67	Franco	Templado
26	1	1	29.37	26.39	5.99	19.94	2026-04-15 14:01:59.321308	t	58.25	50.32	75.65	27.79	12.53	Franco	Templado
27	1	1	47.25	21.80	6.62	23.68	2026-04-15 13:01:59.321308	t	40.58	12.15	23.98	12.86	11.41	Franco	Templado
28	1	1	61.50	17.37	6.72	32.04	2026-04-15 12:01:59.321308	t	48.76	21.60	83.54	55.86	10.48	Franco	Templado
29	1	1	52.96	15.03	5.91	26.37	2026-04-15 11:01:59.321308	t	42.33	88.08	86.55	40.29	12.29	Franco	Templado
30	1	1	44.37	20.75	6.03	21.52	2026-04-15 10:01:59.321308	t	48.85	95.13	64.70	87.70	10.02	Franco	Templado
31	1	1	50.84	27.46	7.50	19.03	2026-04-15 09:01:59.321308	t	63.56	31.63	84.07	41.89	13.35	Franco	Templado
32	1	1	70.10	25.87	7.06	30.09	2026-04-15 08:01:59.321308	t	47.97	94.89	40.16	56.36	8.42	Franco	Templado
33	1	1	58.72	17.47	5.87	24.22	2026-04-15 07:01:59.321308	t	30.60	69.14	71.07	16.57	12.81	Franco	Templado
34	1	1	71.34	21.08	6.53	29.70	2026-04-15 06:01:59.321308	t	82.94	30.71	29.89	47.54	11.43	Franco	Templado
35	1	1	36.34	22.07	6.30	33.03	2026-04-15 05:01:59.321308	t	52.35	95.90	29.51	95.78	8.21	Franco	Templado
36	1	1	44.26	23.57	6.03	31.66	2026-04-15 04:01:59.321308	t	52.57	68.75	46.29	97.50	10.44	Franco	Templado
37	1	1	53.31	22.22	5.76	18.03	2026-04-15 03:01:59.321308	t	51.95	72.30	75.98	87.86	12.52	Franco	Templado
38	1	1	42.05	19.65	5.93	20.97	2026-04-15 02:01:59.321308	t	88.42	72.86	12.52	44.90	12.54	Franco	Templado
39	1	1	31.88	20.99	6.38	34.40	2026-04-15 01:01:59.321308	t	87.01	34.72	65.29	28.12	10.06	Franco	Templado
40	1	1	31.55	20.74	5.50	23.81	2026-04-15 00:01:59.321308	t	61.62	41.90	53.03	38.87	10.54	Franco	Templado
41	1	1	58.38	16.21	6.28	32.94	2026-04-14 23:01:59.321308	t	53.00	43.97	96.30	65.96	9.25	Franco	Templado
42	1	1	44.39	25.65	7.11	31.27	2026-04-14 22:01:59.321308	t	56.23	90.85	24.46	23.00	10.13	Franco	Templado
43	1	1	49.34	19.89	6.27	26.12	2026-04-14 21:01:59.321308	t	79.85	99.54	32.26	76.74	11.25	Franco	Templado
44	1	1	63.52	26.21	6.93	33.95	2026-04-14 20:01:59.321308	t	47.17	45.54	97.57	91.81	13.50	Franco	Templado
45	1	1	37.25	15.68	5.66	29.01	2026-04-14 19:01:59.321308	t	45.94	25.38	47.32	98.47	8.76	Franco	Templado
46	1	1	51.94	19.42	7.32	18.04	2026-04-14 18:01:59.321308	t	43.26	37.04	12.22	43.57	8.91	Franco	Templado
47	1	1	33.42	19.72	5.60	33.83	2026-04-14 17:01:59.321308	t	47.19	53.55	66.95	55.81	12.80	Franco	Templado
48	1	1	31.60	16.94	5.72	32.94	2026-04-14 16:01:59.321308	t	53.18	25.55	88.56	31.45	9.10	Franco	Templado
49	1	1	72.63	17.26	6.86	31.41	2026-04-14 15:01:59.321308	t	58.36	84.66	81.57	95.55	12.47	Franco	Templado
50	1	1	58.45	28.41	7.03	22.32	2026-04-14 14:01:59.321308	t	63.23	42.68	36.85	77.12	13.11	Franco	Templado
51	1	1	38.93	27.87	5.75	24.33	2026-04-14 13:01:59.321308	t	33.04	22.63	22.34	83.41	12.86	Franco	Templado
52	1	1	45.83	21.02	5.99	20.45	2026-04-14 12:01:59.321308	t	51.01	46.83	71.95	93.37	11.82	Franco	Templado
53	1	1	71.37	23.13	7.39	32.77	2026-04-18 17:28:36.495943	t	68.25	63.62	50.19	66.56	10.95	Franco	Templado
54	1	1	39.53	21.92	6.06	21.26	2026-04-18 16:28:36.495943	t	70.68	20.80	67.73	62.70	12.38	Franco	Templado
55	1	1	32.56	29.81	6.68	34.81	2026-04-18 15:28:36.495943	t	74.70	64.48	33.92	69.79	8.99	Franco	Templado
56	1	1	76.69	24.44	7.11	18.66	2026-04-18 14:28:36.495943	t	63.81	44.23	53.92	11.58	12.28	Franco	Templado
57	1	1	69.31	18.84	7.26	34.21	2026-04-18 13:28:36.495943	t	79.84	11.88	51.82	22.57	8.20	Franco	Templado
58	1	1	31.38	26.89	5.97	26.41	2026-04-18 12:28:36.495943	t	45.70	40.53	89.65	67.11	8.46	Franco	Templado
59	1	1	55.91	29.55	6.93	29.00	2026-04-18 11:28:36.495943	t	81.95	47.13	31.74	31.15	9.50	Franco	Templado
60	1	1	27.02	28.06	5.61	31.40	2026-04-18 10:28:36.495943	t	84.71	77.13	70.37	87.75	10.88	Franco	Templado
61	1	1	60.30	21.00	7.15	18.70	2026-04-18 09:28:36.495943	t	45.23	94.58	39.57	30.44	8.28	Franco	Templado
62	1	1	62.36	24.37	6.14	22.04	2026-04-18 08:28:36.495943	t	83.73	33.02	44.44	32.01	11.74	Franco	Templado
63	1	1	27.42	25.55	6.98	27.83	2026-04-18 07:28:36.495943	t	65.99	62.37	72.96	17.86	9.94	Franco	Templado
64	1	1	43.46	19.80	7.50	30.12	2026-04-18 06:28:36.495943	t	45.21	75.99	31.58	53.04	13.47	Franco	Templado
65	1	1	46.83	16.51	7.20	31.00	2026-04-18 05:28:36.495943	t	44.98	77.48	36.48	28.16	11.02	Franco	Templado
66	1	1	78.01	27.04	6.06	34.65	2026-04-18 04:28:36.495943	t	77.90	83.63	39.60	83.56	8.01	Franco	Templado
67	1	1	72.50	25.69	6.17	18.49	2026-04-18 03:28:36.495943	t	82.64	17.65	71.62	51.61	11.84	Franco	Templado
68	1	1	51.61	26.31	6.25	21.67	2026-04-18 02:28:36.495943	t	32.38	27.72	39.53	87.38	13.96	Franco	Templado
69	1	1	42.77	22.23	6.87	28.77	2026-04-18 01:28:36.495943	t	52.83	59.46	15.93	76.74	9.03	Franco	Templado
70	1	1	33.83	20.40	5.87	29.65	2026-04-18 00:28:36.495943	t	78.65	66.16	10.19	75.04	8.66	Franco	Templado
71	1	1	75.02	25.08	7.25	18.59	2026-04-17 23:28:36.495943	t	54.57	77.87	93.24	26.67	8.74	Franco	Templado
72	1	1	21.37	17.77	5.66	34.72	2026-04-17 22:28:36.495943	t	50.75	64.43	29.26	86.18	12.99	Franco	Templado
73	1	1	41.42	20.44	7.33	22.66	2026-04-17 21:28:36.495943	t	53.55	33.44	84.32	21.14	10.43	Franco	Templado
74	1	1	25.09	21.79	6.77	30.96	2026-04-17 20:28:36.495943	t	40.21	40.81	83.32	40.97	13.54	Franco	Templado
75	1	1	58.22	28.07	7.22	24.27	2026-04-17 19:28:36.495943	t	31.18	53.23	69.22	36.78	8.38	Franco	Templado
76	1	1	71.25	21.02	5.86	27.33	2026-04-17 18:28:36.495943	t	52.66	90.15	68.72	69.89	11.25	Franco	Templado
77	1	1	67.10	28.34	6.54	22.43	2026-04-17 17:28:36.495943	t	74.40	73.99	79.09	32.21	12.19	Franco	Templado
78	1	1	22.64	27.47	6.46	34.53	2026-04-17 16:28:36.495943	t	64.30	92.61	68.82	66.94	8.82	Franco	Templado
79	1	1	65.34	16.96	5.89	29.80	2026-04-17 15:28:36.495943	t	31.46	83.43	20.43	48.19	9.08	Franco	Templado
80	1	1	47.63	29.89	5.96	24.56	2026-04-17 14:28:36.495943	t	52.05	21.51	32.57	34.92	11.56	Franco	Templado
81	1	1	62.72	17.83	5.85	18.82	2026-04-17 13:28:36.495943	t	33.42	69.88	95.79	17.88	12.51	Franco	Templado
82	1	1	30.06	29.53	6.89	23.10	2026-04-17 12:28:36.495943	t	37.11	96.35	87.32	21.53	9.92	Franco	Templado
83	1	1	47.44	22.16	5.89	34.39	2026-04-17 11:28:36.495943	t	74.00	32.07	27.97	43.94	11.80	Franco	Templado
84	1	1	33.65	22.10	6.45	29.50	2026-04-17 10:28:36.495943	t	58.26	90.92	33.33	88.03	11.85	Franco	Templado
85	1	1	65.16	29.76	6.84	26.13	2026-04-17 09:28:36.495943	t	31.71	32.04	33.15	99.64	12.54	Franco	Templado
86	1	1	34.36	21.01	5.52	26.05	2026-04-17 08:28:36.495943	t	36.21	46.37	31.23	93.18	8.39	Franco	Templado
87	1	1	56.34	28.63	6.93	30.45	2026-04-17 07:28:36.495943	t	70.43	91.87	96.23	95.22	9.00	Franco	Templado
88	1	1	27.89	17.36	5.83	29.85	2026-04-17 06:28:36.495943	t	58.47	34.71	65.41	79.21	8.62	Franco	Templado
89	1	1	71.82	21.10	5.87	29.53	2026-04-17 05:28:36.495943	t	57.82	16.74	87.46	38.61	12.62	Franco	Templado
90	1	1	22.81	18.03	6.76	32.53	2026-04-17 04:28:36.495943	t	85.73	94.80	26.26	54.39	8.67	Franco	Templado
91	1	1	28.04	27.66	7.43	29.13	2026-04-17 03:28:36.495943	t	40.44	37.37	81.56	85.55	11.10	Franco	Templado
92	1	1	66.60	29.08	5.90	31.91	2026-04-17 02:28:36.495943	t	42.68	31.32	17.35	70.99	9.19	Franco	Templado
93	1	1	49.77	27.34	7.20	27.92	2026-04-17 01:28:36.495943	t	54.08	60.48	18.87	71.06	12.48	Franco	Templado
94	1	1	54.96	18.85	6.32	26.63	2026-04-17 00:28:36.495943	t	78.20	34.75	85.54	98.69	8.55	Franco	Templado
95	1	1	27.28	27.69	7.40	31.79	2026-04-16 23:28:36.495943	t	61.54	86.40	44.78	67.95	11.21	Franco	Templado
96	1	1	22.19	27.01	7.14	20.12	2026-04-16 22:28:36.495943	t	82.02	35.52	87.71	28.90	9.23	Franco	Templado
97	1	1	57.62	18.59	5.96	25.20	2026-04-16 21:28:36.495943	t	72.45	28.22	24.98	76.27	8.58	Franco	Templado
98	1	1	23.62	19.97	7.05	19.59	2026-04-16 20:28:36.495943	t	68.63	31.90	72.22	13.96	9.35	Franco	Templado
99	1	1	20.07	28.50	7.49	31.27	2026-04-16 19:28:36.495943	t	75.44	99.24	54.55	52.67	9.70	Franco	Templado
100	1	1	29.94	21.47	5.55	24.78	2026-04-16 18:28:36.495943	t	76.24	18.44	87.12	38.93	9.93	Franco	Templado
101	1	1	51.12	15.89	6.35	19.16	2026-04-16 17:28:36.495943	t	55.93	20.27	84.24	69.95	9.07	Franco	Templado
102	1	1	64.10	24.53	6.44	20.08	2026-04-16 16:28:36.495943	t	33.82	23.24	43.76	62.87	10.79	Franco	Templado
\.


--
-- Data for Name: rancho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rancho (id_rancho, nombre_rancho) FROM stdin;
1	Rancho Innovación Agrícola
\.


--
-- Data for Name: rango_condicion_plaga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rango_condicion_plaga (id_rango, id_tipo_plaga, humedad_tierra_min, humedad_tierra_max, temp_tierra_min, temp_tierra_max, ph_min, ph_max, temp_ambiente_min, temp_ambiente_max, humedad_ambiente_min, humedad_ambiente_max, nitrogeno_min, nitrogeno_max, fosforo_min, fosforo_max, potasio_min, potasio_max, fotoperiodo_min, fotoperiodo_max, tipo_suelo, tipo_clima) FROM stdin;
4	1	40.00	60.00	15.00	25.00	6.00	7.50	20.00	28.00	50.00	70.00	50.00	80.00	20.00	40.00	30.00	50.00	12.00	14.00	Franco	Templado
5	2	20.00	40.00	20.00	30.00	5.50	6.50	28.00	35.00	20.00	40.00	20.00	40.00	30.00	50.00	40.00	60.00	14.00	16.00	Arenoso	Seco
6	3	70.00	90.00	10.00	20.00	5.00	7.00	15.00	22.00	80.00	95.00	30.00	50.00	10.00	30.00	20.00	40.00	8.00	10.00	Arcilloso	Húmedo
\.


--
-- Data for Name: surco; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.surco (id_surco, numero_surco, tipo_cultivo, id_tunel) FROM stdin;
1	5	Berries	1
\.


--
-- Data for Name: tipo_plaga; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tipo_plaga (id_tipo_plaga, nombre_plaga, descripcion) FROM stdin;
1	Pulgón	Insecto que succiona savia y se favorece por altos niveles de Nitrógeno y clima templado.
2	Araña Roja	Ácaro que prolifera en condiciones de alta temperatura y baja humedad ambiental.
3	Mildiu	Hongo fitopatógeno que requiere alta humedad relativa y temperaturas frescas para su propagación.
\.


--
-- Data for Name: tunel; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.tunel (id_tunel, numero_tunel, id_rancho) FROM stdin;
1	10	1
\.


--
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario (id_usuario, nombre, apellidos, "contraeña", rol) FROM stdin;
1	Mariana	Vaca Soltero	agrotech_2026	Supervisor de Campo
\.


--
-- Data for Name: usuario_rancho; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuario_rancho (id_usuario, id_rancho) FROM stdin;
\.


--
-- Name: diagnostico_id_diagnostico_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.diagnostico_id_diagnostico_seq', 12, true);


--
-- Name: incidencia_plaga_id_incidencia_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.incidencia_plaga_id_incidencia_seq', 3, true);


--
-- Name: lectura_sensor_id_lectura_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.lectura_sensor_id_lectura_seq', 102, true);


--
-- Name: rancho_id_rancho_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rancho_id_rancho_seq', 1, true);


--
-- Name: rango_condicion_plaga_id_rango_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rango_condicion_plaga_id_rango_seq', 6, true);


--
-- Name: surco_id_surco_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.surco_id_surco_seq', 1, true);


--
-- Name: tipo_plaga_id_tipo_plaga_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tipo_plaga_id_tipo_plaga_seq', 1, false);


--
-- Name: tunel_id_tunel_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tunel_id_tunel_seq', 1, true);


--
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 1, true);


--
-- Name: diagnostico diagnostico_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diagnostico);


--
-- Name: incidencia_plaga incidencia_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_pkey PRIMARY KEY (id_incidencia);


--
-- Name: lectura_sensor lectura_sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_pkey PRIMARY KEY (id_lectura);


--
-- Name: rancho rancho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rancho
    ADD CONSTRAINT rancho_pkey PRIMARY KEY (id_rancho);


--
-- Name: rango_condicion_plaga rango_condicion_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rango_condicion_plaga
    ADD CONSTRAINT rango_condicion_plaga_pkey PRIMARY KEY (id_rango);


--
-- Name: surco surco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.surco
    ADD CONSTRAINT surco_pkey PRIMARY KEY (id_surco);


--
-- Name: tipo_plaga tipo_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tipo_plaga
    ADD CONSTRAINT tipo_plaga_pkey PRIMARY KEY (id_tipo_plaga);


--
-- Name: tunel tunel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tunel
    ADD CONSTRAINT tunel_pkey PRIMARY KEY (id_tunel);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- Name: usuario_rancho usuario_rancho_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_rancho
    ADD CONSTRAINT usuario_rancho_pkey PRIMARY KEY (id_usuario, id_rancho);


--
-- Name: diagnostico diagnostico_id_lectura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_id_lectura_fkey FOREIGN KEY (id_lectura) REFERENCES public.lectura_sensor(id_lectura);


--
-- Name: diagnostico diagnostico_id_tipo_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_id_tipo_plaga_fkey FOREIGN KEY (id_tipo_plaga) REFERENCES public.tipo_plaga(id_tipo_plaga);


--
-- Name: incidencia_plaga incidencia_plaga_id_surco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_id_surco_fkey FOREIGN KEY (id_surco) REFERENCES public.surco(id_surco) ON DELETE CASCADE;


--
-- Name: incidencia_plaga incidencia_plaga_id_tipo_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_id_tipo_plaga_fkey FOREIGN KEY (id_tipo_plaga) REFERENCES public.tipo_plaga(id_tipo_plaga) ON DELETE CASCADE;


--
-- Name: incidencia_plaga incidencia_plaga_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- Name: lectura_sensor lectura_sensor_id_surco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_id_surco_fkey FOREIGN KEY (id_surco) REFERENCES public.surco(id_surco);


--
-- Name: lectura_sensor lectura_sensor_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- Name: rango_condicion_plaga rango_condicion_plaga_id_tipo_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rango_condicion_plaga
    ADD CONSTRAINT rango_condicion_plaga_id_tipo_plaga_fkey FOREIGN KEY (id_tipo_plaga) REFERENCES public.tipo_plaga(id_tipo_plaga);


--
-- Name: surco surco_id_tunel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.surco
    ADD CONSTRAINT surco_id_tunel_fkey FOREIGN KEY (id_tunel) REFERENCES public.tunel(id_tunel) ON DELETE CASCADE;


--
-- Name: tunel tunel_id_rancho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tunel
    ADD CONSTRAINT tunel_id_rancho_fkey FOREIGN KEY (id_rancho) REFERENCES public.rancho(id_rancho) ON DELETE CASCADE;


--
-- Name: usuario_rancho usuario_rancho_id_rancho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_rancho
    ADD CONSTRAINT usuario_rancho_id_rancho_fkey FOREIGN KEY (id_rancho) REFERENCES public.rancho(id_rancho) ON DELETE CASCADE;


--
-- Name: usuario_rancho usuario_rancho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_rancho
    ADD CONSTRAINT usuario_rancho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict KiH9H01rdsp9lYBQMex9BzkH5xW5fCFn2r5hQiYe9sUBLcRP1F6M3OUYCTOyWEh

