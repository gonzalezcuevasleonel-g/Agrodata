--
-- PostgreSQL database dump
--

\restrict DzWsL8KHUZkgmPBRE6X92hxCGr0Lowk4HMOGwmIcvZG0ydXXhhWhaNbjR1s39LK

-- Dumped from database version 18.3
-- Dumped by pg_dump version 18.3

-- Started on 2026-04-23 18:47:14

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
-- TOC entry 219 (class 1259 OID 16389)
-- Name: diagnostico; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.diagnostico (
    id_diagnostico integer NOT NULL,
    id_lectura integer NOT NULL,
    id_tipo_plaga integer NOT NULL,
    nivel_riesgo character varying(20) NOT NULL,
    fecha timestamp without time zone DEFAULT now() NOT NULL,
    sincronizado boolean DEFAULT false,
    probabilidad numeric(5,4),
    CONSTRAINT diagnostico_nivel_riesgo_check CHECK (((nivel_riesgo)::text = ANY (ARRAY[('bajo'::character varying)::text, ('medio'::character varying)::text, ('alto'::character varying)::text])))
);


--
-- TOC entry 220 (class 1259 OID 16400)
-- Name: diagnostico_id_diagnostico_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.diagnostico_id_diagnostico_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5117 (class 0 OID 0)
-- Dependencies: 220
-- Name: diagnostico_id_diagnostico_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.diagnostico_id_diagnostico_seq OWNED BY public.diagnostico.id_diagnostico;


--
-- TOC entry 221 (class 1259 OID 16401)
-- Name: incidencia_plaga; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 222 (class 1259 OID 16414)
-- Name: incidencia_plaga_id_incidencia_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.incidencia_plaga_id_incidencia_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5118 (class 0 OID 0)
-- Dependencies: 222
-- Name: incidencia_plaga_id_incidencia_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.incidencia_plaga_id_incidencia_seq OWNED BY public.incidencia_plaga.id_incidencia;


--
-- TOC entry 223 (class 1259 OID 16415)
-- Name: lectura_sensor; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 224 (class 1259 OID 16428)
-- Name: lectura_sensor_id_lectura_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.lectura_sensor_id_lectura_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5119 (class 0 OID 0)
-- Dependencies: 224
-- Name: lectura_sensor_id_lectura_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.lectura_sensor_id_lectura_seq OWNED BY public.lectura_sensor.id_lectura;


--
-- TOC entry 225 (class 1259 OID 16429)
-- Name: rancho; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rancho (
    id_rancho integer NOT NULL,
    nombre_rancho character varying(50) NOT NULL
);


--
-- TOC entry 226 (class 1259 OID 16434)
-- Name: rancho_id_rancho_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rancho_id_rancho_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5120 (class 0 OID 0)
-- Dependencies: 226
-- Name: rancho_id_rancho_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rancho_id_rancho_seq OWNED BY public.rancho.id_rancho;


--
-- TOC entry 227 (class 1259 OID 16435)
-- Name: rango_condicion_plaga; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 228 (class 1259 OID 16440)
-- Name: rango_condicion_plaga_id_rango_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rango_condicion_plaga_id_rango_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5121 (class 0 OID 0)
-- Dependencies: 228
-- Name: rango_condicion_plaga_id_rango_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rango_condicion_plaga_id_rango_seq OWNED BY public.rango_condicion_plaga.id_rango;


--
-- TOC entry 229 (class 1259 OID 16441)
-- Name: surco; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.surco (
    id_surco integer NOT NULL,
    numero_surco integer NOT NULL,
    tipo_cultivo character varying(50) NOT NULL,
    id_tunel integer NOT NULL
);


--
-- TOC entry 230 (class 1259 OID 16448)
-- Name: surco_id_surco_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.surco_id_surco_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5122 (class 0 OID 0)
-- Dependencies: 230
-- Name: surco_id_surco_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.surco_id_surco_seq OWNED BY public.surco.id_surco;


--
-- TOC entry 231 (class 1259 OID 16449)
-- Name: tipo_plaga; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tipo_plaga (
    id_tipo_plaga integer NOT NULL,
    nombre_plaga character varying(50) NOT NULL,
    descripcion text NOT NULL
);


--
-- TOC entry 232 (class 1259 OID 16457)
-- Name: tipo_plaga_id_tipo_plaga_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tipo_plaga_id_tipo_plaga_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5123 (class 0 OID 0)
-- Dependencies: 232
-- Name: tipo_plaga_id_tipo_plaga_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tipo_plaga_id_tipo_plaga_seq OWNED BY public.tipo_plaga.id_tipo_plaga;


--
-- TOC entry 233 (class 1259 OID 16458)
-- Name: tunel; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tunel (
    id_tunel integer NOT NULL,
    numero_tunel integer NOT NULL,
    id_rancho integer NOT NULL
);


--
-- TOC entry 234 (class 1259 OID 16464)
-- Name: tunel_id_tunel_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tunel_id_tunel_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5124 (class 0 OID 0)
-- Dependencies: 234
-- Name: tunel_id_tunel_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tunel_id_tunel_seq OWNED BY public.tunel.id_tunel;


--
-- TOC entry 235 (class 1259 OID 16465)
-- Name: usuario; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario (
    id_usuario integer NOT NULL,
    nombre character varying(30) NOT NULL,
    apellidos character varying(30) NOT NULL,
    "contraeña" character varying(255) NOT NULL,
    rol character varying(50) NOT NULL
);


--
-- TOC entry 236 (class 1259 OID 16473)
-- Name: usuario_id_usuario_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.usuario_id_usuario_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5125 (class 0 OID 0)
-- Dependencies: 236
-- Name: usuario_id_usuario_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.usuario_id_usuario_seq OWNED BY public.usuario.id_usuario;


--
-- TOC entry 237 (class 1259 OID 16474)
-- Name: usuario_rancho; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.usuario_rancho (
    id_usuario integer NOT NULL,
    id_rancho integer NOT NULL
);


--
-- TOC entry 4900 (class 2604 OID 16479)
-- Name: diagnostico id_diagnostico; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnostico ALTER COLUMN id_diagnostico SET DEFAULT nextval('public.diagnostico_id_diagnostico_seq'::regclass);


--
-- TOC entry 4903 (class 2604 OID 16480)
-- Name: incidencia_plaga id_incidencia; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia_plaga ALTER COLUMN id_incidencia SET DEFAULT nextval('public.incidencia_plaga_id_incidencia_seq'::regclass);


--
-- TOC entry 4904 (class 2604 OID 16481)
-- Name: lectura_sensor id_lectura; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lectura_sensor ALTER COLUMN id_lectura SET DEFAULT nextval('public.lectura_sensor_id_lectura_seq'::regclass);


