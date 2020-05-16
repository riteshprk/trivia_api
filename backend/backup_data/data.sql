toc.dat                                                                                             0000600 0004000 0002000 00000011471 13657531514 0014455 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        PGDMP       +                    x           trivia    12.2    12.2                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                    0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                    0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                    1262    41359    trivia    DATABASE     �   CREATE DATABASE trivia WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United Kingdom.1252' LC_CTYPE = 'English_United Kingdom.1252';
    DROP DATABASE trivia;
                postgres    false         �            1259    41360 
   categories    TABLE     K   CREATE TABLE public.categories (
    id integer NOT NULL,
    type text
);
    DROP TABLE public.categories;
       public         heap    postgres    false         �            1259    41366    categories_id_seq    SEQUENCE     �   CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.categories_id_seq;
       public          postgres    false    202                    0    0    categories_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;
          public          postgres    false    203         �            1259    41368 	   questions    TABLE     �   CREATE TABLE public.questions (
    id integer NOT NULL,
    question text,
    answer text,
    difficulty integer,
    category integer
);
    DROP TABLE public.questions;
       public         heap    postgres    false         �            1259    41374    questions_id_seq    SEQUENCE     �   CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.questions_id_seq;
       public          postgres    false    204                    0    0    questions_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;
          public          postgres    false    205         �
           2604    41376    categories id    DEFAULT     n   ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);
 <   ALTER TABLE public.categories ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    203    202         �
           2604    41377    questions id    DEFAULT     l   ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);
 ;   ALTER TABLE public.questions ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    205    204                   0    41360 
   categories 
   TABLE DATA           .   COPY public.categories (id, type) FROM stdin;
    public          postgres    false    202       2828.dat           0    41368 	   questions 
   TABLE DATA           O   COPY public.questions (id, question, answer, difficulty, category) FROM stdin;
    public          postgres    false    204       2830.dat            0    0    categories_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.categories_id_seq', 6, true);
          public          postgres    false    203                    0    0    questions_id_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('public.questions_id_seq', 110, true);
          public          postgres    false    205         �
           2606    41379    categories categories_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.categories DROP CONSTRAINT categories_pkey;
       public            postgres    false    202         �
           2606    41381    questions questions_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.questions DROP CONSTRAINT questions_pkey;
       public            postgres    false    204         �
           2606    41382    questions category    FK CONSTRAINT     �   ALTER TABLE ONLY public.questions
    ADD CONSTRAINT category FOREIGN KEY (category) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;
 <   ALTER TABLE ONLY public.questions DROP CONSTRAINT category;
       public          postgres    false    204    2698    202                                                                                                                                                                                                               2828.dat                                                                                            0000600 0004000 0002000 00000000104 13657531514 0014262 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        1	Science
2	Art
3	Geography
4	History
5	Entertainment
6	Sports
\.


                                                                                                                                                                                                                                                                                                                                                                                                                                                            2830.dat                                                                                            0000600 0004000 0002000 00000002633 13657531514 0014264 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        5	Whose autobiography is entitled 'I Know Why the Caged Bird Sings'?	Maya Angelou	2	4
9	What boxer's original name is Cassius Clay?	Muhammad Ali	1	4
4	What actor did author Anne Rice first denounce, then praise in the role of her beloved Lestat?	Tom Cruise	4	5
6	What was the title of the 1990 fantasy directed by Tim Burton about a young man with multi-bladed appendages?	Edward Scissorhands	3	5
10	Which is the only team to play in every soccer World Cup tournament?	Brazil	3	6
11	Which country won the first ever soccer World Cup in 1930?	Uruguay	4	6
12	Who invented Peanut Butter?	George Washington Carver	2	4
13	What is the largest lake in Africa?	Lake Victoria	2	3
14	In which royal palace would you find the Hall of Mirrors?	The Palace of Versailles	3	3
16	Which Dutch graphic artist–initials M C was a creator of optical illusions?	Escher	1	2
17	La Giaconda is better known as what?	Mona Lisa	3	2
18	How many paintings did Van Gogh sell in his lifetime?	One	4	2
19	Which American artist was a pioneer of Abstract Expressionism, and a leading exponent of action painting?	Jackson Pollock	2	2
20	What is the heaviest organ in the human body?	The Liver	4	1
21	Who discovered penicillin?	Alexander Fleming	3	1
22	Hematology is a branch of medicine involving the study of what?	Blood	4	1
23	Which dung beetle was worshipped by the ancient Egyptians?	Scarab	4	4
110	Humans and chimpanzees share roughly how much DNA?	98 %	4	1
\.


                                                                                                     restore.sql                                                                                         0000600 0004000 0002000 00000010551 13657531514 0015400 0                                                                                                    ustar 00postgres                        postgres                        0000000 0000000                                                                                                                                                                        --
-- NOTE:
--
-- File paths need to be edited. Search for $$PATH$$ and
-- replace it with the path to the directory containing
-- the extracted data files.
--
--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2
-- Dumped by pg_dump version 12.2

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

DROP DATABASE trivia;
--
-- Name: trivia; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE trivia WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United Kingdom.1252' LC_CTYPE = 'English_United Kingdom.1252';


ALTER DATABASE trivia OWNER TO postgres;

\connect trivia

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
-- Name: categories; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categories (
    id integer NOT NULL,
    type text
);


ALTER TABLE public.categories OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.categories_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.categories_id_seq OWNER TO postgres;

--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: questions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.questions (
    id integer NOT NULL,
    question text,
    answer text,
    difficulty integer,
    category integer
);


ALTER TABLE public.questions OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.questions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.questions_id_seq OWNER TO postgres;

--
-- Name: questions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.questions_id_seq OWNED BY public.questions.id;


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: questions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions ALTER COLUMN id SET DEFAULT nextval('public.questions_id_seq'::regclass);


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.categories (id, type) FROM stdin;
\.
COPY public.categories (id, type) FROM '$$PATH$$/2828.dat';

--
-- Data for Name: questions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.questions (id, question, answer, difficulty, category) FROM stdin;
\.
COPY public.questions (id, question, answer, difficulty, category) FROM '$$PATH$$/2830.dat';

--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.categories_id_seq', 6, true);


--
-- Name: questions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.questions_id_seq', 110, true);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: questions questions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT questions_pkey PRIMARY KEY (id);


--
-- Name: questions category; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.questions
    ADD CONSTRAINT category FOREIGN KEY (category) REFERENCES public.categories(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       