--
-- TOC entry 4907 (class 2604 OID 16482)
-- Name: rancho id_rancho; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rancho ALTER COLUMN id_rancho SET DEFAULT nextval('public.rancho_id_rancho_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 16483)
-- Name: rango_condicion_plaga id_rango; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rango_condicion_plaga ALTER COLUMN id_rango SET DEFAULT nextval('public.rango_condicion_plaga_id_rango_seq'::regclass);


--
-- TOC entry 4909 (class 2604 OID 16484)
-- Name: surco id_surco; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surco ALTER COLUMN id_surco SET DEFAULT nextval('public.surco_id_surco_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 16485)
-- Name: tipo_plaga id_tipo_plaga; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_plaga ALTER COLUMN id_tipo_plaga SET DEFAULT nextval('public.tipo_plaga_id_tipo_plaga_seq'::regclass);


--
-- TOC entry 4911 (class 2604 OID 16486)
-- Name: tunel id_tunel; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tunel ALTER COLUMN id_tunel SET DEFAULT nextval('public.tunel_id_tunel_seq'::regclass);


--
-- TOC entry 4912 (class 2604 OID 16487)
-- Name: usuario id_usuario; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario ALTER COLUMN id_usuario SET DEFAULT nextval('public.usuario_id_usuario_seq'::regclass);


--
-- TOC entry 5093 (class 0 OID 16389)
-- Dependencies: 219
-- Data for Name: diagnostico; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.diagnostico VALUES (101, 3, 1, 'alto', '2026-04-20 23:31:03.752955', false, 0.7000);
INSERT INTO public.diagnostico VALUES (102, 4, 1, 'medio', '2026-04-20 23:31:03.752955', false, 0.6600);
INSERT INTO public.diagnostico VALUES (103, 5, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (104, 6, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0600);
INSERT INTO public.diagnostico VALUES (105, 7, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (106, 8, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.1000);
INSERT INTO public.diagnostico VALUES (107, 9, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (108, 10, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (109, 11, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0700);
INSERT INTO public.diagnostico VALUES (110, 12, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (111, 13, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (112, 14, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0800);
INSERT INTO public.diagnostico VALUES (113, 15, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (114, 16, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (115, 17, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0900);
INSERT INTO public.diagnostico VALUES (116, 18, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (117, 19, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (118, 20, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (119, 21, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.1000);
INSERT INTO public.diagnostico VALUES (120, 22, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0500);
INSERT INTO public.diagnostico VALUES (121, 23, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (122, 24, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (123, 25, 2, 'medio', '2026-04-20 23:31:03.752955', false, 0.6900);
INSERT INTO public.diagnostico VALUES (124, 26, 2, 'medio', '2026-04-20 23:31:03.752955', false, 0.5700);
INSERT INTO public.diagnostico VALUES (125, 27, 2, 'medio', '2026-04-20 23:31:03.752955', false, 0.6900);
INSERT INTO public.diagnostico VALUES (126, 28, 2, 'medio', '2026-04-20 23:31:03.752955', false, 0.5800);
INSERT INTO public.diagnostico VALUES (127, 29, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (128, 30, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (129, 31, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0600);
INSERT INTO public.diagnostico VALUES (130, 32, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (131, 33, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (132, 34, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (133, 35, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0800);
INSERT INTO public.diagnostico VALUES (134, 36, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0800);
INSERT INTO public.diagnostico VALUES (135, 37, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0700);
INSERT INTO public.diagnostico VALUES (136, 38, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (137, 39, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (138, 40, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (139, 41, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (140, 42, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (141, 43, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (142, 44, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0700);
INSERT INTO public.diagnostico VALUES (143, 45, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0600);
INSERT INTO public.diagnostico VALUES (144, 46, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (145, 47, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (146, 48, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0600);
INSERT INTO public.diagnostico VALUES (147, 49, 3, 'alto', '2026-04-20 23:31:03.752955', false, 0.7200);
INSERT INTO public.diagnostico VALUES (148, 50, 3, 'medio', '2026-04-20 23:31:03.752955', false, 0.6300);
INSERT INTO public.diagnostico VALUES (149, 51, 3, 'medio', '2026-04-20 23:31:03.752955', false, 0.6600);
INSERT INTO public.diagnostico VALUES (150, 52, 3, 'alto', '2026-04-20 23:31:03.752955', false, 0.7300);
INSERT INTO public.diagnostico VALUES (151, 53, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (152, 54, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (153, 55, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0500);
INSERT INTO public.diagnostico VALUES (154, 56, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0600);
INSERT INTO public.diagnostico VALUES (155, 57, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.1300);
INSERT INTO public.diagnostico VALUES (156, 58, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (157, 59, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (158, 60, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (159, 61, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (160, 62, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (161, 63, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (162, 64, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (163, 65, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (164, 66, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (165, 67, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (166, 68, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.1300);
INSERT INTO public.diagnostico VALUES (167, 69, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (168, 70, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (169, 71, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (170, 72, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0700);
INSERT INTO public.diagnostico VALUES (171, 73, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (172, 74, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0500);
INSERT INTO public.diagnostico VALUES (173, 75, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (174, 76, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (175, 77, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (176, 78, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (177, 79, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (178, 80, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0500);
INSERT INTO public.diagnostico VALUES (179, 81, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (180, 82, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (181, 83, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0500);
INSERT INTO public.diagnostico VALUES (182, 84, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (183, 85, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.1600);
INSERT INTO public.diagnostico VALUES (184, 86, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (185, 87, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0700);
INSERT INTO public.diagnostico VALUES (186, 88, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (187, 89, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (188, 90, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (189, 91, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (190, 92, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (191, 93, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (192, 94, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0300);
INSERT INTO public.diagnostico VALUES (193, 95, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0000);
INSERT INTO public.diagnostico VALUES (194, 96, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0500);
INSERT INTO public.diagnostico VALUES (195, 97, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0100);
INSERT INTO public.diagnostico VALUES (196, 98, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0700);
INSERT INTO public.diagnostico VALUES (197, 99, 1, 'bajo', '2026-04-20 23:31:03.752955', false, 0.1200);
INSERT INTO public.diagnostico VALUES (198, 100, 3, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (199, 101, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0400);
INSERT INTO public.diagnostico VALUES (200, 102, 2, 'bajo', '2026-04-20 23:31:03.752955', false, 0.0200);
INSERT INTO public.diagnostico VALUES (201, 104, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1800);
INSERT INTO public.diagnostico VALUES (202, 105, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1700);
INSERT INTO public.diagnostico VALUES (203, 106, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0500);
INSERT INTO public.diagnostico VALUES (204, 107, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1300);
INSERT INTO public.diagnostico VALUES (205, 108, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1100);
INSERT INTO public.diagnostico VALUES (206, 109, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (207, 110, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0000);
INSERT INTO public.diagnostico VALUES (208, 111, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (209, 112, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0700);
INSERT INTO public.diagnostico VALUES (210, 113, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1900);
INSERT INTO public.diagnostico VALUES (211, 114, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2200);
INSERT INTO public.diagnostico VALUES (212, 115, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2400);
INSERT INTO public.diagnostico VALUES (213, 116, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0400);
INSERT INTO public.diagnostico VALUES (214, 117, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0400);
INSERT INTO public.diagnostico VALUES (215, 118, 3, 'medio', '2026-04-23 17:23:19.679718', false, 0.3000);
INSERT INTO public.diagnostico VALUES (216, 119, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1600);
INSERT INTO public.diagnostico VALUES (217, 120, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0300);
INSERT INTO public.diagnostico VALUES (218, 121, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1800);
INSERT INTO public.diagnostico VALUES (219, 122, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0500);
INSERT INTO public.diagnostico VALUES (220, 123, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1500);
INSERT INTO public.diagnostico VALUES (221, 124, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1900);
INSERT INTO public.diagnostico VALUES (222, 125, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1900);
INSERT INTO public.diagnostico VALUES (223, 126, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2300);
INSERT INTO public.diagnostico VALUES (224, 127, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (225, 128, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1300);
INSERT INTO public.diagnostico VALUES (226, 129, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1700);
INSERT INTO public.diagnostico VALUES (227, 130, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0600);
INSERT INTO public.diagnostico VALUES (228, 131, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2200);
INSERT INTO public.diagnostico VALUES (229, 132, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0300);
INSERT INTO public.diagnostico VALUES (230, 133, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0400);
INSERT INTO public.diagnostico VALUES (231, 134, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0500);
INSERT INTO public.diagnostico VALUES (232, 135, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (233, 136, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (234, 137, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1900);
INSERT INTO public.diagnostico VALUES (235, 138, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (236, 139, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2400);
INSERT INTO public.diagnostico VALUES (237, 140, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0300);
INSERT INTO public.diagnostico VALUES (238, 141, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0400);
INSERT INTO public.diagnostico VALUES (239, 142, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1000);
INSERT INTO public.diagnostico VALUES (240, 143, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2400);
INSERT INTO public.diagnostico VALUES (241, 144, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0700);
INSERT INTO public.diagnostico VALUES (242, 145, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0400);
INSERT INTO public.diagnostico VALUES (243, 146, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0300);
INSERT INTO public.diagnostico VALUES (244, 147, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0600);
INSERT INTO public.diagnostico VALUES (245, 148, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1100);
INSERT INTO public.diagnostico VALUES (246, 149, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0400);
INSERT INTO public.diagnostico VALUES (247, 150, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1700);
INSERT INTO public.diagnostico VALUES (248, 151, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0800);
INSERT INTO public.diagnostico VALUES (249, 152, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2900);
INSERT INTO public.diagnostico VALUES (250, 153, 3, 'medio', '2026-04-23 17:23:19.679718', false, 0.4500);
INSERT INTO public.diagnostico VALUES (251, 155, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0100);
INSERT INTO public.diagnostico VALUES (252, 156, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0400);
INSERT INTO public.diagnostico VALUES (253, 157, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0100);
INSERT INTO public.diagnostico VALUES (254, 158, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2700);
INSERT INTO public.diagnostico VALUES (255, 159, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (256, 160, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0100);
INSERT INTO public.diagnostico VALUES (257, 161, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1700);
INSERT INTO public.diagnostico VALUES (258, 162, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (259, 163, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (260, 164, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2100);
INSERT INTO public.diagnostico VALUES (261, 165, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0100);
INSERT INTO public.diagnostico VALUES (262, 166, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (263, 167, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0100);
INSERT INTO public.diagnostico VALUES (264, 168, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.2300);
INSERT INTO public.diagnostico VALUES (265, 169, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0100);
INSERT INTO public.diagnostico VALUES (266, 170, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0000);
INSERT INTO public.diagnostico VALUES (267, 171, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1700);
INSERT INTO public.diagnostico VALUES (268, 172, 2, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0100);
INSERT INTO public.diagnostico VALUES (269, 173, 3, 'bajo', '2026-04-23 17:23:19.679718', false, 0.0200);
INSERT INTO public.diagnostico VALUES (270, 174, 1, 'bajo', '2026-04-23 17:23:19.679718', false, 0.1600);


--
-- TOC entry 5095 (class 0 OID 16401)
-- Dependencies: 221
-- Data for Name: incidencia_plaga; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.incidencia_plaga VALUES (1, 1, 1, 1, 12, '2026-04-16 13:04:58.242061', 'Presencia detectada en envés de hojas jóvenes.', 'http://sistema-agricola.com/fotos/pulgon01.jpg');
INSERT INTO public.incidencia_plaga VALUES (2, 1, 2, 1, 8, '2026-04-15 13:04:58.242061', 'Puntos amarillos y telarañas finas en el cultivo.', 'http://sistema-agricola.com/fotos/arana02.jpg');
INSERT INTO public.incidencia_plaga VALUES (3, 1, 3, 1, 5, '2026-04-14 13:04:58.242061', 'Manchas aceitosas debido a la alta humedad ambiental.', 'n/a');
INSERT INTO public.incidencia_plaga VALUES (4, 1, 1, 1, 12, '2026-04-05 23:45:57.119083', 'Se observan insectos en hojas inferiores', 'https://example.com/fotos/plaga1.jpg');
INSERT INTO public.incidencia_plaga VALUES (5, 2, 2, 1, 8, '2026-04-06 03:45:57.119083', 'Daño moderado en tallos', 'https://example.com/fotos/plaga2.jpg');
INSERT INTO public.incidencia_plaga VALUES (6, 3, 3, 1, 15, '2026-04-06 13:45:57.119083', 'Presencia abundante en frutos', 'https://example.com/fotos/plaga3.jpg');
INSERT INTO public.incidencia_plaga VALUES (7, 4, 1, 1, 6, '2026-04-06 23:45:57.119083', 'Primeros signos visibles', 'https://example.com/fotos/plaga4.jpg');
INSERT INTO public.incidencia_plaga VALUES (8, 5, 2, 1, 18, '2026-04-07 05:45:57.119083', 'Plaga extendida en varias plantas', 'https://example.com/fotos/plaga5.jpg');
INSERT INTO public.incidencia_plaga VALUES (9, 6, 3, 1, 10, '2026-04-07 11:45:57.119083', 'Daño leve en hojas', 'https://example.com/fotos/plaga6.jpg');
INSERT INTO public.incidencia_plaga VALUES (10, 7, 1, 1, 20, '2026-04-07 23:45:57.119083', 'Alta infestación en el surco', 'https://example.com/fotos/plaga7.jpg');
INSERT INTO public.incidencia_plaga VALUES (11, 8, 2, 1, 7, '2026-04-08 05:45:57.119083', 'Se detectan larvas pequeñas', 'https://example.com/fotos/plaga8.jpg');
INSERT INTO public.incidencia_plaga VALUES (12, 9, 3, 1, 14, '2026-04-08 15:45:57.119083', 'Insectos visibles en la base de la planta', 'https://example.com/fotos/plaga9.jpg');
INSERT INTO public.incidencia_plaga VALUES (13, 10, 1, 1, 9, '2026-04-08 23:45:57.119083', 'Afectación localizada', 'https://example.com/fotos/plaga10.jpg');
INSERT INTO public.incidencia_plaga VALUES (14, 1, 2, 1, 11, '2026-04-09 03:45:57.119083', 'Aumento de insectos respecto al día anterior', 'https://example.com/fotos/plaga11.jpg');
INSERT INTO public.incidencia_plaga VALUES (15, 2, 3, 1, 13, '2026-04-09 11:45:57.119083', 'Se observan daños en frutos maduros', 'https://example.com/fotos/plaga12.jpg');
INSERT INTO public.incidencia_plaga VALUES (16, 3, 1, 1, 5, '2026-04-09 23:45:57.119083', 'Solo unas pocas plantas afectadas', 'https://example.com/fotos/plaga13.jpg');
INSERT INTO public.incidencia_plaga VALUES (17, 4, 2, 1, 16, '2026-04-10 03:45:57.119083', 'Plaga visible en todo el surco', 'https://example.com/fotos/plaga14.jpg');
INSERT INTO public.incidencia_plaga VALUES (18, 5, 3, 1, 19, '2026-04-10 13:45:57.119083', 'Daño severo en hojas y tallos', 'https://example.com/fotos/plaga15.jpg');
INSERT INTO public.incidencia_plaga VALUES (19, 6, 1, 1, 8, '2026-04-10 23:45:57.119083', 'Actividad leve de la plaga', 'https://example.com/fotos/plaga16.jpg');
INSERT INTO public.incidencia_plaga VALUES (20, 7, 2, 1, 22, '2026-04-11 03:45:57.119083', 'Gran cantidad de insectos presentes', 'https://example.com/fotos/plaga17.jpg');
INSERT INTO public.incidencia_plaga VALUES (21, 8, 3, 1, 12, '2026-04-11 11:45:57.119083', 'Se recomienda intervención inmediata', 'https://example.com/fotos/plaga18.jpg');
INSERT INTO public.incidencia_plaga VALUES (22, 9, 1, 1, 4, '2026-04-11 23:45:57.119083', 'Pocos ejemplares detectados', 'https://example.com/fotos/plaga19.jpg');
INSERT INTO public.incidencia_plaga VALUES (23, 10, 2, 1, 17, '2026-04-12 03:45:57.119083', 'Infestación en crecimiento', 'https://example.com/fotos/plaga20.jpg');
INSERT INTO public.incidencia_plaga VALUES (24, 1, 3, 1, 21, '2026-04-12 13:45:57.119083', 'Alta presencia de plaga en el cultivo', 'https://example.com/fotos/plaga21.jpg');
INSERT INTO public.incidencia_plaga VALUES (25, 2, 1, 1, 6, '2026-04-12 23:45:57.119083', 'Daño localizado en una sección', 'https://example.com/fotos/plaga22.jpg');
INSERT INTO public.incidencia_plaga VALUES (26, 3, 2, 1, 14, '2026-04-13 03:45:57.119083', 'Se detectan huevos y larvas', 'https://example.com/fotos/plaga23.jpg');
INSERT INTO public.incidencia_plaga VALUES (27, 4, 3, 1, 18, '2026-04-13 11:45:57.119083', 'La plaga se expande rápidamente', 'https://example.com/fotos/plaga24.jpg');
INSERT INTO public.incidencia_plaga VALUES (28, 5, 1, 1, 7, '2026-04-13 23:45:57.119083', 'Leve afectación visual', 'https://example.com/fotos/plaga25.jpg');
INSERT INTO public.incidencia_plaga VALUES (29, 6, 2, 1, 15, '2026-04-14 03:45:57.119083', 'Se observan varias plantas afectadas', 'https://example.com/fotos/plaga26.jpg');
INSERT INTO public.incidencia_plaga VALUES (30, 7, 3, 1, 23, '2026-04-14 13:45:57.119083', 'Infestación grave', 'https://example.com/fotos/plaga27.jpg');
INSERT INTO public.incidencia_plaga VALUES (31, 8, 1, 1, 9, '2026-04-14 23:45:57.119083', 'Plaga presente en hojas externas', 'https://example.com/fotos/plaga28.jpg');
INSERT INTO public.incidencia_plaga VALUES (32, 9, 2, 1, 16, '2026-04-15 03:45:57.119083', 'Insectos concentrados en la raíz', 'https://example.com/fotos/plaga29.jpg');
INSERT INTO public.incidencia_plaga VALUES (33, 10, 3, 1, 20, '2026-04-15 11:45:57.119083', 'Gran cantidad de daños visibles', 'https://example.com/fotos/plaga30.jpg');
INSERT INTO public.incidencia_plaga VALUES (34, 1, 1, 1, 5, '2026-04-15 23:45:57.119083', 'Presencia leve pero constante', 'https://example.com/fotos/plaga31.jpg');
INSERT INTO public.incidencia_plaga VALUES (35, 2, 2, 1, 13, '2026-04-16 03:45:57.119083', 'Se observan síntomas tempranos', 'https://example.com/fotos/plaga32.jpg');
INSERT INTO public.incidencia_plaga VALUES (36, 3, 3, 1, 18, '2026-04-16 13:45:57.119083', 'Daño notable en hojas superiores', 'https://example.com/fotos/plaga33.jpg');
INSERT INTO public.incidencia_plaga VALUES (37, 4, 1, 1, 7, '2026-04-16 23:45:57.119083', 'Pequeña concentración de plaga', 'https://example.com/fotos/plaga34.jpg');
INSERT INTO public.incidencia_plaga VALUES (38, 5, 2, 1, 19, '2026-04-17 03:45:57.119083', 'Incremento de actividad en la tarde', 'https://example.com/fotos/plaga35.jpg');
INSERT INTO public.incidencia_plaga VALUES (39, 6, 3, 1, 11, '2026-04-17 11:45:57.119083', 'Afectación moderada', 'https://example.com/fotos/plaga36.jpg');
INSERT INTO public.incidencia_plaga VALUES (40, 7, 1, 1, 24, '2026-04-17 23:45:57.119083', 'Máxima infestación registrada', 'https://example.com/fotos/plaga37.jpg');
INSERT INTO public.incidencia_plaga VALUES (41, 8, 2, 1, 10, '2026-04-18 03:45:57.119083', 'Daño leve en frutos pequeños', 'https://example.com/fotos/plaga38.jpg');
INSERT INTO public.incidencia_plaga VALUES (42, 9, 3, 1, 17, '2026-04-18 13:45:57.119083', 'Presencia alta en plantas jóvenes', 'https://example.com/fotos/plaga39.jpg');
INSERT INTO public.incidencia_plaga VALUES (43, 10, 1, 1, 8, '2026-04-18 23:45:57.119083', 'Actividad reducida de la plaga', 'https://example.com/fotos/plaga40.jpg');
INSERT INTO public.incidencia_plaga VALUES (44, 1, 2, 1, 14, '2026-04-19 03:45:57.119083', 'Aumento gradual de ejemplares', 'https://example.com/fotos/plaga41.jpg');
INSERT INTO public.incidencia_plaga VALUES (45, 2, 3, 1, 16, '2026-04-19 11:45:57.119083', 'Se requiere monitoreo frecuente', 'https://example.com/fotos/plaga42.jpg');
INSERT INTO public.incidencia_plaga VALUES (46, 3, 1, 1, 6, '2026-04-19 23:45:57.119083', 'Poca presencia en el cultivo', 'https://example.com/fotos/plaga43.jpg');
INSERT INTO public.incidencia_plaga VALUES (47, 4, 2, 1, 21, '2026-04-20 03:45:57.119083', 'Infestación severa en hojas', 'https://example.com/fotos/plaga44.jpg');
INSERT INTO public.incidencia_plaga VALUES (48, 5, 3, 1, 18, '2026-04-20 05:45:57.119083', 'Gran cantidad de larvas detectadas', 'https://example.com/fotos/plaga45.jpg');
INSERT INTO public.incidencia_plaga VALUES (49, 6, 1, 1, 7, '2026-04-20 07:45:57.119083', 'Leve presencia cerca del riego', 'https://example.com/fotos/plaga46.jpg');
INSERT INTO public.incidencia_plaga VALUES (50, 7, 2, 1, 20, '2026-04-20 11:45:57.119083', 'Alta densidad de plaga', 'https://example.com/fotos/plaga47.jpg');
INSERT INTO public.incidencia_plaga VALUES (51, 8, 3, 1, 15, '2026-04-20 15:45:57.119083', 'Daños visibles en el follaje', 'https://example.com/fotos/plaga48.jpg');
INSERT INTO public.incidencia_plaga VALUES (52, 9, 1, 1, 5, '2026-04-20 19:45:57.119083', 'Solo unas pocas plantas afectadas', 'https://example.com/fotos/plaga49.jpg');
INSERT INTO public.incidencia_plaga VALUES (53, 10, 2, 1, 19, '2026-04-20 21:45:57.119083', 'Se recomienda tratamiento inmediato', 'https://example.com/fotos/plaga50.jpg');


--
-- TOC entry 5097 (class 0 OID 16415)
-- Dependencies: 223
-- Data for Name: lectura_sensor; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.lectura_sensor VALUES (3, 1, 1, 71.91, 23.11, 6.42, 20.39, '2026-04-16 13:01:59.321308', true, 73.01, 36.74, 66.53, 26.77, 13.66, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (4, 1, 1, 20.63, 27.71, 7.20, 26.09, '2026-04-16 12:01:59.321308', true, 48.74, 92.65, 84.01, 92.53, 13.58, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (5, 1, 1, 22.12, 18.14, 7.28, 18.86, '2026-04-16 11:01:59.321308', true, 37.79, 83.50, 91.93, 83.27, 10.79, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (6, 1, 1, 70.59, 28.33, 5.69, 26.50, '2026-04-16 10:01:59.321308', true, 40.65, 19.29, 14.56, 89.88, 8.39, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (7, 1, 1, 72.84, 26.32, 7.29, 29.11, '2026-04-16 09:01:59.321308', true, 66.69, 57.96, 18.30, 15.08, 12.56, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (8, 1, 1, 73.73, 23.85, 6.00, 28.45, '2026-04-16 08:01:59.321308', true, 80.53, 23.20, 15.87, 77.31, 12.89, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (9, 1, 1, 62.21, 23.76, 5.91, 29.46, '2026-04-16 07:01:59.321308', true, 74.73, 53.57, 61.59, 60.70, 8.47, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (10, 1, 1, 76.26, 17.65, 6.02, 28.07, '2026-04-16 06:01:59.321308', true, 52.10, 55.93, 34.20, 68.63, 12.28, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (11, 1, 1, 40.60, 22.97, 5.65, 22.79, '2026-04-16 05:01:59.321308', true, 36.71, 32.40, 57.29, 11.21, 8.08, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (12, 1, 1, 24.62, 15.44, 6.00, 27.46, '2026-04-16 04:01:59.321308', true, 83.28, 43.06, 12.81, 84.51, 10.65, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (13, 1, 1, 49.93, 19.14, 5.99, 26.12, '2026-04-16 03:01:59.321308', true, 65.09, 74.46, 33.39, 72.73, 8.53, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (14, 1, 1, 30.63, 29.73, 6.39, 18.31, '2026-04-16 02:01:59.321308', true, 55.55, 23.16, 67.48, 28.82, 10.48, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (15, 1, 1, 45.83, 29.44, 6.14, 31.10, '2026-04-16 01:01:59.321308', true, 73.76, 80.14, 12.41, 37.84, 10.79, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (16, 1, 1, 42.05, 19.35, 7.29, 21.87, '2026-04-16 00:01:59.321308', true, 75.91, 29.80, 87.03, 12.04, 11.84, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (17, 1, 1, 78.63, 28.69, 6.94, 22.94, '2026-04-15 23:01:59.321308', true, 84.62, 38.80, 58.34, 86.71, 12.50, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (18, 1, 1, 54.17, 22.51, 6.77, 20.92, '2026-04-15 22:01:59.321308', true, 49.16, 78.60, 62.38, 46.02, 9.97, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (19, 1, 1, 78.22, 22.39, 7.05, 26.03, '2026-04-15 21:01:59.321308', true, 70.08, 38.93, 32.09, 22.11, 13.46, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (20, 1, 1, 54.42, 17.65, 7.48, 19.04, '2026-04-15 20:01:59.321308', true, 85.95, 24.44, 70.17, 48.04, 9.31, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (21, 1, 1, 70.42, 18.79, 7.36, 34.84, '2026-04-15 19:01:59.321308', true, 57.59, 47.34, 83.67, 85.95, 9.34, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (22, 1, 1, 61.94, 26.18, 7.31, 24.03, '2026-04-15 18:01:59.321308', true, 63.82, 12.56, 95.56, 70.96, 12.88, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (23, 1, 1, 68.49, 22.17, 6.14, 25.66, '2026-04-15 17:01:59.321308', true, 55.77, 66.55, 72.26, 54.85, 12.19, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (24, 1, 1, 26.37, 26.01, 5.62, 33.62, '2026-04-15 16:01:59.321308', true, 89.02, 53.74, 54.35, 35.83, 10.87, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (25, 1, 1, 64.31, 21.76, 7.22, 34.53, '2026-04-15 15:01:59.321308', true, 72.34, 54.11, 93.08, 35.00, 13.67, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (26, 1, 1, 29.37, 26.39, 5.99, 19.94, '2026-04-15 14:01:59.321308', true, 58.25, 50.32, 75.65, 27.79, 12.53, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (27, 1, 1, 47.25, 21.80, 6.62, 23.68, '2026-04-15 13:01:59.321308', true, 40.58, 12.15, 23.98, 12.86, 11.41, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (28, 1, 1, 61.50, 17.37, 6.72, 32.04, '2026-04-15 12:01:59.321308', true, 48.76, 21.60, 83.54, 55.86, 10.48, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (29, 1, 1, 52.96, 15.03, 5.91, 26.37, '2026-04-15 11:01:59.321308', true, 42.33, 88.08, 86.55, 40.29, 12.29, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (30, 1, 1, 44.37, 20.75, 6.03, 21.52, '2026-04-15 10:01:59.321308', true, 48.85, 95.13, 64.70, 87.70, 10.02, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (31, 1, 1, 50.84, 27.46, 7.50, 19.03, '2026-04-15 09:01:59.321308', true, 63.56, 31.63, 84.07, 41.89, 13.35, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (32, 1, 1, 70.10, 25.87, 7.06, 30.09, '2026-04-15 08:01:59.321308', true, 47.97, 94.89, 40.16, 56.36, 8.42, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (33, 1, 1, 58.72, 17.47, 5.87, 24.22, '2026-04-15 07:01:59.321308', true, 30.60, 69.14, 71.07, 16.57, 12.81, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (34, 1, 1, 71.34, 21.08, 6.53, 29.70, '2026-04-15 06:01:59.321308', true, 82.94, 30.71, 29.89, 47.54, 11.43, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (35, 1, 1, 36.34, 22.07, 6.30, 33.03, '2026-04-15 05:01:59.321308', true, 52.35, 95.90, 29.51, 95.78, 8.21, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (36, 1, 1, 44.26, 23.57, 6.03, 31.66, '2026-04-15 04:01:59.321308', true, 52.57, 68.75, 46.29, 97.50, 10.44, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (37, 1, 1, 53.31, 22.22, 5.76, 18.03, '2026-04-15 03:01:59.321308', true, 51.95, 72.30, 75.98, 87.86, 12.52, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (38, 1, 1, 42.05, 19.65, 5.93, 20.97, '2026-04-15 02:01:59.321308', true, 88.42, 72.86, 12.52, 44.90, 12.54, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (39, 1, 1, 31.88, 20.99, 6.38, 34.40, '2026-04-15 01:01:59.321308', true, 87.01, 34.72, 65.29, 28.12, 10.06, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (40, 1, 1, 31.55, 20.74, 5.50, 23.81, '2026-04-15 00:01:59.321308', true, 61.62, 41.90, 53.03, 38.87, 10.54, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (41, 1, 1, 58.38, 16.21, 6.28, 32.94, '2026-04-14 23:01:59.321308', true, 53.00, 43.97, 96.30, 65.96, 9.25, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (42, 1, 1, 44.39, 25.65, 7.11, 31.27, '2026-04-14 22:01:59.321308', true, 56.23, 90.85, 24.46, 23.00, 10.13, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (43, 1, 1, 49.34, 19.89, 6.27, 26.12, '2026-04-14 21:01:59.321308', true, 79.85, 99.54, 32.26, 76.74, 11.25, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (44, 1, 1, 63.52, 26.21, 6.93, 33.95, '2026-04-14 20:01:59.321308', true, 47.17, 45.54, 97.57, 91.81, 13.50, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (45, 1, 1, 37.25, 15.68, 5.66, 29.01, '2026-04-14 19:01:59.321308', true, 45.94, 25.38, 47.32, 98.47, 8.76, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (46, 1, 1, 51.94, 19.42, 7.32, 18.04, '2026-04-14 18:01:59.321308', true, 43.26, 37.04, 12.22, 43.57, 8.91, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (47, 1, 1, 33.42, 19.72, 5.60, 33.83, '2026-04-14 17:01:59.321308', true, 47.19, 53.55, 66.95, 55.81, 12.80, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (48, 1, 1, 31.60, 16.94, 5.72, 32.94, '2026-04-14 16:01:59.321308', true, 53.18, 25.55, 88.56, 31.45, 9.10, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (49, 1, 1, 72.63, 17.26, 6.86, 31.41, '2026-04-14 15:01:59.321308', true, 58.36, 84.66, 81.57, 95.55, 12.47, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (50, 1, 1, 58.45, 28.41, 7.03, 22.32, '2026-04-14 14:01:59.321308', true, 63.23, 42.68, 36.85, 77.12, 13.11, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (51, 1, 1, 38.93, 27.87, 5.75, 24.33, '2026-04-14 13:01:59.321308', true, 33.04, 22.63, 22.34, 83.41, 12.86, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (52, 1, 1, 45.83, 21.02, 5.99, 20.45, '2026-04-14 12:01:59.321308', true, 51.01, 46.83, 71.95, 93.37, 11.82, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (53, 1, 1, 71.37, 23.13, 7.39, 32.77, '2026-04-18 17:28:36.495943', true, 68.25, 63.62, 50.19, 66.56, 10.95, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (54, 1, 1, 39.53, 21.92, 6.06, 21.26, '2026-04-18 16:28:36.495943', true, 70.68, 20.80, 67.73, 62.70, 12.38, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (55, 1, 1, 32.56, 29.81, 6.68, 34.81, '2026-04-18 15:28:36.495943', true, 74.70, 64.48, 33.92, 69.79, 8.99, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (56, 1, 1, 76.69, 24.44, 7.11, 18.66, '2026-04-18 14:28:36.495943', true, 63.81, 44.23, 53.92, 11.58, 12.28, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (57, 1, 1, 69.31, 18.84, 7.26, 34.21, '2026-04-18 13:28:36.495943', true, 79.84, 11.88, 51.82, 22.57, 8.20, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (58, 1, 1, 31.38, 26.89, 5.97, 26.41, '2026-04-18 12:28:36.495943', true, 45.70, 40.53, 89.65, 67.11, 8.46, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (59, 1, 1, 55.91, 29.55, 6.93, 29.00, '2026-04-18 11:28:36.495943', true, 81.95, 47.13, 31.74, 31.15, 9.50, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (60, 1, 1, 27.02, 28.06, 5.61, 31.40, '2026-04-18 10:28:36.495943', true, 84.71, 77.13, 70.37, 87.75, 10.88, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (61, 1, 1, 60.30, 21.00, 7.15, 18.70, '2026-04-18 09:28:36.495943', true, 45.23, 94.58, 39.57, 30.44, 8.28, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (62, 1, 1, 62.36, 24.37, 6.14, 22.04, '2026-04-18 08:28:36.495943', true, 83.73, 33.02, 44.44, 32.01, 11.74, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (63, 1, 1, 27.42, 25.55, 6.98, 27.83, '2026-04-18 07:28:36.495943', true, 65.99, 62.37, 72.96, 17.86, 9.94, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (64, 1, 1, 43.46, 19.80, 7.50, 30.12, '2026-04-18 06:28:36.495943', true, 45.21, 75.99, 31.58, 53.04, 13.47, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (65, 1, 1, 46.83, 16.51, 7.20, 31.00, '2026-04-18 05:28:36.495943', true, 44.98, 77.48, 36.48, 28.16, 11.02, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (66, 1, 1, 78.01, 27.04, 6.06, 34.65, '2026-04-18 04:28:36.495943', true, 77.90, 83.63, 39.60, 83.56, 8.01, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (67, 1, 1, 72.50, 25.69, 6.17, 18.49, '2026-04-18 03:28:36.495943', true, 82.64, 17.65, 71.62, 51.61, 11.84, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (68, 1, 1, 51.61, 26.31, 6.25, 21.67, '2026-04-18 02:28:36.495943', true, 32.38, 27.72, 39.53, 87.38, 13.96, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (69, 1, 1, 42.77, 22.23, 6.87, 28.77, '2026-04-18 01:28:36.495943', true, 52.83, 59.46, 15.93, 76.74, 9.03, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (70, 1, 1, 33.83, 20.40, 5.87, 29.65, '2026-04-18 00:28:36.495943', true, 78.65, 66.16, 10.19, 75.04, 8.66, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (71, 1, 1, 75.02, 25.08, 7.25, 18.59, '2026-04-17 23:28:36.495943', true, 54.57, 77.87, 93.24, 26.67, 8.74, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (72, 1, 1, 21.37, 17.77, 5.66, 34.72, '2026-04-17 22:28:36.495943', true, 50.75, 64.43, 29.26, 86.18, 12.99, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (73, 1, 1, 41.42, 20.44, 7.33, 22.66, '2026-04-17 21:28:36.495943', true, 53.55, 33.44, 84.32, 21.14, 10.43, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (74, 1, 1, 25.09, 21.79, 6.77, 30.96, '2026-04-17 20:28:36.495943', true, 40.21, 40.81, 83.32, 40.97, 13.54, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (75, 1, 1, 58.22, 28.07, 7.22, 24.27, '2026-04-17 19:28:36.495943', true, 31.18, 53.23, 69.22, 36.78, 8.38, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (76, 1, 1, 71.25, 21.02, 5.86, 27.33, '2026-04-17 18:28:36.495943', true, 52.66, 90.15, 68.72, 69.89, 11.25, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (77, 1, 1, 67.10, 28.34, 6.54, 22.43, '2026-04-17 17:28:36.495943', true, 74.40, 73.99, 79.09, 32.21, 12.19, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (78, 1, 1, 22.64, 27.47, 6.46, 34.53, '2026-04-17 16:28:36.495943', true, 64.30, 92.61, 68.82, 66.94, 8.82, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (79, 1, 1, 65.34, 16.96, 5.89, 29.80, '2026-04-17 15:28:36.495943', true, 31.46, 83.43, 20.43, 48.19, 9.08, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (80, 1, 1, 47.63, 29.89, 5.96, 24.56, '2026-04-17 14:28:36.495943', true, 52.05, 21.51, 32.57, 34.92, 11.56, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (81, 1, 1, 62.72, 17.83, 5.85, 18.82, '2026-04-17 13:28:36.495943', true, 33.42, 69.88, 95.79, 17.88, 12.51, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (82, 1, 1, 30.06, 29.53, 6.89, 23.10, '2026-04-17 12:28:36.495943', true, 37.11, 96.35, 87.32, 21.53, 9.92, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (83, 1, 1, 47.44, 22.16, 5.89, 34.39, '2026-04-17 11:28:36.495943', true, 74.00, 32.07, 27.97, 43.94, 11.80, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (84, 1, 1, 33.65, 22.10, 6.45, 29.50, '2026-04-17 10:28:36.495943', true, 58.26, 90.92, 33.33, 88.03, 11.85, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (85, 1, 1, 65.16, 29.76, 6.84, 26.13, '2026-04-17 09:28:36.495943', true, 31.71, 32.04, 33.15, 99.64, 12.54, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (86, 1, 1, 34.36, 21.01, 5.52, 26.05, '2026-04-17 08:28:36.495943', true, 36.21, 46.37, 31.23, 93.18, 8.39, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (87, 1, 1, 56.34, 28.63, 6.93, 30.45, '2026-04-17 07:28:36.495943', true, 70.43, 91.87, 96.23, 95.22, 9.00, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (88, 1, 1, 27.89, 17.36, 5.83, 29.85, '2026-04-17 06:28:36.495943', true, 58.47, 34.71, 65.41, 79.21, 8.62, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (89, 1, 1, 71.82, 21.10, 5.87, 29.53, '2026-04-17 05:28:36.495943', true, 57.82, 16.74, 87.46, 38.61, 12.62, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (90, 1, 1, 22.81, 18.03, 6.76, 32.53, '2026-04-17 04:28:36.495943', true, 85.73, 94.80, 26.26, 54.39, 8.67, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (91, 1, 1, 28.04, 27.66, 7.43, 29.13, '2026-04-17 03:28:36.495943', true, 40.44, 37.37, 81.56, 85.55, 11.10, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (92, 1, 1, 66.60, 29.08, 5.90, 31.91, '2026-04-17 02:28:36.495943', true, 42.68, 31.32, 17.35, 70.99, 9.19, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (93, 1, 1, 49.77, 27.34, 7.20, 27.92, '2026-04-17 01:28:36.495943', true, 54.08, 60.48, 18.87, 71.06, 12.48, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (94, 1, 1, 54.96, 18.85, 6.32, 26.63, '2026-04-17 00:28:36.495943', true, 78.20, 34.75, 85.54, 98.69, 8.55, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (95, 1, 1, 27.28, 27.69, 7.40, 31.79, '2026-04-16 23:28:36.495943', true, 61.54, 86.40, 44.78, 67.95, 11.21, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (96, 1, 1, 22.19, 27.01, 7.14, 20.12, '2026-04-16 22:28:36.495943', true, 82.02, 35.52, 87.71, 28.90, 9.23, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (97, 1, 1, 57.62, 18.59, 5.96, 25.20, '2026-04-16 21:28:36.495943', true, 72.45, 28.22, 24.98, 76.27, 8.58, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (98, 1, 1, 23.62, 19.97, 7.05, 19.59, '2026-04-16 20:28:36.495943', true, 68.63, 31.90, 72.22, 13.96, 9.35, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (99, 1, 1, 20.07, 28.50, 7.49, 31.27, '2026-04-16 19:28:36.495943', true, 75.44, 99.24, 54.55, 52.67, 9.70, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (100, 1, 1, 29.94, 21.47, 5.55, 24.78, '2026-04-16 18:28:36.495943', true, 76.24, 18.44, 87.12, 38.93, 9.93, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (101, 1, 1, 51.12, 15.89, 6.35, 19.16, '2026-04-16 17:28:36.495943', true, 55.93, 20.27, 84.24, 69.95, 9.07, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (102, 1, 1, 64.10, 24.53, 6.44, 20.08, '2026-04-16 16:28:36.495943', true, 33.82, 23.24, 43.76, 62.87, 10.79, 'Franco', 'Templado');
INSERT INTO public.lectura_sensor VALUES (104, 5, 1, 57.47, 24.03, 6.42, 28.81, '2026-04-07 23:08:04.098135', false, 42.13, 88.31, 30.10, 37.16, 15.65, 'arcilloso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (105, 5, 1, 71.11, 24.62, 5.57, 31.73, '2026-04-20 08:15:29.65795', false, 41.62, 93.52, 27.43, 68.66, 15.18, 'arenoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (106, 5, 1, 53.13, 21.97, 6.40, 20.33, '2026-04-12 21:18:53.619778', false, 71.16, 46.57, 5.15, 72.73, 11.23, 'arcilloso', 'templado');
INSERT INTO public.lectura_sensor VALUES (107, 5, 1, 35.76, 22.01, 5.99, 32.89, '2026-04-10 21:32:48.717984', false, 75.66, 82.09, 16.48, 66.24, 15.65, 'franco', 'tropical');
INSERT INTO public.lectura_sensor VALUES (108, 5, 1, 38.85, 28.16, 5.64, 18.12, '2026-04-17 00:24:09.30913', false, 86.29, 82.29, 5.97, 90.89, 8.68, 'franco', 'humedo');
INSERT INTO public.lectura_sensor VALUES (109, 5, 1, 68.71, 17.90, 7.47, 30.43, '2026-04-16 19:40:51.997719', false, 40.38, 61.11, 45.32, 50.03, 12.16, 'limoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (110, 5, 1, 40.55, 22.26, 5.61, 32.85, '2026-04-06 11:59:49.404187', false, 81.85, 70.53, 18.29, 86.56, 8.58, 'franco', 'seco');
INSERT INTO public.lectura_sensor VALUES (111, 5, 1, 48.46, 14.54, 6.47, 29.02, '2026-04-16 04:31:06.720993', false, 61.04, 84.02, 45.69, 85.55, 10.69, 'limoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (112, 5, 1, 50.99, 18.56, 6.55, 22.93, '2026-04-17 05:25:32.873324', false, 54.36, 18.59, 18.06, 17.80, 12.68, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (113, 5, 1, 37.07, 17.55, 7.43, 28.73, '2026-04-12 23:48:58.600536', false, 41.07, 48.76, 23.34, 59.16, 14.06, 'arenoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (114, 5, 1, 44.09, 15.09, 7.38, 20.04, '2026-04-07 01:13:04.630756', false, 75.70, 30.04, 45.59, 52.74, 14.82, 'arcilloso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (115, 5, 1, 69.34, 21.59, 6.39, 30.67, '2026-04-20 11:55:22.691696', false, 46.03, 18.37, 35.27, 57.96, 15.56, 'arenoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (116, 5, 1, 35.62, 24.28, 6.26, 29.66, '2026-04-08 18:17:57.454869', false, 46.13, 97.01, 16.32, 77.08, 8.43, 'arenoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (117, 5, 1, 78.44, 21.78, 6.38, 32.87, '2026-04-06 05:08:51.347305', false, 59.94, 75.73, 16.64, 78.40, 9.32, 'limoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (118, 5, 1, 74.86, 19.06, 6.70, 25.13, '2026-04-10 09:22:40.626605', false, 76.66, 62.96, 8.21, 98.21, 12.87, 'arcilloso', 'templado');
INSERT INTO public.lectura_sensor VALUES (119, 5, 1, 41.75, 31.20, 6.03, 29.53, '2026-04-14 03:28:34.618276', false, 89.80, 47.98, 44.83, 88.93, 14.78, 'arcilloso', 'templado');
INSERT INTO public.lectura_sensor VALUES (120, 5, 1, 50.09, 19.24, 6.84, 20.32, '2026-04-07 22:42:38.540935', false, 59.25, 68.97, 41.17, 22.80, 12.38, 'arenoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (121, 5, 1, 47.39, 24.77, 6.37, 27.57, '2026-04-12 18:49:29.624455', false, 89.89, 51.31, 25.24, 50.29, 13.91, 'franco', 'humedo');
INSERT INTO public.lectura_sensor VALUES (122, 5, 1, 78.07, 20.99, 6.34, 30.86, '2026-04-20 07:33:15.357382', false, 79.81, 72.25, 11.35, 91.68, 9.30, 'arenoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (123, 5, 1, 69.38, 22.07, 6.05, 18.99, '2026-04-16 15:30:39.930511', false, 42.97, 13.61, 38.32, 91.69, 9.50, 'arenoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (124, 5, 1, 63.37, 29.40, 7.37, 21.61, '2026-04-09 08:22:06.34808', false, 57.15, 15.94, 21.86, 61.82, 12.05, 'limoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (125, 5, 1, 55.57, 21.28, 7.26, 28.26, '2026-04-17 02:46:49.223577', false, 87.44, 81.12, 28.52, 52.17, 15.97, 'limoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (126, 5, 1, 48.26, 29.35, 6.09, 32.49, '2026-04-19 16:07:15.63384', false, 59.90, 97.19, 30.71, 21.49, 15.29, 'limoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (127, 5, 1, 60.20, 31.88, 6.89, 25.30, '2026-04-16 14:39:38.260626', false, 86.06, 65.12, 25.27, 24.44, 8.37, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (128, 5, 1, 39.19, 18.15, 6.31, 24.73, '2026-04-19 16:44:03.099324', false, 53.64, 31.42, 43.61, 88.56, 14.62, 'arenoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (129, 5, 1, 62.18, 28.52, 6.63, 31.04, '2026-04-15 12:55:35.917603', false, 61.14, 34.10, 17.15, 70.73, 14.75, 'limoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (130, 5, 1, 44.63, 28.23, 7.17, 33.11, '2026-04-14 05:33:33.050005', false, 47.06, 76.45, 19.81, 99.05, 8.89, 'arcilloso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (131, 5, 1, 64.17, 23.10, 6.04, 23.96, '2026-04-08 10:26:30.263147', false, 82.34, 65.19, 14.84, 74.56, 13.63, 'arcilloso', 'templado');
INSERT INTO public.lectura_sensor VALUES (132, 5, 1, 59.96, 25.74, 6.16, 27.64, '2026-04-10 22:23:45.294131', false, 44.48, 66.16, 35.55, 78.90, 11.31, 'arenoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (133, 5, 1, 68.75, 28.72, 6.51, 33.40, '2026-04-20 16:48:36.523916', false, 59.50, 89.18, 40.21, 77.78, 8.55, 'franco', 'seco');
INSERT INTO public.lectura_sensor VALUES (134, 5, 1, 37.92, 22.79, 5.82, 25.50, '2026-04-19 05:51:48.363231', false, 86.38, 63.91, 21.90, 37.66, 13.40, 'arcilloso', 'seco');
INSERT INTO public.lectura_sensor VALUES (135, 5, 1, 54.48, 15.51, 6.15, 24.49, '2026-04-15 19:09:14.660334', false, 84.29, 87.76, 44.81, 31.58, 11.20, 'arenoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (136, 5, 1, 77.72, 20.37, 7.14, 29.52, '2026-04-17 17:34:45.299065', false, 85.94, 47.22, 47.12, 33.74, 10.48, 'arenoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (137, 5, 1, 71.68, 23.18, 6.18, 26.60, '2026-04-20 06:39:46.708128', false, 59.45, 82.18, 40.45, 59.62, 14.79, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (138, 5, 1, 50.11, 15.09, 6.14, 23.63, '2026-04-13 19:31:36.140945', false, 68.47, 45.25, 29.21, 68.14, 8.92, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (139, 5, 1, 62.74, 20.00, 5.76, 18.43, '2026-04-11 06:17:14.795581', false, 77.26, 50.76, 38.91, 95.50, 10.25, 'limoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (140, 5, 1, 76.10, 28.42, 6.31, 23.66, '2026-04-13 18:28:24.554704', false, 55.01, 39.98, 17.05, 63.77, 9.10, 'arcilloso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (141, 5, 1, 36.44, 17.99, 5.84, 22.78, '2026-04-18 02:13:19.086636', false, 55.53, 19.67, 49.77, 49.81, 12.78, 'franco', 'tropical');
INSERT INTO public.lectura_sensor VALUES (142, 5, 1, 54.24, 26.45, 5.57, 19.80, '2026-04-15 13:25:53.032502', false, 82.58, 70.26, 7.64, 56.80, 9.94, 'franco', 'tropical');
INSERT INTO public.lectura_sensor VALUES (143, 5, 1, 52.49, 31.42, 6.25, 22.24, '2026-04-07 09:53:35.74569', false, 62.46, 45.98, 26.95, 35.24, 14.49, 'limoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (144, 5, 1, 78.93, 29.98, 6.28, 24.74, '2026-04-08 12:29:26.960236', false, 66.13, 43.70, 6.29, 90.83, 9.74, 'arcilloso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (145, 5, 1, 48.52, 29.13, 6.46, 20.64, '2026-04-09 03:48:55.207941', false, 82.42, 79.67, 19.85, 67.39, 8.43, 'franco', 'seco');
INSERT INTO public.lectura_sensor VALUES (146, 5, 1, 40.79, 18.68, 6.88, 22.85, '2026-04-20 02:47:37.370277', false, 60.86, 66.83, 25.90, 41.70, 11.90, 'limoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (147, 5, 1, 71.46, 30.33, 5.65, 19.38, '2026-04-16 00:54:55.171996', false, 49.58, 80.06, 5.99, 16.70, 11.08, 'franco', 'tropical');
INSERT INTO public.lectura_sensor VALUES (148, 5, 1, 53.95, 27.55, 6.51, 20.31, '2026-04-07 11:54:34.815667', false, 86.78, 14.12, 24.78, 57.37, 11.49, 'arenoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (149, 5, 1, 40.99, 24.01, 6.24, 33.81, '2026-04-07 02:18:22.404658', false, 73.63, 97.50, 37.22, 18.27, 8.93, 'limoso', 'templado');
INSERT INTO public.lectura_sensor VALUES (150, 5, 1, 54.97, 18.92, 7.16, 24.27, '2026-04-14 10:11:22.591297', false, 41.44, 37.77, 36.71, 31.99, 14.01, 'limoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (151, 5, 1, 35.24, 23.16, 6.58, 25.77, '2026-04-18 09:57:47.356331', false, 58.20, 58.40, 5.25, 80.23, 13.53, 'arcilloso', 'templado');
INSERT INTO public.lectura_sensor VALUES (152, 5, 1, 76.97, 17.38, 5.92, 28.01, '2026-04-20 12:28:15.352335', false, 41.74, 12.48, 10.09, 72.32, 14.33, 'limoso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (153, 5, 1, 74.43, 31.58, 7.04, 19.75, '2026-04-17 22:29:16.823845', false, 58.38, 31.75, 35.43, 95.15, 14.14, 'arenoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (155, 1, 1, 62.35, 24.10, 6.45, 29.80, '2026-04-19 23:41:29.533697', false, 71.20, 48.50, 22.10, 61.70, 12.50, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (156, 2, 1, 55.80, 21.90, 6.80, 27.40, '2026-04-20 00:41:29.533697', false, 66.40, 35.20, 18.60, 57.30, 11.80, 'arcilloso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (157, 3, 1, 43.60, 19.70, 5.95, 24.60, '2026-04-20 01:41:29.533697', false, 59.10, 28.40, 14.30, 45.20, 10.20, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (158, 4, 1, 74.10, 26.50, 6.20, 31.30, '2026-04-20 02:41:29.533697', false, 81.70, 62.80, 31.40, 79.60, 13.70, 'limoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (159, 5, 1, 58.90, 23.80, 6.55, 28.20, '2026-04-20 03:41:29.533697', false, 68.50, 44.10, 20.50, 63.40, 12.10, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (160, 6, 1, 49.70, 20.30, 5.75, 25.90, '2026-04-20 04:41:29.533697', false, 61.30, 31.60, 16.20, 50.10, 9.80, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (161, 7, 1, 67.40, 25.60, 6.90, 30.10, '2026-04-20 05:41:29.533697', false, 75.90, 54.30, 26.70, 70.80, 14.20, 'arcilloso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (162, 8, 1, 52.10, 22.40, 6.10, 26.80, '2026-04-20 06:41:29.533697', false, 64.80, 38.70, 19.10, 55.90, 11.40, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (163, 9, 1, 46.30, 18.90, 5.60, 23.70, '2026-04-20 07:41:29.533697', false, 57.20, 25.90, 12.80, 41.50, 8.90, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (164, 10, 1, 71.80, 27.20, 6.35, 32.40, '2026-04-20 08:41:29.533697', false, 84.10, 67.50, 33.90, 82.30, 15.10, 'limoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (165, 1, 1, 60.40, 24.50, 6.50, 29.10, '2026-04-20 09:41:29.533697', false, 70.30, 46.80, 21.40, 60.90, 12.70, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (166, 2, 1, 54.20, 21.10, 6.70, 27.00, '2026-04-20 10:41:29.533697', false, 65.90, 34.10, 17.90, 56.40, 11.60, 'arcilloso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (167, 3, 1, 44.80, 19.20, 5.85, 24.10, '2026-04-20 11:41:29.533697', false, 58.60, 27.50, 13.70, 44.30, 10.00, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (168, 4, 1, 73.20, 26.90, 6.25, 31.80, '2026-04-20 12:41:29.533697', false, 82.50, 63.90, 32.60, 80.70, 13.90, 'limoso', 'tropical');
INSERT INTO public.lectura_sensor VALUES (169, 5, 1, 57.60, 23.50, 6.40, 28.00, '2026-04-20 13:41:29.533697', false, 67.80, 42.90, 19.80, 62.10, 12.00, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (170, 6, 1, 48.90, 20.00, 5.70, 25.40, '2026-04-20 14:41:29.533697', false, 60.70, 30.40, 15.50, 49.60, 9.50, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (171, 7, 1, 66.10, 25.10, 6.85, 29.70, '2026-04-20 15:41:29.533697', false, 74.80, 53.20, 25.60, 69.50, 14.00, 'arcilloso', 'humedo');
INSERT INTO public.lectura_sensor VALUES (172, 8, 1, 51.30, 22.00, 6.05, 26.40, '2026-04-20 16:41:29.533697', false, 63.90, 37.40, 18.30, 54.80, 11.20, 'franco', 'templado');
INSERT INTO public.lectura_sensor VALUES (173, 9, 1, 45.10, 18.50, 5.55, 23.20, '2026-04-20 17:41:29.533697', false, 56.50, 24.70, 12.10, 40.80, 8.70, 'arenoso', 'seco');
INSERT INTO public.lectura_sensor VALUES (174, 10, 1, 70.50, 26.80, 6.30, 31.90, '2026-04-20 18:41:29.533697', false, 83.20, 66.10, 33.10, 81.40, 14.80, 'limoso', 'tropical');


--
-- TOC entry 5099 (class 0 OID 16429)
-- Dependencies: 225
-- Data for Name: rancho; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rancho VALUES (1, 'Rancho Innovación Agrícola');


--
-- TOC entry 5101 (class 0 OID 16435)
-- Dependencies: 227
-- Data for Name: rango_condicion_plaga; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.rango_condicion_plaga VALUES (4, 1, 40.00, 60.00, 15.00, 25.00, 6.00, 7.50, 20.00, 28.00, 50.00, 70.00, 50.00, 80.00, 20.00, 40.00, 30.00, 50.00, 12.00, 14.00, 'Franco', 'Templado');
INSERT INTO public.rango_condicion_plaga VALUES (5, 2, 20.00, 40.00, 20.00, 30.00, 5.50, 6.50, 28.00, 35.00, 20.00, 40.00, 20.00, 40.00, 30.00, 50.00, 40.00, 60.00, 14.00, 16.00, 'Arenoso', 'Seco');
INSERT INTO public.rango_condicion_plaga VALUES (6, 3, 70.00, 90.00, 10.00, 20.00, 5.00, 7.00, 15.00, 22.00, 80.00, 95.00, 30.00, 50.00, 10.00, 30.00, 20.00, 40.00, 8.00, 10.00, 'Arcilloso', 'Húmedo');


--
-- TOC entry 5103 (class 0 OID 16441)
-- Dependencies: 229
-- Data for Name: surco; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.surco VALUES (1, 5, 'Berries', 1);
INSERT INTO public.surco VALUES (2, 1, 'fresa', 1);
INSERT INTO public.surco VALUES (3, 2, 'chile', 1);
INSERT INTO public.surco VALUES (4, 3, 'jitomate', 1);
INSERT INTO public.surco VALUES (5, 4, 'fresa', 1);
INSERT INTO public.surco VALUES (6, 5, 'jitomate', 1);
INSERT INTO public.surco VALUES (7, 6, 'chile', 1);
INSERT INTO public.surco VALUES (8, 7, 'pepino', 1);
INSERT INTO public.surco VALUES (9, 8, 'pepino', 1);
INSERT INTO public.surco VALUES (10, 9, 'pepino', 1);
INSERT INTO public.surco VALUES (11, 10, 'chile', 1);


--
-- TOC entry 5105 (class 0 OID 16449)
-- Dependencies: 231
-- Data for Name: tipo_plaga; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tipo_plaga VALUES (1, 'Pulgón', 'Insecto que succiona savia y se favorece por altos niveles de Nitrógeno y clima templado.');
INSERT INTO public.tipo_plaga VALUES (2, 'Araña Roja', 'Ácaro que prolifera en condiciones de alta temperatura y baja humedad ambiental.');
INSERT INTO public.tipo_plaga VALUES (3, 'Mildiu', 'Hongo fitopatógeno que requiere alta humedad relativa y temperaturas frescas para su propagación.');


--
-- TOC entry 5107 (class 0 OID 16458)
-- Dependencies: 233
-- Data for Name: tunel; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.tunel VALUES (1, 10, 1);


--
-- TOC entry 5109 (class 0 OID 16465)
-- Dependencies: 235
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.usuario VALUES (1, 'Mariana', 'Vaca Soltero', 'agrotech_2026', 'Supervisor de Campo');


--
-- TOC entry 5111 (class 0 OID 16474)
-- Dependencies: 237
-- Data for Name: usuario_rancho; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5126 (class 0 OID 0)
-- Dependencies: 220
-- Name: diagnostico_id_diagnostico_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.diagnostico_id_diagnostico_seq', 270, true);


--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 222
-- Name: incidencia_plaga_id_incidencia_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.incidencia_plaga_id_incidencia_seq', 53, true);


--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 224
-- Name: lectura_sensor_id_lectura_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.lectura_sensor_id_lectura_seq', 174, true);


--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 226
-- Name: rancho_id_rancho_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rancho_id_rancho_seq', 1, true);


--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 228
-- Name: rango_condicion_plaga_id_rango_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rango_condicion_plaga_id_rango_seq', 6, true);


--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 230
-- Name: surco_id_surco_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.surco_id_surco_seq', 11, true);


--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 232
-- Name: tipo_plaga_id_tipo_plaga_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tipo_plaga_id_tipo_plaga_seq', 1, false);


--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 234
-- Name: tunel_id_tunel_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.tunel_id_tunel_seq', 1, true);


--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 236
-- Name: usuario_id_usuario_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.usuario_id_usuario_seq', 1, true);


--
-- TOC entry 4915 (class 2606 OID 16489)
-- Name: diagnostico diagnostico_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_pkey PRIMARY KEY (id_diagnostico);


--
-- TOC entry 4917 (class 2606 OID 16491)
-- Name: incidencia_plaga incidencia_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_pkey PRIMARY KEY (id_incidencia);


--
-- TOC entry 4919 (class 2606 OID 16493)
-- Name: lectura_sensor lectura_sensor_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_pkey PRIMARY KEY (id_lectura);


--
-- TOC entry 4921 (class 2606 OID 16495)
-- Name: rancho rancho_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rancho
    ADD CONSTRAINT rancho_pkey PRIMARY KEY (id_rancho);


--
-- TOC entry 4923 (class 2606 OID 16497)
-- Name: rango_condicion_plaga rango_condicion_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rango_condicion_plaga
    ADD CONSTRAINT rango_condicion_plaga_pkey PRIMARY KEY (id_rango);


--
-- TOC entry 4925 (class 2606 OID 16499)
-- Name: surco surco_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surco
    ADD CONSTRAINT surco_pkey PRIMARY KEY (id_surco);


--
-- TOC entry 4927 (class 2606 OID 16501)
-- Name: tipo_plaga tipo_plaga_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tipo_plaga
    ADD CONSTRAINT tipo_plaga_pkey PRIMARY KEY (id_tipo_plaga);


--
-- TOC entry 4929 (class 2606 OID 16503)
-- Name: tunel tunel_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tunel
    ADD CONSTRAINT tunel_pkey PRIMARY KEY (id_tunel);


--
-- TOC entry 4931 (class 2606 OID 16505)
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id_usuario);


--
-- TOC entry 4933 (class 2606 OID 16507)
-- Name: usuario_rancho usuario_rancho_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario_rancho
    ADD CONSTRAINT usuario_rancho_pkey PRIMARY KEY (id_usuario, id_rancho);


--
-- TOC entry 4934 (class 2606 OID 16508)
-- Name: diagnostico diagnostico_id_lectura_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_id_lectura_fkey FOREIGN KEY (id_lectura) REFERENCES public.lectura_sensor(id_lectura);


--
-- TOC entry 4935 (class 2606 OID 16513)
-- Name: diagnostico diagnostico_id_tipo_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.diagnostico
    ADD CONSTRAINT diagnostico_id_tipo_plaga_fkey FOREIGN KEY (id_tipo_plaga) REFERENCES public.tipo_plaga(id_tipo_plaga);


--
-- TOC entry 4936 (class 2606 OID 16518)
-- Name: incidencia_plaga incidencia_plaga_id_surco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_id_surco_fkey FOREIGN KEY (id_surco) REFERENCES public.surco(id_surco) ON DELETE CASCADE;


--
-- TOC entry 4937 (class 2606 OID 16523)
-- Name: incidencia_plaga incidencia_plaga_id_tipo_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_id_tipo_plaga_fkey FOREIGN KEY (id_tipo_plaga) REFERENCES public.tipo_plaga(id_tipo_plaga) ON DELETE CASCADE;


--
-- TOC entry 4938 (class 2606 OID 16528)
-- Name: incidencia_plaga incidencia_plaga_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.incidencia_plaga
    ADD CONSTRAINT incidencia_plaga_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


--
-- TOC entry 4939 (class 2606 OID 16533)
-- Name: lectura_sensor lectura_sensor_id_surco_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_id_surco_fkey FOREIGN KEY (id_surco) REFERENCES public.surco(id_surco);


--
-- TOC entry 4940 (class 2606 OID 16538)
-- Name: lectura_sensor lectura_sensor_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.lectura_sensor
    ADD CONSTRAINT lectura_sensor_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario);


--
-- TOC entry 4941 (class 2606 OID 16543)
-- Name: rango_condicion_plaga rango_condicion_plaga_id_tipo_plaga_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rango_condicion_plaga
    ADD CONSTRAINT rango_condicion_plaga_id_tipo_plaga_fkey FOREIGN KEY (id_tipo_plaga) REFERENCES public.tipo_plaga(id_tipo_plaga);


--
-- TOC entry 4942 (class 2606 OID 16548)
-- Name: surco surco_id_tunel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.surco
    ADD CONSTRAINT surco_id_tunel_fkey FOREIGN KEY (id_tunel) REFERENCES public.tunel(id_tunel) ON DELETE CASCADE;


--
-- TOC entry 4943 (class 2606 OID 16553)
-- Name: tunel tunel_id_rancho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tunel
    ADD CONSTRAINT tunel_id_rancho_fkey FOREIGN KEY (id_rancho) REFERENCES public.rancho(id_rancho) ON DELETE CASCADE;


--
-- TOC entry 4944 (class 2606 OID 16558)
-- Name: usuario_rancho usuario_rancho_id_rancho_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario_rancho
    ADD CONSTRAINT usuario_rancho_id_rancho_fkey FOREIGN KEY (id_rancho) REFERENCES public.rancho(id_rancho) ON DELETE CASCADE;


--
-- TOC entry 4945 (class 2606 OID 16563)
-- Name: usuario_rancho usuario_rancho_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.usuario_rancho
    ADD CONSTRAINT usuario_rancho_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id_usuario) ON DELETE CASCADE;


-- Completed on 2026-04-23 18:47:14

--
-- PostgreSQL database dump complete
--

\unrestrict DzWsL8KHUZkgmPBRE6X92hxCGr0Lowk4HMOGwmIcvZG0ydXXhhWhaNbjR1s39LK

