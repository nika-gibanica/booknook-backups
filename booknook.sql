--
-- PostgreSQL database dump
--



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

ALTER TABLE IF EXISTS ONLY public.series_entry DROP CONSTRAINT IF EXISTS series_entry_series_id_fkey;
ALTER TABLE IF EXISTS ONLY public.series_entry DROP CONSTRAINT IF EXISTS series_entry_book_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reading_tbr_prompt DROP CONSTRAINT IF EXISTS reading_tbr_prompt_reading_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reading_readathon DROP CONSTRAINT IF EXISTS reading_readathon_reading_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reading_purpose DROP CONSTRAINT IF EXISTS reading_purpose_reading_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reading_format DROP CONSTRAINT IF EXISTS reading_format_reading_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reading_bookclub DROP CONSTRAINT IF EXISTS reading_bookclub_reading_id_fkey;
ALTER TABLE IF EXISTS ONLY public.reading DROP CONSTRAINT IF EXISTS reading_book_id_fkey;
ALTER TABLE IF EXISTS ONLY public.library_loan DROP CONSTRAINT IF EXISTS library_loan_book_id_fkey;
ALTER TABLE IF EXISTS ONLY public.copy DROP CONSTRAINT IF EXISTS copy_book_id_fkey;
ALTER TABLE IF EXISTS ONLY public.book_setting DROP CONSTRAINT IF EXISTS book_setting_book_id_fkey;
ALTER TABLE IF EXISTS ONLY public.book_genre DROP CONSTRAINT IF EXISTS book_genre_book_id_fkey;
ALTER TABLE IF EXISTS ONLY public.book_author DROP CONSTRAINT IF EXISTS book_author_book_id_fkey;
ALTER TABLE IF EXISTS ONLY public.book_author DROP CONSTRAINT IF EXISTS book_author_author_id_fkey;
DROP INDEX IF EXISTS public.series_name_uq;
DROP INDEX IF EXISTS public.series_entry_series_idx;
DROP INDEX IF EXISTS public.series_entry_book_uq;
DROP INDEX IF EXISTS public.series_entry_book_idx;
DROP INDEX IF EXISTS public.reading_year_month_idx;
DROP INDEX IF EXISTS public.reading_book_idx;
DROP INDEX IF EXISTS public.list_value_uq;
DROP INDEX IF EXISTS public.list_value_category_idx;
DROP INDEX IF EXISTS public.library_loan_out_idx;
DROP INDEX IF EXISTS public.library_loan_book_idx;
DROP INDEX IF EXISTS public.flyway_schema_history_s_idx;
DROP INDEX IF EXISTS public.copy_format_idx;
DROP INDEX IF EXISTS public.copy_book_idx;
DROP INDEX IF EXISTS public.book_title_idx;
DROP INDEX IF EXISTS public.book_author_author_idx;
DROP INDEX IF EXISTS public.author_name_uq;
ALTER TABLE IF EXISTS ONLY public.series DROP CONSTRAINT IF EXISTS series_pkey;
ALTER TABLE IF EXISTS ONLY public.series_entry DROP CONSTRAINT IF EXISTS series_entry_pkey;
ALTER TABLE IF EXISTS ONLY public.reading_tbr_prompt DROP CONSTRAINT IF EXISTS reading_tbr_prompt_pkey;
ALTER TABLE IF EXISTS ONLY public.reading_readathon DROP CONSTRAINT IF EXISTS reading_readathon_pkey;
ALTER TABLE IF EXISTS ONLY public.reading_purpose DROP CONSTRAINT IF EXISTS reading_purpose_pkey;
ALTER TABLE IF EXISTS ONLY public.reading DROP CONSTRAINT IF EXISTS reading_pkey;
ALTER TABLE IF EXISTS ONLY public.reading_format DROP CONSTRAINT IF EXISTS reading_format_pkey;
ALTER TABLE IF EXISTS ONLY public.reading_bookclub DROP CONSTRAINT IF EXISTS reading_bookclub_pkey;
ALTER TABLE IF EXISTS ONLY public.list_value DROP CONSTRAINT IF EXISTS list_value_pkey;
ALTER TABLE IF EXISTS ONLY public.library_loan DROP CONSTRAINT IF EXISTS library_loan_pkey;
ALTER TABLE IF EXISTS ONLY public.flyway_schema_history DROP CONSTRAINT IF EXISTS flyway_schema_history_pk;
ALTER TABLE IF EXISTS ONLY public.copy DROP CONSTRAINT IF EXISTS copy_pkey;
ALTER TABLE IF EXISTS ONLY public.book_setting DROP CONSTRAINT IF EXISTS book_setting_pkey;
ALTER TABLE IF EXISTS ONLY public.book DROP CONSTRAINT IF EXISTS book_pkey;
ALTER TABLE IF EXISTS ONLY public.book DROP CONSTRAINT IF EXISTS book_key_uq;
ALTER TABLE IF EXISTS ONLY public.book_genre DROP CONSTRAINT IF EXISTS book_genre_pkey;
ALTER TABLE IF EXISTS ONLY public.book_author DROP CONSTRAINT IF EXISTS book_author_uq;
ALTER TABLE IF EXISTS ONLY public.book_author DROP CONSTRAINT IF EXISTS book_author_pkey;
ALTER TABLE IF EXISTS ONLY public.author DROP CONSTRAINT IF EXISTS author_pkey;
DROP TABLE IF EXISTS public.series_entry;
DROP TABLE IF EXISTS public.series;
DROP TABLE IF EXISTS public.reading_tbr_prompt;
DROP TABLE IF EXISTS public.reading_readathon;
DROP TABLE IF EXISTS public.reading_purpose;
DROP TABLE IF EXISTS public.reading_format;
DROP TABLE IF EXISTS public.reading_bookclub;
DROP TABLE IF EXISTS public.reading;
DROP TABLE IF EXISTS public.list_value;
DROP TABLE IF EXISTS public.library_loan;
DROP TABLE IF EXISTS public.flyway_schema_history;
DROP TABLE IF EXISTS public.copy;
DROP TABLE IF EXISTS public.book_setting;
DROP TABLE IF EXISTS public.book_genre;
DROP TABLE IF EXISTS public.book_author;
DROP TABLE IF EXISTS public.book;
DROP TABLE IF EXISTS public.author;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: author; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.author (
    id bigint NOT NULL,
    name text NOT NULL,
    gender text,
    country text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: author_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.author ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.author_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: book; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book (
    id bigint NOT NULL,
    title text NOT NULL,
    book_key text NOT NULL,
    year_published integer,
    pages integer,
    type text,
    audience text,
    language_written text,
    cover_color text,
    serial text,
    poc boolean DEFAULT false NOT NULL,
    lgbtqia boolean DEFAULT false NOT NULL,
    read_before_tracking boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT book_pages_check CHECK ((pages > 0))
);


--
-- Name: book_author; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book_author (
    book_id bigint NOT NULL,
    "position" integer NOT NULL,
    author_id bigint NOT NULL
);


--
-- Name: book_genre; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book_genre (
    book_id bigint NOT NULL,
    "position" integer NOT NULL,
    genre text NOT NULL
);


--
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.book ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.book_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: book_setting; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.book_setting (
    book_id bigint NOT NULL,
    "position" integer NOT NULL,
    setting text NOT NULL
);


--
-- Name: copy; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.copy (
    id bigint NOT NULL,
    book_id bigint NOT NULL,
    format text NOT NULL,
    price numeric(8,2),
    year_acquired integer,
    source text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT copy_format_check CHECK ((format = ANY (ARRAY['Physical'::text, 'Ebook'::text, 'Audiobook'::text]))),
    CONSTRAINT copy_price_check CHECK ((price >= (0)::numeric)),
    CONSTRAINT copy_price_physical_only CHECK (((price IS NULL) OR (format = 'Physical'::text))),
    CONSTRAINT copy_year_acquired_check CHECK (((year_acquired >= 1900) AND (year_acquired <= 2999)))
);


--
-- Name: copy_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.copy ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.copy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: flyway_schema_history; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);


--
-- Name: library_loan; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.library_loan (
    id bigint NOT NULL,
    book_id bigint NOT NULL,
    library text,
    date_due date NOT NULL,
    returned boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: library_loan_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.library_loan ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.library_loan_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: list_value; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.list_value (
    id bigint NOT NULL,
    category text NOT NULL,
    value text NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: list_value_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.list_value ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.list_value_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reading; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reading (
    id bigint NOT NULL,
    book_id bigint NOT NULL,
    date_started date,
    date_finished date,
    reading_year integer,
    month integer,
    pages_read integer,
    dnf boolean DEFAULT false NOT NULL,
    rating numeric(2,1),
    reread boolean DEFAULT false NOT NULL,
    language_read text,
    author_status text,
    acquired text,
    buzzword text,
    buzzword_cover text,
    bingo_prompt text,
    notes text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT reading_dates_ck CHECK (((date_started IS NULL) OR (date_finished IS NULL) OR (date_started <= date_finished))),
    CONSTRAINT reading_month_check CHECK (((month >= 1) AND (month <= 12))),
    CONSTRAINT reading_pages_read_check CHECK ((pages_read >= 0)),
    CONSTRAINT reading_rating_check CHECK ((((rating >= (0)::numeric) AND (rating <= (5)::numeric)) AND ((rating * (2)::numeric) = floor((rating * (2)::numeric))))),
    CONSTRAINT reading_reading_year_check CHECK (((reading_year >= 1900) AND (reading_year <= 2999)))
);


--
-- Name: reading_bookclub; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reading_bookclub (
    reading_id bigint NOT NULL,
    bookclub text NOT NULL
);


--
-- Name: reading_format; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reading_format (
    reading_id bigint NOT NULL,
    format text NOT NULL
);


--
-- Name: reading_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.reading ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.reading_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: reading_purpose; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reading_purpose (
    reading_id bigint NOT NULL,
    purpose text NOT NULL
);


--
-- Name: reading_readathon; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reading_readathon (
    reading_id bigint NOT NULL,
    readathon text NOT NULL
);


--
-- Name: reading_tbr_prompt; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.reading_tbr_prompt (
    reading_id bigint NOT NULL,
    prompt text NOT NULL
);


--
-- Name: series; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.series (
    id bigint NOT NULL,
    name text NOT NULL,
    dropped boolean DEFAULT false NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


--
-- Name: series_entry; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.series_entry (
    id bigint NOT NULL,
    series_id bigint NOT NULL,
    number numeric(6,2),
    book_id bigint,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    CONSTRAINT series_entry_number_check CHECK ((number >= (0)::numeric))
);


--
-- Name: series_entry_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.series_entry ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.series_entry_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: series_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.series ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.series_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: author; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.author (id, name, gender, country, created_at, updated_at) FROM stdin;
453	Tarryn Fisher	Female	USA	2026-10-10 09:49:27.377183+00	2026-10-10 09:49:27.670817+00
454	Taylor Adams	Male	USA	2026-10-10 09:49:27.692698+00	2026-10-10 09:49:27.703455+00
455	Colleen Hoover	Female	USA	2026-10-10 09:49:27.718587+00	2026-10-10 09:49:27.762458+00
456	Amie Kaufman	Female	Australia	2026-10-10 09:49:27.774731+00	2026-10-10 09:49:27.777947+00
457	Jay Kristoff	Male	Australia	2026-10-10 09:49:27.78242+00	2026-10-10 09:49:27.792761+00
458	Mira Grant	Female	USA	2026-10-10 09:49:27.807937+00	2026-10-10 09:49:27.852122+00
459	Jennifer Niven	Female	USA	2026-10-10 09:49:27.864841+00	2026-10-10 09:49:27.87974+00
460	Sarah J. Maas	Female	USA	2026-10-10 09:49:27.897462+00	2026-10-10 09:49:27.951122+00
461	Stephen Chbosky	Male	USA	2026-10-10 09:49:27.96487+00	2026-10-10 09:49:27.976585+00
462	K. A. Tucker	Female	Canada	2026-10-10 09:49:27.988144+00	2026-10-10 09:49:27.998925+00
463	C. J. Tudor	Female	The United Kingdom	2026-10-10 09:49:28.010586+00	2026-10-10 09:49:28.061876+00
464	Andrew David MacDonald	Male	Canada	2026-10-10 09:49:28.077936+00	2026-10-10 09:49:28.092148+00
465	Sabaa Tahir	Female	USA	2026-10-10 09:49:28.104353+00	2026-10-10 09:49:28.158835+00
466	Karen M. McManus	Female	USA	2026-10-10 09:49:28.175836+00	2026-10-10 09:49:28.1898+00
467	Sarah Pinborough	Female	The United Kingdom	2026-10-10 09:49:28.201189+00	2026-10-10 09:49:28.212203+00
468	J. A. Redmerski	Female	USA	2026-10-10 09:49:28.265202+00	2026-10-10 09:49:28.279131+00
469	Maggie Stiefvater	Female	USA	2026-10-10 09:49:28.294432+00	2026-10-10 09:49:28.311432+00
470	Kiley Reid	Female	USA	2026-10-10 09:49:28.351478+00	2026-10-10 09:49:28.364521+00
471	Sophie Hannah	Female	The United Kingdom	2026-10-10 09:49:28.375668+00	2026-10-10 09:49:28.3985+00
472	Peter Swanson	Male	USA	2026-10-10 09:49:28.460071+00	2026-10-10 09:49:28.471152+00
473	Zoje Stage	Female	USA	2026-10-10 09:49:28.483339+00	2026-10-10 09:49:28.493489+00
474	Samantha Hunt	Female	USA	2026-10-10 09:49:28.509059+00	2026-10-10 09:49:28.551599+00
475	Tanya Tagaq	Female	Canada	2026-10-10 09:49:28.564743+00	2026-10-10 09:49:28.578549+00
476	Stephen King	Male	USA	2026-10-10 09:49:28.594708+00	2026-10-10 09:49:28.652962+00
477	Adam Silvera	Male	USA	2026-10-10 09:49:28.666744+00	2026-10-10 09:49:28.670863+00
478	Becky Albertalli	Female	USA	2026-10-10 09:49:28.675342+00	2026-10-10 09:49:28.686825+00
479	V. E. Schwab	Female	USA	2026-10-10 09:49:28.750495+00	2026-10-10 09:49:28.76448+00
480	Elizabeth Little	Female	USA	2026-10-10 09:49:28.776163+00	2026-10-10 09:49:28.787475+00
481	Antoine de Saint Exupery	Male	France	2026-10-10 09:49:28.799296+00	2026-10-10 09:49:28.862157+00
482	M. L. Rio	Female	USA	2026-10-10 09:49:28.875318+00	2026-10-10 09:49:28.959352+00
483	Anna-Marie McLemore	Non-binary	USA	2026-10-10 09:49:28.970856+00	2026-10-10 09:49:28.982408+00
484	Madeline Miller	Female	USA	2026-10-10 09:49:28.993684+00	2026-10-10 09:49:29.050227+00
485	Margaret Rogerson	Female	USA	2026-10-10 09:49:29.06392+00	2026-10-10 09:49:29.075524+00
486	Greer Hendricks	Female	USA	2026-10-10 09:49:29.086818+00	2026-10-10 09:49:29.090139+00
487	Sarah Pekkanen	Female	USA	2026-10-10 09:49:29.096065+00	2026-10-10 09:49:29.157069+00
488	Ismee Amiel Williams	Female	USA	2026-10-10 09:49:29.172665+00	2026-10-10 09:49:29.191489+00
489	Kacen Callender	Non-binary	U.S. Virgin Islands	2026-10-10 09:49:29.210448+00	2026-10-10 09:49:29.257368+00
490	Sarah Gailey	Non-binary	USA	2026-10-10 09:49:29.27187+00	2026-10-10 09:49:29.291825+00
491	A. J. Finn	Male	USA	2026-10-10 09:49:29.350372+00	2026-10-10 09:49:29.363416+00
492	Elizabeth Acevedo	Female	USA	2026-10-10 09:49:29.381827+00	2026-10-10 09:49:29.459769+00
493	Lucy Foley	Female	The United Kingdom	2026-10-10 09:49:29.4826+00	2026-10-10 09:49:29.493774+00
494	Nic Stone	Female	USA	2026-10-10 09:49:29.504979+00	2026-10-10 09:49:29.559834+00
495	Mindy McGinnis	Female	USA	2026-10-10 09:49:29.571603+00	2026-10-10 09:49:29.651448+00
496	Brittney Morris	Female	USA	2026-10-10 09:49:29.668985+00	2026-10-10 09:49:29.67946+00
497	Rivers Solomon	Non-binary	USA	2026-10-10 09:49:29.690092+00	2026-10-10 09:49:29.70111+00
498	George M. Johnson	Non-binary	USA	2026-10-10 09:49:29.711531+00	2026-10-10 09:49:29.761317+00
499	Dean Atta	Male	The United Kingdom	2026-10-10 09:49:29.772371+00	2026-10-10 09:49:29.7831+00
500	Leah Johnson	Female	USA	2026-10-10 09:49:29.793471+00	2026-10-10 09:49:29.852519+00
501	B. A. Paris	Female	The United Kingdom	2026-10-10 09:49:29.864315+00	2026-10-10 09:49:29.876135+00
502	Emily Henry	Female	USA	2026-10-10 09:49:29.889338+00	2026-10-10 09:49:29.952047+00
503	Christina Lauren	Female	USA	2026-10-10 09:49:29.970136+00	2026-10-10 09:49:29.982408+00
504	Adiba Jaigirdar	Female	Bangladesh	2026-10-10 09:49:29.994015+00	2026-10-10 09:49:30.004934+00
1281	A. M. Shine	\N	\N	2026-10-11 15:09:45.08151+00	2026-10-11 15:09:45.08151+00
1282	Alex Finlay	\N	\N	2026-10-11 15:09:45.182829+00	2026-10-11 15:09:45.182829+00
1283	Ashley Flowers	\N	\N	2026-10-11 15:09:45.363327+00	2026-10-11 15:09:45.363327+00
1284	Clemence Michallon	\N	\N	2026-10-11 15:09:45.775409+00	2026-10-11 15:09:45.775409+00
1285	Edward Ashton	\N	\N	2026-10-11 15:09:45.879469+00	2026-10-11 15:09:45.879469+00
1286	Emma Donoghue	\N	\N	2026-10-11 15:09:46.083515+00	2026-10-11 15:09:46.083515+00
1287	Jennifer Hillier	\N	\N	2026-10-11 15:09:46.46455+00	2026-10-11 15:09:46.46455+00
1288	Kaliane Bradley	\N	\N	2026-10-11 15:09:46.771663+00	2026-10-11 15:09:46.771663+00
1289	Kate Goldbeck	\N	\N	2026-10-11 15:09:46.859164+00	2026-10-11 15:09:46.859164+00
1290	Kaylie Smith	\N	\N	2026-10-11 15:09:46.873143+00	2026-10-11 15:09:46.873143+00
1291	Keri Lake	\N	\N	2026-10-11 15:09:46.884862+00	2026-10-11 15:09:46.884862+00
1292	Louise Swanson	\N	\N	2026-10-11 15:09:46.968818+00	2026-10-11 15:09:46.968818+00
1293	Mariana Zapata	\N	\N	2026-10-11 15:09:47.059692+00	2026-10-11 15:09:47.059692+00
1294	Mary Kubica	\N	\N	2026-10-11 15:09:47.086158+00	2026-10-11 15:09:47.086158+00
1295	Meghan Quinn	\N	\N	2026-10-11 15:09:47.180435+00	2026-10-11 15:09:47.180435+00
1296	Monique Asher	\N	\N	2026-10-11 15:09:47.27512+00	2026-10-11 15:09:47.27512+00
1297	Nana Kwame Adjei-Brenyah	\N	\N	2026-10-11 15:09:47.364031+00	2026-10-11 15:09:47.364031+00
1298	Nicola Sanders	\N	\N	2026-10-11 15:09:47.378389+00	2026-10-11 15:09:47.378389+00
1299	Sarah Adler	\N	\N	2026-10-11 15:09:47.758774+00	2026-10-11 15:09:47.758774+00
1300	SenLinYu	\N	\N	2026-10-11 15:09:47.784244+00	2026-10-11 15:09:47.784244+00
1301	Stuart Turton	\N	\N	2026-10-11 15:09:48.271546+00	2026-10-11 15:09:48.271546+00
1302	Tarah DeWitt	\N	\N	2026-10-11 15:09:48.477653+00	2026-10-11 15:09:48.477653+00
1303	Matt Dinniman	\N	\N	2026-10-11 15:09:48.781392+00	2026-10-11 15:09:48.781392+00
1304	Jennifer Hartmann	\N	\N	2026-10-11 15:09:49.072849+00	2026-10-11 15:09:49.072849+00
1305	Cara Bastone	\N	\N	2026-10-11 15:09:49.376994+00	2026-10-11 15:09:49.376994+00
1306	Jessica Joyce	\N	\N	2026-10-11 15:09:49.481455+00	2026-10-11 15:09:49.481455+00
1307	Lyra Parish	\N	\N	2026-10-11 15:09:49.7618+00	2026-10-11 15:09:49.7618+00
1308	Sara Cate	\N	\N	2026-10-11 15:09:49.968149+00	2026-10-11 15:09:49.968149+00
1309	M. L. Wang	\N	\N	2026-10-11 15:09:50.466376+00	2026-10-11 15:09:50.466376+00
1310	Allie Oleander	\N	\N	2026-10-11 15:09:50.658603+00	2026-10-11 15:09:50.658603+00
1311	Sophie Stava	\N	\N	2026-10-11 15:09:50.684907+00	2026-10-11 15:09:50.684907+00
1312	Hanna Harp	\N	\N	2026-10-11 15:09:50.771824+00	2026-10-11 15:09:50.771824+00
1313	Tate James	\N	\N	2026-10-11 15:09:51.279977+00	2026-10-11 15:09:51.279977+00
1314	Kate Crew	\N	\N	2026-10-11 15:09:51.373034+00	2026-10-11 15:09:51.373034+00
1315	H. M. Wolfe	\N	\N	2026-10-11 15:09:51.772665+00	2026-10-11 15:09:51.772665+00
1316	Amber Tambglyn	\N	\N	2026-10-11 15:09:52.071691+00	2026-10-11 15:09:52.071691+00
1317	Leigh Rivers	\N	\N	2026-10-11 15:09:52.172823+00	2026-10-11 15:09:52.172823+00
1318	Victoria Wilder	\N	\N	2026-10-11 15:09:52.555714+00	2026-10-11 15:09:52.555714+00
1319	qntm	\N	\N	2026-10-11 15:09:52.667553+00	2026-10-11 15:09:52.667553+00
1320	Brittanee Nicole	\N	\N	2026-10-11 15:09:52.771217+00	2026-10-11 15:09:52.771217+00
1321	Mona Awad	\N	\N	2026-10-11 15:09:56.772257+00	2026-10-11 15:09:56.772257+00
1322	Cassandra Clare	\N	\N	2026-10-11 15:09:59.959481+00	2026-10-11 15:09:59.959481+00
1323	Gillian Flynn	\N	\N	2026-10-11 15:10:00.07361+00	2026-10-11 15:10:00.07361+00
1324	Meg Cabot	\N	\N	2026-10-11 15:10:00.66073+00	2026-10-11 15:10:00.66073+00
1325	Liu Cixin	\N	\N	2026-10-11 15:10:01.760382+00	2026-10-11 15:10:01.760382+00
1326	Marry Shelly	\N	\N	2026-10-11 15:10:03.863105+00	2026-10-11 15:10:03.863105+00
1327	Kiera Cass	\N	\N	2026-10-11 15:10:03.95989+00	2026-10-11 15:10:03.95989+00
1328	Jenny Han	\N	\N	2026-10-11 15:10:03.986161+00	2026-10-11 15:10:03.986161+00
1329	R. L. Stine	\N	\N	2026-10-11 15:10:04.381138+00	2026-10-11 15:10:04.381138+00
1330	Rory Power	\N	\N	2026-10-11 15:10:05.974042+00	2026-10-11 15:10:05.974042+00
1331	Ernest Cline	\N	\N	2026-10-11 15:10:06.074241+00	2026-10-11 15:10:06.074241+00
1332	Nicola Yoon	\N	\N	2026-10-11 15:10:06.159517+00	2026-10-11 15:10:06.159517+00
505	Helen FitzGerald	Female	The United Kingdom	2026-10-10 09:49:30.060016+00	2026-10-10 09:49:30.072652+00
506	Grady Hendrix	Male	USA	2026-10-10 09:49:30.157993+00	2026-10-10 09:49:30.169865+00
507	Ruth Ware	Female	The United Kingdom	2026-10-10 09:49:30.18116+00	2026-10-10 09:49:30.251038+00
508	Riley Sager	Male	USA	2026-10-10 09:49:30.265648+00	2026-10-10 09:49:30.279472+00
509	Tess Gerritsen	Female	USA	2026-10-10 09:49:30.292647+00	2026-10-10 09:49:30.364619+00
510	JoAnn Chaney	Female	USA	2026-10-10 09:49:30.375252+00	2026-10-10 09:49:30.455249+00
511	Seanan McGuire	Female	USA	2026-10-10 09:49:30.468513+00	2026-10-10 09:49:30.479776+00
512	Julie Clark	Female	USA	2026-10-10 09:49:30.490769+00	2026-10-10 09:49:30.559712+00
513	Silvia Moreno-Garcia	Female	Mexico	2026-10-10 09:49:30.578071+00	2026-10-10 09:49:30.588652+00
514	Stephenie Meyer	Female	USA	2026-10-10 09:49:30.600543+00	2026-10-10 09:49:30.667277+00
515	Ali Land	Female	The United Kingdom	2026-10-10 09:49:30.685029+00	2026-10-10 09:49:30.750603+00
516	Abigail Hing Wen	Female	USA	2026-10-10 09:49:30.762487+00	2026-10-10 09:49:30.773684+00
517	Kate Stayman-London	Female	USA	2026-10-10 09:49:30.783992+00	2026-10-10 09:49:30.855445+00
518	Sue Rainsford	Female	Ireland	2026-10-10 09:49:30.884143+00	2026-10-10 09:49:30.901664+00
519	Blake Crouch	Male	USA	2026-10-10 09:49:30.919481+00	2026-10-10 09:49:30.959152+00
520	Diana Urban	Female	USA	2026-10-10 09:49:30.969623+00	2026-10-10 09:49:30.987372+00
521	Ruta Sepetys	Female	USA	2026-10-10 09:49:31.00547+00	2026-10-10 09:49:31.055565+00
522	Ciara Smyth	Female	Ireland	2026-10-10 09:49:31.06753+00	2026-10-10 09:49:31.087106+00
523	Adam Cesare	Male	USA	2026-10-10 09:49:31.106082+00	2026-10-10 09:49:31.170194+00
524	Lyssa Kay Adams	Female	USA	2026-10-10 09:49:31.188076+00	2026-10-10 09:49:31.251651+00
525	Akwaeke Emezi	Non-binary	Nigeria	2026-10-10 09:49:31.263627+00	2026-10-10 09:49:31.276668+00
526	Kate Elizabeth Russell	Female	USA	2026-10-10 09:49:31.287737+00	2026-10-10 09:49:31.352196+00
527	Catherine Steadman	Female	The United Kingdom	2026-10-10 09:49:31.36349+00	2026-10-10 09:49:31.382139+00
528	Alex North	Male	The United Kingdom	2026-10-10 09:49:31.404239+00	2026-10-10 09:49:31.472333+00
529	Scott Thomas	Male	USA	2026-10-10 09:49:31.497347+00	2026-10-10 09:49:31.550987+00
530	Alyssa Cole	Female	USA	2026-10-10 09:49:31.563213+00	2026-10-10 09:49:31.575897+00
531	Andrea Tomić	Female	Croatia	2026-10-10 09:49:31.586567+00	2026-10-10 09:49:31.659454+00
532	Paul Tremblay	Male	USA	2026-10-10 09:49:31.679099+00	2026-10-10 09:49:31.699457+00
533	Josh Malerman	Male	USA	2026-10-10 09:49:31.763278+00	2026-10-10 09:49:31.776206+00
534	Simone St. James	Female	Canada	2026-10-10 09:49:31.787425+00	2026-10-10 09:49:31.851939+00
535	T. Kingfisher	Female	USA	2026-10-10 09:49:31.863839+00	2026-10-10 09:49:31.951862+00
536	Iain Reid	Male	Canada	2026-10-10 09:49:31.979031+00	2026-10-10 09:49:32.051234+00
537	Cora Carmack	Female	USA	2026-10-10 09:49:32.078586+00	2026-10-10 09:49:32.090636+00
538	Joe Hill	Male	USA	2026-10-10 09:49:32.101876+00	2026-10-10 09:49:32.113288+00
539	Sarah Morgan	Female	The United Kingdom	2026-10-10 09:49:32.162718+00	2026-10-10 09:49:32.177878+00
540	Carmen Maria Machado	Female	USA	2026-10-10 09:49:32.189747+00	2026-10-10 09:49:32.352286+00
541	Rosamund Lupton	Female	The United Kingdom	2026-10-10 09:49:32.366158+00	2026-10-10 09:49:32.379214+00
542	Katherine McGee	Female	USA	2026-10-10 09:49:32.390561+00	2026-10-10 09:49:32.457008+00
543	Alexandria Bellefleur	Female	USA	2026-10-10 09:49:32.46771+00	2026-10-10 09:49:32.479641+00
544	Fredrik Backman	Male	Sweden	2026-10-10 09:49:32.490938+00	2026-10-10 09:49:32.56313+00
545	Samuel Bjørk	Male	Norway	2026-10-10 09:49:32.582571+00	2026-10-10 09:49:32.604823+00
546	Stephanie Wrobel	Female	USA	2026-10-10 09:49:32.653155+00	2026-10-10 09:49:32.688315+00
547	Vlasta Golub	Female	Croatia	2026-10-10 09:49:32.772083+00	2026-10-10 09:49:32.80028+00
548	Rachel Lynn Solomon	Female	USA	2026-10-10 09:49:32.872082+00	2026-10-10 09:49:32.89445+00
549	Julia Heaberlin	Female	USA	2026-10-10 09:49:32.95865+00	2026-10-10 09:49:33.171993+00
550	Alister Hodge	Male	Australia	2026-10-10 09:49:33.303947+00	2026-10-10 09:49:33.318098+00
551	Helen Hoang	Female	USA	2026-10-10 09:49:33.333324+00	2026-10-10 09:49:33.364195+00
552	Taylor Jenkins Reid	Female	USA	2026-10-10 09:49:33.379032+00	2026-10-10 09:49:33.453148+00
553	Isabel Sterling	Female	USA	2026-10-10 09:49:33.466572+00	2026-10-10 09:49:33.65395+00
554	Nnedi Okorafor	Female	USA	2026-10-10 09:49:33.707091+00	2026-10-10 09:49:33.767074+00
555	Robinne Lee	Female	USA	2026-10-10 09:49:33.796359+00	2026-10-10 09:49:33.868321+00
556	Rebecca Roanhorse	Female	USA	2026-10-10 09:49:33.881251+00	2026-10-10 09:49:33.969328+00
557	Sally Thorne	Female	Australia	2026-10-10 09:49:33.992011+00	2026-10-10 09:49:34.069831+00
1333	Natascha Kampusch	\N	\N	2026-10-11 15:10:06.472847+00	2026-10-11 15:10:06.472847+00
1334	Ransom Riggs	\N	\N	2026-10-11 15:10:07.164527+00	2026-10-11 15:10:07.164527+00
1335	Susannah Cahalan	\N	\N	2026-10-11 15:10:07.470468+00	2026-10-11 15:10:07.470468+00
1336	Chuck Palahniuk	\N	\N	2026-10-11 15:10:08.263214+00	2026-10-11 15:10:08.263214+00
1337	Gemma Malley	\N	\N	2026-10-11 15:10:10.571758+00	2026-10-11 15:10:10.571758+00
1338	P. C. Cast	\N	\N	2026-10-11 15:10:11.285135+00	2026-10-11 15:10:11.285135+00
1339	Vladimir Nabokov	\N	\N	2026-10-11 15:10:11.460503+00	2026-10-11 15:10:11.460503+00
1340	Sharon Bolton	\N	\N	2026-10-11 15:10:11.565891+00	2026-10-11 15:10:11.565891+00
1341	Caroline Kepnes	\N	\N	2026-10-11 15:10:12.271562+00	2026-10-11 15:10:12.271562+00
1342	Imani Thompson	\N	\N	2026-10-11 15:10:12.655716+00	2026-10-11 15:10:12.655716+00
1343	Abbott Kahler	\N	\N	2026-10-11 15:10:12.763905+00	2026-10-11 15:10:12.763905+00
1344	Adam Kay	\N	\N	2026-10-11 15:10:12.789382+00	2026-10-11 15:10:12.789382+00
1345	Adam Plantinga	\N	\N	2026-10-11 15:10:12.795925+00	2026-10-11 15:10:12.795925+00
1346	Aisling Rawle	\N	\N	2026-10-11 15:10:12.80483+00	2026-10-11 15:10:12.80483+00
1347	Alex Aster	\N	\N	2026-10-11 15:10:12.813776+00	2026-10-11 15:10:12.813776+00
1348	Ali Brady	\N	\N	2026-10-11 15:10:12.847317+00	2026-10-11 15:10:12.847317+00
1349	Alicia Thompson	\N	\N	2026-10-11 15:10:12.874574+00	2026-10-11 15:10:12.874574+00
1350	Alison Gaylin	\N	\N	2026-10-11 15:10:12.894748+00	2026-10-11 15:10:12.894748+00
1351	Allie Reynolds	\N	\N	2026-10-11 15:10:12.904088+00	2026-10-11 15:10:12.904088+00
1352	Amanda Jayatissa	\N	\N	2026-10-11 15:10:12.924712+00	2026-10-11 15:10:12.924712+00
1353	Amber Tamblyn	\N	\N	2026-10-11 15:10:12.934157+00	2026-10-11 15:10:12.934157+00
1354	Amy K. Green	\N	\N	2026-10-11 15:10:12.94083+00	2026-10-11 15:10:12.94083+00
1355	Amy Taylor	\N	\N	2026-10-11 15:10:12.957621+00	2026-10-11 15:10:12.957621+00
1356	Andie Burke	\N	\N	2026-10-11 15:10:12.964484+00	2026-10-11 15:10:12.964484+00
1357	Andrea Bartz	\N	\N	2026-10-11 15:10:12.978321+00	2026-10-11 15:10:12.978321+00
1358	Andrew Joseph White	\N	\N	2026-10-11 15:10:12.985461+00	2026-10-11 15:10:12.985461+00
1359	Andy Marino	\N	\N	2026-10-11 15:10:12.995214+00	2026-10-11 15:10:12.995214+00
1360	Anise Starre	\N	\N	2026-10-11 15:10:13.003529+00	2026-10-11 15:10:13.003529+00
1361	Annie McQuaid	\N	\N	2026-10-11 15:10:13.010675+00	2026-10-11 15:10:13.010675+00
1362	Ariel Sullivan	\N	\N	2026-10-11 15:10:13.017545+00	2026-10-11 15:10:13.017545+00
1363	Aura Hayes	\N	\N	2026-10-11 15:10:13.041234+00	2026-10-11 15:10:13.041234+00
1364	Emily Wibberly	\N	\N	2026-10-11 15:10:13.04877+00	2026-10-11 15:10:13.04877+00
1365	Avril Ashton	\N	\N	2026-10-11 15:10:13.057136+00	2026-10-11 15:10:13.057136+00
1366	Ayana Gray	\N	\N	2026-10-11 15:10:13.065065+00	2026-10-11 15:10:13.065065+00
1367	Bailey Seybolt	\N	\N	2026-10-11 15:10:13.087964+00	2026-10-11 15:10:13.087964+00
1368	Beatriz Serrano	\N	\N	2026-10-11 15:10:13.100813+00	2026-10-11 15:10:13.100813+00
1369	Bellamy Rose	\N	\N	2026-10-11 15:10:13.127646+00	2026-10-11 15:10:13.127646+00
1370	Bonnie Woods	\N	\N	2026-10-11 15:10:13.167366+00	2026-10-11 15:10:13.167366+00
1371	Brian Asman	\N	\N	2026-10-11 15:10:13.176988+00	2026-10-11 15:10:13.176988+00
1372	Brigitte Knightley	\N	\N	2026-10-11 15:10:13.18991+00	2026-10-11 15:10:13.18991+00
1373	Britney S. Lewis	\N	\N	2026-10-11 15:10:13.199057+00	2026-10-11 15:10:13.199057+00
1374	Brom	\N	\N	2026-10-11 15:10:13.208189+00	2026-10-11 15:10:13.208189+00
1375	C. J. Dotson	\N	\N	2026-10-11 15:10:13.224441+00	2026-10-11 15:10:13.224441+00
1376	Caitlin Starling	\N	\N	2026-10-11 15:10:13.233923+00	2026-10-11 15:10:13.233923+00
1377	Camilla Bruce	\N	\N	2026-10-11 15:10:13.248727+00	2026-10-11 15:10:13.248727+00
1378	Cara Tanamachi	\N	\N	2026-10-11 15:10:13.267145+00	2026-10-11 15:10:13.267145+00
1379	Carinn Jade	\N	\N	2026-10-11 15:10:13.285791+00	2026-10-11 15:10:13.285791+00
1380	Carlie Walker	\N	\N	2026-10-11 15:10:13.3012+00	2026-10-11 15:10:13.3012+00
1381	Caro Carver	\N	\N	2026-10-11 15:10:13.311792+00	2026-10-11 15:10:13.311792+00
1382	Carole Johnstone	\N	\N	2026-10-11 15:10:13.321372+00	2026-10-11 15:10:13.321372+00
1383	Cassandra Celia	\N	\N	2026-10-11 15:10:13.328046+00	2026-10-11 15:10:13.328046+00
558	John Boyne	Male	Ireland	2026-10-10 09:49:34.082051+00	2026-10-10 09:49:34.176332+00
559	Sarah J. Harris	Female	The United Kingdom	2026-10-10 09:49:34.276065+00	2026-10-10 09:49:34.29141+00
560	Richard Osman	Male	The United Kingdom	2026-10-10 09:49:34.303779+00	2026-10-10 09:49:34.363158+00
561	Camilla Läckberg	Female	Sweden	2026-10-10 09:49:34.375409+00	2026-10-10 09:49:34.473308+00
562	Layne Fargo	Female	USA	2026-10-10 09:49:34.555708+00	2026-10-10 09:49:34.569536+00
563	Matea Čvagić Prašnjak	Female	Croatia	2026-10-10 09:49:34.585966+00	2026-10-10 09:49:34.652419+00
564	Lucinda Berry	Female	USA	2026-10-10 09:49:34.675956+00	2026-10-10 09:49:34.711148+00
565	Lauren Oliver	Female	USA	2026-10-10 09:49:34.7661+00	2026-10-10 09:49:34.794108+00
566	Ashley Audrain	Female	Canada	2026-10-10 09:49:34.807707+00	2026-10-10 09:49:34.88625+00
567	Niccolò Ammaniti	Male	Italy	2026-10-10 09:49:34.997799+00	2026-10-10 09:49:35.099771+00
568	Elena Ferrante	Female	Italy	2026-10-10 09:49:35.13517+00	2026-10-10 09:49:35.253051+00
569	John Fram	Male	USA	2026-10-10 09:49:35.493341+00	2026-10-10 09:49:35.509262+00
570	Aiden Thomas	Male	USA	2026-10-10 09:49:35.521005+00	2026-10-10 09:49:35.563993+00
571	Francesc Miralles	Male	Spain	2026-10-10 09:49:35.589265+00	2026-10-10 09:49:35.654364+00
572	Sara Dobie Bauer	Female	USA	2026-10-10 09:49:35.666001+00	2026-10-10 09:49:35.680101+00
573	Julia Quinn	Female	USA	2026-10-10 09:49:35.69268+00	2026-10-10 09:49:35.761464+00
574	Claire Legrand	Female	USA	2026-10-10 09:49:35.775312+00	2026-10-10 09:49:35.856785+00
575	John Marrs	Male	The United Kingdom	2026-10-10 09:49:35.875831+00	2026-10-10 09:49:35.951184+00
576	Sally Hepworth	Female	Australia	2026-10-10 09:49:35.963732+00	2026-10-10 09:49:35.979128+00
577	Philippe Besson	Male	France	2026-10-10 09:49:35.991116+00	2026-10-10 09:49:36.162689+00
578	Stephen Graham Jones	Male	USA	2026-10-10 09:49:36.219969+00	2026-10-10 09:49:36.451892+00
579	Casey McQuiston	Non-binary	USA	2026-10-10 09:49:36.508889+00	2026-10-10 09:49:36.550692+00
580	Marie Lu	Female	USA	2026-10-10 09:49:36.567948+00	2026-10-10 09:49:36.58967+00
581	Elle Cosimano	Female	USA	2026-10-10 09:49:36.651993+00	2026-10-10 09:49:36.667909+00
582	Beth O'Leary	Female	The United Kingdom	2026-10-10 09:49:36.679343+00	2026-10-10 09:49:36.751253+00
583	Rosie Danan	Female	USA	2026-10-10 09:49:36.763011+00	2026-10-10 09:49:36.786207+00
584	Jelena Hrvoj	Female	Croatia	2026-10-10 09:49:36.805913+00	2026-10-10 09:49:36.861452+00
585	Ryan Douglass	Male	USA	2026-10-10 09:49:36.873623+00	2026-10-10 09:49:36.958921+00
586	Penelope Douglas	Female	USA	2026-10-10 09:49:36.981603+00	2026-10-10 09:49:37.05236+00
587	Jennifer McMahon	Female	USA	2026-10-10 09:49:37.071668+00	2026-10-10 09:49:37.086141+00
588	Becky Chambers	Female	USA	2026-10-10 09:49:37.097706+00	2026-10-10 09:49:37.172119+00
589	S. T. Abby	Female	USA	2026-10-10 09:49:37.263314+00	2026-10-10 09:49:37.279009+00
590	Dinko Mihovilović	Male	Croatia	2026-10-10 09:49:37.290346+00	2026-10-10 09:49:37.362418+00
591	Eric LaRocca	Non-binary	USA	2026-10-10 09:49:37.378989+00	2026-10-10 09:49:37.450372+00
592	Samanta Schweblin	Female	Argentina	2026-10-10 09:49:37.466625+00	2026-10-10 09:49:37.551724+00
593	Talia Hibbert	Female	The United Kingdom	2026-10-10 09:49:37.577491+00	2026-10-10 09:49:37.59093+00
594	Heather Morris	Female	New Zealand	2026-10-10 09:49:37.60703+00	2026-10-10 09:49:37.671446+00
595	Hye Young Pyun	Female	South Korea	2026-10-10 09:49:37.696615+00	2026-10-10 09:49:37.853246+00
596	Sarah Pearse	Female	The United Kingdom	2026-10-10 09:49:37.882483+00	2026-10-10 09:49:37.961635+00
597	Jonathan Parks-Ramage	Male	USA	2026-10-10 09:49:37.97302+00	2026-10-10 09:49:38.052143+00
598	Lesley Kara	Female	The United Kingdom	2026-10-10 09:49:38.064071+00	2026-10-10 09:49:38.077367+00
599	Laura Purcell	Female	The United Kingdom	2026-10-10 09:49:38.088349+00	2026-10-10 09:49:38.169135+00
600	Andy Weir	Male	USA	2026-10-10 09:49:38.186849+00	2026-10-10 09:49:38.261566+00
601	J. P. Delaney	Male	The United Kingdom	2026-10-10 09:49:38.277641+00	2026-10-10 09:49:38.353505+00
602	Alex Michaelides	Male	Cyprus	2026-10-10 09:49:38.365664+00	2026-10-10 09:49:38.37983+00
603	Ane Riel	Female	Denmark	2026-10-10 09:49:38.390701+00	2026-10-10 09:49:38.46101+00
604	Jasper DeWitt	Male	USA	2026-10-10 09:49:38.476124+00	2026-10-10 09:49:38.551072+00
605	Kiersten Modglin	Female	USA	2026-10-10 09:49:38.563009+00	2026-10-10 09:49:38.582872+00
606	Ashley Winstead	Female	USA	2026-10-10 09:49:38.601213+00	2026-10-10 09:49:38.664193+00
607	Sebastian Fitzek	Male	Germany	2026-10-10 09:49:38.676353+00	2026-10-10 09:49:38.760508+00
608	Grace Draven	Female	USA	2026-10-10 09:49:38.777561+00	2026-10-10 09:49:38.851837+00
609	Krystal Sutherland	Female	Australia	2026-10-10 09:49:38.863859+00	2026-10-10 09:49:38.880117+00
610	Alice Feeney	Female	The United Kingdom	2026-10-10 09:49:38.953336+00	2026-10-10 09:49:38.968875+00
1384	Cate Quinn	\N	\N	2026-10-11 15:10:13.335164+00	2026-10-11 15:10:13.335164+00
1385	Catherine Mack	\N	\N	2026-10-11 15:10:13.342153+00	2026-10-11 15:10:13.342153+00
1386	Chad Lutzke	\N	\N	2026-10-11 15:10:13.378395+00	2026-10-11 15:10:13.378395+00
1387	John Boden	\N	\N	2026-10-11 15:10:13.38047+00	2026-10-11 15:10:13.38047+00
1388	Charlotte McConaghy	\N	\N	2026-10-11 15:10:13.387066+00	2026-10-11 15:10:13.387066+00
1389	Chelsea Conradt	\N	\N	2026-10-11 15:10:13.396072+00	2026-10-11 15:10:13.396072+00
1390	Cheon Seon-Ran	\N	\N	2026-10-11 15:10:13.402624+00	2026-10-11 15:10:13.402624+00
1391	Chris Butera	\N	\N	2026-10-11 15:10:13.415819+00	2026-10-11 15:10:13.415819+00
1392	Claire Kann	\N	\N	2026-10-11 15:10:13.453743+00	2026-10-11 15:10:13.453743+00
1393	Collin Armstrong	\N	\N	2026-10-11 15:10:13.479138+00	2026-10-11 15:10:13.479138+00
1394	Daisy Pearce	\N	\N	2026-10-11 15:10:13.49222+00	2026-10-11 15:10:13.49222+00
1395	Danica Nava	\N	\N	2026-10-11 15:10:13.498688+00	2026-10-11 15:10:13.498688+00
1396	Danielle Lori	\N	\N	2026-10-11 15:10:13.505449+00	2026-10-11 15:10:13.505449+00
1397	Danielle Valentine	\N	\N	2026-10-11 15:10:13.511988+00	2026-10-11 15:10:13.511988+00
1398	Daphne Woolsoncroft	\N	\N	2026-10-11 15:10:13.518602+00	2026-10-11 15:10:13.518602+00
1399	Daria Lavelle	\N	\N	2026-10-11 15:10:13.545655+00	2026-10-11 15:10:13.545655+00
1400	David Barnett	\N	\N	2026-10-11 15:10:13.558932+00	2026-10-11 15:10:13.558932+00
1401	Deanna Raybourn	\N	\N	2026-10-11 15:10:13.579606+00	2026-10-11 15:10:13.579606+00
1402	Elaine Castillo	\N	\N	2026-10-11 15:10:13.599926+00	2026-10-11 15:10:13.599926+00
1403	Ellen O'Clover	\N	\N	2026-10-11 15:10:13.606917+00	2026-10-11 15:10:13.606917+00
1404	Ellery Lloyd	\N	\N	2026-10-11 15:10:13.613172+00	2026-10-11 15:10:13.613172+00
1405	Ellie Palmer	\N	\N	2026-10-11 15:10:13.619533+00	2026-10-11 15:10:13.619533+00
1406	Emily Stone	\N	\N	2026-10-11 15:10:13.652815+00	2026-10-11 15:10:13.652815+00
1407	Emma C. Wells	\N	\N	2026-10-11 15:10:13.659451+00	2026-10-11 15:10:13.659451+00
1408	Erin Branscom	\N	\N	2026-10-11 15:10:13.673053+00	2026-10-11 15:10:13.673053+00
1409	Erin Connor	\N	\N	2026-10-11 15:10:13.679352+00	2026-10-11 15:10:13.679352+00
1410	Eva Marks	\N	\N	2026-10-11 15:10:13.68637+00	2026-10-11 15:10:13.68637+00
1411	Francesca Serritella	\N	\N	2026-10-11 15:10:13.699727+00	2026-10-11 15:10:13.699727+00
1412	Gabriella Gamez	\N	\N	2026-10-11 15:10:13.711548+00	2026-10-11 15:10:13.711548+00
1413	Grace Walker	\N	\N	2026-10-11 15:10:13.7284+00	2026-10-11 15:10:13.7284+00
1414	Gwendolyn Kiste	\N	\N	2026-10-11 15:10:13.748642+00	2026-10-11 15:10:13.748642+00
1415	H.D. Carlton	\N	\N	2026-10-11 15:10:13.755249+00	2026-10-11 15:10:13.755249+00
1416	Hannah Jay	\N	\N	2026-10-11 15:10:13.791508+00	2026-10-11 15:10:13.791508+00
1417	Hannah Orenstein	\N	\N	2026-10-11 15:10:13.798583+00	2026-10-11 15:10:13.798583+00
1418	Hannah Richell	\N	\N	2026-10-11 15:10:13.80523+00	2026-10-11 15:10:13.80523+00
1419	Hiron Ennes	\N	\N	2026-10-11 15:10:13.811786+00	2026-10-11 15:10:13.811786+00
1420	J.D. Barker	\N	\N	2026-10-11 15:10:13.838058+00	2026-10-11 15:10:13.838058+00
1421	J. F. Gonzalez	\N	\N	2026-10-11 15:10:13.844689+00	2026-10-11 15:10:13.844689+00
1422	J.J. Arias	\N	\N	2026-10-11 15:10:13.851074+00	2026-10-11 15:10:13.851074+00
1423	J. T. Geissinger	\N	\N	2026-10-11 15:10:13.857567+00	2026-10-11 15:10:13.857567+00
1424	James Islington	\N	\N	2026-10-11 15:10:13.864215+00	2026-10-11 15:10:13.864215+00
1425	Janelle Brown	\N	\N	2026-10-11 15:10:13.875178+00	2026-10-11 15:10:13.875178+00
1426	Jasmine Guillory	\N	\N	2026-10-11 15:10:13.883684+00	2026-10-11 15:10:13.883684+00
1427	Jason Rekulak	\N	\N	2026-10-11 15:10:13.89281+00	2026-10-11 15:10:13.89281+00
1428	Jen Beagin	\N	\N	2026-10-11 15:10:13.899339+00	2026-10-11 15:10:13.899339+00
1429	Jen DeLuca	\N	\N	2026-10-11 15:10:13.906356+00	2026-10-11 15:10:13.906356+00
1430	Jennifer Fawcett	\N	\N	2026-10-11 15:10:13.934856+00	2026-10-11 15:10:13.934856+00
1431	Jenny Bayliss	\N	\N	2026-10-11 15:10:13.959801+00	2026-10-11 15:10:13.959801+00
1432	Jessica Gross	\N	\N	2026-10-11 15:10:13.97569+00	2026-10-11 15:10:13.97569+00
1433	Jessie Q. Sutanto	\N	\N	2026-10-11 15:10:13.9896+00	2026-10-11 15:10:13.9896+00
611	Catherine Ryan Howard	Female	Ireland	2026-10-10 09:49:38.983204+00	2026-10-10 09:49:39.062802+00
612	Mana Pass	Female	Croatia	2026-10-10 09:49:39.073858+00	2026-10-10 09:49:39.153263+00
613	Ali Hazelwood	Female	Italy	2026-10-10 09:49:39.168624+00	2026-10-10 09:49:39.182211+00
614	Samantha Downing	Female	USA	2026-10-10 09:49:39.192988+00	2026-10-10 09:49:39.26314+00
615	T. J. Newman	Female	USA	2026-10-10 09:49:39.275528+00	2026-10-10 09:49:39.352427+00
616	Karin Slaughter	Female	USA	2026-10-10 09:49:39.364176+00	2026-10-10 09:49:39.461524+00
617	Christina Henry	Female	USA	2026-10-10 09:49:39.48547+00	2026-10-10 09:49:39.553764+00
618	Darcy Coates	Female	Australia	2026-10-10 09:49:39.566028+00	2026-10-10 09:49:39.653293+00
619	J.R. Ward	Female	USA	2026-10-10 09:49:39.665027+00	2026-10-10 09:49:39.683027+00
620	Rachel Hawkins	Female	USA	2026-10-10 09:49:39.750875+00	2026-10-10 09:49:39.772676+00
621	Catriona Ward	Female	The United Kingdom	2026-10-10 09:49:39.784585+00	2026-10-10 09:49:39.865702+00
622	Tessa Bailey	Female	USA	2026-10-10 09:49:39.881301+00	2026-10-10 09:49:39.956633+00
623	Dana Isaly	Female	USA	2026-10-10 09:49:39.969114+00	2026-10-10 09:49:40.07198+00
624	Felix Blackwell	Male	USA	2026-10-10 09:49:40.098123+00	2026-10-10 09:49:40.178613+00
625	Linwood Barclay	Male	Canada	2026-10-10 09:49:40.268237+00	2026-10-10 09:49:40.353988+00
626	Nita Prose	Female	Canada	2026-10-10 09:49:40.369252+00	2026-10-10 09:49:40.464671+00
627	Scott Carson	Male	USA	2026-10-10 09:49:40.483423+00	2026-10-10 09:49:40.56566+00
628	Ruby Dixon	Female	USA	2026-10-10 09:49:40.579189+00	2026-10-10 09:49:40.666614+00
629	Catherynne M. Valente	Female	USA	2026-10-10 09:49:40.682908+00	2026-10-10 09:49:40.862513+00
630	Kimi Cunningham Grant	Female	USA	2026-10-10 09:49:40.891206+00	2026-10-10 09:49:41.250795+00
631	S. A. Barnes	Female	USA	2026-10-10 09:49:41.30859+00	2026-10-10 09:49:41.32249+00
632	Molly Doyle	Female	USA	2026-10-10 09:49:41.337989+00	2026-10-10 09:49:41.478713+00
633	TJ Alexander	Non-binary	USA	2026-10-10 09:49:41.572426+00	2026-10-10 09:49:41.652421+00
634	Kiersten White	Female	USA	2026-10-10 09:49:41.66588+00	2026-10-10 09:49:41.761013+00
635	S. J. Watson	Male	The United Kingdom	2026-10-10 09:49:41.775064+00	2026-10-10 09:49:41.864309+00
636	Dot Hutchison	Female	USA	2026-10-10 09:49:41.883156+00	2026-10-10 09:49:42.062988+00
637	P. J. Vernon	Male	USA	2026-10-10 09:49:42.095097+00	2026-10-10 09:49:42.169153+00
638	Nick Cutter	Male	Canada	2026-10-10 09:49:42.186929+00	2026-10-10 09:49:42.256187+00
639	Jeremy Ray	Male	USA	2026-10-10 09:49:42.272518+00	2026-10-10 09:49:42.355593+00
640	Georgia Hunter	Female	USA	2026-10-10 09:49:42.368201+00	2026-10-10 09:49:42.477073+00
641	Samantha Allen	Non-binary	USA	2026-10-10 09:49:42.555863+00	2026-10-10 09:49:42.656162+00
642	Bora Chung	Female	South Korea	2026-10-10 09:49:42.761747+00	2026-10-10 09:49:42.880523+00
643	Laurel Hightower	Female	USA	2026-10-10 09:49:42.974285+00	2026-10-10 09:49:43.071864+00
644	Stacy Willingham	Female	USA	2026-10-10 09:49:43.093999+00	2026-10-10 09:49:43.170584+00
645	Max Booth III	Male	USA	2026-10-10 09:49:43.182936+00	2026-10-10 09:49:43.266778+00
646	Alison Cochrun	Female	USA	2026-10-10 09:49:43.279427+00	2026-10-10 09:49:43.363212+00
647	Sergio Gomez	Male	Mexico	2026-10-10 09:49:43.376827+00	2026-10-10 09:49:43.568552+00
648	Claudia Lux	Female	USA	2026-10-10 09:49:43.603981+00	2026-10-10 09:49:43.751218+00
649	Jennifer Hilier	Female	Canada	2026-10-10 09:49:43.773292+00	2026-10-10 09:49:43.850874+00
650	Malcolm Devlin	Male	The United Kingdom	2026-10-10 09:49:43.866743+00	2026-10-10 09:49:43.882102+00
651	Vladimira Becić	Female	Croatia	2026-10-10 09:49:43.894912+00	2026-10-10 09:49:43.975803+00
652	L. J. Shen	Female	Israel	2026-10-10 09:49:44.058428+00	2026-10-10 09:49:44.074413+00
653	Brandon Massey	Male	USA	2026-10-10 09:49:44.085623+00	2026-10-10 09:49:44.252603+00
654	Kanae Minato	Female	Japan	2026-10-10 09:49:44.285087+00	2026-10-10 09:49:44.301289+00
655	Nino Cipri	Non-binary	USA	2026-10-10 09:49:44.359779+00	2026-10-10 09:49:44.46+00
656	Mark Edwards	Male	The United Kingdom	2026-10-10 09:49:44.47316+00	2026-10-10 09:49:44.571528+00
657	Johnny Compton	Male	USA	2026-10-10 09:49:44.667738+00	2026-10-10 09:49:44.753015+00
658	Julia Bartz	Female	USA	2026-10-10 09:49:44.781042+00	2026-10-10 09:49:44.852724+00
659	Shari Lapena	Female	Canada	2026-10-10 09:49:44.869569+00	2026-10-10 09:49:44.88541+00
660	Amy Lea	Female	Canada	2026-10-10 09:49:44.897836+00	2026-10-10 09:49:44.968538+00
661	Celia Laskey	Female	USA	2026-10-10 09:49:44.983332+00	2026-10-10 09:49:45.067155+00
662	Calvin Kasulke	Male	USA	2026-10-10 09:49:45.078375+00	2026-10-10 09:49:45.172815+00
663	Kate Alice Marshall	Female	USA	2026-10-10 09:49:45.191289+00	2026-10-10 09:49:45.27317+00
664	A. R. Torre	Female	USA	2026-10-10 09:49:45.353221+00	2026-10-10 09:49:45.371057+00
1434	Jillian Cantor	\N	\N	2026-10-11 15:10:14.005363+00	2026-10-11 15:10:14.005363+00
1435	Jillian Meadows	\N	\N	2026-10-11 15:10:14.012681+00	2026-10-11 15:10:14.012681+00
1436	Jodi McAlister	\N	\N	2026-10-11 15:10:14.020235+00	2026-10-11 15:10:14.020235+00
1437	John Darnielle	\N	\N	2026-10-11 15:10:14.036251+00	2026-10-11 15:10:14.036251+00
1438	Josh Winning	\N	\N	2026-10-11 15:10:14.074653+00	2026-10-11 15:10:14.074653+00
1439	Joss Richard	\N	\N	2026-10-11 15:10:14.085755+00	2026-10-11 15:10:14.085755+00
1440	Judith Sonnet	\N	\N	2026-10-11 15:10:14.095207+00	2026-10-11 15:10:14.095207+00
1441	Julia McKay	\N	\N	2026-10-11 15:10:14.101892+00	2026-10-11 15:10:14.101892+00
1442	Julie Soto	\N	\N	2026-10-11 15:10:14.112827+00	2026-10-11 15:10:14.112827+00
1443	Kali Wallace	\N	\N	2026-10-11 15:10:14.125886+00	2026-10-11 15:10:14.125886+00
1444	Karen Dukess	\N	\N	2026-10-11 15:10:14.139545+00	2026-10-11 15:10:14.139545+00
1445	Karina Halle	\N	\N	2026-10-11 15:10:14.148857+00	2026-10-11 15:10:14.148857+00
1446	Kat Singleton	\N	\N	2026-10-11 15:10:14.157675+00	2026-10-11 15:10:14.157675+00
1447	Kate Posey	\N	\N	2026-10-11 15:10:14.187249+00	2026-10-11 15:10:14.187249+00
1448	Katee Robert	\N	\N	2026-10-11 15:10:14.203129+00	2026-10-11 15:10:14.203129+00
1449	Kath Richards	\N	\N	2026-10-11 15:10:14.20989+00	2026-10-11 15:10:14.20989+00
1450	Katherine Center	\N	\N	2026-10-11 15:10:14.216749+00	2026-10-11 15:10:14.216749+00
1451	Katie bishop	\N	\N	2026-10-11 15:10:14.22648+00	2026-10-11 15:10:14.22648+00
1452	Katrina Kwan	\N	\N	2026-10-11 15:10:14.233352+00	2026-10-11 15:10:14.233352+00
1453	Kelsey Cox	\N	\N	2026-10-11 15:10:14.2538+00	2026-10-11 15:10:14.2538+00
1454	Ken Liu	\N	\N	2026-10-11 15:10:14.260741+00	2026-10-11 15:10:14.260741+00
1455	Kerry Cullen	\N	\N	2026-10-11 15:10:14.270455+00	2026-10-11 15:10:14.270455+00
1456	Kimberly Lemming	\N	\N	2026-10-11 15:10:14.283847+00	2026-10-11 15:10:14.283847+00
1457	Koushun Takami	\N	\N	2026-10-11 15:10:14.295772+00	2026-10-11 15:10:14.295772+00
1458	Kristen Bailey	\N	\N	2026-10-11 15:10:14.302685+00	2026-10-11 15:10:14.302685+00
1459	Kristen Perrin	\N	\N	2026-10-11 15:10:14.309168+00	2026-10-11 15:10:14.309168+00
1460	Kristina Forest	\N	\N	2026-10-11 15:10:14.318451+00	2026-10-11 15:10:14.318451+00
1461	LaTanya McQueen	\N	\N	2026-10-11 15:10:14.347591+00	2026-10-11 15:10:14.347591+00
1462	Laura Bishop	\N	\N	2026-10-11 15:10:14.356163+00	2026-10-11 15:10:14.356163+00
1463	Laura Hankin	\N	\N	2026-10-11 15:10:14.362513+00	2026-10-11 15:10:14.362513+00
1464	Leah Konen	\N	\N	2026-10-11 15:10:14.375184+00	2026-10-11 15:10:14.375184+00
1465	Leanne Shapton	\N	\N	2026-10-11 15:10:14.383998+00	2026-10-11 15:10:14.383998+00
1466	Leigh Radford	\N	\N	2026-10-11 15:10:14.390402+00	2026-10-11 15:10:14.390402+00
1467	Leigh Stein	\N	\N	2026-10-11 15:10:14.403748+00	2026-10-11 15:10:14.403748+00
1468	Libba Bray	\N	\N	2026-10-11 15:10:14.410218+00	2026-10-11 15:10:14.410218+00
1469	Lily Gold	\N	\N	2026-10-11 15:10:14.419663+00	2026-10-11 15:10:14.419663+00
1470	Lindsay Merbaum	\N	\N	2026-10-11 15:10:14.427048+00	2026-10-11 15:10:14.427048+00
1471	Lindsey Kelk	\N	\N	2026-10-11 15:10:14.434024+00	2026-10-11 15:10:14.434024+00
1472	Lisa Brideau	\N	\N	2026-10-11 15:10:14.440399+00	2026-10-11 15:10:14.440399+00
1473	Liz Moore	\N	\N	2026-10-11 15:10:14.465863+00	2026-10-11 15:10:14.465863+00
1474	Lucy Lehane	\N	\N	2026-10-11 15:10:14.495605+00	2026-10-11 15:10:14.495605+00
1475	Lucy Score	\N	\N	2026-10-11 15:10:14.502355+00	2026-10-11 15:10:14.502355+00
1476	Lyla Lee	\N	\N	2026-10-11 15:10:14.50922+00	2026-10-11 15:10:14.50922+00
1477	Madeline Ashby	\N	\N	2026-10-11 15:10:14.524631+00	2026-10-11 15:10:14.524631+00
1478	Mads Rafferty	\N	\N	2026-10-11 15:10:14.531066+00	2026-10-11 15:10:14.531066+00
1479	Maggie C. Gates	\N	\N	2026-10-11 15:10:14.537576+00	2026-10-11 15:10:14.537576+00
1480	Maggie North	\N	\N	2026-10-11 15:10:14.544634+00	2026-10-11 15:10:14.544634+00
1481	Maggie Su	\N	\N	2026-10-11 15:10:14.551575+00	2026-10-11 15:10:14.551575+00
1482	Maika Moulite	\N	\N	2026-10-11 15:10:14.560142+00	2026-10-11 15:10:14.560142+00
1483	Maritza Moulite	\N	\N	2026-10-11 15:10:14.562856+00	2026-10-11 15:10:14.562856+00
1484	Mallory Marlowe	\N	\N	2026-10-11 15:10:14.569349+00	2026-10-11 15:10:14.569349+00
665	Emily Carpenter	Female	USA	2026-10-10 09:49:45.386689+00	2026-10-10 09:49:45.460886+00
666	Clay McLeod Chapman	Male	USA	2026-10-10 09:49:45.47453+00	2026-10-10 09:49:45.56418+00
667	N. G. Peltier	Female	Trinidad and Tobago	2026-10-10 09:49:45.588592+00	2026-10-10 09:49:45.853531+00
668	Lisa Jewell	Female	The United Kingdom	2026-10-10 09:49:45.906134+00	2026-10-10 09:49:45.974231+00
669	Helene Tursten	Female	Sweden	2026-10-10 09:49:46.051613+00	2026-10-10 09:49:46.276232+00
670	Anita Kelly	Female	USA	2026-10-10 09:49:46.397327+00	2026-10-10 09:49:46.461586+00
671	Chevy Stevens	Female	Canada	2026-10-10 09:49:46.480592+00	2026-10-10 09:49:46.570693+00
672	C.J. Leede	Female	USA	2026-10-10 09:49:46.654255+00	2026-10-10 09:49:46.752829+00
673	Sarah Adams	Female	USA	2026-10-10 09:49:46.775134+00	2026-10-10 09:49:46.862631+00
674	Chelsea G. Summers	Female	USA	2026-10-10 09:49:46.881779+00	2026-10-10 09:49:47.065887+00
675	Angie Hockman	Female	USA	2026-10-10 09:49:47.092461+00	2026-10-10 09:49:47.168358+00
676	Dathan Auerbach	Male	USA	2026-10-10 09:49:47.257346+00	2026-10-10 09:49:47.366447+00
677	Sara Gran	Female	USA	2026-10-10 09:49:47.389782+00	2026-10-10 09:49:47.469938+00
678	Lucy Clarke	Female	The United Kingdom	2026-10-10 09:49:47.550425+00	2026-10-10 09:49:47.577293+00
679	Julia Armfield	Female	The United Kingdom	2026-10-10 09:49:47.680106+00	2026-10-10 09:49:47.780409+00
680	Johan Harstad	Male	Norway	2026-10-10 09:49:47.932841+00	2026-10-10 09:49:48.146617+00
681	James Frey	Male	USA	2026-10-10 09:49:48.236886+00	2026-10-10 09:49:48.245195+00
682	Nils Johnson-Shelton	Male	USA	2026-10-10 09:49:48.258159+00	2026-10-10 09:49:48.27562+00
683	Jimmy Juliano	Male	USA	2026-10-10 09:49:48.298686+00	2026-10-10 09:49:48.451094+00
684	Mique Watson	Male	USA	2026-10-10 09:49:48.475803+00	2026-10-10 09:49:48.655992+00
685	Will Dean	Male	The United Kingdom	2026-10-10 09:49:48.692362+00	2026-10-10 09:49:48.953611+00
686	Daniel Kraus	Male	USA	2026-10-10 09:49:49.000259+00	2026-10-10 09:49:49.151627+00
687	Cathy Yardley	Female	USA	2026-10-10 09:49:49.163643+00	2026-10-10 09:49:49.266339+00
688	Sammy Scott	Male	USA	2026-10-10 09:49:49.28844+00	2026-10-10 09:49:49.464692+00
689	Shirley Jackson	Female	USA	2026-10-10 09:49:49.487588+00	2026-10-10 09:49:49.669621+00
690	Lisa M. Matlin	Female	Australia	2026-10-10 09:49:49.784038+00	2026-10-10 09:49:49.854061+00
691	Danya Kukafka	Female	USA	2026-10-10 09:49:49.871644+00	2026-10-10 09:49:50.057276+00
692	Carissa Orlando	Female	USA	2026-10-10 09:49:50.084071+00	2026-10-10 09:49:50.265931+00
693	Brynne Weaver	Female	USA	2026-10-10 09:49:50.299454+00	2026-10-10 09:49:50.370325+00
694	Ling Ling Huang	Female	USA	2026-10-10 09:49:50.455079+00	2026-10-10 09:49:50.551372+00
695	Christopher Golden	Male	USA	2026-10-10 09:49:50.56408+00	2026-10-10 09:49:50.753156+00
696	Sarah Goodwin	Female	The United Kingdom	2026-10-10 09:49:50.779829+00	2026-10-10 09:49:50.951312+00
697	Chloe Liese	Female	USA	2026-10-10 09:49:50.975243+00	2026-10-10 09:49:51.06641+00
698	Andrew Shaffer	Male	USA	2026-10-10 09:49:51.085171+00	2026-10-10 09:49:51.167021+00
699	B. K. Borison	Female	USA	2026-10-10 09:49:51.203499+00	2026-10-10 09:49:51.35072+00
700	Benjamin Stevenson	Male	Australia	2026-10-10 09:49:51.366834+00	2026-10-10 09:49:51.555689+00
701	Maggie Knox	Female	Canada	2026-10-10 09:49:51.57837+00	2026-10-10 09:49:51.656546+00
702	Laure Van Rensburg	Female	France	2026-10-10 09:49:51.670873+00	2026-10-10 09:49:51.765827+00
703	Kealan Patrick Burke	Male	Ireland	2026-10-10 09:49:51.778449+00	2026-10-10 09:49:51.868171+00
704	Kate Folk	Female	USA	2026-10-10 09:49:51.953661+00	2026-10-10 09:49:52.069018+00
705	Rachel Harrison	Female	USA	2026-10-10 09:49:52.174794+00	2026-10-10 09:49:52.192619+00
706	Caitlin Marceau	Female	Canada	2026-10-10 09:49:52.255593+00	2026-10-10 09:49:52.467424+00
707	Araminta Hall	Female	The United Kingdom	2026-10-10 09:49:52.562462+00	2026-10-10 09:49:52.6541+00
708	Jessa Maxwell	Female	USA	2026-10-10 09:49:52.674233+00	2026-10-10 09:49:52.757403+00
709	Ray Nayler	Male	USA	2026-10-10 09:49:52.774722+00	2026-10-10 09:49:52.865324+00
710	R. F. Kuang	Female	China	2026-10-10 09:49:52.88043+00	2026-10-10 09:49:53.051795+00
711	Janice Hallett	Female	The United Kingdom	2026-10-10 09:49:53.065908+00	2026-10-10 09:49:53.257089+00
712	Tanarive Due	Female	USA	2026-10-10 09:49:53.284681+00	2026-10-10 09:49:53.374411+00
713	Jordan Peele	Male	USA	2026-10-10 09:49:53.396682+00	2026-10-10 09:49:53.551546+00
714	Hannah Grace	Female	The United Kingdom	2026-10-10 09:49:53.572702+00	2026-10-10 09:49:53.758849+00
715	Jenny Kiefer	Female	USA	2026-10-10 09:49:53.781827+00	2026-10-10 09:49:53.868312+00
716	Ania Ahlborn	Female	Poland	2026-10-10 09:49:53.892132+00	2026-10-10 09:49:54.053271+00
717	Liz Kerin	Female	USA	2026-10-10 09:49:54.075082+00	2026-10-10 09:49:54.155845+00
1485	Marie Still	\N	\N	2026-10-11 15:10:14.582896+00	2026-10-11 15:10:14.582896+00
1486	Marina Yuszczuk	\N	\N	2026-10-11 15:10:14.589405+00	2026-10-11 15:10:14.589405+00
1487	Marissa Levien	\N	\N	2026-10-11 15:10:14.599116+00	2026-10-11 15:10:14.599116+00
1488	Mason Coile	\N	\N	2026-10-11 15:10:14.627738+00	2026-10-11 15:10:14.627738+00
1489	Mason Deaver	\N	\N	2026-10-11 15:10:14.634739+00	2026-10-11 15:10:14.634739+00
1490	Matt Riordan	\N	\N	2026-10-11 15:10:14.643847+00	2026-10-11 15:10:14.643847+00
1491	Matt Serafini	\N	\N	2026-10-11 15:10:14.650223+00	2026-10-11 15:10:14.650223+00
1492	Matthew Norman	\N	\N	2026-10-11 15:10:14.664175+00	2026-10-11 15:10:14.664175+00
1493	Maud Ventura	\N	\N	2026-10-11 15:10:14.670452+00	2026-10-11 15:10:14.670452+00
1494	Maureen Kilmer	\N	\N	2026-10-11 15:10:14.677292+00	2026-10-11 15:10:14.677292+00
1495	Meagan Church	\N	\N	2026-10-11 15:10:14.688362+00	2026-10-11 15:10:14.688362+00
1496	Melissa Ferguson	\N	\N	2026-10-11 15:10:14.700258+00	2026-10-11 15:10:14.700258+00
1497	Melissa Pace	\N	\N	2026-10-11 15:10:14.707252+00	2026-10-11 15:10:14.707252+00
1498	Michael Wehunt	\N	\N	2026-10-11 15:10:14.714356+00	2026-10-11 15:10:14.714356+00
1499	Miranda Smith	\N	\N	2026-10-11 15:10:14.729819+00	2026-10-11 15:10:14.729819+00
1500	Molly Burke	\N	\N	2026-10-11 15:10:14.739772+00	2026-10-11 15:10:14.739772+00
1501	Monty Jay	\N	\N	2026-10-11 15:10:14.748527+00	2026-10-11 15:10:14.748527+00
1502	Naomi Salman	\N	\N	2026-10-11 15:10:14.756935+00	2026-10-11 15:10:14.756935+00
1503	Nathan Ballingrud	\N	\N	2026-10-11 15:10:14.768028+00	2026-10-11 15:10:14.768028+00
1504	Andrew Sullivan	\N	\N	2026-10-11 15:10:14.783477+00	2026-10-11 15:10:14.783477+00
1505	Nicole Baart	\N	\N	2026-10-11 15:10:14.792951+00	2026-10-11 15:10:14.792951+00
1506	Nikki Erlick	\N	\N	2026-10-11 15:10:14.800141+00	2026-10-11 15:10:14.800141+00
1507	Olivia Waite	\N	\N	2026-10-11 15:10:14.823024+00	2026-10-11 15:10:14.823024+00
1508	Paisley Hope	\N	\N	2026-10-11 15:10:14.836906+00	2026-10-11 15:10:14.836906+00
1509	Pam Godwin	\N	\N	2026-10-11 15:10:14.844405+00	2026-10-11 15:10:14.844405+00
1510	Paul Bradley Carr	\N	\N	2026-10-11 15:10:14.854072+00	2026-10-11 15:10:14.854072+00
1511	Per Jacobsen	\N	\N	2026-10-11 15:10:14.872906+00	2026-10-11 15:10:14.872906+00
1512	Peyton Corinne	\N	\N	2026-10-11 15:10:14.879456+00	2026-10-11 15:10:14.879456+00
1513	Philip Fracassi	\N	\N	2026-10-11 15:10:14.888536+00	2026-10-11 15:10:14.888536+00
1514	Rachel Eve Moulton	\N	\N	2026-10-11 15:10:14.89847+00	2026-10-11 15:10:14.89847+00
1515	Rachel Lacey	\N	\N	2026-10-11 15:10:14.936774+00	2026-10-11 15:10:14.936774+00
1516	Rachel Van Dyken	\N	\N	2026-10-11 15:10:14.958377+00	2026-10-11 15:10:14.958377+00
1517	Ren DeStefano	\N	\N	2026-10-11 15:10:14.965388+00	2026-10-11 15:10:14.965388+00
1518	Ruby Barrett	\N	\N	2026-10-11 15:10:14.988805+00	2026-10-11 15:10:14.988805+00
1519	Ruth Kelly	\N	\N	2026-10-11 15:10:15.000533+00	2026-10-11 15:10:15.000533+00
1520	Samantha Highfill	\N	\N	2026-10-11 15:10:15.06077+00	2026-10-11 15:10:15.06077+00
1521	Samantha Kolesnik	\N	\N	2026-10-11 15:10:15.070415+00	2026-10-11 15:10:15.070415+00
1522	Sarah Alderson	\N	\N	2026-10-11 15:10:15.079538+00	2026-10-11 15:10:15.079538+00
1523	Sarah Hogle	\N	\N	2026-10-11 15:10:15.09076+00	2026-10-11 15:10:15.09076+00
1524	Saratoga Schaefer	\N	\N	2026-10-11 15:10:15.116377+00	2026-10-11 15:10:15.116377+00
1525	Sascha Rothchild	\N	\N	2026-10-11 15:10:15.12514+00	2026-10-11 15:10:15.12514+00
1526	Seth Haddon	\N	\N	2026-10-11 15:10:15.134502+00	2026-10-11 15:10:15.134502+00
1527	Sian Gilbert	\N	\N	2026-10-11 15:10:15.141086+00	2026-10-11 15:10:15.141086+00
1528	Slutty Cheff	\N	\N	2026-10-11 15:10:15.154506+00	2026-10-11 15:10:15.154506+00
1529	Stephanie Perkins	\N	\N	2026-10-11 15:10:15.182618+00	2026-10-11 15:10:15.182618+00
1530	T.J. Payne	\N	\N	2026-10-11 15:10:15.206763+00	2026-10-11 15:10:15.206763+00
1531	Tatiana Schlote-Bonne	\N	\N	2026-10-11 15:10:15.268803+00	2026-10-11 15:10:15.268803+00
1532	Trisha Sakhlecha	\N	\N	2026-10-11 15:10:15.283361+00	2026-10-11 15:10:15.283361+00
1533	V. L. Bovalino	\N	\N	2026-10-11 15:10:15.29339+00	2026-10-11 15:10:15.29339+00
1534	Valerie Bowman	\N	\N	2026-10-11 15:10:15.303405+00	2026-10-11 15:10:15.303405+00
718	Ashley Elston	Female	USA	2026-10-10 09:49:54.176289+00	2026-10-10 09:49:54.266344+00
719	Linden A. Lewis	Female	USA	2026-10-10 09:49:54.288924+00	2026-10-10 09:49:54.467519+00
720	Delilah S. Dawson	Female	USA	2026-10-10 09:49:54.550427+00	2026-10-10 09:49:54.67506+00
721	Tim Lebbon	Male	The United Kingdom	2026-10-10 09:49:54.789092+00	2026-10-10 09:49:54.871208+00
722	Sunny Moraine	Non-binary	USA	2026-10-10 09:49:54.952801+00	2026-10-10 09:49:55.056712+00
723	Sylvain Neuvel	Male	Canada	2026-10-10 09:49:55.076348+00	2026-10-10 09:49:55.173217+00
724	Steve Cavanagh	Male	The United Kingdom	2026-10-10 09:49:55.189445+00	2026-10-10 09:49:55.267354+00
725	Falon Ballard	Female	USA	2026-10-10 09:49:55.282426+00	2026-10-10 09:49:55.480679+00
726	Jesse Q. Sutanto	Female	Indonesia	2026-10-10 09:49:55.509684+00	2026-10-10 09:49:55.753319+00
727	Gemma Amor	Female	The United Kingdom	2026-10-10 09:49:55.78961+00	2026-10-10 09:49:55.854644+00
728	Emily Ruth Verona	Female	USA	2026-10-10 09:49:55.867166+00	2026-10-10 09:49:56.063285+00
729	William Friend	Male	The United Kingdom	2026-10-10 09:49:56.0917+00	2026-10-10 09:49:56.253351+00
730	Kristopher Triana	Male	USA	2026-10-10 09:49:56.276352+00	2026-10-10 09:49:56.361193+00
731	J.K. Rowling	Female	The United Kingdom	2026-10-10 09:49:56.374623+00	2026-10-10 09:49:56.852136+00
732	Tracy Sierra	Female	USA	2026-10-10 09:49:56.923456+00	2026-10-10 09:49:57.065544+00
733	Heather Gudenkauf	Female	USA	2026-10-10 09:49:57.089549+00	2026-10-10 09:49:57.264712+00
734	Adrian McKinty	Male	The United Kingdom	2026-10-10 09:49:57.299001+00	2026-10-10 09:49:57.455628+00
735	Martha Wells	Female	USA	2026-10-10 09:49:57.484343+00	2026-10-10 09:49:57.564195+00
736	Jennifer Thorne	Female	USA	2026-10-10 09:49:57.580245+00	2026-10-10 09:49:57.853152+00
737	Neil Sharpson	Male	Ireland	2026-10-10 09:49:57.898275+00	2026-10-10 09:49:58.05482+00
738	Amy Tintera	Female	USA	2026-10-10 09:49:58.068809+00	2026-10-10 09:49:58.16393+00
739	Marlee Bush	Female	USA	2026-10-10 09:49:58.181403+00	2026-10-10 09:49:58.37045+00
740	Anne Heltzel	Female	USA	2026-10-10 09:49:58.455258+00	2026-10-10 09:49:58.97425+00
741	Emily Wibberley	Female	USA	2026-10-10 09:49:59.159934+00	2026-10-10 09:49:59.168246+00
742	Austin Siegemund-Broka	Male	USA	2026-10-10 09:49:59.173997+00	2026-10-10 09:49:59.550266+00
743	Elle Kennedy	Female	Canada	2026-10-10 09:49:59.597826+00	2026-10-10 09:49:59.757831+00
744	Craig DiLouie	Male	Canada	2026-10-10 09:49:59.789547+00	2026-10-10 09:49:59.954501+00
745	Romy Hausmann	Female	Germany	2026-10-10 09:49:59.981071+00	2026-10-10 09:50:00.068846+00
746	Elsie Silver	Female	Canada	2026-10-10 09:50:00.150795+00	2026-10-10 09:50:00.252129+00
747	Rumaan Alam	Male	USA	2026-10-10 09:50:00.269069+00	2026-10-10 09:50:00.357509+00
748	Lana Ferguson	Female	USA	2026-10-10 09:50:00.370615+00	2026-10-10 09:50:00.652858+00
749	Elizabeth Moon	Female	USA	2026-10-10 09:50:00.682676+00	2026-10-10 09:50:00.761827+00
750	Katherine Wood	Female	USA	2026-10-10 09:50:00.773765+00	2026-10-10 09:50:00.866787+00
751	Christine Riccio	Female	USA	2026-10-10 09:50:00.950399+00	2026-10-10 09:50:00.971072+00
752	Chuck Tingle	Male	USA	2026-10-10 09:50:00.985247+00	2026-10-10 09:50:01.069192+00
753	Gregoire Curtois	Male	France	2026-10-10 09:50:01.166565+00	2026-10-10 09:50:01.254861+00
754	David Sodergren	Male	The United Kingdom	2026-10-10 09:50:01.272648+00	2026-10-10 09:50:01.357281+00
755	K. L. Cerra	Female	USA	2026-10-10 09:50:01.37119+00	2026-10-10 09:50:01.466138+00
756	Laurie Gilmore	Female	USA	2026-10-10 09:50:01.479889+00	2026-10-10 09:50:01.654038+00
757	Gillian McAllister	Female	The United Kingdom	2026-10-10 09:50:01.668192+00	2026-10-10 09:50:01.850817+00
758	Nat Cassidy	Male	USA	2026-10-10 09:50:01.875779+00	2026-10-10 09:50:02.165882+00
759	Jeneva Rose	Female	USA	2026-10-10 09:50:02.219528+00	2026-10-10 09:50:02.268333+00
760	Marcus Kliewer	Male	Canada	2026-10-10 09:50:02.350427+00	2026-10-10 09:50:02.452799+00
761	Sierra Greer	Female	USA	2026-10-10 09:50:02.470056+00	2026-10-10 09:50:02.566759+00
762	Monika Kim	Female	USA	2026-10-10 09:50:02.679147+00	2026-10-10 09:50:02.857753+00
763	Hildur Knutsdottir	Female	Iceland	2026-10-10 09:50:02.883045+00	2026-10-10 09:50:03.076819+00
764	Lauren A. Forry	Female	USA	2026-10-10 09:50:03.172955+00	2026-10-10 09:50:03.257088+00
765	James S. Murray	Male	USA	2026-10-10 09:50:03.285691+00	2026-10-10 09:50:03.360017+00
766	Darren Wearmouth	Male	USA	2026-10-10 09:50:03.368797+00	2026-10-10 09:50:03.660207+00
767	Jacquie Walters	Female	USA	2026-10-10 09:50:03.699752+00	2026-10-10 09:50:03.854782+00
768	Ashley Herring Blake	Female	USA	2026-10-10 09:50:03.871713+00	2026-10-10 09:50:03.972437+00
769	Ally Carter	Female	USA	2026-10-10 09:50:04.056963+00	2026-10-10 09:50:04.452639+00
770	Monica Ojeda	Female	Ecuador	2026-10-10 09:50:04.50009+00	2026-10-10 09:50:04.570191+00
1535	Vi Keeland	\N	\N	2026-10-11 15:10:15.311697+00	2026-10-11 15:10:15.311697+00
1536	Victor Manibo	\N	\N	2026-10-11 15:10:15.329441+00	2026-10-11 15:10:15.329441+00
1537	Victoria Lavine	\N	\N	2026-10-11 15:10:15.33951+00	2026-10-11 15:10:15.33951+00
1538	Vincent Tirado	\N	\N	2026-10-11 15:10:15.361592+00	2026-10-11 15:10:15.361592+00
1539	Yume Kitasei	\N	\N	2026-10-11 15:10:15.370692+00	2026-10-11 15:10:15.370692+00
1540	Shantel Tessier	\N	\N	2026-10-11 15:10:15.409658+00	2026-10-11 15:10:15.409658+00
1541	Swan Huntley	\N	\N	2026-10-11 15:10:15.423536+00	2026-10-11 15:10:15.423536+00
1542	D.L. Darby	\N	\N	2026-10-11 15:10:15.43264+00	2026-10-11 15:10:15.43264+00
1543	Mia Ballard	\N	\N	2026-10-11 15:10:15.441712+00	2026-10-11 15:10:15.441712+00
1544	J. Bree	\N	\N	2026-10-11 15:10:15.452156+00	2026-10-11 15:10:15.452156+00
1545	Antonia Hodgson	\N	\N	2026-10-11 15:10:15.465058+00	2026-10-11 15:10:15.465058+00
1546	Brooke Fast	\N	\N	2026-10-11 15:10:15.479169+00	2026-10-11 15:10:15.479169+00
1547	Julie Johnson	\N	\N	2026-10-11 15:10:15.486779+00	2026-10-11 15:10:15.486779+00
1548	Carissa Broadbent	\N	\N	2026-10-11 15:10:15.493852+00	2026-10-11 15:10:15.493852+00
1549	Letizia Lorini	\N	\N	2026-10-11 15:10:15.501145+00	2026-10-11 15:10:15.501145+00
1550	Jeff Rake	\N	\N	2026-10-11 15:10:15.509851+00	2026-10-11 15:10:15.509851+00
1551	Rob Hart	\N	\N	2026-10-11 15:10:15.512404+00	2026-10-11 15:10:15.512404+00
1552	Lexi Davis	\N	\N	2026-10-11 15:10:15.544823+00	2026-10-11 15:10:15.544823+00
1553	Lior Torenberg	\N	\N	2026-10-11 15:10:15.57362+00	2026-10-11 15:10:15.57362+00
1554	Rachel Taff	\N	\N	2026-10-11 15:10:15.589956+00	2026-10-11 15:10:15.589956+00
1555	Callie Kazumi	\N	\N	2026-10-11 15:10:15.601898+00	2026-10-11 15:10:15.601898+00
1556	Shailee Thompson	\N	\N	2026-10-11 15:10:15.60879+00	2026-10-11 15:10:15.60879+00
1557	Leodora Darlington	\N	\N	2026-10-11 15:10:15.625907+00	2026-10-11 15:10:15.625907+00
1558	Sarah G. Pierce	\N	\N	2026-10-11 15:10:15.661099+00	2026-10-11 15:10:15.661099+00
1559	Jennifer Iacopelli	\N	\N	2026-10-11 15:10:15.673683+00	2026-10-11 15:10:15.673683+00
1560	Denise Williams	\N	\N	2026-10-11 15:10:15.680507+00	2026-10-11 15:10:15.680507+00
1561	Daphne Elliot	\N	\N	2026-10-11 15:10:15.705312+00	2026-10-11 15:10:15.705312+00
1562	Trilina Pucci	\N	\N	2026-10-11 15:10:15.732389+00	2026-10-11 15:10:15.732389+00
1563	Athena Rose	\N	\N	2026-10-11 15:10:15.763672+00	2026-10-11 15:10:15.763672+00
1564	Claire Oshetsky	\N	\N	2026-10-11 15:10:15.770666+00	2026-10-11 15:10:15.770666+00
1565	Kate Golden	\N	\N	2026-10-11 15:10:15.789856+00	2026-10-11 15:10:15.789856+00
1566	T Kira Mahealani Madden	\N	\N	2026-10-11 15:10:15.808871+00	2026-10-11 15:10:15.808871+00
1567	Liz Tomforde	\N	\N	2026-10-11 15:10:15.815814+00	2026-10-11 15:10:15.815814+00
1568	Emily Ohanjanians	\N	\N	2026-10-11 15:10:15.82352+00	2026-10-11 15:10:15.82352+00
1569	Kat Rosenfield	\N	\N	2026-10-11 15:10:15.834997+00	2026-10-11 15:10:15.834997+00
1570	Tiffany Crum	\N	\N	2026-10-11 15:10:15.856434+00	2026-10-11 15:10:15.856434+00
1571	Mia Sosa	\N	\N	2026-10-11 15:10:15.875658+00	2026-10-11 15:10:15.875658+00
1572	Catherine Walsh	\N	\N	2026-10-11 15:10:15.909119+00	2026-10-11 15:10:15.909119+00
1573	C. G. Drews	\N	\N	2026-10-11 15:10:15.920823+00	2026-10-11 15:10:15.920823+00
1574	Robyn Harding	\N	\N	2026-10-11 15:10:15.932212+00	2026-10-11 15:10:15.932212+00
1575	E. Salvador	\N	\N	2026-10-11 15:10:15.939215+00	2026-10-11 15:10:15.939215+00
1576	Sophia St. Germain	\N	\N	2026-10-11 15:10:15.955517+00	2026-10-11 15:10:15.955517+00
1577	Luke Dumas	\N	\N	2026-10-11 15:10:15.977121+00	2026-10-11 15:10:15.977121+00
1578	Georgia McVeigh	\N	\N	2026-10-11 15:10:15.984211+00	2026-10-11 15:10:15.984211+00
1579	Kirsten King	\N	\N	2026-10-11 15:10:15.991375+00	2026-10-11 15:10:15.991375+00
1580	Riss M. Neilson	\N	\N	2026-10-11 15:10:15.997823+00	2026-10-11 15:10:15.997823+00
1581	Laura Brooke Robson	\N	\N	2026-10-11 15:10:16.005332+00	2026-10-11 15:10:16.005332+00
1582	Lori Gold	\N	\N	2026-10-11 15:10:16.016829+00	2026-10-11 15:10:16.016829+00
1583	Amin Ahmad	\N	\N	2026-10-11 15:10:16.025137+00	2026-10-11 15:10:16.025137+00
1584	Alisha Rai	\N	\N	2026-10-11 15:10:16.032617+00	2026-10-11 15:10:16.032617+00
771	Chuck Wendig	Male	USA	2026-10-10 09:50:04.668805+00	2026-10-10 09:50:05.054107+00
772	C. J. Cooke	Female	The United Kingdom	2026-10-10 09:50:05.458301+00	2026-10-10 09:50:05.550793+00
773	Bonnie Garmus	Female	USA	2026-10-10 09:50:05.616658+00	2026-10-10 09:50:05.656367+00
774	Chris Whitaker	Male	USA	2026-10-10 09:50:05.674548+00	2026-10-10 09:50:05.764491+00
775	Aamna Qureshi	Female	Pakistan	2026-10-10 09:50:05.787684+00	2026-10-10 09:50:05.953082+00
776	Navessa Allen	Female	USA	2026-10-10 09:50:05.972761+00	2026-10-10 09:50:06.1558+00
777	John Wiswell	Male	USA	2026-10-10 09:50:06.187857+00	2026-10-10 09:50:06.369207+00
778	Kayla Olson	Female	USA	2026-10-10 09:50:06.48092+00	2026-10-10 09:50:06.558814+00
779	Callie Hart	Female	USA	2026-10-10 09:50:06.574865+00	2026-10-10 09:50:06.769464+00
780	Megan Collins	Female	USA	2026-10-10 09:50:06.853348+00	2026-10-10 09:50:06.959944+00
781	Megan Goldin	Female	Australia	2026-10-10 09:50:06.978896+00	2026-10-10 09:50:07.169051+00
782	Steph Nelson	Female	USA	2026-10-10 09:50:07.275658+00	2026-10-10 09:50:07.673104+00
783	Ande Pliego	Female	USA	2026-10-10 09:50:07.836225+00	2026-10-10 09:50:07.956052+00
784	Suzanne Collins	Female	USA	2026-10-10 09:50:07.996086+00	2026-10-10 09:50:08.37421+00
785	Ainslie Hogarth	Female	Canada	2026-10-10 09:50:08.541201+00	2026-10-10 09:50:08.655943+00
786	Lisa Unger	Female	USA	2026-10-10 09:50:08.678174+00	2026-10-10 09:50:08.961718+00
787	Neena Viel	Female	USA	2026-10-10 09:50:09.006947+00	2026-10-10 09:50:09.155651+00
788	Katie Holt	Female	USA	2026-10-10 09:50:09.174006+00	2026-10-10 09:50:09.272825+00
789	Markus Zusak	Male	Australia	2026-10-10 09:50:09.366547+00	2026-10-10 09:50:09.755313+00
790	Sarah Hawley	Female	USA	2026-10-10 09:50:09.815685+00	2026-10-10 09:50:09.953402+00
791	Lucy Rose	Female	The United Kingdom	2026-10-10 09:50:09.972031+00	2026-10-10 09:50:10.064935+00
792	Carter Wilson	Male	USA	2026-10-10 09:50:10.083669+00	2026-10-10 09:50:10.275122+00
793	Asia Mackay	Female	The United Kingdom	2026-10-10 09:50:10.385886+00	2026-10-10 09:50:10.469222+00
794	Alexis Henderson	Female	USA	2026-10-10 09:50:10.550591+00	2026-10-10 09:50:10.655213+00
795	Mazey Eddings	Female	USA	2026-10-10 09:50:10.678128+00	2026-10-10 09:50:10.955039+00
796	Nikki Sloane	Female	USA	2026-10-10 09:50:10.998594+00	2026-10-10 09:50:11.069174+00
797	You-Jeong Jeong	Female	South Korea	2026-10-10 09:50:11.158547+00	2026-10-10 09:50:11.261635+00
798	Onley James	Female	USA	2026-10-10 09:50:11.286862+00	2026-10-10 09:50:11.559438+00
799	Jon Bassoff	Male	USA	2026-10-10 09:50:11.610797+00	2026-10-10 09:50:11.755767+00
800	Bal Khabra	Female	Canada	2026-10-10 09:50:11.779883+00	2026-10-10 09:50:11.956911+00
801	Liann Zhang	Female	Canada	2026-10-10 09:50:11.993716+00	2026-10-10 09:50:12.165371+00
802	Holly Jackson	Female	The United Kingdom	2026-10-10 09:50:12.198652+00	2026-10-10 09:50:12.359988+00
803	Kylie Lee Baker	Female	USA	2026-10-10 09:50:12.382022+00	2026-10-10 09:50:12.568359+00
804	London Sperry	Female	USA	2026-10-10 09:50:12.653144+00	2026-10-10 09:50:12.866469+00
805	Sarah Maria Griffin	Female	Ireland	2026-10-10 09:50:12.994678+00	2026-10-10 09:50:13.067228+00
806	Bridget Morrisey	Female	USA	2026-10-10 09:50:13.165099+00	2026-10-10 09:50:13.26189+00
807	Blair Braverman	Female	USA	2026-10-10 09:50:13.284096+00	2026-10-10 09:50:13.460065+00
808	Johanna Van Veen	Female	The Netherlands	2026-10-10 09:50:13.488006+00	2026-10-10 09:50:13.658156+00
809	Kate Fagan	Female	USA	2026-10-10 09:50:13.689401+00	2026-10-10 09:50:13.957837+00
810	Haley Cass	Female	USA	2026-10-10 09:50:14.050344+00	2026-10-10 09:50:14.153886+00
811	Hailey Piper	Female	USA	2026-10-10 09:50:14.173962+00	2026-10-10 09:50:14.276697+00
812	Sara Tantlinger	Female	USA	2026-10-10 09:50:14.366202+00	2026-10-10 09:50:14.675687+00
813	Daniel Aleman	Male	Mexico	2026-10-10 09:50:14.808768+00	2026-10-10 09:50:15.070275+00
814	Meryl Wilsner	Non-binary	USA	2026-10-10 09:50:15.196071+00	2026-10-10 09:50:15.558072+00
815	Tess Sharpe	Female	USA	2026-10-10 09:50:15.63342+00	2026-10-10 09:50:15.757137+00
816	Isabel Cañas	Female	Mexico	2026-10-10 09:50:15.77898+00	2026-10-10 09:50:16.265862+00
817	Hannah Bonam-Young	Female	Canada	2026-10-10 09:50:16.440982+00	2026-10-10 09:50:16.553247+00
818	Matt Haig	Male	The United Kingdom	2026-10-10 09:50:16.575165+00	2026-10-10 09:50:16.955933+00
819	Katy Hays	Female	USA	2026-10-10 09:50:17.057154+00	2026-10-10 09:50:17.154056+00
820	T. Marie Vandelly	Female	USA	2026-10-10 09:50:17.176043+00	2026-10-10 09:50:17.470679+00
821	Uketsu	Male	Japan	2026-10-10 09:50:17.553689+00	2026-10-10 09:50:17.72528+00
822	Steph Macca	Female	Australia	2026-10-10 09:50:17.862914+00	2026-10-10 09:50:17.955121+00
823	Rae Wilde	Female	USA	2026-10-10 09:50:17.972189+00	2026-10-10 09:50:18.369212+00
824	Lyla Sage	Female	USA	2026-10-10 09:50:18.502668+00	2026-10-10 09:50:18.757025+00
1585	Jennifer O'Brien	\N	\N	2026-10-11 15:10:16.048571+00	2026-10-11 15:10:16.048571+00
1586	Rainbow Rowell	\N	\N	2026-10-11 15:10:16.055146+00	2026-10-11 15:10:16.055146+00
1587	Charlotte Stein	\N	\N	2026-10-11 15:10:16.06163+00	2026-10-11 15:10:16.06163+00
1588	Kara McDowell	\N	\N	2026-10-11 15:10:16.075046+00	2026-10-11 15:10:16.075046+00
1589	Carter Keane	\N	\N	2026-10-11 15:10:16.086586+00	2026-10-11 15:10:16.086586+00
1590	S.R. Masters	\N	\N	2026-10-11 15:10:16.097553+00	2026-10-11 15:10:16.097553+00
1591	Richard Adams	\N	\N	2026-10-11 15:10:16.109245+00	2026-10-11 15:10:16.109245+00
1592	Sierra Branham	\N	\N	2026-10-11 15:10:16.115915+00	2026-10-11 15:10:16.115915+00
1593	Ellis Hunter	\N	\N	2026-10-11 15:10:16.127634+00	2026-10-11 15:10:16.127634+00
1594	Rachael Chadwick	\N	\N	2026-10-11 15:10:16.134818+00	2026-10-11 15:10:16.134818+00
1595	Laura Zigman	\N	\N	2026-10-11 15:10:16.156612+00	2026-10-11 15:10:16.156612+00
1596	Clio Evans	\N	\N	2026-10-11 15:10:16.16973+00	2026-10-11 15:10:16.16973+00
1597	C. O. Wheel	\N	\N	2026-10-11 15:10:16.17636+00	2026-10-11 15:10:16.17636+00
1598	Tanya Das	\N	\N	2026-10-11 15:10:16.178473+00	2026-10-11 15:10:16.178473+00
1599	Mary Berman	\N	\N	2026-10-11 15:10:16.196651+00	2026-10-11 15:10:16.196651+00
1600	Ellie Graves	\N	\N	2026-10-11 15:10:16.207508+00	2026-10-11 15:10:16.207508+00
1601	Joanne Rock	\N	\N	2026-10-11 15:10:16.217186+00	2026-10-11 15:10:16.217186+00
1602	Liz Lawson	\N	\N	2026-10-11 15:10:16.229207+00	2026-10-11 15:10:16.229207+00
1603	Lauren Blakely	\N	\N	2026-10-11 15:10:16.236408+00	2026-10-11 15:10:16.236408+00
1604	Monica Murphy	\N	\N	2026-10-11 15:10:16.271039+00	2026-10-11 15:10:16.271039+00
1605	Liv Zander	\N	\N	2026-10-11 15:10:16.307488+00	2026-10-11 15:10:16.307488+00
1606	Avina St. Graves	\N	\N	2026-10-11 15:10:16.318956+00	2026-10-11 15:10:16.318956+00
1607	Michelle Thate	\N	\N	2026-10-11 15:10:16.325815+00	2026-10-11 15:10:16.325815+00
1608	Leah Rowan	\N	\N	2026-10-11 15:10:16.337216+00	2026-10-11 15:10:16.337216+00
1609	Isabel J. Kim	\N	\N	2026-10-11 15:10:16.350774+00	2026-10-11 15:10:16.350774+00
1610	Eliza Jabore	\N	\N	2026-10-11 15:10:16.358298+00	2026-10-11 15:10:16.358298+00
1611	Olivia Worley	\N	\N	2026-10-11 15:10:16.365129+00	2026-10-11 15:10:16.365129+00
1612	Violet Lumani	\N	\N	2026-10-11 15:10:16.373847+00	2026-10-11 15:10:16.373847+00
1613	Sonia Feldman	\N	\N	2026-10-11 15:10:16.380477+00	2026-10-11 15:10:16.380477+00
1614	Seren Rose	\N	\N	2026-10-11 15:10:16.386942+00	2026-10-11 15:10:16.386942+00
1615	Tetyana Walker	\N	\N	2026-10-11 15:10:16.400818+00	2026-10-11 15:10:16.400818+00
1616	Madison Lawson	\N	\N	2026-10-11 15:10:16.416641+00	2026-10-11 15:10:16.416641+00
1617	Illona Andrews	\N	\N	2026-10-11 15:10:16.433556+00	2026-10-11 15:10:16.433556+00
1618	Fonda Lee	\N	\N	2026-10-11 15:10:16.440488+00	2026-10-11 15:10:16.440488+00
1619	Amy Pennza	\N	\N	2026-10-11 15:10:16.456349+00	2026-10-11 15:10:16.456349+00
1620	E.L. Chen	\N	\N	2026-10-11 15:10:16.463078+00	2026-10-11 15:10:16.463078+00
1621	Heather Frances	\N	\N	2026-10-11 15:10:16.474797+00	2026-10-11 15:10:16.474797+00
1622	Kathy Lockheart	\N	\N	2026-10-11 15:10:16.486189+00	2026-10-11 15:10:16.486189+00
1623	Penelope Sky	\N	\N	2026-10-11 15:10:16.497848+00	2026-10-11 15:10:16.497848+00
1624	Trinity Lynn	\N	\N	2026-10-11 15:10:16.504632+00	2026-10-11 15:10:16.504632+00
1625	Katharine McGee	\N	\N	2026-10-11 15:10:16.521501+00	2026-10-11 15:10:16.521501+00
1626	Georgia Stone	\N	\N	2026-10-11 15:10:16.533532+00	2026-10-11 15:10:16.533532+00
1627	Aria Ashbrook	\N	\N	2026-10-11 15:10:16.540654+00	2026-10-11 15:10:16.540654+00
1628	Elayna R. Gallea	\N	\N	2026-10-11 15:10:16.547967+00	2026-10-11 15:10:16.547967+00
1629	Shirlene Obuobi	\N	\N	2026-10-11 15:10:16.559681+00	2026-10-11 15:10:16.559681+00
1630	Chelsea Curto	\N	\N	2026-10-11 15:10:16.57151+00	2026-10-11 15:10:16.57151+00
1631	Grace Reilly	\N	\N	2026-10-11 15:10:16.587614+00	2026-10-11 15:10:16.587614+00
1632	Kit Haley	\N	\N	2026-10-11 15:10:16.594828+00	2026-10-11 15:10:16.594828+00
1633	Minyoung Kang	\N	\N	2026-10-11 15:10:16.608508+00	2026-10-11 15:10:16.608508+00
1634	Josh Silver	\N	\N	2026-10-11 15:10:16.624857+00	2026-10-11 15:10:16.624857+00
1635	Kat Sloane	\N	\N	2026-10-11 15:10:16.638639+00	2026-10-11 15:10:16.638639+00
825	Mallory Arnold	Female	USA	2026-10-10 09:50:18.802654+00	2026-10-10 09:50:19.069599+00
826	Agustina Bazterrica	Female	Argentina	2026-10-10 09:50:19.183465+00	2026-10-10 09:50:19.560274+00
827	Elise Kova	Female	USA	2026-10-10 09:50:19.598711+00	2026-10-10 09:50:19.757656+00
828	Alison Espach	Female	USA	2026-10-10 09:50:19.777366+00	2026-10-10 09:50:19.871673+00
829	Shari Franke	Female	USA	2026-10-10 09:50:19.957311+00	2026-10-10 09:50:20.253688+00
830	Sable Sorensen	Female	USA	2026-10-10 09:50:20.323651+00	2026-10-10 09:50:20.451736+00
831	Sophie Lark	Female	USA	2026-10-10 09:50:20.472742+00	2026-10-10 09:50:20.950363+00
832	Annalee Newitz	Non-binary	USA	2026-10-10 09:50:21.012792+00	2026-10-10 09:50:21.151626+00
833	Noelle W. Ihli	Female	USA	2026-10-10 09:50:21.170199+00	2026-10-10 09:50:21.267849+00
834	Helene Flood	Female	Norway	2026-10-10 09:50:21.353276+00	2026-10-10 09:50:21.656736+00
835	Mark Z. Danielewski	Male	USA	2026-10-10 09:50:21.698588+00	2026-10-10 09:50:22.354426+00
836	S. T. Gibson	Female	USA	2026-10-10 09:50:22.433707+00	2026-10-10 09:50:22.557027+00
837	Freida McFadden	Female	USA	2026-10-10 09:50:22.572299+00	2026-10-10 09:50:22.756452+00
838	Dani Francis	Female	USA	2026-10-10 09:50:22.779722+00	2026-10-10 09:50:22.961348+00
839	Nuzo Onoh	Female	Nigeria	2026-10-10 09:50:22.978915+00	2026-10-10 09:50:23.159811+00
840	Tasha Coryell	Female	USA	2026-10-10 09:50:23.176118+00	2026-10-10 09:50:23.555238+00
841	Catherine Dang	Female	Vietnam	2026-10-10 09:50:23.613055+00	2026-10-10 09:50:23.757028+00
842	Clare Leslie Hall	Female	The United Kingdom	2026-10-10 09:50:23.77819+00	2026-10-10 09:50:24.066622+00
843	Brian McAuley	Male	USA	2026-10-10 09:50:24.156577+00	2026-10-10 09:50:24.350236+00
844	Jacqueline Harpman	Female	Belgium	2026-10-10 09:50:24.372205+00	2026-10-10 09:50:24.655122+00
845	Sophie Sullivan	Female	Canada	2026-10-10 09:50:24.680938+00	2026-10-10 09:50:24.857523+00
846	Oscar Wilde	Male	Ireland	2026-10-10 09:50:24.874496+00	2026-10-10 09:50:25.058811+00
847	Stephanie Garber	Female	USA	2026-10-10 09:50:25.083846+00	2026-10-10 09:50:25.258718+00
848	Ana Huang	Female	China	2026-10-10 09:50:25.285218+00	2026-10-10 09:50:25.556477+00
849	Georgia K. Boone	Female	USA	2026-10-10 09:50:25.592372+00	2026-10-10 09:50:25.770185+00
850	Allegra Goodman	Female	USA	2026-10-10 09:50:25.860371+00	2026-10-10 09:50:26.053876+00
851	Liz Nugent	Female	Ireland	2026-10-10 09:50:26.077016+00	2026-10-10 09:50:26.262077+00
852	Alta Hensley	Female	USA	2026-10-10 09:50:26.287414+00	2026-10-10 09:50:26.471869+00
853	Virginia Feito	Female	Spain	2026-10-10 09:50:26.552056+00	2026-10-10 09:50:26.668331+00
854	Liz Maverick	Female	USA	2026-10-10 09:50:26.759226+00	2026-10-10 09:50:27.05532+00
855	Emily Adrian	Female	USA	2026-10-10 09:50:27.09066+00	2026-10-10 09:50:27.47008+00
856	R. S. Burnett	Male	Falkland Islands	2026-10-10 09:50:27.622237+00	2026-10-10 09:50:28.15477+00
857	Rina Kent	Female	The United Kingdom	2026-10-10 09:50:28.227321+00	2026-10-10 09:50:28.371435+00
858	Stacia Stark	Female	New Zealand	2026-10-10 09:50:28.461814+00	2026-10-10 09:50:28.557961+00
859	Stephanie Archer	Female	Canada	2026-10-10 09:50:28.577768+00	2026-10-10 09:50:28.756956+00
860	Beth Revis	Female	USA	2026-10-10 09:50:28.775241+00	2026-10-10 09:50:29.059148+00
861	Leigh Bardugo	Female	USA	2026-10-10 09:50:29.089219+00	2026-10-10 09:50:29.85292+00
862	Abby Jimenez	Female	USA	2026-10-10 09:50:29.952203+00	2026-10-10 09:50:30.063605+00
863	Stephen Fischbach	Male	USA	2026-10-10 09:50:30.07973+00	2026-10-10 09:50:30.361274+00
864	Jennette McCurdy	Female	USA	2026-10-10 09:50:30.454646+00	2026-10-10 09:50:30.562736+00
865	Hannah Brohm	Female	Germany	2026-10-10 09:50:30.582672+00	2026-10-10 09:50:31.155469+00
866	Olivie Blake	Female	USA	2026-10-10 09:50:31.227952+00	2026-10-10 09:50:31.474874+00
867	Kasie West	Female	USA	2026-10-10 09:50:31.572292+00	2026-10-10 09:50:31.861416+00
868	Keigo Higashino	Male	Japan	2026-10-10 09:50:31.887663+00	2026-10-10 09:50:32.268248+00
869	Marisa Kashino	Female	Japan	2026-10-10 09:50:32.377217+00	2026-10-10 09:50:32.554652+00
870	Rebecca Yarros	Female	USA	2026-10-10 09:50:32.605155+00	2026-10-10 09:50:32.857736+00
871	Annie Neugebauer	Female	USA	2026-10-10 09:50:33.323894+00	2026-10-10 09:50:33.556686+00
872	Catherine Cowles	Female	USA	2026-10-10 09:50:33.590849+00	2026-10-10 09:50:33.75683+00
873	Elizabeth Arnott	Female	USA	2026-10-10 09:50:33.776443+00	2026-10-10 09:50:33.959082+00
874	Cassandra Khaw	Non-binary	Malaysia	2026-10-10 09:50:33.983934+00	2026-10-10 09:50:34.155092+00
875	Haley Pham	Female	USA	2026-10-10 09:50:34.174454+00	2026-10-10 09:50:34.270139+00
876	Asako Yuzuki	Female	Japan	2026-10-10 09:50:34.375541+00	2026-10-10 09:50:34.55724+00
877	Sheena Patel	Female	The United Kingdom	2026-10-10 09:50:34.580833+00	2026-10-10 09:50:34.857326+00
1636	Jessica Peterson	\N	\N	2026-10-11 15:10:16.654661+00	2026-10-11 15:10:16.654661+00
1637	Kate Eberle	\N	\N	2026-10-11 15:10:16.66158+00	2026-10-11 15:10:16.66158+00
1638	V. A. Vazquez	\N	\N	2026-10-11 15:10:16.668325+00	2026-10-11 15:10:16.668325+00
1639	Raphael Montes	\N	\N	2026-10-11 15:10:16.682107+00	2026-10-11 15:10:16.682107+00
1640	H. G. Carlton	\N	\N	2026-10-11 15:10:16.713097+00	2026-10-11 15:10:16.713097+00
1641	Helen Scheuerer	\N	\N	2026-10-11 15:10:16.720104+00	2026-10-11 15:10:16.720104+00
1642	T Kira Madden	\N	\N	2026-10-11 15:10:16.749322+00	2026-10-11 15:10:16.749322+00
1643	Sarina Bowen	\N	\N	2026-10-11 15:10:16.79768+00	2026-10-11 15:10:16.79768+00
1644	Amy Daws	\N	\N	2026-10-11 15:10:16.805919+00	2026-10-11 15:10:16.805919+00
1645	David Ellis	\N	\N	2026-10-11 15:10:16.899981+00	2026-10-11 15:10:16.899981+00
1646	Rosie Walsh	\N	\N	2026-10-11 15:10:16.939482+00	2026-10-11 15:10:16.939482+00
1647	Allison Speka	\N	\N	2026-10-11 15:10:16.962064+00	2026-10-11 15:10:16.962064+00
1648	Max Doty	\N	\N	2026-10-11 15:10:16.98223+00	2026-10-11 15:10:16.98223+00
1649	Laura Piper Lee	\N	\N	2026-10-11 15:10:17.036376+00	2026-10-11 15:10:17.036376+00
1650	Sarah Anderson	\N	\N	2026-10-11 15:10:17.044414+00	2026-10-11 15:10:17.044414+00
1651	Will Maclean	\N	\N	2026-10-11 15:10:17.170236+00	2026-10-11 15:10:17.170236+00
1652	Hailey Dickert	\N	\N	2026-10-11 15:10:17.189213+00	2026-10-11 15:10:17.189213+00
1653	Sabrina Hoffmann	\N	\N	2026-10-11 15:10:17.196153+00	2026-10-11 15:10:17.196153+00
1654	Rioghnach Robinson	\N	\N	2026-10-11 15:10:17.202753+00	2026-10-11 15:10:17.202753+00
1655	Kelley Armstrong	\N	\N	2026-10-11 15:10:17.226382+00	2026-10-11 15:10:17.226382+00
1656	Devney Perry	\N	\N	2026-10-11 15:10:17.361797+00	2026-10-11 15:10:17.361797+00
878	Dolki Min	Non-binary	South Korea	2026-10-10 09:50:34.895018+00	2026-10-10 09:50:35.064168+00
879	Evelyn Clarke	Female	USA	2026-10-10 09:50:35.097276+00	2026-10-10 09:50:35.556961+00
880	Rufaro Faith Mazarura	Female	The United Kingdom	2026-10-10 09:50:35.65054+00	2026-10-10 09:50:35.855563+00
881	Micah Nemerever	Male	USA	2026-10-10 09:50:35.894854+00	2026-10-10 09:50:36.058106+00
882	Barbara Truelove	Female	Australia	2026-10-10 09:50:36.081962+00	2026-10-10 09:50:36.261089+00
883	Rachel Reid	Female	Canada	2026-10-10 09:50:36.350461+00	2026-10-10 09:50:36.654973+00
884	Kat Dunn	Female	The United Kingdom	2026-10-10 09:50:36.697311+00	2026-10-10 09:50:36.858487+00
885	Julia May Jonas	Female	USA	2026-10-10 09:50:36.88335+00	2026-10-10 09:50:37.358642+00
886	Tom Vellner	Male	USA	2026-10-10 09:50:37.461736+00	2026-10-10 09:50:37.768474+00
887	Ilona Bannister	Female	USA	2026-10-10 09:50:37.853831+00	2026-10-10 09:50:38.060319+00
888	Coco Mellors	Female	The United Kingdom	2026-10-10 09:50:38.091305+00	2026-10-10 09:50:38.461296+00
889	Nisha J. Tuli	Female	USA	2026-10-10 09:50:38.504017+00	2026-10-10 09:50:38.861345+00
890	Natalie Barelli	Female	Australia	2026-10-10 09:50:38.972808+00	2026-10-10 09:50:39.450141+00
891	Mike Bockoven	Male	USA	2026-10-10 09:50:39.50174+00	2026-10-10 09:50:40.064022+00
892	Caro Claire Burke	Female	USA	2026-10-10 09:50:40.192889+00	2026-10-10 09:50:40.361429+00
893	Olga Ravn	Female	Denmark	2026-10-10 09:50:40.387728+00	2026-10-10 09:50:40.667208+00
894	Jessie Garcia	Female	USA	2026-10-10 09:50:40.690966+00	2026-10-10 09:50:40.953857+00
895	Holly Brickley	Female	Canada	2026-10-10 09:50:40.976434+00	2026-10-10 09:50:41.262647+00
896	K.M. Moronova	Female	USA	2026-10-10 09:50:41.371117+00	2026-10-10 09:50:41.668254+00
897	Gabrielle Zevin	Female	USA	2026-10-10 09:50:41.78885+00	2026-10-10 09:50:42.270895+00
898	Jessica Knoll	Female	USA	2026-10-10 09:50:42.400602+00	2026-10-10 09:50:42.563682+00
899	Edward Schmit	Male	USA	2026-10-10 09:50:42.585775+00	2026-10-10 09:50:42.766269+00
900	Craig Davidson	Male	Canada	2026-10-10 09:50:42.8598+00	2026-10-10 09:50:43.068752+00
901	Jenna Levine	Female	USA	2026-10-10 09:50:43.189734+00	2026-10-10 09:50:43.361573+00
902	Julie Olivia	Female	USA	2026-10-10 09:50:43.453579+00	2026-10-10 09:50:43.654245+00
903	Natsuko Imamura	Female	Japan	2026-10-10 09:50:43.673465+00	2026-10-10 09:50:44.068268+00
904	Holly Gramazio	Female	Australia	2026-10-10 09:50:44.206295+00	2026-10-10 09:50:45.059878+00
\.


--
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.book (id, title, book_key, year_published, pages, type, audience, language_written, cover_color, serial, poc, lgbtqia, read_before_tracking, created_at, updated_at) FROM stdin;
772	The Wives	the wives | tarryn fisher	2019	336	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:27.650875+00	2026-10-10 09:49:27.650875+00
773	No Exit	no exit | taylor adams	2018	283	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:27.697632+00	2026-10-10 09:49:27.697632+00
774	Regretting You	regretting you | colleen hoover	2019	365	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:27.756026+00	2026-10-10 09:49:27.756026+00
775	Illuminae	illuminae | amie kaufman; jay kristoff	2015	599	Novel	Young adult	English	Orange	Series	f	f	f	2026-10-10 09:49:27.787042+00	2026-10-10 09:49:27.787042+00
776	Into the Drowning Deep	into the drowning deep | mira grant	2017	440	Novel	Adult	English	Red	Series	f	t	f	2026-10-10 09:49:27.813883+00	2026-10-10 09:49:27.813883+00
777	Holding Up the Universe	holding up the universe | jennifer niven	2016	271	Novel	Young adult	English	White	Standalone	f	f	f	2026-10-10 09:49:27.872091+00	2026-10-10 09:49:27.872091+00
778	Throne of Glass	throne of glass | sarah j. maas	2013	430	Novel	Young adult	English	Purple	Series	f	f	f	2026-10-10 09:49:27.902849+00	2026-10-10 09:49:27.902849+00
779	Imaginary Friend	imaginary friend | stephen chbosky	2019	706	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:27.969903+00	2026-10-10 09:49:27.969903+00
780	The Simple Wild	the simple wild | k. a. tucker	2018	390	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:27.993016+00	2026-10-10 09:49:27.993016+00
781	The Other People	the other people | c. j. tudor	2020	400	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:28.054243+00	2026-10-10 09:49:28.054243+00
782	When We Were Vikings	when we were vikings | andrew david macdonald	2020	336	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:28.086458+00	2026-10-10 09:49:28.086458+00
783	An Ember in the Ashes	an ember in the ashes | sabaa tahir	2016	311	Novel	Young adult	English	Yellow	Series	t	f	f	2026-10-10 09:49:28.151846+00	2026-10-10 09:49:28.151846+00
784	One of Us Is Next	one of us is next | karen m. mcmanus	2020	377	Novel	Young adult	English	Red	Series	f	f	f	2026-10-10 09:49:28.180683+00	2026-10-10 09:49:28.180683+00
785	Dead to Her	dead to her | sarah pinborough	2020	400	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:28.20677+00	2026-10-10 09:49:28.20677+00
786	The Song of the Fireflies	the song of the fireflies | j. a. redmerski	2014	319	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:28.27053+00	2026-10-10 09:49:28.27053+00
787	The Raven Boys	the raven boys | maggie stiefvater	2012	419	Novel	Young adult	English	White	Series	f	t	f	2026-10-10 09:49:28.302284+00	2026-10-10 09:49:28.302284+00
788	Such a Fun Age	such a fun age | kiley reid	2020	320	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:49:28.358445+00	2026-10-10 09:49:28.358445+00
789	Perfect Little Children	perfect little children | sophie hannah	2020	329	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:28.38078+00	2026-10-10 09:49:28.38078+00
790	The Dream Thieves	the dream thieves | maggie stiefvater	2013	450	Novel	Young adult	English	White	Series	f	t	f	2026-10-10 09:49:28.392053+00	2026-10-10 09:49:28.392053+00
791	Eight Perfect Murders	eight perfect murders | peter swanson	2020	288	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:28.465755+00	2026-10-10 09:49:28.465755+00
792	Baby Teeth	baby teeth | zoje stage	2018	304	Novel	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:49:28.488345+00	2026-10-10 09:49:28.488345+00
793	The Dark Dark	the dark dark | samantha hunt	2017	241	Short stories	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:49:28.514584+00	2026-10-10 09:49:28.514584+00
794	Split Tooth	split tooth | tanya tagaq	2018	202	Verse	Adult	English	White	Standalone	t	f	f	2026-10-10 09:49:28.572038+00	2026-10-10 09:49:28.572038+00
795	Pet Sematary	pet sematary | stephen king	1983	465	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:28.600511+00	2026-10-10 09:49:28.600511+00
796	What If It's Us	what if it's us | adam silvera; becky albertalli	2018	433	Novel	Young adult	English	Blue	Standalone	t	t	f	2026-10-10 09:49:28.680266+00	2026-10-10 09:49:28.680266+00
797	Vicious	vicious | v. e. schwab	2013	340	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:28.756844+00	2026-10-10 09:49:28.756844+00
798	Pretty as a Picture	pretty as a picture | elizabeth little	2020	352	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:28.781834+00	2026-10-10 09:49:28.781834+00
799	The Little Prince	the little prince | antoine de saint exupery	1943	91	Novel	Children	French	Blue	Standalone	f	f	f	2026-10-10 09:49:28.855183+00	2026-10-10 09:49:28.855183+00
800	If We Were Villains	if we were villains | m. l. rio	2017	368	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:49:28.952982+00	2026-10-10 09:49:28.952982+00
801	Wild Beauty	wild beauty | anna-marie mclemore	2017	313	Novel	Young adult	English	Multicolor	Standalone	t	t	f	2026-10-10 09:49:28.976763+00	2026-10-10 09:49:28.976763+00
802	The Song of Achilles	the song of achilles | madeline miller	2011	322	Novel	Adult	English	Yellow	Standalone	f	t	f	2026-10-10 09:49:28.998976+00	2026-10-10 09:49:28.998976+00
803	An Enchantment of Ravens	an enchantment of ravens | margaret rogerson	2017	303	Novel	Young adult	English	Multicolor	Standalone	f	f	f	2026-10-10 09:49:29.069308+00	2026-10-10 09:49:29.069308+00
804	You Are Not Alone	you are not alone | greer hendricks; sarah pekkanen	2020	343	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:29.150488+00	2026-10-10 09:49:29.150488+00
805	This Train is Being Held	this train is being held | ismee amiel williams	2020	336	Novel	Young adult	English	Pink	Standalone	t	f	f	2026-10-10 09:49:29.178261+00	2026-10-10 09:49:29.178261+00
806	Rolling in the Deep	rolling in the deep | mira grant	2015	123	Novel	Adult	English	Teal	Series	f	t	f	2026-10-10 09:49:29.185839+00	2026-10-10 09:49:29.185839+00
807	King and the Dragonflies	king and the dragonflies | kacen callender	2020	272	Novel	Middle-grade	English	Green	Standalone	t	t	f	2026-10-10 09:49:29.250515+00	2026-10-10 09:49:29.250515+00
808	Upright Women Wanted	upright women wanted | sarah gailey	2020	176	Novel	Adult	English	Teal	Standalone	f	t	f	2026-10-10 09:49:29.277801+00	2026-10-10 09:49:29.277801+00
809	Vengeful	vengeful | v. e. schwab	2018	462	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:29.285978+00	2026-10-10 09:49:29.285978+00
810	The Woman in the Window	the woman in the window | a. j. finn	2018	434	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:29.356809+00	2026-10-10 09:49:29.356809+00
811	The Poet X	the poet x | elizabeth acevedo	2018	368	Verse	Young adult	English	White	Standalone	t	f	f	2026-10-10 09:49:29.387567+00	2026-10-10 09:49:29.387567+00
812	The Wife Between Us	the wife between us | greer hendricks; sarah pekkanen	2018	351	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:29.452783+00	2026-10-10 09:49:29.452783+00
813	The Guest List	the guest list | lucy foley	2020	320	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:29.48767+00	2026-10-10 09:49:29.48767+00
814	Dear Martin	dear martin | nic stone	2017	196	Novel	Young adult	English	White	Standalone	t	f	f	2026-10-10 09:49:29.553981+00	2026-10-10 09:49:29.553981+00
815	Be Not Far From Me	be not far from me | mindy mcginnis	2020	240	Novel	Young adult	English	White	Standalone	f	f	f	2026-10-10 09:49:29.577735+00	2026-10-10 09:49:29.577735+00
816	The Kind Worth Killing	the kind worth killing | peter swanson	2015	303	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:29.584517+00	2026-10-10 09:49:29.584517+00
817	SLAY	slay | brittney morris	2019	323	Novel	Young adult	English	White	Standalone	t	f	f	2026-10-10 09:49:29.674024+00	2026-10-10 09:49:29.674024+00
818	The Deep	the deep | rivers solomon	2019	166	Novel	Adult	English	Blue	Standalone	t	t	f	2026-10-10 09:49:29.695573+00	2026-10-10 09:49:29.695573+00
819	All Boys Aren't Blue	all boys aren't blue | george m. johnson	2020	304	Memoir	Adult	English	Blue	Standalone	t	t	f	2026-10-10 09:49:29.754401+00	2026-10-10 09:49:29.754401+00
820	The Black Flamingo	the black flamingo | dean atta	2019	360	Verse	Young adult	English	Black	Standalone	t	t	f	2026-10-10 09:49:29.777357+00	2026-10-10 09:49:29.777357+00
821	You Should See Me In a Crown	you should see me in a crown | leah johnson	2020	328	Novel	Young adult	English	Purple	Standalone	t	t	f	2026-10-10 09:49:29.798778+00	2026-10-10 09:49:29.798778+00
822	Behind Closed Doors	behind closed doors | b. a. paris	2016	263	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:29.869872+00	2026-10-10 09:49:29.869872+00
823	Beach Read	beach read | emily henry	2020	361	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:29.896428+00	2026-10-10 09:49:29.896428+00
824	They Both Die at the End	they both die at the end | adam silvera	2017	368	Novel	Young adult	English	Purple	Standalone	t	t	f	2026-10-10 09:49:29.904099+00	2026-10-10 09:49:29.904099+00
825	The Unhoneymooners	the unhoneymooners | christina lauren	2019	400	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:29.976259+00	2026-10-10 09:49:29.976259+00
826	The Henna Wars	the henna wars | adiba jaigirdar	2020	400	Novel	Young adult	English	Pink	Standalone	t	t	f	2026-10-10 09:49:29.9991+00	2026-10-10 09:49:29.9991+00
827	The Cry	the cry | helen fitzgerald	2012	257	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:30.066125+00	2026-10-10 09:49:30.066125+00
828	The Southern Book Club's Guide to Slaying Vampires	the southern book club's guide to slaying vampires | grady hendrix	2020	400	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:30.163808+00	2026-10-10 09:49:30.163808+00
829	In a Dark, Dark Wood	in a dark, dark wood | ruth ware	2015	325	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:30.187044+00	2026-10-10 09:49:30.187044+00
830	Home Before Dark	home before dark | riley sager	2020	384	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:30.272943+00	2026-10-10 09:49:30.272943+00
831	Last to Die	last to die | tess gerritsen	2012	346	Novel	Adult	English	Brown	Series	f	f	f	2026-10-10 09:49:30.357937+00	2026-10-10 09:49:30.357937+00
832	As Long As We Both Shall Live	as long as we both shall live | joann chaney	2018	359	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:30.380684+00	2026-10-10 09:49:30.380684+00
833	Every Heart a Doorway	every heart a doorway | seanan mcguire	2016	173	Novel	Young adult	English	Brown	Series	t	t	f	2026-10-10 09:49:30.474175+00	2026-10-10 09:49:30.474175+00
834	The Last Flight	the last flight | julie clark	2020	288	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:30.495582+00	2026-10-10 09:49:30.495582+00
835	Carrie	carrie | stephen king	1974	242	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:30.55407+00	2026-10-10 09:49:30.55407+00
836	Mexican Gothic	mexican gothic | silvia moreno-garcia	2020	320	Novel	Adult	English	Green	Standalone	t	f	f	2026-10-10 09:49:30.583055+00	2026-10-10 09:49:30.583055+00
837	Twilight	twilight | stephenie meyer	2005	404	Novel	Young adult	English	Black	Series	f	f	f	2026-10-10 09:49:30.653669+00	2026-10-10 09:49:30.653669+00
838	Clap When You Land	clap when you land | elizabeth acevedo	2020	417	Verse	Young adult	English	Multicolor	Standalone	t	f	f	2026-10-10 09:49:30.661669+00	2026-10-10 09:49:30.661669+00
839	Good Me, Bad Me	good me, bad me | ali land	2017	320	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:30.690799+00	2026-10-10 09:49:30.690799+00
840	Loveboat, Taipei	loveboat, taipei | abigail hing wen	2020	432	Novel	Young adult	English	Black	Series	t	f	f	2026-10-10 09:49:30.767804+00	2026-10-10 09:49:30.767804+00
841	One to Watch	one to watch | kate stayman-london	2020	432	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:30.789257+00	2026-10-10 09:49:30.789257+00
842	Bring Me Back	bring me back | b. a. paris	2018	267	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:30.796321+00	2026-10-10 09:49:30.796321+00
843	Gemina	gemina | amie kaufman; jay kristoff	2016	659	Novel	Young adult	English	Blue	Series	t	f	f	2026-10-10 09:49:30.803581+00	2026-10-10 09:49:30.803581+00
844	Follow Me to Ground	follow me to ground | sue rainsford	2018	208	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:30.889465+00	2026-10-10 09:49:30.889465+00
845	Wild at Heart	wild at heart | k. a. tucker	2020	456	Novel	Adult	English	Multicolor	Series	f	f	f	2026-10-10 09:49:30.896573+00	2026-10-10 09:49:30.896573+00
846	Pines	pines | blake crouch	2012	299	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:30.953544+00	2026-10-10 09:49:30.953544+00
847	All Your Twisted Secrets	all your twisted secrets | diana urban	2020	400	Novel	Young adult	English	White	Standalone	f	t	f	2026-10-10 09:49:30.974655+00	2026-10-10 09:49:30.974655+00
848	Down Among the Sticks and Bones	down among the sticks and bones | seanan mcguire	2017	187	Novel	Young adult	English	Black	Series	f	t	f	2026-10-10 09:49:30.982046+00	2026-10-10 09:49:30.982046+00
849	Salt to the Sea	salt to the sea | ruta sepetys	2016	342	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:31.010431+00	2026-10-10 09:49:31.010431+00
850	The Falling in Love Montage	the falling in love montage | ciara smyth	2020	368	Novel	Young adult	English	Pink	Standalone	f	t	f	2026-10-10 09:49:31.073683+00	2026-10-10 09:49:31.073683+00
851	Beneath the Sugar Sky	beneath the sugar sky | seanan mcguire	2018	174	Novel	Young adult	English	Pink	Series	t	t	f	2026-10-10 09:49:31.081707+00	2026-10-10 09:49:31.081707+00
852	Clown in a Cornfield	clown in a cornfield | adam cesare	2020	352	Novel	Young adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:31.154771+00	2026-10-10 09:49:31.154771+00
853	The Woman in Cabin 10	the woman in cabin 10 | ruth ware	2016	351	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:31.163531+00	2026-10-10 09:49:31.163531+00
854	Undercover Bromance	undercover bromance | lyssa kay adams	2020	320	Novel	Adult	English	Yellow	Series	t	f	f	2026-10-10 09:49:31.193652+00	2026-10-10 09:49:31.193652+00
855	Freshwater	freshwater | akwaeke emezi	2018	229	Novel	Adult	English	Pink	Standalone	t	t	f	2026-10-10 09:49:31.269457+00	2026-10-10 09:49:31.269457+00
856	My Dark Vanessa	my dark vanessa | kate elizabeth russell	2020	373	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:31.293447+00	2026-10-10 09:49:31.293447+00
857	Something in the Water	something in the water | catherine steadman	2018	366	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:31.368812+00	2026-10-10 09:49:31.368812+00
858	It	it | stephen king	1986	1376	Novel	Adult	English	Orange	Standalone	t	f	f	2026-10-10 09:49:31.376327+00	2026-10-10 09:49:31.376327+00
859	The Shadows	the shadows | alex north	2020	336	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:31.450532+00	2026-10-10 09:49:31.450532+00
860	The Death of Mrs. Westaway	the death of mrs. westaway | ruth ware	2018	381	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:31.459396+00	2026-10-10 09:49:31.459396+00
861	Wonderland	wonderland | zoje stage	2020	354	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:31.46705+00	2026-10-10 09:49:31.46705+00
862	Kill Creek	kill creek | scott thomas	2017	416	Novel	Adult	English	White	Standalone	f	t	f	2026-10-10 09:49:31.502502+00	2026-10-10 09:49:31.502502+00
863	When No One is Watching	when no one is watching | alyssa cole	2020	368	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:49:31.569841+00	2026-10-10 09:49:31.569841+00
864	Grad zvijeri	grad zvijeri | andrea tomić	2019	321	Novel	Adult	Croatian	Blue	Standalone	f	f	f	2026-10-10 09:49:31.592538+00	2026-10-10 09:49:31.592538+00
865	Blue Lily, Lily Blue	blue lily, lily blue | maggie stiefvater	2014	381	Novel	Young adult	English	White	Series	f	t	f	2026-10-10 09:49:31.652882+00	2026-10-10 09:49:31.652882+00
866	Survivor Song	survivor song | paul tremblay	2020	320	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:31.684811+00	2026-10-10 09:49:31.684811+00
867	Felix Ever After	felix ever after | kacen callender	2020	368	Novel	Young adult	English	Orange	Standalone	t	t	f	2026-10-10 09:49:31.693347+00	2026-10-10 09:49:31.693347+00
868	Malorie	malorie | josh malerman	2020	301	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:31.769498+00	2026-10-10 09:49:31.769498+00
869	The Sun Down Motel	the sun down motel | simone st. james	2020	389	Novel	Adult	English	Multicolor	Standalone	f	f	f	2026-10-10 09:49:31.793735+00	2026-10-10 09:49:31.793735+00
870	The Hollow Places	the hollow places | t. kingfisher	2020	352	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:31.869801+00	2026-10-10 09:49:31.869801+00
871	In a Holidaze	in a holidaze | christina lauren	2020	336	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:31.878424+00	2026-10-10 09:49:31.878424+00
872	One by One	one by one | ruth ware	2020	372	Novel	Adult	English	White	Standalone	f	t	f	2026-10-10 09:49:31.886595+00	2026-10-10 09:49:31.886595+00
873	I'm Thinking of Ending Things	i'm thinking of ending things | iain reid	2016	210	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:31.984899+00	2026-10-10 09:49:31.984899+00
874	The Raven King	the raven king | maggie stiefvater	2016	438	Novel	Young adult	English	White	Series	f	t	f	2026-10-10 09:49:31.99333+00	2026-10-10 09:49:31.99333+00
875	Layla	layla | colleen hoover	2020	301	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:32.001179+00	2026-10-10 09:49:32.001179+00
876	Faking It	faking it | cora carmack	2013	271	Novel	Adult	English	Multicolor	Series	f	f	f	2026-10-10 09:49:32.0849+00	2026-10-10 09:49:32.0849+00
877	NOS4A2	nos4a2 | joe hill	2013	575	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:32.107355+00	2026-10-10 09:49:32.107355+00
878	Sleigh Bells in the Snow	sleigh bells in the snow | sarah morgan	2013	297	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:32.171156+00	2026-10-10 09:49:32.171156+00
879	In the Dream House	in the dream house | carmen maria machado	2019	251	Memoir	Adult	English	Green	Standalone	t	t	f	2026-10-10 09:49:32.196527+00	2026-10-10 09:49:32.196527+00
880	The Quality of Silence	the quality of silence | rosamund lupton	2015	292	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:32.372681+00	2026-10-10 09:49:32.372681+00
881	The Thousandth Floor	the thousandth floor | katherine mcgee	2016	385	Novel	Young adult	English	Yellow	Series	f	f	f	2026-10-10 09:49:32.450494+00	2026-10-10 09:49:32.450494+00
882	Written in the Stars	written in the stars | alexandria bellefleur	2020	384	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:32.473371+00	2026-10-10 09:49:32.473371+00
883	Beartown	beartown | fredrik backman	2016	439	Novel	Adult	Swedish	Blue	Series	f	f	f	2026-10-10 09:49:32.496958+00	2026-10-10 09:49:32.496958+00
884	The Cousins	the cousins | karen m. mcmanus	2020	337	Novel	Young adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:32.556976+00	2026-10-10 09:49:32.556976+00
885	The Boy in the Headlights	the boy in the headlights | samuel bjørk	2018	423	Novel	Adult	Norwegian	Black	Series	f	f	f	2026-10-10 09:49:32.588616+00	2026-10-10 09:49:32.588616+00
886	Darling Rose Gold	darling rose gold | stephanie wrobel	2020	307	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:32.659843+00	2026-10-10 09:49:32.659843+00
887	The Wrong Family	the wrong family | tarryn fisher	2020	336	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:32.676937+00	2026-10-10 09:49:32.676937+00
888	O ljubavi, spletkama i svemu pomalo	o ljubavi, spletkama i svemu pomalo | vlasta golub	2016	144	Novel	Young adult	Croatian	White	Standalone	f	f	f	2026-10-10 09:49:32.778199+00	2026-10-10 09:49:32.778199+00
889	The Dazzling Heights	the dazzling heights | katherine mcgee	2017	364	Novel	Young adult	English	Blue	Series	f	f	f	2026-10-10 09:49:32.78641+00	2026-10-10 09:49:32.78641+00
890	Heart Bones	heart bones | colleen hoover	2020	338	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:32.794254+00	2026-10-10 09:49:32.794254+00
891	The Ex Talk	the ex talk | rachel lynn solomon	2021	336	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:32.879087+00	2026-10-10 09:49:32.879087+00
892	The Whisper Man	the whisper man | alex north	2018	321	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:32.887215+00	2026-10-10 09:49:32.887215+00
893	Black Eyed Susans	black eyed susans | julia heaberlin	2015	359	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:32.965775+00	2026-10-10 09:49:32.965775+00
894	Beautiful Bastard	beautiful bastard | christina lauren	2013	252	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:32.975772+00	2026-10-10 09:49:32.975772+00
895	Crazy Stupid Bromance	crazy stupid bromance | lyssa kay adams	2020	342	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:32.985285+00	2026-10-10 09:49:32.985285+00
896	The Towering Sky	the towering sky | katherine mcgee	2018	388	Novel	Young adult	English	Pink	Series	f	f	f	2026-10-10 09:49:33.054948+00	2026-10-10 09:49:33.054948+00
897	Pet	pet | akwaeke emezi	2019	208	Novel	Middle-grade	English	Pink	Standalone	t	t	f	2026-10-10 09:49:33.068621+00	2026-10-10 09:49:33.068621+00
898	Beautiful Bitch	beautiful bitch | christina lauren	2013	175	Novella	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:33.154631+00	2026-10-10 09:49:33.154631+00
899	Behind Her Eyes	behind her eyes | sarah pinborough	2016	353	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:49:33.164498+00	2026-10-10 09:49:33.164498+00
900	The Cavern	the cavern | alister hodge	2019	207	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:33.310608+00	2026-10-10 09:49:33.310608+00
901	The Kiss Quotient	the kiss quotient | helen hoang	2018	290	Novel	Adult	English	Teal	Series	t	f	f	2026-10-10 09:49:33.354206+00	2026-10-10 09:49:33.354206+00
902	The Seven Husbands of Evelyn Hugo	the seven husbands of evelyn hugo | taylor jenkins reid	2017	416	Novel	Adult	English	Green	Standalone	t	t	f	2026-10-10 09:49:33.386206+00	2026-10-10 09:49:33.386206+00
903	These Witches Don't Burn	these witches don't burn | isabel sterling	2019	336	Novel	Young adult	English	Purple	Series	f	t	f	2026-10-10 09:49:33.473986+00	2026-10-10 09:49:33.473986+00
904	Elevation	elevation | stephen king	2018	146	Novella	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:33.5523+00	2026-10-10 09:49:33.5523+00
905	Beautiful Stranger	beautiful stranger | christina lauren	2013	279	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:33.568895+00	2026-10-10 09:49:33.568895+00
906	In an Absent Dream	in an absent dream | seanan mcguire	2019	187	Novella	Young adult	English	Teal	Series	f	f	f	2026-10-10 09:49:33.58785+00	2026-10-10 09:49:33.58785+00
907	Binti	binti | nnedi okorafor	2015	96	Novella	Young adult	English	Brown	Series	t	f	f	2026-10-10 09:49:33.719475+00	2026-10-10 09:49:33.719475+00
908	Beautiful Bombshell	beautiful bombshell | christina lauren	2013	173	Novella	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:33.758029+00	2026-10-10 09:49:33.758029+00
909	The Idea of You	the idea of you | robinne lee	2017	372	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:33.856369+00	2026-10-10 09:49:33.856369+00
910	Black Sun	black sun | rebecca roanhorse	2020	454	Novel	Adult	English	Black	Series	t	t	f	2026-10-10 09:49:33.889435+00	2026-10-10 09:49:33.889435+00
911	Heart-Shaped Box	heart-shaped box | joe hill	2007	265	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:33.957615+00	2026-10-10 09:49:33.957615+00
912	99 Percent Mine	99 percent mine | sally thorne	2019	295	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:34.055874+00	2026-10-10 09:49:34.055874+00
913	The Heart's Invisible Furies	the heart's invisible furies | john boyne	2017	582	Novel	Adult	English	Green	Standalone	f	t	f	2026-10-10 09:49:34.093294+00	2026-10-10 09:49:34.093294+00
914	Circe	circe | madeline miller	2018	347	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:34.155426+00	2026-10-10 09:49:34.155426+00
915	Every Vow You Break	every vow you break | peter swanson	2021	308	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:34.168635+00	2026-10-10 09:49:34.168635+00
916	The Colour of Bee Larkham's Murder	the colour of bee larkham's murder | sarah j. harris	2018	371	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:34.284259+00	2026-10-10 09:49:34.284259+00
917	The Thursday Murder Club	the thursday murder club | richard osman	2020	324	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:34.35602+00	2026-10-10 09:49:34.35602+00
918	The Golden Cage	the golden cage | camilla läckberg	2019	290	Novel	Adult	Swedish	Pink	Series	f	f	f	2026-10-10 09:49:34.454764+00	2026-10-10 09:49:34.454764+00
919	A House at the Bottom of the Lake	a house at the bottom of the lake | josh malerman	2016	118	Novella	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:34.465482+00	2026-10-10 09:49:34.465482+00
920	They Never Learn	they never learn | layne fargo	2020	378	Novel	Adult	English	Red	Standalone	f	t	f	2026-10-10 09:49:34.562449+00	2026-10-10 09:49:34.562449+00
921	31 nogometni teren	31 nogometni teren | matea čvagić prašnjak	2020	335	Novel	Adult	Croatian	Purple	Standalone	f	f	f	2026-10-10 09:49:34.592578+00	2026-10-10 09:49:34.592578+00
922	The Perfect Child	the perfect child | lucinda berry	2019	365	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:34.694313+00	2026-10-10 09:49:34.694313+00
923	Broken Things	broken things | lauren oliver	2018	408	Novel	Young adult	English	Black	Standalone	f	t	f	2026-10-10 09:49:34.782496+00	2026-10-10 09:49:34.782496+00
924	The Push	the push | ashley audrain	2021	307	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:34.858954+00	2026-10-10 09:49:34.858954+00
925	Anxious People	anxious people | fredrik backman	2019	357	Novel	Adult	Swedish	Yellow	Standalone	f	t	f	2026-10-10 09:49:34.876551+00	2026-10-10 09:49:34.876551+00
926	I'm Not Scared	i'm not scared | niccolò ammaniti	2001	225	Novel	Adult	Italian	Beige	Standalone	f	f	f	2026-10-10 09:49:35.039902+00	2026-10-10 09:49:35.039902+00
927	My Brilliant Friend	my brilliant friend | elena ferrante	2011	349	Novel	Adult	Italian	Gray	Series	f	f	f	2026-10-10 09:49:35.162479+00	2026-10-10 09:49:35.162479+00
928	Forever Wild	forever wild | k. a. tucker	2020	158	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:35.173881+00	2026-10-10 09:49:35.173881+00
929	Cesta za Zion	cesta za zion | matea čvagić prašnjak	2018	139	Novella	Adult	Croatian	Pink	Standalone	f	f	f	2026-10-10 09:49:35.189239+00	2026-10-10 09:49:35.189239+00
930	The Bright Lands	the bright lands | john fram	2020	473	Novel	Adult	English	Purple	Standalone	f	t	f	2026-10-10 09:49:35.501271+00	2026-10-10 09:49:35.501271+00
931	Cemetery Boys	cemetery boys | aiden thomas	2020	352	Novel	Young adult	English	Pink	Standalone	t	t	f	2026-10-10 09:49:35.528642+00	2026-10-10 09:49:35.528642+00
932	Malibu Rising	malibu rising | taylor jenkins reid	2021	384	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:35.555821+00	2026-10-10 09:49:35.555821+00
933	Cuando estuvimos muertos	cuando estuvimos muertos | francesc miralles	2010	351	Novel	Young adult	Spanish	Black	Series	f	f	f	2026-10-10 09:49:35.595667+00	2026-10-10 09:49:35.595667+00
934	This is Not a Horror Movie	this is not a horror movie | sara dobie bauer	2021	280	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:35.673414+00	2026-10-10 09:49:35.673414+00
935	The Duke and I	the duke and i | julia quinn	2000	348	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:35.754681+00	2026-10-10 09:49:35.754681+00
936	Sawkill Girls	sawkill girls | claire legrand	2018	447	Novel	Young adult	English	Gray	Standalone	t	t	f	2026-10-10 09:49:35.782349+00	2026-10-10 09:49:35.782349+00
937	Misery	misery | stephen king	1987	293	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:35.790971+00	2026-10-10 09:49:35.790971+00
938	The One	the one | john marrs	2016	437	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:35.883249+00	2026-10-10 09:49:35.883249+00
939	The Mother-in-Law	the mother-in-law | sally hepworth	2019	316	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:35.971151+00	2026-10-10 09:49:35.971151+00
940	Lie With Me	lie with me | philippe besson	2017	149	Novella	Adult	French	Gray	Standalone	f	t	f	2026-10-10 09:49:36.054082+00	2026-10-10 09:49:36.054082+00
941	The Broken Girls	the broken girls | simone st. james	2018	356	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:36.063188+00	2026-10-10 09:49:36.063188+00
942	My Best Friend's Exorcism	my best friend's exorcism | grady hendrix	2016	337	Novel	Young adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:36.07484+00	2026-10-10 09:49:36.07484+00
943	The Chalk Man	the chalk man | c. j. tudor	2018	298	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:36.084458+00	2026-10-10 09:49:36.084458+00
944	Survive the Night	survive the night | riley sager	2021	336	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:36.155426+00	2026-10-10 09:49:36.155426+00
945	Night of the Mannequins	night of the mannequins | stephen graham jones	2020	136	Novella	Adult	English	Beige	Standalone	t	f	f	2026-10-10 09:49:36.250504+00	2026-10-10 09:49:36.250504+00
946	The Soulmate Equation	the soulmate equation | christina lauren	2021	368	Novel	Adult	English	Yellow	Series	f	f	f	2026-10-10 09:49:36.260904+00	2026-10-10 09:49:36.260904+00
947	Losing It	losing it | cora carmack	2012	222	Novel	Adult	English	Multicolor	Series	f	f	f	2026-10-10 09:49:36.271169+00	2026-10-10 09:49:36.271169+00
948	The Surgeon	the surgeon | tess gerritsen	2001	330	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:36.280502+00	2026-10-10 09:49:36.280502+00
949	Beautiful Player	beautiful player | christina lauren	2013	432	Novel	Adult	English	Green	Series	f	f	f	2026-10-10 09:49:36.356437+00	2026-10-10 09:49:36.356437+00
950	The Final Girl Support Group	the final girl support group | grady hendrix	2021	393	Novel	Adult	English	Red	Standalone	t	t	f	2026-10-10 09:49:36.365641+00	2026-10-10 09:49:36.365641+00
951	Roomies	roomies | christina lauren	2017	369	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:36.374515+00	2026-10-10 09:49:36.374515+00
952	One Last Stop	one last stop | casey mcquiston	2021	422	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:49:36.515691+00	2026-10-10 09:49:36.515691+00
953	Warcross	warcross | marie lu	2017	353	Novel	Young adult	English	White	Series	t	f	f	2026-10-10 09:49:36.574715+00	2026-10-10 09:49:36.574715+00
954	Finding It	finding it | cora carmack	2013	259	Novel	Adult	English	Multicolor	Series	f	f	f	2026-10-10 09:49:36.58301+00	2026-10-10 09:49:36.58301+00
955	Finlay Donovan Is Killing It	finlay donovan is killing it | elle cosimano	2021	314	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:36.660322+00	2026-10-10 09:49:36.660322+00
956	The Flatshare	the flatshare | beth o'leary	2019	414	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:36.68537+00	2026-10-10 09:49:36.68537+00
957	The Roomate	the roomate | rosie danan	2020	325	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:36.769911+00	2026-10-10 09:49:36.769911+00
958	Suddenly Last Summer	suddenly last summer | sarah morgan	2014	297	Novel	Adult	English	Green	Series	f	f	f	2026-10-10 09:49:36.778718+00	2026-10-10 09:49:36.778718+00
959	Štorka	štorka | jelena hrvoj	2015	414	Novel	Adult	Croatian	Green	Series	f	f	f	2026-10-10 09:49:36.854207+00	2026-10-10 09:49:36.854207+00
960	The Taking of Jake Livingston	the taking of jake livingston | ryan douglass	2021	244	Novel	Young adult	English	Teal	Standalone	t	t	f	2026-10-10 09:49:36.880596+00	2026-10-10 09:49:36.880596+00
961	Beautiful Beginning	beautiful beginning | christina lauren	2013	241	Novella	Adult	English	Teal	Series	f	f	f	2026-10-10 09:49:36.950737+00	2026-10-10 09:49:36.950737+00
962	Birthday Girl	birthday girl | penelope douglas	2018	417	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:36.988364+00	2026-10-10 09:49:36.988364+00
963	Beautiful Beloved	beautiful beloved | christina lauren	2015	129	Novel	Adult	English	Green	Series	f	f	f	2026-10-10 09:49:36.997143+00	2026-10-10 09:49:36.997143+00
964	The Drowning Kind	the drowning kind | jennifer mcmahon	2021	307	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:37.079205+00	2026-10-10 09:49:37.079205+00
965	The Long Way to a Small, Angry Planet	the long way to a small, angry planet | becky chambers	2014	415	Novel	Adult	English	Purple	Series	t	t	f	2026-10-10 09:49:37.156165+00	2026-10-10 09:49:37.156165+00
966	The Invisible Life of Addie Larue	the invisible life of addie larue | v. e. schwab	2020	442	Novel	Adult	English	Brown	Standalone	f	t	f	2026-10-10 09:49:37.165434+00	2026-10-10 09:49:37.165434+00
967	The Risk	the risk | s. t. abby	2016	105	Novella	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:37.270948+00	2026-10-10 09:49:37.270948+00
968	Doručak	doručak | dinko mihovilović	2021	160	Novella	Adult	Croatian	Beige	Standalone	f	f	f	2026-10-10 09:49:37.350892+00	2026-10-10 09:49:37.350892+00
969	Things Have Gotten Worse Since We Last Spoke	things have gotten worse since we last spoke | eric larocca	2021	102	Novella	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:37.386704+00	2026-10-10 09:49:37.386704+00
970	Little Eyes	little eyes | samanta schweblin	2018	207	Novel	Adult	Spanish	White	Standalone	f	f	f	2026-10-10 09:49:37.47374+00	2026-10-10 09:49:37.47374+00
971	Isn't It Bromantic	isn't it bromantic | lyssa kay adams	2021	350	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:37.483594+00	2026-10-10 09:49:37.483594+00
972	Get a Life, Chloe Brown	get a life, chloe brown | talia hibbert	2019	369	Novel	Adult	English	White	Series	t	f	f	2026-10-10 09:49:37.584134+00	2026-10-10 09:49:37.584134+00
973	The Tattooist of Auschwitz	the tattooist of auschwitz | heather morris	2017	225	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:37.654834+00	2026-10-10 09:49:37.654834+00
974	Daisy Jones & The Six	daisy jones & the six | taylor jenkins reid	2019	355	Novel	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:49:37.664559+00	2026-10-10 09:49:37.664559+00
975	The Hole	the hole | hye young pyun	2016	137	Novella	Adult	Korean	Beige	Standalone	t	f	f	2026-10-10 09:49:37.754608+00	2026-10-10 09:49:37.754608+00
976	Sidetracked	sidetracked | s. t. abby	2016	95	Novella	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:37.765153+00	2026-10-10 09:49:37.765153+00
977	The Shining	the shining | stephen king	1977	412	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:37.775096+00	2026-10-10 09:49:37.775096+00
978	The Sanatorium	the sanatorium | sarah pearse	2021	346	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:37.953784+00	2026-10-10 09:49:37.953784+00
979	Yes, Daddy	yes, daddy | jonathan parks-ramage	2021	282	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:49:37.980429+00	2026-10-10 09:49:37.980429+00
980	The Rumor	the rumor | lesley kara	2018	295	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:38.070556+00	2026-10-10 09:49:38.070556+00
981	The Silent Companions	the silent companions | laura purcell	2017	326	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:38.153199+00	2026-10-10 09:49:38.153199+00
982	To Be Taught, If Fortunate	to be taught, if fortunate | becky chambers	2019	175	Novella	Adult	English	Orange	Standalone	t	t	f	2026-10-10 09:49:38.162129+00	2026-10-10 09:49:38.162129+00
983	Project Hail Mary	project hail mary | andy weir	2021	486	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:38.250544+00	2026-10-10 09:49:38.250544+00
984	Believe Me	believe me | j. p. delaney	2018	360	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:38.285588+00	2026-10-10 09:49:38.285588+00
985	The Maidens	the maidens | alex michaelides	2021	337	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:38.372889+00	2026-10-10 09:49:38.372889+00
986	Resin	resin | ane riel	2018	246	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:38.453967+00	2026-10-10 09:49:38.453967+00
987	The Patient	the patient | jasper dewitt	2020	224	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:38.482678+00	2026-10-10 09:49:38.482678+00
988	The Arrangement	the arrangement | kiersten modglin	2021	228	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:38.571803+00	2026-10-10 09:49:38.571803+00
989	In My Dreams I Hold a Knife	in my dreams i hold a knife | ashley winstead	2021	329	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:49:38.655877+00	2026-10-10 09:49:38.655877+00
990	The Package	the package | sebastian fitzek	2016	277	Novel	Adult	German	Beige	Standalone	f	f	f	2026-10-10 09:49:38.752854+00	2026-10-10 09:49:38.752854+00
991	Radiance	radiance | grace draven	2014	297	Novel	Adult	English	Brown	Series	f	f	f	2026-10-10 09:49:38.785683+00	2026-10-10 09:49:38.785683+00
992	House of Hollow	house of hollow | krystal sutherland	2021	292	Novel	Young adult	English	Pink	Standalone	f	t	f	2026-10-10 09:49:38.871685+00	2026-10-10 09:49:38.871685+00
993	Rock, Paper, Scissors	rock, paper, scissors | alice feeney	2021	310	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:38.960944+00	2026-10-10 09:49:38.960944+00
994	56 Days	56 days | catherine ryan howard	2021	305	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:39.055436+00	2026-10-10 09:49:39.055436+00
995	Volja	volja | mana pass	2021	253	Novel	Adult	Croatian	Red	Series	f	f	f	2026-10-10 09:49:39.080355+00	2026-10-10 09:49:39.080355+00
996	The Love Hypothesis	the love hypothesis | ali hazelwood	2021	352	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:39.175244+00	2026-10-10 09:49:39.175244+00
997	For Your Own Good	for your own good | samantha downing	2021	347	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:39.254089+00	2026-10-10 09:49:39.254089+00
998	Falling	falling | t. j. newman	2021	270	Novel	Adult	English	Multicolor	Standalone	f	f	f	2026-10-10 09:49:39.282476+00	2026-10-10 09:49:39.282476+00
999	False Witness	false witness | karin slaughter	2021	435	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:39.370945+00	2026-10-10 09:49:39.370945+00
1000	Beautiful Secret	beautiful secret | christina lauren	2015	307	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:39.453822+00	2026-10-10 09:49:39.453822+00
1001	Near the Bone	near the bone | christina henry	2021	336	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:39.493964+00	2026-10-10 09:49:39.493964+00
1002	The Whispering Dead	the whispering dead | darcy coates	2021	256	Novel	Adult	English	Red	Series	f	f	f	2026-10-10 09:49:39.573157+00	2026-10-10 09:49:39.573157+00
1003	Dark Lover	dark lover | j.r. ward	2005	455	Novel	Adult	English	Red	Series	f	f	f	2026-10-10 09:49:39.674108+00	2026-10-10 09:49:39.674108+00
1004	The Wife Upstairs	the wife upstairs | rachel hawkins	2021	290	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:39.760482+00	2026-10-10 09:49:39.760482+00
1005	The Last House on Needless Street	the last house on needless street | catriona ward	2021	363	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:39.857214+00	2026-10-10 09:49:39.857214+00
1006	Window Shopping	window shopping | tessa bailey	2021	258	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:39.887898+00	2026-10-10 09:49:39.887898+00
1007	Dipped in Holly	dipped in holly | dana isaly	2021	55	Novella	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:39.977526+00	2026-10-10 09:49:39.977526+00
1008	Maybe This Christmas	maybe this christmas | sarah morgan	2014	336	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:40.053162+00	2026-10-10 09:49:40.053162+00
1009	Scarlet Angel	scarlet angel | s. t. abby	2016	114	Novella	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:40.064017+00	2026-10-10 09:49:40.064017+00
1010	Stolen Tongues	stolen tongues | felix blackwell	2017	298	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:40.155769+00	2026-10-10 09:49:40.155769+00
1011	A Psalm for the Wild-Built	a psalm for the wild-built | becky chambers	2021	131	Novella	Adult	English	Green	Series	f	t	f	2026-10-10 09:49:40.16632+00	2026-10-10 09:49:40.16632+00
1012	A Noise Downstairs	a noise downstairs | linwood barclay	2018	356	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:40.278769+00	2026-10-10 09:49:40.278769+00
1013	The Maid	the maid | nita prose	2022	304	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:40.377904+00	2026-10-10 09:49:40.377904+00
1014	Weather Girl	weather girl | rachel lynn solomon	2022	352	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:40.455534+00	2026-10-10 09:49:40.455534+00
1015	Where They Wait	where they wait | scott carson	2021	359	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:40.555876+00	2026-10-10 09:49:40.555876+00
1016	Ice Planet Barbarians	ice planet barbarians | ruby dixon	2015	188	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:40.656559+00	2026-10-10 09:49:40.656559+00
1017	Comfort Me With Apples	comfort me with apples | catherynne m. valente	2021	103	Novella	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:49:40.756145+00	2026-10-10 09:49:40.756145+00
1018	Games We Play	games we play | dana isaly	2021	90	Novella	Adult	English	Purple	Series	f	f	f	2026-10-10 09:49:40.769421+00	2026-10-10 09:49:40.769421+00
1019	Secrets We Hunt	secrets we hunt | dana isaly	2022	72	Novella	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:40.853532+00	2026-10-10 09:49:40.853532+00
1020	These Silent Woods	these silent woods | kimi cunningham grant	2021	239	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:49:40.953036+00	2026-10-10 09:49:40.953036+00
1021	Reminders of Him	reminders of him | colleen hoover	2022	327	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:40.96401+00	2026-10-10 09:49:40.96401+00
1022	Claimed By Cupid	claimed by cupid | dana isaly	2022	63	Novella	Adult	English	Red	Series	f	f	f	2026-10-10 09:49:40.975678+00	2026-10-10 09:49:40.975678+00
1023	Under One Roof	under one roof | ali hazelwood	2022	112	Novella	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:41.062882+00	2026-10-10 09:49:41.062882+00
1024	Eyeshot	eyeshot | taylor adams	2014	287	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:41.153527+00	2026-10-10 09:49:41.153527+00
1025	Hang the Moon	hang the moon | alexandria bellefleur	2021	364	Novel	Adult	English	Purple	Series	f	t	f	2026-10-10 09:49:41.162815+00	2026-10-10 09:49:41.162815+00
1026	Stuck With You	stuck with you | ali hazelwood	2022	127	Novella	Adult	English	Green	Series	f	f	f	2026-10-10 09:49:41.174928+00	2026-10-10 09:49:41.174928+00
1027	Dead Silence	dead silence | s. a. barnes	2022	343	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:41.315546+00	2026-10-10 09:49:41.315546+00
1028	Scream For Us	scream for us | molly doyle	2021	84	Novella	Adult	English	Purple	Series	f	f	f	2026-10-10 09:49:41.355414+00	2026-10-10 09:49:41.355414+00
1029	The Man Who Died Twice	the man who died twice | richard osman	2021	324	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:41.365982+00	2026-10-10 09:49:41.365982+00
1030	All the Lies	all the lies | s. t. abby	2016	141	Novella	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:41.453881+00	2026-10-10 09:49:41.453881+00
1031	Below Zero	below zero | ali hazelwood	2022	139	Novella	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:41.467413+00	2026-10-10 09:49:41.467413+00
1032	Chef's Kiss	chef's kiss | tj alexander	2022	320	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:41.579522+00	2026-10-10 09:49:41.579522+00
1033	Hide	hide | kiersten white	2022	256	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:41.674249+00	2026-10-10 09:49:41.674249+00
1034	Before I Go To Sleep	before i go to sleep | s. j. watson	2011	288	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:41.782055+00	2026-10-10 09:49:41.782055+00
1035	My Killer Vacation	my killer vacation | tessa bailey	2022	290	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:41.855293+00	2026-10-10 09:49:41.855293+00
1036	The Butterfly Garden	the butterfly garden | dot hutchison	2016	285	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:41.953028+00	2026-10-10 09:49:41.953028+00
1037	People We Meet on Vacation	people we meet on vacation | emily henry	2021	361	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:41.974798+00	2026-10-10 09:49:41.974798+00
1038	Bath Haus	bath haus | p. j. vernon	2021	312	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:49:42.105797+00	2026-10-10 09:49:42.105797+00
1039	The Troop	the troop | nick cutter	2014	355	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:42.198776+00	2026-10-10 09:49:42.198776+00
1040	Petrified Women	petrified women | jeremy ray	2021	91	Novella	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:42.282607+00	2026-10-10 09:49:42.282607+00
1041	We Were the Lucky Ones	we were the lucky ones | georgia hunter	2017	452	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:42.388633+00	2026-10-10 09:49:42.388633+00
1042	He Started It	he started it | samantha downing	2020	377	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:42.461144+00	2026-10-10 09:49:42.461144+00
1043	Patricia Wants to Cuddle	patricia wants to cuddle | samantha allen	2022	220	Novel	Adult	English	Teal	Standalone	f	t	f	2026-10-10 09:49:42.566627+00	2026-10-10 09:49:42.566627+00
1044	Carrie Soto is Back	carrie soto is back | taylor jenkins reid	2022	364	Novel	Adult	English	Orange	Standalone	t	f	f	2026-10-10 09:49:42.578714+00	2026-10-10 09:49:42.578714+00
1045	Cursed Bunny	cursed bunny | bora chung	2017	251	Short stories	Adult	Korean	Purple	Standalone	t	f	f	2026-10-10 09:49:42.779888+00	2026-10-10 09:49:42.779888+00
1046	Fever Dream	fever dream | samanta schweblin	2017	151	Novella	Adult	Spanish	Brown	Standalone	f	f	f	2026-10-10 09:49:42.797575+00	2026-10-10 09:49:42.797575+00
1047	Horrorstör	horrorstör | grady hendrix	2014	248	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:42.86721+00	2026-10-10 09:49:42.86721+00
1048	Crossroads	crossroads | laurel hightower	2020	115	Novella	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:49:42.98886+00	2026-10-10 09:49:42.98886+00
1049	Horseman	horseman | christina henry	2021	347	Novel	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:49:43.055862+00	2026-10-10 09:49:43.055862+00
1050	A Flicker in the Dark	a flicker in the dark | stacy willingham	2022	337	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:43.156572+00	2026-10-10 09:49:43.156572+00
1051	We Need to Do Something	we need to do something | max booth iii	2020	160	Novella	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:43.25706+00	2026-10-10 09:49:43.25706+00
1052	Kiss Her Once for Me	kiss her once for me | alison cochrun	2022	368	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:43.354507+00	2026-10-10 09:49:43.354507+00
1053	The Visitor	the visitor | sergio gomez	2020	64	Novella	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:43.454292+00	2026-10-10 09:49:43.454292+00
1054	Pretty Girls	pretty girls | karin slaughter	2015	442	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:43.467794+00	2026-10-10 09:49:43.467794+00
1055	Paint It All Red	paint it all red | s. t. abby	2016	176	Novella	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:43.556061+00	2026-10-10 09:49:43.556061+00
1056	Sign Here	sign here | claudia lux	2022	390	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:43.656033+00	2026-10-10 09:49:43.656033+00
1057	Ghost 19	ghost 19 | simone st. james	2023	109	Novella	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:43.669574+00	2026-10-10 09:49:43.669574+00
1058	Wonderland	wonderland | jennifer hilier	2015	343	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:43.782102+00	2026-10-10 09:49:43.782102+00
1059	And Then I Woke Up	and then i woke up | malcolm devlin	2022	127	Novella	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:43.874642+00	2026-10-10 09:49:43.874642+00
1060	Kuća slomljenih lutaka	kuća slomljenih lutaka | vladimira becić	2017	549	Novel	Adult	Croatian	Black	Standalone	f	f	f	2026-10-10 09:49:43.954926+00	2026-10-10 09:49:43.954926+00
1061	Finlay Donovan Knocks 'Em Dead	finlay donovan knocks 'em dead | elle cosimano	2022	357	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:43.965202+00	2026-10-10 09:49:43.965202+00
1062	Sparrow	sparrow | l. j. shen	2016	344	Novel	Adult	English	Orange	Series	f	f	f	2026-10-10 09:49:44.065966+00	2026-10-10 09:49:44.065966+00
1063	Nana	nana | brandon massey	2018	246	Novel	Adult	English	Green	Standalone	t	f	f	2026-10-10 09:49:44.155831+00	2026-10-10 09:49:44.155831+00
1064	Take a Hint, Dani Brown	take a hint, dani brown | talia hibbert	2020	361	Novel	Adult	English	Yellow	Series	t	f	f	2026-10-10 09:49:44.165482+00	2026-10-10 09:49:44.165482+00
1065	The Long Walk	the long walk | stephen king	1979	270	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:44.174943+00	2026-10-10 09:49:44.174943+00
1066	Confessions	confessions | kanae minato	2008	234	Novel	Adult	Japanese	Red	Standalone	t	f	f	2026-10-10 09:49:44.293031+00	2026-10-10 09:49:44.293031+00
1067	Finna	finna | nino cipri	2020	90	Novella	Adult	English	Blue	Series	t	t	f	2026-10-10 09:49:44.370614+00	2026-10-10 09:49:44.370614+00
1068	The House Guest	the house guest | mark edwards	2020	287	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:44.481941+00	2026-10-10 09:49:44.481941+00
1069	How to Sell a Haunted House	how to sell a haunted house | grady hendrix	2023	398	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:44.554089+00	2026-10-10 09:49:44.554089+00
1070	The House Across the Lake	the house across the lake | riley sager	2022	349	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:44.563836+00	2026-10-10 09:49:44.563836+00
1071	The Spite House	the spite house | johnny compton	2023	261	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:49:44.675808+00	2026-10-10 09:49:44.675808+00
1072	Secretly Yours	secretly yours | tessa bailey	2023	384	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:44.68792+00	2026-10-10 09:49:44.68792+00
1073	The Writing Retreat	the writing retreat | julia bartz	2023	313	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:44.790146+00	2026-10-10 09:49:44.790146+00
1074	The Couple Next Door	the couple next door | shari lapena	2016	289	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:44.877333+00	2026-10-10 09:49:44.877333+00
1075	Exes and O's	exes and o's | amy lea	2023	361	Novel	Adult	English	Yellow	Series	f	f	f	2026-10-10 09:49:44.957123+00	2026-10-10 09:49:44.957123+00
1076	So Happy For You	so happy for you | celia laskey	2022	300	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:49:45.059015+00	2026-10-10 09:49:45.059015+00
1077	Several People Are Typing	several people are typing | calvin kasulke	2021	219	Novel	Adult	English	White	Standalone	f	t	f	2026-10-10 09:49:45.153048+00	2026-10-10 09:49:45.153048+00
1079	What Lies in the Woods	what lies in the woods | kate alice marshall	2023	322	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:45.25525+00	2026-10-10 09:49:45.25525+00
1080	What Moves the Dead	what moves the dead | t. kingfisher	2022	169	Novella	Adult	English	Green	Series	f	t	f	2026-10-10 09:49:45.26496+00	2026-10-10 09:49:45.26496+00
1081	The Girl in 6E	the girl in 6e | a. r. torre	2014	336	Novel	Adult	English	Red	Series	f	f	f	2026-10-10 09:49:45.363118+00	2026-10-10 09:49:45.363118+00
1082	Every Single Secret	every single secret | emily carpenter	2018	306	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:45.452676+00	2026-10-10 09:49:45.452676+00
1083	Whisper Down the Lane	whisper down the lane | clay mcleod chapman	2021	316	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:45.482438+00	2026-10-10 09:49:45.482438+00
1084	Do Not Disturb	do not disturb | a. r. torre	2015	357	Novel	Adult	English	Teal	Series	f	f	f	2026-10-10 09:49:45.556006+00	2026-10-10 09:49:45.556006+00
1085	Sweethand	sweethand | n. g. peltier	2021	305	Novel	Adult	English	Orange	Series	t	f	f	2026-10-10 09:49:45.65492+00	2026-10-10 09:49:45.65492+00
1086	The Last Word	the last word | taylor adams	2023	358	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:45.667736+00	2026-10-10 09:49:45.667736+00
1087	Not a Happy Family	not a happy family | shari lapena	2021	429	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:45.678086+00	2026-10-10 09:49:45.678086+00
1088	Square³	square³ | mira grant	2021	144	Novella	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:45.756143+00	2026-10-10 09:49:45.756143+00
1089	If You Dare	if you dare | a. r. torre	2015	368	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:45.76776+00	2026-10-10 09:49:45.76776+00
1090	Then She Was Gone	then she was gone | lisa jewell	2017	320	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:45.953979+00	2026-10-10 09:49:45.953979+00
1091	A Closed and Common Orbit	a closed and common orbit | becky chambers	2016	364	Novel	Adult	English	Red	Series	t	t	f	2026-10-10 09:49:45.964548+00	2026-10-10 09:49:45.964548+00
1092	An Elderly Lady Is Up to No Good	an elderly lady is up to no good | helene tursten	2013	93	Short stories	Adult	Swedish	Beige	Series	f	f	f	2026-10-10 09:49:46.063795+00	2026-10-10 09:49:46.063795+00
1093	I Must Betray You	i must betray you | ruta sepetys	2022	310	Novel	Young adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:46.156629+00	2026-10-10 09:49:46.156629+00
1094	Count Your Lucky Stars	count your lucky stars | alexandria bellefleur	2022	365	Novel	Adult	English	Pink	Series	f	t	f	2026-10-10 09:49:46.170776+00	2026-10-10 09:49:46.170776+00
1095	Children on the Hill	children on the hill | jennifer mcmahon	2022	338	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:46.255082+00	2026-10-10 09:49:46.255082+00
1096	The Perfect Wife	the perfect wife | j. p. delaney	2019	429	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:46.267498+00	2026-10-10 09:49:46.267498+00
1097	Love and Other Disasters	love and other disasters | anita kelly	2022	384	Novel	Adult	English	Red	Standalone	f	t	f	2026-10-10 09:49:46.405831+00	2026-10-10 09:49:46.405831+00
1098	Looking Glass Sound	looking glass sound | catriona ward	2023	323	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:46.450544+00	2026-10-10 09:49:46.450544+00
1099	Never Let You Go	never let you go | chevy stevens	2017	356	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:46.488205+00	2026-10-10 09:49:46.488205+00
1100	The Soulmate	the soulmate | sally hepworth	2022	269	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:46.55957+00	2026-10-10 09:49:46.55957+00
1101	Maeve Fly	maeve fly | c.j. leede	2023	255	Novella	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:46.664251+00	2026-10-10 09:49:46.664251+00
1102	Consumed	consumed | j.r. ward	2018	419	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:46.675114+00	2026-10-10 09:49:46.675114+00
1103	Practice Makes Perfect	practice makes perfect | sarah adams	2023	352	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:46.783814+00	2026-10-10 09:49:46.783814+00
1104	The Trees Grew Because I Bled There	the trees grew because i bled there | eric larocca	2021	202	Short stories	Adult	English	White	Standalone	f	t	f	2026-10-10 09:49:46.85409+00	2026-10-10 09:49:46.85409+00
1105	A Certain Hunger	a certain hunger | chelsea g. summers	2021	317	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:46.955924+00	2026-10-10 09:49:46.955924+00
1106	Our Last Night	our last night | taylor adams	2015	324	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:46.968035+00	2026-10-10 09:49:46.968035+00
1107	All the Dangerous Things	all the dangerous things | stacy willingham	2023	326	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:47.055747+00	2026-10-10 09:49:47.055747+00
1108	Shipped	shipped | angie hockman	2021	321	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:47.157987+00	2026-10-10 09:49:47.157987+00
1109	Penpal	penpal | dathan auerbach	2012	238	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:47.270065+00	2026-10-10 09:49:47.270065+00
1110	The Only One Left	the only one left | riley sager	2023	368	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:47.355692+00	2026-10-10 09:49:47.355692+00
1111	Come Closer	come closer | sara gran	2003	135	Novella	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:47.458547+00	2026-10-10 09:49:47.458547+00
1112	You Let Me In	you let me in | lucy clarke	2018	409	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:47.564069+00	2026-10-10 09:49:47.564069+00
1113	Our Wives Under the Sea	our wives under the sea | julia armfield	2022	229	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:49:47.68922+00	2026-10-10 09:49:47.68922+00
1114	Joyland	joyland | stephen king	2013	283	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:47.721091+00	2026-10-10 09:49:47.721091+00
1115	It Happened One Summer	it happened one summer | tessa bailey	2021	385	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:49:47.764927+00	2026-10-10 09:49:47.764927+00
1116	172 Hours on the Moon	172 hours on the moon | johan harstad	2008	368	Novel	Young adult	Swedish	Black	Standalone	f	f	f	2026-10-10 09:49:47.962834+00	2026-10-10 09:49:47.962834+00
1117	A Twisted Love Story	a twisted love story | samantha downing	2023	370	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:48.119096+00	2026-10-10 09:49:48.119096+00
1118	The Calling	the calling | james frey; nils johnson-shelton	2014	415	Novel	Young adult	English	Yellow	Series	f	f	f	2026-10-10 09:49:48.26676+00	2026-10-10 09:49:48.26676+00
1119	Dead Eleven	dead eleven | jimmy juliano	2023	472	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:48.357925+00	2026-10-10 09:49:48.357925+00
1120	Follow You Home	follow you home | mark edwards	2015	383	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:48.388525+00	2026-10-10 09:49:48.388525+00
1121	Broken Dolls	broken dolls | mique watson	2023	113	Novella	Adult	English	Red	Series	f	f	f	2026-10-10 09:49:48.48717+00	2026-10-10 09:49:48.48717+00
1122	A Head Full of Ghosts	a head full of ghosts | paul tremblay	2015	336	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:48.556647+00	2026-10-10 09:49:48.556647+00
1123	Hook, Line, and Sinker	hook, line, and sinker | tessa bailey	2022	353	Novel	Adult	English	Teal	Series	f	f	f	2026-10-10 09:49:48.572073+00	2026-10-10 09:49:48.572073+00
1124	The Last One	the last one | will dean	2023	400	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:48.755875+00	2026-10-10 09:49:48.755875+00
1125	Love, Theoretically	love, theoretically | ali hazelwood	2023	407	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:48.767375+00	2026-10-10 09:49:48.767375+00
1126	Rose Madder	rose madder | stephen king	1995	415	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:48.779062+00	2026-10-10 09:49:48.779062+00
1127	The Lying Game	the lying game | ruth ware	2017	453	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:48.857802+00	2026-10-10 09:49:48.857802+00
1128	Good Bad Girl	good bad girl | alice feeney	2023	289	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:48.868815+00	2026-10-10 09:49:48.868815+00
1129	Whalefall	whalefall | daniel kraus	2023	270	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:49.054912+00	2026-10-10 09:49:49.054912+00
1130	Role Playing	role playing | cathy yardley	2023	333	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:49.174009+00	2026-10-10 09:49:49.174009+00
1131	Daisy Darker	daisy darker | alice feeney	2022	336	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:49.2548+00	2026-10-10 09:49:49.2548+00
1132	BETA: A Technological Nightmare	beta: a technological nightmare | sammy scott	2023	501	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:49.359272+00	2026-10-10 09:49:49.359272+00
1133	The Bullet That Missed	the bullet that missed | richard osman	2022	324	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:49.453775+00	2026-10-10 09:49:49.453775+00
1134	We Have Always Lived in the Castle	we have always lived in the castle | shirley jackson	1962	146	Novella	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:49.556939+00	2026-10-10 09:49:49.556939+00
1135	None of This is True	none of this is true | lisa jewell	2023	384	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:49.571806+00	2026-10-10 09:49:49.571806+00
1136	The Family Game	the family game | catherine steadman	2022	379	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:49.658976+00	2026-10-10 09:49:49.658976+00
1137	The Stranger Upstairs	the stranger upstairs | lisa m. matlin	2023	298	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:49.795187+00	2026-10-10 09:49:49.795187+00
1138	Notes on an Execution	notes on an execution | danya kukafka	2022	306	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:49.953215+00	2026-10-10 09:49:49.953215+00
1139	Midnight Is the Darkest Hour	midnight is the darkest hour | ashley winstead	2023	349	Novel	Adult	English	Teal	Standalone	f	t	f	2026-10-10 09:49:49.967183+00	2026-10-10 09:49:49.967183+00
1140	The September House	the september house | carissa orlando	2023	344	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:50.093344+00	2026-10-10 09:49:50.093344+00
1141	The Last Thing To Burn	the last thing to burn | will dean	2021	242	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:50.164233+00	2026-10-10 09:49:50.164233+00
1142	Drowning	drowning | t. j. newman	2023	244	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:50.254627+00	2026-10-10 09:49:50.254627+00
1143	Butcher & Blackbird	butcher & blackbird | brynne weaver	2023	362	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:50.357682+00	2026-10-10 09:49:50.357682+00
1144	Natural Beauty	natural beauty | ling ling huang	2023	235	Novel	Adult	English	Beige	Standalone	t	f	f	2026-10-10 09:49:50.466257+00	2026-10-10 09:49:50.466257+00
1145	All Hallows	all hallows | christopher golden	2023	379	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:50.5747+00	2026-10-10 09:49:50.5747+00
1146	Ankle Snatcher	ankle snatcher | grady hendrix	2023	29	Novella	Adult	English	Blue	Collection	f	f	f	2026-10-10 09:49:50.664258+00	2026-10-10 09:49:50.664258+00
1147	The Resort	the resort | sarah goodwin	2023	384	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:50.789623+00	2026-10-10 09:49:50.789623+00
1148	Melt for Us	melt for us | molly doyle	2021	128	Novella	Adult	English	Red	Series	f	f	f	2026-10-10 09:49:50.857939+00	2026-10-10 09:49:50.857939+00
1149	The Mistletoe Motive	the mistletoe motive | chloe liese	2021	185	Novella	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:50.984261+00	2026-10-10 09:49:50.984261+00
1150	Dead of Winter	dead of winter | darcy coates	2023	341	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:51.055827+00	2026-10-10 09:49:51.055827+00
1151	Secret Santa	secret santa | andrew shaffer	2020	220	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:51.15707+00	2026-10-10 09:49:51.15707+00
1152	Lovelight Farms	lovelight farms | b. k. borison	2021	332	Novel	Adult	English	Teal	Series	f	f	f	2026-10-10 09:49:51.256975+00	2026-10-10 09:49:51.256975+00
1153	Everyone in My Family Has Killed Someone	everyone in my family has killed someone | benjamin stevenson	2022	367	Novel	Adult	English	Orange	Series	f	f	f	2026-10-10 09:49:51.37848+00	2026-10-10 09:49:51.37848+00
1154	The Christmas Guest	the christmas guest | peter swanson	2023	102	Novella	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:51.460676+00	2026-10-10 09:49:51.460676+00
1155	The Holiday Swap	the holiday swap | maggie knox	2021	330	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:51.593363+00	2026-10-10 09:49:51.593363+00
1156	Nobody But Us	nobody but us | laure van rensburg	2022	310	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:51.754308+00	2026-10-10 09:49:51.754308+00
1157	Sour Candy	sour candy | kealan patrick burke	2015	84	Novella	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:51.8574+00	2026-10-10 09:49:51.8574+00
1158	Out There	out there | kate folk	2022	256	Short stories	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:51.964207+00	2026-10-10 09:49:51.964207+00
1159	The Hike	the hike | lucy clarke	2023	375	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:51.980143+00	2026-10-10 09:49:51.980143+00
1160	Below	below | laurel hightower	2022	124	Novella	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:52.058057+00	2026-10-10 09:49:52.058057+00
1161	Cackle	cackle | rachel harrison	2021	291	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:52.183187+00	2026-10-10 09:49:52.183187+00
1162	This is Where We Talk Things Out	this is where we talk things out | caitlin marceau	2022	86	Novella	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:52.266562+00	2026-10-10 09:49:52.266562+00
1163	The Winter People	the winter people | jennifer mcmahon	2014	382	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:52.354725+00	2026-10-10 09:49:52.354725+00
1164	The Drift	the drift | c. j. tudor	2023	390	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:52.367591+00	2026-10-10 09:49:52.367591+00
1165	The Quiet Retreat	the quiet retreat | kiersten modglin	2022	240	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:52.456214+00	2026-10-10 09:49:52.456214+00
1166	One of the Good Guys	one of the good guys | araminta hall	2024	288	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:52.573714+00	2026-10-10 09:49:52.573714+00
1167	The Golden Spoon	the golden spoon | jessa maxwell	2023	375	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:52.686471+00	2026-10-10 09:49:52.686471+00
1168	The Tusks of Extinction	the tusks of extinction | ray nayler	2024	113	Novella	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:52.853767+00	2026-10-10 09:49:52.853767+00
1169	Yellowface	yellowface | r. f. kuang	2023	336	Novel	Adult	English	Yellow	Standalone	t	f	f	2026-10-10 09:49:52.961744+00	2026-10-10 09:49:52.961744+00
1170	The Appeal	the appeal | janice hallett	2021	445	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:53.085244+00	2026-10-10 09:49:53.085244+00
1171	No One Can Know	no one can know | kate alice marshall	2024	328	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:53.164954+00	2026-10-10 09:49:53.164954+00
1172	The Reformatory	the reformatory | tanarive due	2023	571	Novel	Adult	English	Orange	Standalone	t	f	f	2026-10-10 09:49:53.357245+00	2026-10-10 09:49:53.357245+00
1173	Out There Screaming	out there screaming | jordan peele	2023	366	Short stories	Adult	English	Gray	Standalone	t	f	f	2026-10-10 09:49:53.460483+00	2026-10-10 09:49:53.460483+00
1174	Icebreaker	icebreaker | hannah grace	2022	435	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:49:53.584593+00	2026-10-10 09:49:53.584593+00
1175	Killing Sarai	killing sarai | j. a. redmerski	2013	309	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:53.666919+00	2026-10-10 09:49:53.666919+00
1176	This Wretched Valley	this wretched valley | jenny kiefer	2024	276	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:53.855863+00	2026-10-10 09:49:53.855863+00
1177	The Shuddering	the shuddering | ania ahlborn	2013	283	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:53.961437+00	2026-10-10 09:49:53.961437+00
1178	Night's Edge	night's edge | liz kerin	2023	288	Novel	Adult	English	Teal	Series	f	f	f	2026-10-10 09:49:54.085543+00	2026-10-10 09:49:54.085543+00
1179	First Lie Wins	first lie wins | ashley elston	2024	340	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:54.253034+00	2026-10-10 09:49:54.253034+00
1180	The First Sister	the first sister | linden a. lewis	2020	342	Novel	Adult	English	Black	Series	t	t	f	2026-10-10 09:49:54.361125+00	2026-10-10 09:49:54.361125+00
1181	The Last Housewife	the last housewife | ashley winstead	2022	382	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:54.456492+00	2026-10-10 09:49:54.456492+00
1182	Bloom	bloom | delilah s. dawson	2023	162	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:54.561928+00	2026-10-10 09:49:54.561928+00
1183	Act Your Age, Eve Brown	act your age, eve brown | talia hibbert	2021	375	Novel	Adult	English	Blue	Series	t	f	f	2026-10-10 09:49:54.654572+00	2026-10-10 09:49:54.654572+00
1184	The Fury	the fury | alex michaelides	2024	250	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:49:54.665961+00	2026-10-10 09:49:54.665961+00
1185	Among the Living	among the living | tim lebbon	2024	236	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:54.797904+00	2026-10-10 09:49:54.797904+00
1186	The Only Good Indians	the only good indians | stephen graham jones	2020	349	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:49:54.850472+00	2026-10-10 09:49:54.850472+00
1187	Keep Her Secret	keep her secret | mark edwards	2023	315	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:54.862408+00	2026-10-10 09:49:54.862408+00
1188	Your Shadow Half Remains	your shadow half remains | sunny moraine	2024	134	Novella	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:49:54.9636+00	2026-10-10 09:49:54.9636+00
1189	He Will Be My Ruin	he will be my ruin | k. a. tucker	2016	341	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:54.975438+00	2026-10-10 09:49:54.975438+00
1190	Sleeping Giants	sleeping giants | sylvain neuvel	2016	376	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:55.1533+00	2026-10-10 09:49:55.1533+00
1191	Kill For Me, Kill For You	kill for me, kill for you | steve cavanagh	2023	346	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:55.256068+00	2026-10-10 09:49:55.256068+00
1192	Lease on Love	lease on love | falon ballard	2022	332	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:49:55.363977+00	2026-10-10 09:49:55.363977+00
1193	Reviving Izabel	reviving izabel | j. a. redmerski	2013	283	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:55.459019+00	2026-10-10 09:49:55.459019+00
1194	Vera Wong's Unsolicited Advice for Murderers	vera wong's unsolicited advice for murderers | jesse q. sutanto	2023	334	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:49:55.55977+00	2026-10-10 09:49:55.55977+00
1195	You've Lost a Lot of Blood	you've lost a lot of blood | eric larocca	2022	236	Novella	Adult	English	Green	Standalone	f	t	f	2026-10-10 09:49:55.655879+00	2026-10-10 09:49:55.655879+00
1196	The Echo Wife	the echo wife | sarah gailey	2021	256	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:55.669168+00	2026-10-10 09:49:55.669168+00
1197	Dear Laura	dear laura | gemma amor	2019	111	Novella	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:49:55.798366+00	2026-10-10 09:49:55.798366+00
1198	Midnight on Beacon Street	midnight on beacon street | emily ruth verona	2024	194	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:55.876216+00	2026-10-10 09:49:55.876216+00
1199	My Darling Daughter	my darling daughter | j. p. delaney	2022	385	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:55.958025+00	2026-10-10 09:49:55.958025+00
1200	The Night She Disappeared	the night she disappeared | lisa jewell	2021	465	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:56.050527+00	2026-10-10 09:49:56.050527+00
1201	Let Him In	let him in | william friend	2022	238	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:56.156871+00	2026-10-10 09:49:56.156871+00
1202	The Fiancee Farce	the fiancee farce | alexandria bellefleur	2023	384	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:49:56.167961+00	2026-10-10 09:49:56.167961+00
1203	Gone to See the River Man	gone to see the river man | kristopher triana	2020	165	Novella	Adult	English	Orange	Series	f	f	f	2026-10-10 09:49:56.287729+00	2026-10-10 09:49:56.287729+00
1204	Harry Potter and the Philosopher's Stone	harry potter and the philosopher's stone | j.k. rowling	1997	332	Novel	Middle-grade	English	Green	Series	f	f	f	2026-10-10 09:49:56.455339+00	2026-10-10 09:49:56.455339+00
1205	Murder Road	murder road | simone st. james	2024	341	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:56.470513+00	2026-10-10 09:49:56.470513+00
1206	Harry Potter and the Chamber of Secrets	harry potter and the chamber of secrets | j.k. rowling	1998	270	Novel	Middle-grade	English	Red	Series	f	f	f	2026-10-10 09:49:56.557096+00	2026-10-10 09:49:56.557096+00
1207	Harry Potter and the Prisoner of Azkaban	harry potter and the prisoner of azkaban | j.k. rowling	1999	345	Novel	Middle-grade	English	Pink	Series	f	f	f	2026-10-10 09:49:56.569662+00	2026-10-10 09:49:56.569662+00
1208	Harry Potter and the Goblet of Fire	harry potter and the goblet of fire | j.k. rowling	2000	577	Novel	Young adult	English	Green	Series	f	f	f	2026-10-10 09:49:56.659209+00	2026-10-10 09:49:56.659209+00
1209	Harry Potter and the Order of the Phoenix	harry potter and the order of the phoenix | j.k. rowling	2003	793	Novel	Young adult	English	Blue	Series	f	f	f	2026-10-10 09:49:56.753367+00	2026-10-10 09:49:56.753367+00
1210	Harry Potter and the Half-Blood Prince	harry potter and the half-blood prince | j.k. rowling	2005	519	Novel	Young adult	English	Green	Series	f	f	f	2026-10-10 09:49:56.767825+00	2026-10-10 09:49:56.767825+00
1211	Nightwatching	nightwatching | tracy sierra	2024	368	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:56.958839+00	2026-10-10 09:49:56.958839+00
1212	Harry Potter and the Deathly Hallows	harry potter and the deathly hallows | j.k. rowling	2007	610	Novel	Young adult	English	Orange	Series	f	f	f	2026-10-10 09:49:57.055344+00	2026-10-10 09:49:57.055344+00
1213	Everyone is Watching	everyone is watching | heather gudenkauf	2024	279	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:57.154123+00	2026-10-10 09:49:57.154123+00
1214	The Last Devil to Die	the last devil to die | richard osman	2023	417	Novel	Adult	English	Purple	Series	f	f	f	2026-10-10 09:49:57.167214+00	2026-10-10 09:49:57.167214+00
1215	Love on the Brain	love on the brain | ali hazelwood	2022	352	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:57.254306+00	2026-10-10 09:49:57.254306+00
1216	The Island	the island | adrian mckinty	2022	370	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:57.355982+00	2026-10-10 09:49:57.355982+00
1217	The Passengers	the passengers | john marrs	2019	404	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:57.36762+00	2026-10-10 09:49:57.36762+00
1218	All Systems Red	all systems red | martha wells	2017	144	Novella	Adult	English	Gray	Series	f	t	f	2026-10-10 09:49:57.495053+00	2026-10-10 09:49:57.495053+00
1219	Diavola	diavola | jennifer thorne	2024	305	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:49:57.664419+00	2026-10-10 09:49:57.664419+00
1220	The Swan & the Jackal	the swan & the jackal | j. a. redmerski	2014	294	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:57.753989+00	2026-10-10 09:49:57.753989+00
1221	The Good Daughter	the good daughter | karin slaughter	2017	500	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:57.76655+00	2026-10-10 09:49:57.76655+00
1222	Knock Knock Open Wide	knock knock open wide | neil sharpson	2023	384	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:49:57.956405+00	2026-10-10 09:49:57.956405+00
1223	Listen for the Lie	listen for the lie | amy tintera	2024	390	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:58.15056+00	2026-10-10 09:49:58.15056+00
1224	When She Was Me	when she was me | marlee bush	2024	346	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:58.259344+00	2026-10-10 09:49:58.259344+00
1225	Tools of Engagement	tools of engagement | tessa bailey	2020	356	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:49:58.354593+00	2026-10-10 09:49:58.354593+00
1226	Just Like Mother	just like mother | anne heltzel	2022	320	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:58.46533+00	2026-10-10 09:49:58.46533+00
1227	The House That Horror Built	the house that horror built | christina henry	2024	317	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:49:58.554862+00	2026-10-10 09:49:58.554862+00
1228	The Return	the return | rachel harrison	2020	296	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:58.570023+00	2026-10-10 09:49:58.570023+00
1229	The Honey-Don't List	the honey-don't list | christina lauren	2020	303	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:49:58.661292+00	2026-10-10 09:49:58.661292+00
1230	One Perfect Couple	one perfect couple | ruth ware	2024	360	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:58.673117+00	2026-10-10 09:49:58.673117+00
1231	They Were Here Before Us	they were here before us | eric larocca	2022	80	Novella	Adult	English	White	Standalone	f	t	f	2026-10-10 09:49:58.760048+00	2026-10-10 09:49:58.760048+00
1232	Such Sharp Teeth	such sharp teeth | rachel harrison	2022	315	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:58.850538+00	2026-10-10 09:49:58.850538+00
1233	Mr. Nobody	mr. nobody | catherine steadman	2020	344	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:49:58.8637+00	2026-10-10 09:49:58.8637+00
1234	Middle of the Night	middle of the night | riley sager	2024	366	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:49:58.950512+00	2026-10-10 09:49:58.950512+00
1235	Seeds of Iniquity	seeds of iniquity | j. a. redmerski	2014	247	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:58.964611+00	2026-10-10 09:49:58.964611+00
1236	The Roughest Draft	the roughest draft | austin siegemund-broka; emily wibberley	2022	313	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:49:59.253594+00	2026-10-10 09:49:59.253594+00
1237	First Born	first born | will dean	2022	358	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:49:59.268211+00	2026-10-10 09:49:59.268211+00
1238	Book Lovers	book lovers | emily henry	2022	373	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:59.357647+00	2026-10-10 09:49:59.357647+00
1239	Stranded	stranded | sarah goodwin	2021	390	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:59.456834+00	2026-10-10 09:49:59.456834+00
1240	Good Girl Complex	good girl complex | elle kennedy	2022	355	Novel	Adult	English	Orange	Series	f	f	f	2026-10-10 09:49:59.608753+00	2026-10-10 09:49:59.608753+00
1241	Something Wilder	something wilder | christina lauren	2022	361	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:49:59.656826+00	2026-10-10 09:49:59.656826+00
1242	Unbury Carol	unbury carol | josh malerman	2018	362	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:59.67105+00	2026-10-10 09:49:59.67105+00
1243	How to Make a Horror Movie and Survive	how to make a horror movie and survive | craig dilouie	2024	430	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:49:59.855058+00	2026-10-10 09:49:59.855058+00
1244	The Black Wolf	the black wolf | j. a. redmerski	2015	280	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:49:59.867247+00	2026-10-10 09:49:59.867247+00
1245	Dear Child	dear child | romy hausmann	2019	326	Novel	Adult	German	White	Standalone	f	f	f	2026-10-10 09:50:00.057729+00	2026-10-10 09:50:00.057729+00
1246	Flawless	flawless | elsie silver	2022	397	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:00.16322+00	2026-10-10 09:50:00.16322+00
1247	Leave the World Behind	leave the world behind | rumaan alam	2020	268	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:00.281245+00	2026-10-10 09:50:00.281245+00
1248	The Nanny	the nanny | lana ferguson	2023	403	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:00.457268+00	2026-10-10 09:50:00.457268+00
1249	The Chamber	the chamber | will dean	2024	303	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:00.471898+00	2026-10-10 09:50:00.471898+00
1250	Incidents Around the House	incidents around the house | josh malerman	2024	298	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:00.560812+00	2026-10-10 09:50:00.560812+00
1251	Remnant Population	remnant population | elizabeth moon	1996	360	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:00.750587+00	2026-10-10 09:50:00.750587+00
1252	Ladykiller	ladykiller | katherine wood	2024	382	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:00.854063+00	2026-10-10 09:50:00.854063+00
1253	Attached at the Hip	attached at the hip | christine riccio	2024	419	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:00.9607+00	2026-10-10 09:50:00.9607+00
1254	Bury Your Gays	bury your gays | chuck tingle	2024	318	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:50:01.058853+00	2026-10-10 09:50:01.058853+00
1255	The Laws of the Skies	the laws of the skies | gregoire curtois	2016	118	Novella	Adult	French	Green	Standalone	f	f	f	2026-10-10 09:50:01.179067+00	2026-10-10 09:50:01.179067+00
1256	The Haar	the haar | david sodergren	2022	206	Novella	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:01.283259+00	2026-10-10 09:50:01.283259+00
1257	Such Pretty Flowers	such pretty flowers | k. l. cerra	2023	286	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:01.45547+00	2026-10-10 09:50:01.45547+00
1258	The Pumpkin Spice Café	the pumpkin spice café | laurie gilmore	2023	286	Novel	Adult	English	Orange	Series	f	f	f	2026-10-10 09:50:01.558809+00	2026-10-10 09:50:01.558809+00
1259	Wrong Place, Wrong Time	wrong place, wrong time | gillian mcallister	2022	312	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:01.677999+00	2026-10-10 09:50:01.677999+00
1260	Episode Thirteen	episode thirteen | craig dilouie	2023	433	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:01.757687+00	2026-10-10 09:50:01.757687+00
1261	Nestlings	nestlings | nat cassidy	2023	367	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:50:01.88612+00	2026-10-10 09:50:01.88612+00
1262	Behind the Hands That Kill	behind the hands that kill | j. a. redmerski	2016	220	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:01.956104+00	2026-10-10 09:50:01.956104+00
1263	Our Kind of Cruelty	our kind of cruelty | araminta hall	2018	345	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:01.968806+00	2026-10-10 09:50:01.968806+00
1264	1922	1922 | stephen king	2010	154	Novella	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:02.057473+00	2026-10-10 09:50:02.057473+00
1265	Leather & Lark	leather & lark | brynne weaver	2024	390	Novel	Adult	English	Teal	Series	f	f	f	2026-10-10 09:50:02.153216+00	2026-10-10 09:50:02.153216+00
1266	Home Is Where the Bodies Are	home is where the bodies are | jeneva rose	2024	266	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:02.258314+00	2026-10-10 09:50:02.258314+00
1267	We Used To Live Here	we used to live here | marcus kliewer	2024	264	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:02.361292+00	2026-10-10 09:50:02.361292+00
1268	Annie Bot	annie bot | sierra greer	2024	252	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:02.479885+00	2026-10-10 09:50:02.479885+00
1269	Not in Love	not in love | ali hazelwood	2024	379	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:02.555711+00	2026-10-10 09:50:02.555711+00
1270	The Eyes Are the Best Part	the eyes are the best part | monika kim	2024	283	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:50:02.756566+00	2026-10-10 09:50:02.756566+00
1271	Bride	bride | ali hazelwood	2024	396	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:02.772955+00	2026-10-10 09:50:02.772955+00
1272	The Night Guest	the night guest | hildur knutsdottir	2021	197	Novella	Adult	Icelandic	Pink	Standalone	f	f	f	2026-10-10 09:50:02.960872+00	2026-10-10 09:50:02.960872+00
1273	Worst Case Scenario	worst case scenario | t. j. newman	2024	307	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:03.058467+00	2026-10-10 09:50:03.058467+00
1274	The Launch Party	the launch party | lauren a. forry	2023	368	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:03.183208+00	2026-10-10 09:50:03.183208+00
1275	You Better Watch Out	you better watch out | darren wearmouth; james s. murray	2024	201	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:03.45911+00	2026-10-10 09:50:03.45911+00
1276	We Solve Murders	we solve murders | richard osman	2024	380	Novel	Adult	English	Beige	Series	f	f	f	2026-10-10 09:50:03.553299+00	2026-10-10 09:50:03.553299+00
1277	Cruel Winter With You	cruel winter with you | ali hazelwood	2024	60	Novella	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:03.574096+00	2026-10-10 09:50:03.574096+00
1278	Dearest	dearest | jacquie walters	2024	292	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:50:03.76567+00	2026-10-10 09:50:03.76567+00
1279	Make the Season Bright	make the season bright | ashley herring blake	2024	341	Novel	Adult	English	Green	Standalone	f	t	f	2026-10-10 09:50:03.956928+00	2026-10-10 09:50:03.956928+00
1280	The Most Wonderful Crime of the Year	the most wonderful crime of the year | ally carter	2024	390	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:50:04.071229+00	2026-10-10 09:50:04.071229+00
1281	All I Want Is You	all i want is you | falon ballard	2024	234	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:04.161908+00	2026-10-10 09:50:04.161908+00
1282	Merriment and Mayhem	merriment and mayhem | alexandria bellefleur	2024	46	Novella	Adult	English	Yellow	Series	f	t	f	2026-10-10 09:50:04.258918+00	2026-10-10 09:50:04.258918+00
1283	Beg, Borrow, or Steal	beg, borrow, or steal | sarah adams	2025	343	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:04.356281+00	2026-10-10 09:50:04.356281+00
1284	Jawbone	jawbone | monica ojeda	2018	254	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:04.556138+00	2026-10-10 09:50:04.556138+00
1285	The Book of Accidents	the book of accidents | chuck wendig	2021	525	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:04.683268+00	2026-10-10 09:50:04.683268+00
1286	Voices in the Snow	voices in the snow | darcy coates	2019	278	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:50:04.761139+00	2026-10-10 09:50:04.761139+00
1287	The Gathering	the gathering | c. j. tudor	2024	372	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:04.860605+00	2026-10-10 09:50:04.860605+00
1288	Rest Stop	rest stop | nat cassidy	2024	110	Novella	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:04.953949+00	2026-10-10 09:50:04.953949+00
1289	The Nesting	the nesting | c. j. cooke	2020	394	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:05.469241+00	2026-10-10 09:50:05.469241+00
1290	Lessons in Chemistry	lessons in chemistry | bonnie garmus	2022	409	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:05.630514+00	2026-10-10 09:50:05.630514+00
1291	All the Colors of the Dark	all the colors of the dark | chris whitaker	2024	593	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:50:05.753195+00	2026-10-10 09:50:05.753195+00
1292	The Baby Dragon Café	the baby dragon café | aamna qureshi	2025	271	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:05.859997+00	2026-10-10 09:50:05.859997+00
1293	Lights Out	lights out | navessa allen	2024	414	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:05.984526+00	2026-10-10 09:50:05.984526+00
1294	Wake Up and Open Your Eyes	wake up and open your eyes | clay mcleod chapman	2025	396	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:06.060297+00	2026-10-10 09:50:06.060297+00
1295	Someone You Can Build a Nest In	someone you can build a nest in | john wiswell	2024	320	Novel	Adult	English	Red	Standalone	f	t	f	2026-10-10 09:50:06.256162+00	2026-10-10 09:50:06.256162+00
1296	Josh and Hazel's Guide to Not Dating	josh and hazel's guide to not dating | christina lauren	2018	306	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:06.356317+00	2026-10-10 09:50:06.356317+00
1297	The Lodge	the lodge | kayla olson	2025	304	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:50:06.493781+00	2026-10-10 09:50:06.493781+00
1298	Quicksilver	quicksilver | callie hart	2024	632	Novel	Adult	English	Gray	Series	f	f	f	2026-10-10 09:50:06.657935+00	2026-10-10 09:50:06.657935+00
1299	The Favorites	the favorites | layne fargo	2025	466	Novel	Adult	English	Beige	Standalone	t	f	f	2026-10-10 09:50:06.755888+00	2026-10-10 09:50:06.755888+00
1300	Cross My Heart	cross my heart | megan collins	2025	306	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:50:06.867655+00	2026-10-10 09:50:06.867655+00
1301	The Night Swim	the night swim | megan goldin	2020	341	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:07.064717+00	2026-10-10 09:50:07.064717+00
1302	Witchcraft for Wayward Girls	witchcraft for wayward girls | grady hendrix	2025	433	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:07.158278+00	2026-10-10 09:50:07.158278+00
1303	The Final Scene	the final scene | steph nelson	2024	229	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:07.287835+00	2026-10-10 09:50:07.287835+00
1304	Beautiful Ugly	beautiful ugly | alice feeney	2025	290	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:07.366163+00	2026-10-10 09:50:07.366163+00
1305	Deep End	deep end | ali hazelwood	2025	436	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:07.458755+00	2026-10-10 09:50:07.458755+00
1306	Scythe & Sparrow	scythe & sparrow | brynne weaver	2025	416	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:07.564893+00	2026-10-10 09:50:07.564893+00
1307	Spiders in the Grove	spiders in the grove | j. a. redmerski	2018	283	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:07.656698+00	2026-10-10 09:50:07.656698+00
1308	You Are Fatally Invited	you are fatally invited | ande pliego	2025	374	Novel	Adult	English	Orange	Standalone	t	t	f	2026-10-10 09:50:07.859661+00	2026-10-10 09:50:07.859661+00
1309	The Hunger Games	the hunger games | suzanne collins	2008	454	Novel	Young adult	English	Black	Series	f	f	f	2026-10-10 09:50:08.06472+00	2026-10-10 09:50:08.06472+00
1310	Catching Fire	catching fire | suzanne collins	2009	472	Novel	Young adult	English	Orange	Series	f	f	f	2026-10-10 09:50:08.162261+00	2026-10-10 09:50:08.162261+00
1311	Mockingjay	mockingjay | suzanne collins	2010	455	Novel	Young adult	English	Blue	Series	f	f	f	2026-10-10 09:50:08.263146+00	2026-10-10 09:50:08.263146+00
1312	Happenstance	happenstance | tessa bailey	2022	269	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:08.351998+00	2026-10-10 09:50:08.351998+00
1313	Motherthing	motherthing | ainslie hogarth	2022	250	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:08.563326+00	2026-10-10 09:50:08.563326+00
1314	Close Your Eyes and Count to 10	close your eyes and count to 10 | lisa unger	2025	366	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:08.755371+00	2026-10-10 09:50:08.755371+00
1315	The Ballad of Songbirds and Snakes	the ballad of songbirds and snakes | suzanne collins	2020	517	Novel	Young adult	English	Brown	Series	f	f	f	2026-10-10 09:50:08.772634+00	2026-10-10 09:50:08.772634+00
1316	Sunrise on the Reaping	sunrise on the reaping | suzanne collins	2025	348	Novel	Young adult	English	Purple	Series	f	f	f	2026-10-10 09:50:08.865873+00	2026-10-10 09:50:08.865873+00
1317	Listen to Your Sister	listen to your sister | neena viel	2025	316	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:50:09.067215+00	2026-10-10 09:50:09.067215+00
1318	Not in My Book	not in my book | katie holt	2024	368	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:09.256755+00	2026-10-10 09:50:09.256755+00
1319	The Book Thief	the book thief | markus zusak	2005	492	Novel	Young adult	English	Brown	Standalone	f	f	f	2026-10-10 09:50:09.455716+00	2026-10-10 09:50:09.455716+00
1320	The Answer Is No	the answer is no | fredrik backman	2024	55	Novella	Adult	Swedish	Orange	Standalone	f	f	f	2026-10-10 09:50:09.471506+00	2026-10-10 09:50:09.471506+00
1321	The Fireman	the fireman | joe hill	2016	762	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:09.564875+00	2026-10-10 09:50:09.564875+00
1322	You Killed Me First	you killed me first | john marrs	2025	299	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:09.660182+00	2026-10-10 09:50:09.660182+00
1323	A Witch's Guide to Fake Dating a Demon	a witch's guide to fake dating a demon | sarah hawley	2023	363	Novel	Adult	English	Green	Series	f	f	f	2026-10-10 09:50:09.85884+00	2026-10-10 09:50:09.85884+00
1324	The Lamb	the lamb | lucy rose	2025	245	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:09.984237+00	2026-10-10 09:50:09.984237+00
1325	Tell Me What You Did	tell me what you did | carter wilson	2025	365	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:10.162484+00	2026-10-10 09:50:10.162484+00
1326	Foe	foe | iain reid	2018	260	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:10.25703+00	2026-10-10 09:50:10.25703+00
1327	A Serial Killer's Guide to Marriage	a serial killer's guide to marriage | asia mackay	2025	332	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:10.45399+00	2026-10-10 09:50:10.45399+00
1328	An Academy for Liars	an academy for liars | alexis henderson	2024	450	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:50:10.562402+00	2026-10-10 09:50:10.562402+00
1329	Late Bloomer	late bloomer | mazey eddings	2024	304	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:10.757211+00	2026-10-10 09:50:10.757211+00
1330	The Invited	the invited | jennifer mcmahon	2019	399	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:50:10.772038+00	2026-10-10 09:50:10.772038+00
1331	Them	them | mique watson	2023	171	Novella	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:10.858141+00	2026-10-10 09:50:10.858141+00
1332	The Doctor	the doctor | nikki sloane	2018	229	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:11.054782+00	2026-10-10 09:50:11.054782+00
1333	The Good Son	the good son | you-jeong jeong	2016	242	Novel	Adult	Korean	Black	Standalone	t	f	f	2026-10-10 09:50:11.171012+00	2026-10-10 09:50:11.171012+00
1334	Unhinged	unhinged | onley james	2021	239	Novel	Adult	English	Pink	Series	f	t	f	2026-10-10 09:50:11.358811+00	2026-10-10 09:50:11.358811+00
1335	Graveyard Shift	graveyard shift | m. l. rio	2024	108	Novella	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:11.453714+00	2026-10-10 09:50:11.453714+00
1336	Do Me a Favor	do me a favor | cathy yardley	2024	289	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:11.470472+00	2026-10-10 09:50:11.470472+00
1337	The Memory Ward	the memory ward | jon bassoff	2025	300	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:11.66387+00	2026-10-10 09:50:11.66387+00
1338	Collide	collide | bal khabra	2023	371	Novel	Adult	English	Green	Series	t	f	f	2026-10-10 09:50:11.857454+00	2026-10-10 09:50:11.857454+00
1339	The Amendment	the amendment | kiersten modglin	2022	214	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:11.87246+00	2026-10-10 09:50:11.87246+00
1340	Julie Chan Is Dead	julie chan is dead | liann zhang	2025	324	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:50:12.059854+00	2026-10-10 09:50:12.059854+00
1341	The Atonement	the atonement | kiersten modglin	2022	215	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:12.154437+00	2026-10-10 09:50:12.154437+00
1342	A Good Girl's Guide to Murder	a good girl's guide to murder | holly jackson	2019	433	Novel	Young adult	English	White	Series	t	f	f	2026-10-10 09:50:12.264626+00	2026-10-10 09:50:12.264626+00
1343	Bat Eater and Other Names for Cora Zeng	bat eater and other names for cora zeng | kylie lee baker	2025	304	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:50:12.458535+00	2026-10-10 09:50:12.458535+00
1344	Confessions on the 7:45	confessions on the 7:45 | lisa unger	2019	379	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:12.554777+00	2026-10-10 09:50:12.554777+00
1345	Passion Project	passion project | london sperry	2025	319	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:12.669601+00	2026-10-10 09:50:12.669601+00
1346	When the Wolf Comes Home	when the wolf comes home | nat cassidy	2025	371	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:12.761308+00	2026-10-10 09:50:12.761308+00
1347	Eat the Ones You Love	eat the ones you love | sarah maria griffin	2025	241	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:13.008739+00	2026-10-10 09:50:13.008739+00
1348	Anywhere You Go	anywhere you go | bridget morrisey	2025	320	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:13.1849+00	2026-10-10 09:50:13.1849+00
1349	Small Game	small game | blair braverman	2022	288	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:13.366196+00	2026-10-10 09:50:13.366196+00
1350	Blood on Her Tongue	blood on her tongue | johanna van veen	2025	283	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:50:13.565031+00	2026-10-10 09:50:13.565031+00
1351	The Three Lives of Cate Kay	the three lives of cate kay | kate fagan	2025	283	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:50:13.760193+00	2026-10-10 09:50:13.760193+00
1352	The Man Made of Smoke	the man made of smoke | alex north	2025	301	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:13.856027+00	2026-10-10 09:50:13.856027+00
1353	Record of a Spaceborn Few	record of a spaceborn few | becky chambers	2018	358	Novel	Adult	English	Blue	Series	t	t	f	2026-10-10 09:50:13.869661+00	2026-10-10 09:50:13.869661+00
1354	On the Same Page	on the same page | haley cass	2023	505	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:50:14.063018+00	2026-10-10 09:50:14.063018+00
1355	Queen of Teeth	queen of teeth | hailey piper	2021	198	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:50:14.25087+00	2026-10-10 09:50:14.25087+00
1356	To Be Devoured	to be devoured | sara tantlinger	2019	90	Novella	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:14.463257+00	2026-10-10 09:50:14.463257+00
1357	The Influencers	the influencers | anna-marie mclemore	2025	381	Novel	Adult	English	Pink	Standalone	t	t	f	2026-10-10 09:50:14.557931+00	2026-10-10 09:50:14.557931+00
1358	The True Love Experiment	the true love experiment | christina lauren	2023	401	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:14.654458+00	2026-10-10 09:50:14.654458+00
1359	I Might Be In Trouble	i might be in trouble | daniel aleman	2024	360	Novel	Adult	English	Pink	Standalone	t	t	f	2026-10-10 09:50:14.862889+00	2026-10-10 09:50:14.862889+00
1360	The Galaxy, and the Ground Within	the galaxy, and the ground within | becky chambers	2021	324	Novel	Adult	English	Purple	Series	t	t	f	2026-10-10 09:50:14.958241+00	2026-10-10 09:50:14.958241+00
1361	Delilah Green Doesn't Care	delilah green doesn't care | ashley herring blake	2022	371	Novel	Adult	English	Purple	Series	f	t	f	2026-10-10 09:50:14.981936+00	2026-10-10 09:50:14.981936+00
1362	My Best Friend's Honeymoon	my best friend's honeymoon | meryl wilsner	2025	235	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:50:15.255193+00	2026-10-10 09:50:15.255193+00
1363	Atmosphere	atmosphere | taylor jenkins reid	2025	332	Novel	Adult	English	Orange	Standalone	f	t	f	2026-10-10 09:50:15.275784+00	2026-10-10 09:50:15.275784+00
1364	Immaculate Conception	immaculate conception | ling ling huang	2025	244	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:50:15.366038+00	2026-10-10 09:50:15.366038+00
1365	Caught Up	caught up | navessa allen	2025	332	Novel	Adult	English	Red	Series	f	f	f	2026-10-10 09:50:15.461037+00	2026-10-10 09:50:15.461037+00
1366	The Girls I've Been	the girls i've been | tess sharpe	2021	332	Novel	Young adult	English	Red	Series	f	t	f	2026-10-10 09:50:15.663271+00	2026-10-10 09:50:15.663271+00
1367	The Hacienda	the hacienda | isabel cañas	2022	331	Novel	Adult	English	Orange	Standalone	t	f	f	2026-10-10 09:50:15.858212+00	2026-10-10 09:50:15.858212+00
1368	The Ghostwriter	the ghostwriter | julie clark	2025	328	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:15.954481+00	2026-10-10 09:50:15.954481+00
1369	Insomnia	insomnia | sarah pinborough	2022	340	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:15.968477+00	2026-10-10 09:50:15.968477+00
1370	Happy Place	happy place | emily henry	2023	385	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:16.05882+00	2026-10-10 09:50:16.05882+00
1371	The Poppy War	the poppy war | r. f. kuang	2018	527	Novel	Adult	English	White	Series	t	f	f	2026-10-10 09:50:16.151187+00	2026-10-10 09:50:16.151187+00
1372	With a Vengeance	with a vengeance | riley sager	2025	311	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:16.250539+00	2026-10-10 09:50:16.250539+00
1373	Out on a Limb	out on a limb | hannah bonam-young	2023	348	Novel	Adult	English	Brown	Series	f	f	f	2026-10-10 09:50:16.457293+00	2026-10-10 09:50:16.457293+00
1374	The Humans	the humans | matt haig	2013	291	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:16.654735+00	2026-10-10 09:50:16.654735+00
1375	Sky Daddy	sky daddy | kate folk	2025	285	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:16.750509+00	2026-10-10 09:50:16.750509+00
1376	First-Time Caller	first-time caller | b. k. borison	2025	391	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:16.766634+00	2026-10-10 09:50:16.766634+00
1377	At Home With the Horrors	at home with the horrors | sammy scott	2022	462	Short stories	Adult	English	Blue	Collection	f	f	f	2026-10-10 09:50:16.859662+00	2026-10-10 09:50:16.859662+00
1378	Saltwater	saltwater | katy hays	2025	355	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:17.070664+00	2026-10-10 09:50:17.070664+00
1379	Theme Music	theme music | t. marie vandelly	2019	383	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:17.254307+00	2026-10-10 09:50:17.254307+00
1380	The Private Jet	the private jet | sarah goodwin	2025	287	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:17.274559+00	2026-10-10 09:50:17.274559+00
1381	The Paradise Problem	the paradise problem | christina lauren	2024	336	Novel	Adult	English	Yellow	Standalone	t	f	f	2026-10-10 09:50:17.36211+00	2026-10-10 09:50:17.36211+00
1382	Strange Pictures	strange pictures | uketsu	2022	180	Novella	Adult	Japanese	Green	Standalone	t	f	f	2026-10-10 09:50:17.578046+00	2026-10-10 09:50:17.578046+00
1383	Unhinged	unhinged | steph macca	2024	186	Novella	Adult	English	Gray	Series	f	f	f	2026-10-10 09:50:17.875049+00	2026-10-10 09:50:17.875049+00
1384	I Can Fix Her	i can fix her | rae wilde	2025	69	Novella	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:50:18.060644+00	2026-10-10 09:50:18.060644+00
1385	Wearing the Lion	wearing the lion | john wiswell	2025	400	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:50:18.154961+00	2026-10-10 09:50:18.154961+00
1386	Problematic Summer Romance	problematic summer romance | ali hazelwood	2025	397	Novel	Adult	English	Teal	Series	f	f	f	2026-10-10 09:50:18.169116+00	2026-10-10 09:50:18.169116+00
1387	Sunburned	sunburned | katherine wood	2025	335	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:18.259345+00	2026-10-10 09:50:18.259345+00
1388	Playing Nice	playing nice | j. p. delaney	2020	422	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:18.354864+00	2026-10-10 09:50:18.354864+00
1389	Done and Dusted	done and dusted | lyla sage	2023	321	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:18.514136+00	2026-10-10 09:50:18.514136+00
1390	Love & Other Killers	love & other killers | brynne weaver	2025	61	Novella	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:18.56243+00	2026-10-10 09:50:18.56243+00
1391	Swift and Saddled	swift and saddled | lyla sage	2024	285	Novel	Adult	English	Orange	Series	f	f	f	2026-10-10 09:50:18.660905+00	2026-10-10 09:50:18.660905+00
1392	How to Survive a Horror Story	how to survive a horror story | mallory arnold	2025	353	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:18.872721+00	2026-10-10 09:50:18.872721+00
1393	Lost and Lassoed	lost and lassoed | lyla sage	2024	368	Novel	Adult	English	Green	Series	f	f	f	2026-10-10 09:50:18.974897+00	2026-10-10 09:50:18.974897+00
1394	Tender Is the Flesh	tender is the flesh | agustina bazterrica	2017	164	Novella	Adult	Spanish	Black	Standalone	f	f	f	2026-10-10 09:50:19.25765+00	2026-10-10 09:50:19.25765+00
1395	One in Four	one in four | lucinda berry	2025	245	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:19.35949+00	2026-10-10 09:50:19.35949+00
1396	Wild and Wrangled	wild and wrangled | lyla sage	2025	368	Novel	Adult	English	Red	Series	f	f	f	2026-10-10 09:50:19.465709+00	2026-10-10 09:50:19.465709+00
1397	Arcana Academy	arcana academy | elise kova	2025	544	Novel	Adult	English	Brown	Series	f	f	f	2026-10-10 09:50:19.669082+00	2026-10-10 09:50:19.669082+00
1398	The Wedding People	the wedding people | alison espach	2024	381	Novel	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:50:19.856947+00	2026-10-10 09:50:19.856947+00
1399	The House of My Mother	the house of my mother | shari franke	2025	256	Memoir	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:19.973016+00	2026-10-10 09:50:19.973016+00
1400	The Cinnamon Bun Book Store	the cinnamon bun book store | laurie gilmore	2024	347	Novel	Adult	English	Green	Series	f	f	f	2026-10-10 09:50:20.061443+00	2026-10-10 09:50:20.061443+00
1401	We Live Here Now	we live here now | sarah pinborough	2025	283	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:20.159953+00	2026-10-10 09:50:20.159953+00
1402	Dire Bound	dire bound | sable sorensen	2025	619	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:20.359584+00	2026-10-10 09:50:20.359584+00
1403	There Are No Saints	there are no saints | sophie lark	2021	293	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:50:20.554673+00	2026-10-10 09:50:20.554673+00
1404	The Bewitching	the bewitching | silvia moreno-garcia	2025	383	Novel	Adult	English	Green	Standalone	t	f	f	2026-10-10 09:50:20.656147+00	2026-10-10 09:50:20.656147+00
1405	The Night Sister	the night sister | jennifer mcmahon	2015	369	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:50:20.754168+00	2026-10-10 09:50:20.754168+00
1406	People Watching	people watching | hannah bonam-young	2025	328	Novel	Adult	English	Beige	Standalone	f	f	f	2026-10-10 09:50:20.854815+00	2026-10-10 09:50:20.854815+00
1407	Automatic Noodle	automatic noodle | annalee newitz	2025	128	Novella	Adult	English	Blue	Standalone	t	t	f	2026-10-10 09:50:21.062162+00	2026-10-10 09:50:21.062162+00
1408	Gray After Dark	gray after dark | noelle w. ihli	2024	289	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:50:21.255188+00	2026-10-10 09:50:21.255188+00
1409	The Therapist	the therapist | helene flood	2019	301	Novel	Adult	Norwegian	Gray	Standalone	f	f	f	2026-10-10 09:50:21.366969+00	2026-10-10 09:50:21.366969+00
1410	13 Months Haunted	13 months haunted | jimmy juliano	2025	372	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:21.46212+00	2026-10-10 09:50:21.46212+00
1411	This Skin Was Once Mine and Other Disturbances	this skin was once mine and other disturbances | eric larocca	2024	186	Short stories	Adult	English	Red	Standalone	f	t	f	2026-10-10 09:50:21.558349+00	2026-10-10 09:50:21.558349+00
1412	House of Leaves	house of leaves | mark z. danielewski	2000	709	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:21.760861+00	2026-10-10 09:50:21.760861+00
1413	Mate	mate | ali hazelwood	2025	446	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:21.86161+00	2026-10-10 09:50:21.86161+00
1414	The Burning Girls	the burning girls | c. j. tudor	2021	384	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:21.95816+00	2026-10-10 09:50:21.95816+00
1415	Tourist Season	tourist season | brynne weaver	2025	428	Novel	Adult	English	Purple	Series	f	f	f	2026-10-10 09:50:22.061341+00	2026-10-10 09:50:22.061341+00
1416	Night Shoot	night shoot | david sodergren	2019	209	Novella	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:22.159239+00	2026-10-10 09:50:22.159239+00
1417	Guillotine	guillotine | delilah s. dawson	2024	163	Novella	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:22.256911+00	2026-10-10 09:50:22.256911+00
1418	A Dowry of Blood	a dowry of blood | s. t. gibson	2021	292	Novel	Adult	English	Black	Series	f	t	f	2026-10-10 09:50:22.462596+00	2026-10-10 09:50:22.462596+00
1419	The Intruder	the intruder | freida mcfadden	2025	256	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:50:22.660956+00	2026-10-10 09:50:22.660956+00
1420	Silver Elite	silver elite | dani francis	2025	512	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:22.86195+00	2026-10-10 09:50:22.86195+00
1421	Futility	futility | nuzo onoh	2025	271	Novel	Adult	English	Teal	Standalone	t	f	f	2026-10-10 09:50:23.064591+00	2026-10-10 09:50:23.064591+00
1422	Matchmaking for Psychopaths	matchmaking for psychopaths | tasha coryell	2025	303	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:23.262212+00	2026-10-10 09:50:23.262212+00
1423	The Crash	the crash | freida mcfadden	2025	285	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:23.361354+00	2026-10-10 09:50:23.361354+00
1424	Katabasis	katabasis | r. f. kuang	2025	541	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:50:23.460068+00	2026-10-10 09:50:23.460068+00
1425	What Hunger	what hunger | catherine dang	2025	237	Novel	Adult	English	Red	Standalone	t	f	f	2026-10-10 09:50:23.662793+00	2026-10-10 09:50:23.662793+00
1426	Broken Country	broken country | clare leslie hall	2025	262	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:23.864263+00	2026-10-10 09:50:23.864263+00
1427	Spiral	spiral | bal khabra	2025	338	Novel	Adult	English	Purple	Series	t	f	f	2026-10-10 09:50:23.966826+00	2026-10-10 09:50:23.966826+00
1428	Breathe In, Bleed Out	breathe in, bleed out | brian mcauley	2025	259	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:24.253932+00	2026-10-10 09:50:24.253932+00
1429	I Who Have Never Known Men	i who have never known men | jacqueline harpman	1995	188	Novel	Adult	French	Black	Standalone	f	f	f	2026-10-10 09:50:24.456539+00	2026-10-10 09:50:24.456539+00
1430	The Tenant	the tenant | freida mcfadden	2025	368	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:24.55662+00	2026-10-10 09:50:24.55662+00
1431	You Make It Feel Like Christmas	you make it feel like christmas | sophie sullivan	2025	303	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:50:24.761544+00	2026-10-10 09:50:24.761544+00
1432	The Picture of Dorian Gray	the picture of dorian gray | oscar wilde	1891	203	Novel	Adult	English	Orange	Standalone	f	t	f	2026-10-10 09:50:24.965938+00	2026-10-10 09:50:24.965938+00
1433	Alchemy of Secrets	alchemy of secrets | stephanie garber	2025	311	Novel	Adult	English	Orange	Series	f	f	f	2026-10-10 09:50:25.161202+00	2026-10-10 09:50:25.161202+00
1434	Twisted Love	twisted love | ana huang	2021	343	Novel	Adult	English	Blue	Series	t	f	f	2026-10-10 09:50:25.362185+00	2026-10-10 09:50:25.362185+00
1435	Set the Record Straight	set the record straight | hannah bonam-young	2022	169	Novella	Adult	English	White	Standalone	f	t	f	2026-10-10 09:50:25.460049+00	2026-10-10 09:50:25.460049+00
1436	I'll Be Gone for Christmas	i'll be gone for christmas | georgia k. boone	2024	279	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:25.668893+00	2026-10-10 09:50:25.668893+00
1437	Isola	isola | allegra goodman	2025	362	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:50:25.955244+00	2026-10-10 09:50:25.955244+00
1438	Strange Sally Diamond	strange sally diamond | liz nugent	2023	374	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:26.158884+00	2026-10-10 09:50:26.158884+00
1439	He Sees You When You're Sleeping	he sees you when you're sleeping | alta hensley	2024	270	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:26.369289+00	2026-10-10 09:50:26.369289+00
1440	Victorian Psycho	victorian psycho | virginia feito	2025	149	Novella	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:50:26.569683+00	2026-10-10 09:50:26.569683+00
1441	Booked for the Holidays	booked for the holidays | liz maverick	2024	147	Novella	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:26.781884+00	2026-10-10 09:50:26.781884+00
1442	He Knows When You're Awake	he knows when you're awake | alta hensley	2025	298	Novel	Adult	English	Red	Series	f	f	f	2026-10-10 09:50:26.866034+00	2026-10-10 09:50:26.866034+00
1443	The Yacht	the yacht | sarah goodwin	2024	305	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:26.960004+00	2026-10-10 09:50:26.960004+00
1444	Seduction Theory	seduction theory | emily adrian	2025	181	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:50:27.159218+00	2026-10-10 09:50:27.159218+00
1445	Brimstone	brimstone | callie hart	2025	660	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:27.174636+00	2026-10-10 09:50:27.174636+00
1446	Soul Searching	soul searching | lyla sage	2025	303	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:27.264916+00	2026-10-10 09:50:27.264916+00
1447	Dating After the End of the World	dating after the end of the world | jeneva rose	2025	308	Novel	Adult	English	Purple	Series	f	f	f	2026-10-10 09:50:27.356646+00	2026-10-10 09:50:27.356646+00
1448	Brother	brother | ania ahlborn	2015	319	Novel	Adult	English	Brown	Standalone	f	f	f	2026-10-10 09:50:27.45321+00	2026-10-10 09:50:27.45321+00
1449	Whiteout	whiteout | r. s. burnett	2025	256	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:27.658342+00	2026-10-10 09:50:27.658342+00
1450	So Thirsty	so thirsty | rachel harrison	2024	315	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:50:27.757464+00	2026-10-10 09:50:27.757464+00
1451	At Dark, I Become Loathsome	at dark, i become loathsome | eric larocca	2025	174	Novel	Adult	English	Red	Standalone	f	t	f	2026-10-10 09:50:27.859118+00	2026-10-10 09:50:27.859118+00
1452	House of Hunger	house of hunger | alexis henderson	2022	288	Novel	Adult	English	Green	Standalone	t	t	f	2026-10-10 09:50:27.961632+00	2026-10-10 09:50:27.961632+00
1453	In Your Dreams	in your dreams | sarah adams	2025	330	Novel	Adult	English	Green	Series	f	f	f	2026-10-10 09:50:28.062948+00	2026-10-10 09:50:28.062948+00
1454	Beautiful Venom	beautiful venom | rina kent	2025	484	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:50:28.271188+00	2026-10-10 09:50:28.271188+00
1455	We Who Will Die	we who will die | stacia stark	2025	500	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:28.478075+00	2026-10-10 09:50:28.478075+00
1456	Behind the Net	behind the net | stephanie archer	2023	404	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:28.662333+00	2026-10-10 09:50:28.662333+00
1457	Full Speed to a Crash Landing	full speed to a crash landing | beth revis	2024	187	Novella	Adult	English	Orange	Series	f	f	f	2026-10-10 09:50:28.862741+00	2026-10-10 09:50:28.862741+00
1458	Woman Down	woman down | colleen hoover	2026	299	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:28.960899+00	2026-10-10 09:50:28.960899+00
1459	Ninth House	ninth house | leigh bardugo	2019	450	Novel	Adult	English	Black	Series	t	f	f	2026-10-10 09:50:29.164832+00	2026-10-10 09:50:29.164832+00
1460	Ask for Andrea	ask for andrea | noelle w. ihli	2022	267	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:50:29.264472+00	2026-10-10 09:50:29.264472+00
1461	The Housemaid	the housemaid | freida mcfadden	2022	328	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:29.361265+00	2026-10-10 09:50:29.361265+00
1462	Spread Me	spread me | sarah gailey	2025	146	Novella	Adult	English	Orange	Standalone	f	t	f	2026-10-10 09:50:29.461042+00	2026-10-10 09:50:29.461042+00
1463	Sweet Venom	sweet venom | rina kent	2025	441	Novel	Adult	English	White	Series	f	f	f	2026-10-10 09:50:29.559358+00	2026-10-10 09:50:29.559358+00
1464	My Husband's Wife	my husband's wife | alice feeney	2026	289	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:29.66083+00	2026-10-10 09:50:29.66083+00
1465	Twisted Games	twisted games | ana huang	2021	438	Novel	Adult	English	Yellow	Series	f	f	f	2026-10-10 09:50:29.761496+00	2026-10-10 09:50:29.761496+00
1466	Say You'll Remember Me	say you'll remember me | abby jimenez	2025	353	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:29.969037+00	2026-10-10 09:50:29.969037+00
1467	Escape!	escape! | stephen fischbach	2026	424	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:30.163933+00	2026-10-10 09:50:30.163933+00
1468	Twisted Hate	twisted hate | ana huang	2022	504	Novel	Adult	English	Pink	Series	t	f	f	2026-10-10 09:50:30.262968+00	2026-10-10 09:50:30.262968+00
1469	Half His Age	half his age | jennette mccurdy	2026	238	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:30.472153+00	2026-10-10 09:50:30.472153+00
1470	Love and Other Brain Experiments	love and other brain experiments | hannah brohm	2026	352	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:30.660614+00	2026-10-10 09:50:30.660614+00
1471	No Body No Crime	no body no crime | tess sharpe	2025	292	Novel	Adult	English	Beige	Standalone	f	t	f	2026-10-10 09:50:30.761986+00	2026-10-10 09:50:30.761986+00
1472	When in Rome	when in rome | sarah adams	2022	306	Novel	Adult	English	Orange	Series	f	f	f	2026-10-10 09:50:30.857714+00	2026-10-10 09:50:30.857714+00
1473	Dear Debbie	dear debbie | freida mcfadden	2026	315	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:30.954621+00	2026-10-10 09:50:30.954621+00
1474	Twisted Lies	twisted lies | ana huang	2022	558	Novel	Adult	English	Green	Series	t	f	f	2026-10-10 09:50:31.055115+00	2026-10-10 09:50:31.055115+00
1475	Girl Dinner	girl dinner | olivie blake	2025	323	Novel	Adult	English	Teal	Standalone	t	f	f	2026-10-10 09:50:31.268308+00	2026-10-10 09:50:31.268308+00
1476	Adrift	adrift | will dean	2026	300	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:31.371272+00	2026-10-10 09:50:31.371272+00
1477	We Met Like This	we met like this | kasie west	2025	312	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:31.660156+00	2026-10-10 09:50:31.660156+00
1478	There Is No Devil	there is no devil | sophie lark	2021	281	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:31.764894+00	2026-10-10 09:50:31.764894+00
1479	The Devotion of Suspect X	the devotion of suspect x | keigo higashino	2005	275	Novel	Adult	Japanese	Black	Standalone	t	f	f	2026-10-10 09:50:31.967918+00	2026-10-10 09:50:31.967918+00
1480	Game On	game on | navessa allen	2026	370	Novel	Adult	English	Green	Series	f	t	f	2026-10-10 09:50:32.068591+00	2026-10-10 09:50:32.068591+00
1481	Daphne	daphne | josh malerman	2022	254	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:32.16458+00	2026-10-10 09:50:32.16458+00
1482	Best Offer Wins	best offer wins | marisa kashino	2025	257	Novel	Adult	English	Red	Standalone	t	f	f	2026-10-10 09:50:32.457028+00	2026-10-10 09:50:32.457028+00
1483	Fourth Wing	fourth wing | rebecca yarros	2023	561	Novel	Adult	English	Yellow	Series	f	f	f	2026-10-10 09:50:32.660594+00	2026-10-10 09:50:32.660594+00
1484	Heartless	heartless | elsie silver	2022	432	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:32.759451+00	2026-10-10 09:50:32.759451+00
1485	The Extra	the extra | annie neugebauer	2025	83	Novella	Adult	English	Green	Series	f	f	f	2026-10-10 09:50:33.359863+00	2026-10-10 09:50:33.359863+00
1486	Anatomy of an Alibi	anatomy of an alibi | ashley elston	2026	314	Novel	Adult	English	Green	Standalone	f	f	f	2026-10-10 09:50:33.459661+00	2026-10-10 09:50:33.459661+00
1487	Across the Vanishing Sky	across the vanishing sky | catherine cowles	2026	493	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:33.661425+00	2026-10-10 09:50:33.661425+00
1488	The Secret Lives of Murderers' Wives	the secret lives of murderers' wives | elizabeth arnott	2026	296	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:33.857452+00	2026-10-10 09:50:33.857452+00
1489	The Library at Hellebore	the library at hellebore | cassandra khaw	2025	266	Novel	Adult	English	Blue	Standalone	t	t	f	2026-10-10 09:50:34.060984+00	2026-10-10 09:50:34.060984+00
1490	Just Friends	just friends | haley pham	2026	292	Novel	Adult	English	Orange	Standalone	t	f	f	2026-10-10 09:50:34.256717+00	2026-10-10 09:50:34.256717+00
1491	Butter	butter | asako yuzuki	2017	474	Novel	Adult	Japanese	Yellow	Standalone	t	f	f	2026-10-10 09:50:34.459276+00	2026-10-10 09:50:34.459276+00
1492	I'm a Fan	i'm a fan | sheena patel	2022	203	Novel	Adult	English	Pink	Standalone	t	f	f	2026-10-10 09:50:34.656695+00	2026-10-10 09:50:34.656695+00
1493	Strange Houses	strange houses | uketsu	2021	197	Novella	Adult	Japanese	Red	Standalone	t	f	f	2026-10-10 09:50:34.755789+00	2026-10-10 09:50:34.755789+00
1494	Walking Practice	walking practice | dolki min	2022	160	Novella	Adult	Korean	Black	Standalone	t	t	f	2026-10-10 09:50:34.963063+00	2026-10-10 09:50:34.963063+00
1495	The Ending Writes Itself	the ending writes itself | evelyn clarke	2026	385	Novel	Adult	English	White	Standalone	f	f	f	2026-10-10 09:50:35.254421+00	2026-10-10 09:50:35.254421+00
1496	The Caretaker	the caretaker | marcus kliewer	2026	291	Novel	Adult	English	Teal	Standalone	f	f	f	2026-10-10 09:50:35.357531+00	2026-10-10 09:50:35.357531+00
1497	My Heart Is a Chainsaw	my heart is a chainsaw | stephen graham jones	2021	439	Novel	Adult	English	White	Series	t	f	f	2026-10-10 09:50:35.460726+00	2026-10-10 09:50:35.460726+00
1498	Skate It Till You Make It	skate it till you make it | rufaro faith mazarura	2026	334	Novel	Adult	English	Blue	Standalone	t	f	f	2026-10-10 09:50:35.666559+00	2026-10-10 09:50:35.666559+00
1499	It's Not the End of the World	it's not the end of the world | jonathan parks-ramage	2025	380	Novel	Adult	English	Orange	Standalone	f	t	f	2026-10-10 09:50:35.760335+00	2026-10-10 09:50:35.760335+00
1500	These Violent Delights	these violent delights | micah nemerever	2020	460	Novel	Adult	English	White	Standalone	f	t	f	2026-10-10 09:50:35.959711+00	2026-10-10 09:50:35.959711+00
1501	Of Monsters and Mainframes	of monsters and mainframes | barbara truelove	2025	367	Novel	Adult	English	Black	Standalone	f	t	f	2026-10-10 09:50:36.163494+00	2026-10-10 09:50:36.163494+00
1502	Heated Rivalry	heated rivalry | rachel reid	2019	337	Novel	Adult	English	Blue	Series	f	t	f	2026-10-10 09:50:36.450967+00	2026-10-10 09:50:36.450967+00
1503	Iron Flame	iron flame | rebecca yarros	2023	786	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:36.469601+00	2026-10-10 09:50:36.469601+00
1504	Hungerstone	hungerstone | kat dunn	2025	377	Novel	Adult	English	Brown	Standalone	f	t	f	2026-10-10 09:50:36.761186+00	2026-10-10 09:50:36.761186+00
1505	Vladimir	vladimir | julia may jonas	2022	292	Novel	Adult	English	Black	Standalone	f	f	f	2026-10-10 09:50:36.966128+00	2026-10-10 09:50:36.966128+00
1506	Stars In Your Eyes	stars in your eyes | kacen callender	2023	324	Novel	Adult	English	Pink	Standalone	t	t	f	2026-10-10 09:50:37.157207+00	2026-10-10 09:50:37.157207+00
1507	Astrid Parker Doesn't Fail	astrid parker doesn't fail | ashley herring blake	2022	363	Novel	Adult	English	Teal	Series	f	t	f	2026-10-10 09:50:37.258287+00	2026-10-10 09:50:37.258287+00
1508	Thirty Love	thirty love | tom vellner	2026	306	Novel	Adult	English	Green	Standalone	f	t	f	2026-10-10 09:50:37.557909+00	2026-10-10 09:50:37.557909+00
1509	The Devil She Knows	the devil she knows | alexandria bellefleur	2025	322	Novel	Adult	English	Pink	Standalone	f	t	f	2026-10-10 09:50:37.661491+00	2026-10-10 09:50:37.661491+00
1510	Five	five | ilona bannister	2026	230	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:37.956013+00	2026-10-10 09:50:37.956013+00
1511	Blue Sisters	blue sisters | coco mellors	2024	371	Novel	Adult	English	White	Standalone	f	t	f	2026-10-10 09:50:38.181286+00	2026-10-10 09:50:38.181286+00
1512	Funny Story	funny story | emily henry	2024	384	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:38.359564+00	2026-10-10 09:50:38.359564+00
1513	Not Safe For Work	not safe for work | nisha j. tuli	2025	335	Novel	Adult	English	Orange	Standalone	t	f	f	2026-10-10 09:50:38.65155+00	2026-10-10 09:50:38.65155+00
1514	From Below	from below | darcy coates	2022	469	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:38.756041+00	2026-10-10 09:50:38.756041+00
1515	The Housewife	the housewife | natalie barelli	2026	368	Novel	Adult	English	Pink	Standalone	f	f	f	2026-10-10 09:50:39.072819+00	2026-10-10 09:50:39.072819+00
1516	The Other	the other | annie neugebauer	2026	152	Novella	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:39.15954+00	2026-10-10 09:50:39.15954+00
1517	Christine	christine | stephen king	1983	749	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:39.260229+00	2026-10-10 09:50:39.260229+00
1518	FantasticLand	fantasticland | mike bockoven	2016	277	Novel	Adult	English	Gray	Standalone	f	f	f	2026-10-10 09:50:39.566021+00	2026-10-10 09:50:39.566021+00
1519	King of Wrath	king of wrath | ana huang	2022	379	Novel	Adult	English	White	Series	t	f	f	2026-10-10 09:50:39.672746+00	2026-10-10 09:50:39.672746+00
1520	Tempting Venom	tempting venom | rina kent	2026	564	Novel	Adult	English	White	Series	f	t	f	2026-10-10 09:50:39.855209+00	2026-10-10 09:50:39.855209+00
1521	Too Old For This	too old for this | samantha downing	2025	316	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:39.960775+00	2026-10-10 09:50:39.960775+00
1522	Yesteryear	yesteryear | caro claire burke	2026	427	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:40.257599+00	2026-10-10 09:50:40.257599+00
1523	The Employees	the employees | olga ravn	2018	155	Novella	Adult	Danish	Black	Standalone	f	f	f	2026-10-10 09:50:40.473903+00	2026-10-10 09:50:40.473903+00
1524	The Business Trip	the business trip | jessie garcia	2025	294	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:40.854947+00	2026-10-10 09:50:40.854947+00
1525	Deep Cuts	deep cuts | holly brickley	2025	284	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:41.064895+00	2026-10-10 09:50:41.064895+00
1526	The Fountains of Silence	the fountains of silence | ruta sepetys	2019	492	Novel	Young adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:41.168398+00	2026-10-10 09:50:41.168398+00
1527	Your Knife, My Heart	your knife, my heart | k.m. moronova	2025	301	Novel	Adult	English	Blue	Series	f	f	f	2026-10-10 09:50:41.471313+00	2026-10-10 09:50:41.471313+00
1528	Stranger Things Have Happened	stranger things have happened | kasie west	2026	291	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:41.571261+00	2026-10-10 09:50:41.571261+00
1529	Tomorrow, and Tomorrow, and Tomorrow	tomorrow, and tomorrow, and tomorrow | gabrielle zevin	2022	397	Novel	Adult	English	Multicolor	Standalone	t	f	f	2026-10-10 09:50:41.858865+00	2026-10-10 09:50:41.858865+00
1530	The Unknown	the unknown | riley sager	2026	366	Novel	Adult	English	Red	Standalone	f	f	f	2026-10-10 09:50:41.968456+00	2026-10-10 09:50:41.968456+00
1531	My Friends	my friends | fredrik backman	2025	422	Novel	Adult	Swedish	Blue	Standalone	f	f	f	2026-10-10 09:50:42.070329+00	2026-10-10 09:50:42.070329+00
1532	Hot Girl Murder Club	hot girl murder club | ashley winstead	2026	354	Novel	Adult	English	Blue	Standalone	f	t	f	2026-10-10 09:50:42.253836+00	2026-10-10 09:50:42.253836+00
1533	Bright Young Women	bright young women | jessica knoll	2023	373	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:42.457782+00	2026-10-10 09:50:42.457782+00
1534	The Open Era	the open era | edward schmit	2026	351	Novel	Adult	English	Purple	Standalone	f	f	f	2026-10-10 09:50:42.667922+00	2026-10-10 09:50:42.667922+00
1535	The Saturday Night Ghost Club	the saturday night ghost club | craig davidson	2018	253	Novel	Adult	English	Blue	Standalone	f	f	f	2026-10-10 09:50:42.875004+00	2026-10-10 09:50:42.875004+00
1536	The Housemaid's Secret	the housemaid's secret | freida mcfadden	2023	327	Novel	Adult	English	Red	Series	f	f	f	2026-10-10 09:50:42.967641+00	2026-10-10 09:50:42.967641+00
1537	My Roommate Is a Vampire	my roommate is a vampire | jenna levine	2023	337	Novel	Adult	English	Pink	Series	f	f	f	2026-10-10 09:50:43.264896+00	2026-10-10 09:50:43.264896+00
1538	If It Makes You Happy	if it makes you happy | julie olivia	2025	491	Novel	Adult	English	Orange	Standalone	f	f	f	2026-10-10 09:50:43.556897+00	2026-10-10 09:50:43.556897+00
1539	The Woman in the Purple Skirt	the woman in the purple skirt | natsuko imamura	2019	127	Novella	Adult	Japanese	Purple	Standalone	t	f	f	2026-10-10 09:50:43.757906+00	2026-10-10 09:50:43.757906+00
1540	Onyx Storm	onyx storm | rebecca yarros	2025	656	Novel	Adult	English	Black	Series	f	f	f	2026-10-10 09:50:43.867491+00	2026-10-10 09:50:43.867491+00
1541	The Green Mile	the green mile | stephen king	1996	433	Novel	Adult	English	Black	Standalone	t	f	f	2026-10-10 09:50:43.979648+00	2026-10-10 09:50:43.979648+00
1542	The Husbands	the husbands | holly gramazio	2025	316	Novel	Adult	English	Yellow	Standalone	f	f	f	2026-10-10 09:50:44.356043+00	2026-10-10 09:50:44.356043+00
1078	Things Have Gotten Worse Since We Last Spoke and Other Misfortunes	things have gotten worse since we last spoke and other misfortunes | eric larocca	2022	275	Short stories	Adult	English	White	Standalone	f	t	f	2026-10-10 09:49:45.162803+00	2026-10-11 15:01:49.133213+00
2440	My Lovely Wife	my lovely wife | samantha downing	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:09.160895+00	2026-10-11 15:10:09.160895+00
2397	Bunny	bunny | mona awad	2019	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:09:56.774455+00	2026-10-11 15:10:17.471805+00
2462	Not Quite Dead Yet	not quite dead yet | holly jackson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.560445+00	2026-10-11 15:10:12.560445+00
2466	Where You End	where you end | abbott kahler	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.766078+00	2026-10-11 15:10:12.766078+00
2468	Yours Truly	yours truly | abby jimenez	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.777518+00	2026-10-11 15:10:12.777518+00
2469	A Particularly Nasty Case	a particularly nasty case | adam kay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.791505+00	2026-10-11 15:10:12.791505+00
2472	Summer in the City	summer in the city | alex aster	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.816251+00	2026-10-11 15:10:12.816251+00
2473	The Night Shift	the night shift | alex finlay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.823121+00	2026-10-11 15:10:12.823121+00
2474	What Have We Done	what have we done | alex finlay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.829857+00	2026-10-11 15:10:12.829857+00
2479	First	first | ali hazelwood	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.869214+00	2026-10-11 15:10:12.869214+00
2480	Love in the Time of Serial Killers	love in the time of serial killers | alicia thompson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.876737+00	2026-10-11 15:10:12.876737+00
2483	We Are Watching	we are watching | alison gaylin	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.896897+00	2026-10-11 15:10:12.896897+00
2485	The Bay	the bay | allie reynolds	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.913057+00	2026-10-11 15:10:12.913057+00
2490	The Catch	the catch | amy lea	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.947986+00	2026-10-11 15:10:12.947986+00
2491	Something Like Fate	something like fate | amy lea	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.953091+00	2026-10-11 15:10:12.953091+00
2492	Ruins	ruins | amy taylor	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.95974+00	2026-10-11 15:10:12.95974+00
2496	You Weren't Meant to Be Human	you weren't meant to be human | andrew joseph white	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.987607+00	2026-10-11 15:10:12.987607+00
2497	The Seven Visitations of Sydney Burgess	the seven visitations of sydney burgess | andy marino	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.997391+00	2026-10-11 15:10:12.997391+00
2501	Dream On, Ramona RIley	dream on, ramona riley | ashley herring blake	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.025702+00	2026-10-11 15:10:13.025702+00
2503	Loving a Vampire Is Total Chaos	loving a vampire is total chaos | aura hayes	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.04343+00	2026-10-11 15:10:13.04343+00
2504	Book Boyfriend	book boyfriend | austin siegemund-broka; emily wibberly	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.050864+00	2026-10-11 15:10:13.050864+00
2507	The Guest	the guest | b. a. paris	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.073946+00	2026-10-11 15:10:13.073946+00
2508	Good Spirits	good spirits | b. k. borison	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.080923+00	2026-10-11 15:10:13.080923+00
2509	Coram House	coram house | bailey seybolt	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.091974+00	2026-10-11 15:10:13.091974+00
2510	Discontent	discontent | beatriz serrano	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.103072+00	2026-10-11 15:10:13.103072+00
2511	Pomona Afton Can So Solve a Murder	pomona afton can so solve a murder | bellamy rose	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.13764+00	2026-10-11 15:10:13.13764+00
2512	Everyone on This Train is a Suspect	everyone on this train is a suspect | benjamin stevenson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.146667+00	2026-10-11 15:10:13.146667+00
2514	Kindling	kindling | bonnie woods	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.169622+00	2026-10-11 15:10:13.169622+00
2515	Man, Fuck This House	man, fuck this house | brian asman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.179251+00	2026-10-11 15:10:13.179251+00
2516	Candy Cain Kills	candy cain kills | brian mcauley	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.184984+00	2026-10-11 15:10:13.184984+00
2518	Blood Moon	blood moon | britney s. lewis	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.20175+00	2026-10-11 15:10:13.20175+00
2519	Slewfoot	slewfoot | brom	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.210426+00	2026-10-11 15:10:13.210426+00
2520	A Haunting in the Arctic	a haunting in the arctic | c. j. cooke	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.218864+00	2026-10-11 15:10:13.218864+00
2521	The Cut	the cut | c. j. dotson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.226587+00	2026-10-11 15:10:13.226587+00
2522	Last to Leave the Room	last to leave the room | caitlin starling	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.236346+00	2026-10-11 15:10:13.236346+00
2523	The Graceview Patient	the graceview patient | caitlin starling	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.241808+00	2026-10-11 15:10:13.241808+00
2524	At the Bottom of the Garden	at the bottom of the garden | camilla bruce	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.252426+00	2026-10-11 15:10:13.252426+00
2525	The Takeover	the takeover | cara tanamachi	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.280573+00	2026-10-11 15:10:13.280573+00
2526	The Astrology House	the astrology house | carinn jade	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.292637+00	2026-10-11 15:10:13.292637+00
2527	Code Word Romance	code word romance | carlie walker	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.303445+00	2026-10-11 15:10:13.303445+00
2529	Mirrorland	mirrorland | carole johnstone	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.323684+00	2026-10-11 15:10:13.323684+00
2530	Sugarcane	sugarcane | cassandra celia	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.330225+00	2026-10-11 15:10:13.330225+00
2531	The Clinic	the clinic | cate quinn	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.33732+00	2026-10-11 15:10:13.33732+00
2536	The Disappearing Act	the disappearing act | catherine steadman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.373808+00	2026-10-11 15:10:13.373808+00
2537	Out Behind the Barn	out behind the barn | chad lutzke; john boden	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.382742+00	2026-10-11 15:10:13.382742+00
2539	The Farmhouse	the farmhouse | chelsea conradt	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.398154+00	2026-10-11 15:10:13.398154+00
2540	The Midnight Shift	the midnight shift | cheon seon-ran	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.404746+00	2026-10-11 15:10:13.404746+00
2544	Falling	falling | christina lauren	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.434117+00	2026-10-11 15:10:13.434117+00
2545	Night Birds	night birds | christopher golden	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.439478+00	2026-10-11 15:10:13.439478+00
2549	Ghost Eaters	ghost eaters | clay mcleod chapman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.465777+00	2026-10-11 15:10:13.465777+00
2550	Our Last Resort	our last resort | clemence michallon	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.470211+00	2026-10-11 15:10:13.470211+00
2551	Polybius	polybius | collin armstrong	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.481177+00	2026-10-11 15:10:13.481177+00
2552	Suffer the Children	suffer the children | craig dilouie	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.487714+00	2026-10-11 15:10:13.487714+00
2553	Something in the Walls	something in the walls | daisy pearce	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.494378+00	2026-10-11 15:10:13.494378+00
2554	The Truth According to Amber	the truth according to amber | danica nava	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.500806+00	2026-10-11 15:10:13.500806+00
2561	Aftertaste	aftertaste | daria lavelle	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.547819+00	2026-10-11 15:10:13.547819+00
2562	Bad Man	bad man | dathan auerbach	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.554594+00	2026-10-11 15:10:13.554594+00
2563	Withered Hill	withered hill | david barnett	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.561129+00	2026-10-11 15:10:13.561129+00
2564	Maggie's Grave	maggie's grave | david sodergren	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.566347+00	2026-10-11 15:10:13.566347+00
2565	The Forgotten Island	the forgotten island | david sodergren	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.570793+00	2026-10-11 15:10:13.570793+00
2566	Summer of the Monsters	summer of the monsters | david sodergren	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.575222+00	2026-10-11 15:10:13.575222+00
2567	A Curious Beginning	a curious beginning | deanna raybourn	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.581721+00	2026-10-11 15:10:13.581721+00
2570	Moderation	moderation | elaine castillo	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.602442+00	2026-10-11 15:10:13.602442+00
2571	The Heartbreak Hotel	the heartbreak hotel | ellen o'clover	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.608963+00	2026-10-11 15:10:13.608963+00
2572	Bad Date	bad date | ellery lloyd	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.61519+00	2026-10-11 15:10:13.61519+00
2573	Anywhere With You	anywhere with you | ellie palmer	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.621967+00	2026-10-11 15:10:13.621967+00
2575	Wild Eyes	wild eyes | elsie silver	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.635836+00	2026-10-11 15:10:13.635836+00
2576	Gothictown	gothictown | emily carpenter	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.642515+00	2026-10-11 15:10:13.642515+00
2577	Yours for the Season	yours for the season | emily stone	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.654899+00	2026-10-11 15:10:13.654899+00
2579	We Are Always Tender With Our Dead	we are always tender with our dead | eric larocca	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.668435+00	2026-10-11 15:10:13.668435+00
2580	Fall Too Well	fall too well | erin branscom	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.675114+00	2026-10-11 15:10:13.675114+00
2581	Unromance	unromance | erin connor	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.681581+00	2026-10-11 15:10:13.681581+00
2582	Bake the Town Red	bake the town red | eva marks	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.688446+00	2026-10-11 15:10:13.688446+00
2583	Change of Heart	change of heart | falon ballard	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.695408+00	2026-10-11 15:10:13.695408+00
2584	Full Bloom	full bloom | francesca serritella	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.702249+00	2026-10-11 15:10:13.702249+00
2585	The Next Best Fling	the next best fling | gabriella gamez	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.713585+00	2026-10-11 15:10:13.713585+00
2586	Itch	itch | gemma amor	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.71776+00	2026-10-11 15:10:13.71776+00
2588	The Merge	the merge | grace walker	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.730863+00	2026-10-11 15:10:13.730863+00
2589	We Sold Our Souls	we sold our souls | grady hendrix	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.735477+00	2026-10-11 15:10:13.735477+00
2591	The Golden Couple	the golden couple | greer hendricks; sarah pekkanen	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.744323+00	2026-10-11 15:10:13.744323+00
2595	Out of the Woods	out of the woods | hannah bonam-young	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.779693+00	2026-10-11 15:10:13.779693+00
2596	Holiday Ever After	holiday ever after | hannah grace	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.784707+00	2026-10-11 15:10:13.784707+00
2597	Same Paige	same paige | hannah jay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.793694+00	2026-10-11 15:10:13.793694+00
2598	Maine Characters	maine characters | hannah orenstein	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.800653+00	2026-10-11 15:10:13.800653+00
2599	The Search Party	the search party | hannah richell	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.807392+00	2026-10-11 15:10:13.807392+00
2601	The Possession of Alba Diaz	the possession of alba diaz | isabel cañas	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.829302+00	2026-10-11 15:10:13.829302+00
2602	The Darkest Half	the darkest half | j. a. redmerski	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.833744+00	2026-10-11 15:10:13.833744+00
2604	Survivor	survivor | j. f. gonzalez	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.846782+00	2026-10-11 15:10:13.846782+00
2605	Guava Flavored Lies	guava flavored lies | j.j. arias	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.853131+00	2026-10-11 15:10:13.853131+00
2606	Spicy Little Curses	spicy little curses | j. t. geissinger	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.859687+00	2026-10-11 15:10:13.859687+00
2608	The Strength of the Few	the strength of the few | james islington	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.870662+00	2026-10-11 15:10:13.870662+00
2610	Flirting Lessons	flirting lessons | jasmine guillory	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.885747+00	2026-10-11 15:10:13.885747+00
2611	Hidden Pictures	hidden pictures | jason rekulak	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.894946+00	2026-10-11 15:10:13.894946+00
2612	Big Swiss	big swiss | jen beagin	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.90149+00	2026-10-11 15:10:13.90149+00
2614	You Shouldn't Have Come Here	you shouldn't have come here | jeneva rose	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.915735+00	2026-10-11 15:10:13.915735+00
2615	My Vampire Plus-One	my vampire plus-one | jenna levine	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.92266+00	2026-10-11 15:10:13.92266+00
2616	I'm Glad My Mom Died	i'm glad my mom died | jennette mccurdy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.930345+00	2026-10-11 15:10:13.930345+00
2617	Beneath the Stairs	beneath the stairs | jennifer fawcett	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.936972+00	2026-10-11 15:10:13.936972+00
2618	The Butcher	the butcher | jennifer hillier	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.948304+00	2026-10-11 15:10:13.948304+00
2619	My Darling Girl	my darling girl | jennifer mcmahon	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.953235+00	2026-10-11 15:10:13.953235+00
2620	I'll Be Home for Christmas	i'll be home for christmas | jenny bayliss	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.962301+00	2026-10-11 15:10:13.962301+00
2621	Crafting for Sinners	crafting for sinners | jenny kiefer	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.966758+00	2026-10-11 15:10:13.966758+00
2622	Open Wide	open wide | jessica gross	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.977949+00	2026-10-11 15:10:13.977949+00
2623	The Ex Vows	the ex vows | jessica joyce	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.982525+00	2026-10-11 15:10:13.982525+00
2624	Vera Wong's Guide to Snooping (on a Dead Man)	vera wong's guide to snooping (on a dead man) | jessie q. sutanto	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.99236+00	2026-10-11 15:10:13.99236+00
2625	The Fiction Writer	the fiction writer | jillian cantor	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.00775+00	2026-10-11 15:10:14.00775+00
2628	Devil House	devil house | john darnielle	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.038454+00	2026-10-11 15:10:14.038454+00
2632	It Waits in the Woods	it waits in the woods | josh malerman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.070185+00	2026-10-11 15:10:14.070185+00
2633	Burn the Negative	burn the negative | josh winning	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.07668+00	2026-10-11 15:10:14.07668+00
2636	No One Rides For Free	no one rides for free | judith sonnet	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.097511+00	2026-10-11 15:10:14.097511+00
2637	Christmas at the Ranch	christmas at the ranch | julia mckay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.104075+00	2026-10-11 15:10:14.104075+00
2638	Forget Me Not	forget me not | julie soto	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.114834+00	2026-10-11 15:10:14.114834+00
2642	Welcome to Murder Week	welcome to murder week | karen dukess	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.142431+00	2026-10-11 15:10:14.142431+00
2644	Bad for Business	bad for business | kat singleton	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.159695+00	2026-10-11 15:10:14.159695+00
2647	Serial Killer Games	serial killer games | kate posey	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.189703+00	2026-10-11 15:10:14.189703+00
2648	Fang Fiction	fang fiction | kate stayman-london	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.197911+00	2026-10-11 15:10:14.197911+00
2649	Beautiful Nightmare	beautiful nightmare | katee robert	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.205365+00	2026-10-11 15:10:14.205365+00
2650	A Love Most Fatal	a love most fatal | kath richards	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.21213+00	2026-10-11 15:10:14.21213+00
2720	Overgrowth	overgrowth | mira grant	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.723411+00	2026-10-11 15:10:14.723411+00
2651	The Bodyguard	the bodyguard | katherine center	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.218797+00	2026-10-11 15:10:14.218797+00
2652	High Season	high season | katie bishop	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.228568+00	2026-10-11 15:10:14.228568+00
2653	Knives, Seasoning, and a Dash of Love	knives, seasoning, and a dash of love | katrina kwan	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.235765+00	2026-10-11 15:10:14.235765+00
2654	Enchantra	enchantra | kaylie smith	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.240213+00	2026-10-11 15:10:14.240213+00
2656	Party of Liars	party of liars | kelsey cox	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.256083+00	2026-10-11 15:10:14.256083+00
2658	House of Beth	house of beth | kerry cullen	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.272613+00	2026-10-11 15:10:14.272613+00
2659	Mister Magic	mister magic | kiersten white	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.276979+00	2026-10-11 15:10:14.276979+00
2660	My Boyfriends Are All Monsters	my boyfriends are all monsters | kimberly lemming	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.285972+00	2026-10-11 15:10:14.285972+00
2663	Big Nick Energy	big nick energy | kristen bailey	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.304806+00	2026-10-11 15:10:14.304806+00
2671	Love Me Stalk Me	love me stalk me | laura bishop	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.358181+00	2026-10-11 15:10:14.358181+00
2700	Love at First Sighting	love at first sighting | mallory marlowe	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.571559+00	2026-10-11 15:10:14.571559+00
2702	Bad Things Happened In This Room	bad things happened in this room | marie still	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.584971+00	2026-10-11 15:10:14.584971+00
2703	Thirst	thirst | marina yuszczuk	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.592109+00	2026-10-11 15:10:14.592109+00
2705	The Darkest Water	the darkest water | mark edwards	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.606806+00	2026-10-11 15:10:14.606806+00
2706	The Wasp Trap	the wasp trap | mark edwards	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.61634+00	2026-10-11 15:10:14.61634+00
2707	She's Not Sorry	she's not sorry | mary kubica	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.620695+00	2026-10-11 15:10:14.620695+00
2710	The North Line	the north line | matt riordan	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.645909+00	2026-10-11 15:10:14.645909+00
2711	Feeders	feeders | matt serafini	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.659537+00	2026-10-11 15:10:14.659537+00
2713	My Husband	my husband | maud ventura	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.672452+00	2026-10-11 15:10:14.672452+00
2714	Suburban Hell	suburban hell | maureen kilmer	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.679366+00	2026-10-11 15:10:14.679366+00
2717	The Perfect Rom-Com	the perfect rom-com | melissa ferguson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.702561+00	2026-10-11 15:10:14.702561+00
2718	The Once and Future Me	the once and future me | melissa pace	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.709406+00	2026-10-11 15:10:14.709406+00
2719	The October Film Haunt	the october film haunt | michael wehunt	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.716787+00	2026-10-11 15:10:14.716787+00
2721	Smile for the Cameras	smile for the cameras | miranda smith	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.731945+00	2026-10-11 15:10:14.731945+00
2722	Unseen	unseen | molly burke	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.742+00	2026-10-11 15:10:14.742+00
2723	Wrath of an Exile	wrath of an exile | monty jay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.7506+00	2026-10-11 15:10:14.7506+00
2724	Nothing But the Rain	nothing but the rain | naomi salman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.758945+00	2026-10-11 15:10:14.758945+00
2726	Crypt of the Moon Spider	crypt of the moon spider | nathan ballingrud	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.77004+00	2026-10-11 15:10:14.77004+00
2727	The Burial Tide	the burial tide | neil sharpson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.774947+00	2026-10-11 15:10:14.774947+00
2728	The Handyman Method	the handyman method | andrew sullivan; nick cutter	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.785652+00	2026-10-11 15:10:14.785652+00
2729	Where He Left Me	where he left me | nicole baart	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.795457+00	2026-10-11 15:10:14.795457+00
2733	Murder by Memory	murder by memory | olivia waite	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.825242+00	2026-10-11 15:10:14.825242+00
2734	Gifted & Talented	gifted & talented | olivie blake	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.832322+00	2026-10-11 15:10:14.832322+00
2735	Wolf.e	wolf.e | paisley hope	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.83902+00	2026-10-11 15:10:14.83902+00
2737	The Confessions	the confessions | paul bradley carr	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.856579+00	2026-10-11 15:10:14.856579+00
2738	Horror Movie	horror movie | paul tremblay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.861489+00	2026-10-11 15:10:14.861489+00
2739	The Beast You Are	the beast you are | paul tremblay	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.868453+00	2026-10-11 15:10:14.868453+00
2743	Tantrum	tantrum | rachel eve moulton	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.900822+00	2026-10-11 15:10:14.900822+00
2744	Play Nice	play nice | rachel harrison	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.925235+00	2026-10-11 15:10:14.925235+00
2745	Learning Curves	learning curves | rachel lacey	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.939213+00	2026-10-11 15:10:14.939213+00
2750	Space Vampire	space vampire | ruby dixon	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.99616+00	2026-10-11 15:10:14.99616+00
2751	The Ice Retreat	the ice retreat | ruth kelly	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.002811+00	2026-10-11 15:10:15.002811+00
2752	Zero Days	zero days | ruth ware	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.009244+00	2026-10-11 15:10:15.009244+00
2753	The Woman in Suite 11	the woman in suite 11 | ruth ware	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.016466+00	2026-10-11 15:10:15.016466+00
2756	Savage Blooms	savage blooms | s. t. gibson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.03507+00	2026-10-11 15:10:15.03507+00
2760	The Ex-Wives Club	the ex-wives club | sally hepworth	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.055971+00	2026-10-11 15:10:15.055971+00
2761	I Was Feeling Epic	i was feeling epic | samantha highfill	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.06347+00	2026-10-11 15:10:15.06347+00
2762	True Crime	true crime | samantha kolesnik	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.072852+00	2026-10-11 15:10:15.072852+00
2763	The Cabin in the Woods	the cabin in the woods | sarah alderson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.08161+00	2026-10-11 15:10:15.08161+00
2766	A Merry Little Lie	a merry little lie | sarah morgan	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.097434+00	2026-10-11 15:10:15.097434+00
2767	Gone Tonight	gone tonight | sarah pekkanen	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.102566+00	2026-10-11 15:10:15.102566+00
2768	House of Glass	house of glass | sarah pekkanen	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.107596+00	2026-10-11 15:10:15.107596+00
2769	The Locked Ward	the locked ward | sarah pekkanen	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.112109+00	2026-10-11 15:10:15.112109+00
2772	Volatile Memory	volatile memory | seth haddon	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.136705+00	2026-10-11 15:10:15.136705+00
2773	I Did Warn Her	i did warn her | sian gilbert	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.143331+00	2026-10-11 15:10:15.143331+00
2774	The Book of Cold Cases	the book of cold cases | simone st. james	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.149561+00	2026-10-11 15:10:15.149561+00
2775	Tart	tart | slutty cheff	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.156691+00	2026-10-11 15:10:15.156691+00
2776	Forget Me Not	forget me not | stacy willingham	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.170686+00	2026-10-11 15:10:15.170686+00
2777	The Threshing Floor	the threshing floor | steph nelson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.178052+00	2026-10-11 15:10:15.178052+00
2778	Overdue	overdue | stephanie perkins	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.18478+00	2026-10-11 15:10:15.18478+00
2780	Triple Sec	triple sec | tj alexander	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.201597+00	2026-10-11 15:10:15.201597+00
2783	A House With Good Bones	a house with good bones | t. kingfisher	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.226852+00	2026-10-11 15:10:15.226852+00
2785	Left of Forever	left of forever | tarah dewitt	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.243973+00	2026-10-11 15:10:15.243973+00
2786	Love Letters to a Serial Killer	love letters to a serial killer | tasha coryell	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.256532+00	2026-10-11 15:10:15.256532+00
2787	Such Lovely Skin	such lovely skin | tatiana schlote-bonne	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.271611+00	2026-10-11 15:10:15.271611+00
2788	Hairpin Bridge	hairpin bridge | taylor adams	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.27842+00	2026-10-11 15:10:15.27842+00
2789	The Inheritance	the inheritance | trisha sakhlecha	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.285742+00	2026-10-11 15:10:15.285742+00
2790	The Second Death of Locke	the second death of locke | v. l. bovalino	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.297247+00	2026-10-11 15:10:15.297247+00
2791	The Honeycrisp Orchard Inn	the honeycrisp orchard inn | valerie bowman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.305742+00	2026-10-11 15:10:15.305742+00
2792	Someone Knows	someone knows | vi keeland	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.313995+00	2026-10-11 15:10:15.313995+00
2793	The Unraveling	the unraveling | vi keeland	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.32409+00	2026-10-11 15:10:15.32409+00
2794	Escape Velocity	escape velocity | victor manibo	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.334178+00	2026-10-11 15:10:15.334178+00
2796	Bourbon and Secrets	bourbon and secrets | victoria wilder	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.347841+00	2026-10-11 15:10:15.347841+00
2797	Bourbon and Proof	bourbon and proof | victoria wilder	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.353343+00	2026-10-11 15:10:15.353343+00
2798	We Came to Welcome You	we came to welcome you | vincent tirado	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.363903+00	2026-10-11 15:10:15.363903+00
2809	The Long Game	the long game | rachel reid	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.472361+00	2026-10-11 15:10:15.472361+00
2811	The Wind Weaver	the wind weaver | julie johnson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.489054+00	2026-10-11 15:10:15.489054+00
2816	Game Changer	game changer | rachel reid	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.525094+00	2026-10-11 15:10:15.525094+00
2817	Role Model	role model | rachel reid	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.529642+00	2026-10-11 15:10:15.529642+00
2818	Common Goal	common goal | rachel reid	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.534563+00	2026-10-11 15:10:15.534563+00
2819	Tough Guy	tough guy | rachel reid	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.538992+00	2026-10-11 15:10:15.538992+00
2820	Pretty Vicious	pretty vicious | lexi davis	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.546997+00	2026-10-11 15:10:15.546997+00
2822	The Storm	the storm | rachel hawkins	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.56391+00	2026-10-11 15:10:15.56391+00
2827	Paper Cut	paper cut | rachel taff	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.592495+00	2026-10-11 15:10:15.592495+00
2833	The Exes	the exes | leodora darlington	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.628166+00	2026-10-11 15:10:15.628166+00
2835	Warning Signs	warning signs | tracy sierra	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.655932+00	2026-10-11 15:10:15.655932+00
2837	Her Last Breath	her last breath | taylor adams	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.668957+00	2026-10-11 15:10:15.668957+00
2839	The Re-Do List	the re-do list | denise williams	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.682738+00	2026-10-11 15:10:15.682738+00
2842	Nowhere Burning	nowhere burning | catriona ward	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.699537+00	2026-10-11 15:10:15.699537+00
2843	Sap and Secrets	sap and secrets | daphne elliot	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.70761+00	2026-10-11 15:10:15.70761+00
2844	Accidentally Yours	accidentally yours | christina lauren	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.712506+00	2026-10-11 15:10:15.712506+00
2845	Time Will Tell	time will tell | hannah bonam-young	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.717352+00	2026-10-11 15:10:15.717352+00
2847	Second Act Romance	second act romance | julie soto	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.727537+00	2026-10-11 15:10:15.727537+00
2848	A Play for Love	a play for love | trilina pucci	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.734542+00	2026-10-11 15:10:15.734542+00
2854	Half City	half city | kate golden	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.792161+00	2026-10-11 15:10:15.792161+00
2856	Whidbey	whidbey | t kira mahealani madden	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.811106+00	2026-10-11 15:10:15.811106+00
2859	A Girl Like Her	a girl like her | talia hibbert	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.830447+00	2026-10-11 15:10:15.830447+00
2860	How to Survive in the Woods	how to survive in the woods | kat rosenfield	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.837124+00	2026-10-11 15:10:15.837124+00
2865	Don't Ask Why	don't ask why | steph nelson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.888652+00	2026-10-11 15:10:15.888652+00
2867	The Move	the move | j. p. delaney	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.899072+00	2026-10-11 15:10:15.899072+00
2868	Served Him Right	served him right | lisa unger	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.904456+00	2026-10-11 15:10:15.904456+00
2869	How to Write a Love Story	how to write a love story | catherine walsh	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.911431+00	2026-10-11 15:10:15.911431+00
2870	Love Song	love song | elle kennedy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.916145+00	2026-10-11 15:10:15.916145+00
2871	You Did Nothing Wrong	you did nothing wrong | c. g. drews	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.92304+00	2026-10-11 15:10:15.92304+00
2872	You Should Have Been Nicer to My Mom	you should have been nicer to my mom | vincent tirado	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.92757+00	2026-10-11 15:10:15.92757+00
2873	Strangers in the Villa	strangers in the villa | robyn harding	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.934531+00	2026-10-11 15:10:15.934531+00
2874	Please Don't Go	please don't go | e. salvador	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.941798+00	2026-10-11 15:10:15.941798+00
2876	A Promise So Bold and Broken	a promise so bold and broken | sophia st. germain	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.962588+00	2026-10-11 15:10:15.962588+00
2877	A Bond So Fierce and Fragile	a bond so fierce and fragile | sophia st. germain	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.967363+00	2026-10-11 15:10:15.967363+00
2878	A Fate So Dark and Delicate	a fate so dark and delicate | sophia st. germain	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.972393+00	2026-10-11 15:10:15.972393+00
2880	Sorry For Your Loss	sorry for your loss | georgia mcveigh	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.986495+00	2026-10-11 15:10:15.986495+00
2881	A Good Person	a good person | kirsten king	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.993473+00	2026-10-11 15:10:15.993473+00
2882	The Bridge Back To You	the bridge back to you | riss m. neilson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.999959+00	2026-10-11 15:10:15.999959+00
2884	Kiss, Mary, Kill	kiss, mary, kill | lori gold	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.018951+00	2026-10-11 15:10:16.018951+00
2885	A Killer In the Family	a killer in the family | amin ahmad	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.027415+00	2026-10-11 15:10:16.027415+00
2886	Enemies to Lovers	enemies to lovers | alisha rai	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.034935+00	2026-10-11 15:10:16.034935+00
2889	The Summer I Found You	the summer i found you | jennifer o'brien	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.050648+00	2026-10-11 15:10:16.050648+00
2891	While You Were Seething	while you were seething | charlotte stein	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.063749+00	2026-10-11 15:10:16.063749+00
2893	The Write Off	the write off | kara mcdowell	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.077334+00	2026-10-11 15:10:16.077334+00
2895	Morsell	morsell | carter keane	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.088797+00	2026-10-11 15:10:16.088797+00
2897	The Drop	the drop | s.r. masters	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.099678+00	2026-10-11 15:10:16.099678+00
2899	Watership Down	watership down | richard adams	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.111536+00	2026-10-11 15:10:16.111536+00
2903	How (Not) To Raise The Dead	how (not) to raise the dead | rachael chadwick	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.136982+00	2026-10-11 15:10:16.136982+00
2906	The Author Weekend	the author weekend | laura zigman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.158705+00	2026-10-11 15:10:16.158705+00
2909	Mine to Hunt	mine to hunt | c. o. wheel; tanya das	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.180633+00	2026-10-11 15:10:16.180633+00
2910	The Last Page	the last page | katie holt	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.187097+00	2026-10-11 15:10:16.187097+00
2911	The Dorians	the dorians | nick cutter	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.191748+00	2026-10-11 15:10:16.191748+00
2912	Until Death	until death | mary berman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.19878+00	2026-10-11 15:10:16.19878+00
2917	It Happened One Murder	it happened one murder | liz lawson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.231523+00	2026-10-11 15:10:16.231523+00
2919	The Romance Line	the romance line | lauren blakely	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.243352+00	2026-10-11 15:10:16.243352+00
2920	The Proposal Play	the proposal play | lauren blakely	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.24807+00	2026-10-11 15:10:16.24807+00
2921	The Girlfriend Zone	the girlfriend zone | lauren blakely	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.252688+00	2026-10-11 15:10:16.252688+00
2922	The Overtime Kiss	the overtime kiss | lauren blakely	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.257198+00	2026-10-11 15:10:16.257198+00
2923	The Flirting Game	the flirting game | lauren blakely	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.261687+00	2026-10-11 15:10:16.261687+00
2925	When Sparks Fly	when sparks fly | monica murphy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.273494+00	2026-10-11 15:10:16.273494+00
2926	The Risk	the risk | elle kennedy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.278038+00	2026-10-11 15:10:16.278038+00
2927	The Chase	the chase | elle kennedy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.283205+00	2026-10-11 15:10:16.283205+00
2928	The Play	the play | elle kennedy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.287913+00	2026-10-11 15:10:16.287913+00
2929	The Dare	the dare | elle kennedy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.292881+00	2026-10-11 15:10:16.292881+00
2930	The Charlie Method	the charlie method | elle kennedy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.297738+00	2026-10-11 15:10:16.297738+00
2931	The Graham Effect	the graham effect | elle kennedy	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.30247+00	2026-10-11 15:10:16.30247+00
2933	Crown Me Yours	crown me yours | liv zander	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.314467+00	2026-10-11 15:10:16.314467+00
2934	Midnight Message	midnight message | avina st. graves	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.321322+00	2026-10-11 15:10:16.321322+00
2936	The Girl in the Lake	the girl in the lake | lauren oliver	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.33239+00	2026-10-11 15:10:16.33239+00
2937	Marion	marion | leah rowan	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.339392+00	2026-10-11 15:10:16.339392+00
2942	Girl's Girl	girl's girl | sonia feldman	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.382605+00	2026-10-11 15:10:16.382605+00
2943	The Song of Salt and Smoke	the song of salt and smoke | seren rose	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.389082+00	2026-10-11 15:10:16.389082+00
2968	The Roommate Rule	the roommate rule | georgia stone	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.535858+00	2026-10-11 15:10:16.535858+00
2982	Fruit Fly	fruit fly | josh silver	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.627065+00	2026-10-11 15:10:16.627065+00
2986	Stay Buried	stay buried | jennifer mcmahon	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.64963+00	2026-10-11 15:10:16.64963+00
2987	Colt	colt | jessica peterson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.656853+00	2026-10-11 15:10:16.656853+00
2993	Kiss Slay Replay	kiss slay replay | rachel harrison	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.692846+00	2026-10-11 15:10:16.692846+00
3000	Keep Them Close	keep them close | david ellis	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.902251+00	2026-10-11 15:10:16.902251+00
3011	The Women in White	the women in white | sarah pekkanen	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.014931+00	2026-10-11 15:10:17.014931+00
3012	She's a Doll	she's a doll | barbara truelove	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.027492+00	2026-10-11 15:10:17.027492+00
3015	Fallow	fallow | sarah anderson	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.046548+00	2026-10-11 15:10:17.046548+00
3016	Serenity Falls	serenity falls | c. j. tudor	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.050968+00	2026-10-11 15:10:17.050968+00
3027	Shield of Sparrows	shield of sparrows | devney perry	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.364144+00	2026-10-11 15:10:17.364144+00
3028	A Deal With the Elf King	a deal with the elf king | elise kova	\N	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.384193+00	2026-10-11 15:10:17.384193+00
2286	The Watchers	the watchers | a. m. shine	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.085226+00	2026-10-11 15:10:17.4652+00
2287	Every Last Fear	every last fear | alex finlay	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.185456+00	2026-10-11 15:10:17.468338+00
2288	All Good People Here	all good people here | ashley flowers	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.365746+00	2026-10-11 15:10:17.468374+00
2289	Iris Kelly Doesn't Date	iris kelly doesn't date | ashley herring blake	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.458892+00	2026-10-11 15:10:17.468387+00
2290	The Switch	the switch | beth o'leary	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.471538+00	2026-10-11 15:10:17.468397+00
2291	Dark Matter	dark matter | blake crouch	2016	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.483822+00	2026-10-11 15:10:17.468407+00
2292	The Taking of Annie Thorne	the taking of annie thorne | c. j. tudor	2019	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.5621+00	2026-10-11 15:10:17.468416+00
2293	The Trap	the trap | catherine ryan howard	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.666573+00	2026-10-11 15:10:17.468429+00
2294	The Nothing Man	the nothing man | catherine ryan howard	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.757836+00	2026-10-11 15:10:17.468439+00
2295	The Quiet Tenant	the quiet tenant | clemence michallon	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.777925+00	2026-10-11 15:10:17.468456+00
2296	Mickey7	mickey7 | edward ashton	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.882861+00	2026-10-11 15:10:17.46847+00
2297	Reckless	reckless | elsie silver	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:45.97831+00	2026-10-11 15:10:17.468483+00
2298	Powerless	powerless | elsie silver	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.063159+00	2026-10-11 15:10:17.468493+00
2299	The Room	the room | emma donoghue	2010	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.085775+00	2026-10-11 15:10:17.468508+00
2300	The Inmate	the inmate | freida mcfadden	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.166103+00	2026-10-11 15:10:17.468519+00
2301	The Boyfriend	the boyfriend | freida mcfadden	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.176922+00	2026-10-11 15:10:17.468529+00
2302	Never Lie	never lie | freida mcfadden	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.187347+00	2026-10-11 15:10:17.46854+00
2303	Next of Kin	next of kin | hannah bonam-young	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.262373+00	2026-10-11 15:10:17.46855+00
2304	Good Girl, Bad Blood	good girl, bad blood | holly jackson	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.359648+00	2026-10-11 15:10:17.468559+00
2305	As Good as Dead	as good as dead | holly jackson	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.373033+00	2026-10-11 15:10:17.468568+00
2306	Lifelike	lifelike | jay kristoff	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.384209+00	2026-10-11 15:10:17.468579+00
2307	Things We Do In the Dark	things we do in the dark | jennifer hillier	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.46758+00	2026-10-11 15:10:17.468591+00
2308	Keep it in the Family	keep it in the family | john marrs	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.484903+00	2026-10-11 15:10:17.468617+00
2309	What Lies Between Us	what lies between us | john marrs	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.559574+00	2026-10-11 15:10:17.468628+00
2310	When You Disappeared	when you disappeared | john marrs	2013	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.570637+00	2026-10-11 15:10:17.468638+00
2311	The New Wife	the new wife | j. p. delaney	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.669763+00	2026-10-11 15:10:17.468653+00
2312	Leave Me Behind	leave me behind | k.m. moronova	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.760862+00	2026-10-11 15:10:17.468664+00
2313	The Ministry of Time	the ministry of time | kaliane bradley	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.774006+00	2026-10-11 15:10:17.468674+00
2314	You, Again	you, again | kate goldbeck	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.861886+00	2026-10-11 15:10:17.468686+00
2315	Phantasma	phantasma | kaylie smith	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.875369+00	2026-10-11 15:10:17.468697+00
2316	Nocticadia	nocticadia | keri lake	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.887954+00	2026-10-11 15:10:17.468707+00
2317	End of Story	end of story | louise swanson	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.97153+00	2026-10-11 15:10:17.468719+00
2318	The Paris Apartment	the paris apartment | lucy foley	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:46.982319+00	2026-10-11 15:10:17.468728+00
2319	All Rhodes Lead Here	all rhodes lead here | mariana zapata	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.062855+00	2026-10-11 15:10:17.468738+00
2320	The Psychopath Next Door	the psychopath next door | mark edwards	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.074862+00	2026-10-11 15:10:17.468747+00
2321	Local Woman Missing	local woman missing | mary kubica	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.155733+00	2026-10-11 15:10:17.468757+00
2322	A Brush With Love	a brush with love | mazey eddings	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.168788+00	2026-10-11 15:10:17.468766+00
2323	Till Summer Do Us Part	till summer do us part | meghan quinn	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.182834+00	2026-10-11 15:10:17.468776+00
2324	Don't Eat the Pie	don't eat the pie | monique asher	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.277568+00	2026-10-11 15:10:17.468787+00
2325	Chain-Gang All-Stars	chain-gang all-stars | nana kwame adjei-brenyah	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.366431+00	2026-10-11 15:10:17.468797+00
2326	Don't Let Her Stay	don't let her stay | nicola sanders	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.380608+00	2026-10-11 15:10:17.468807+00
2327	Business or Pleasure	business or pleasure | rachel lynn solomon	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.569123+00	2026-10-11 15:10:17.46882+00
2328	The It Girl	the it girl | ruth ware	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.670259+00	2026-10-11 15:10:17.46883+00
2329	Happy Medium	happy medium | sarah adler	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.761122+00	2026-10-11 15:10:17.468841+00
2330	Alchemised	alchemised | senlinyu	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.786461+00	2026-10-11 15:10:17.468852+00
2331	Brutal Prince	brutal prince | sophie lark	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:47.87685+00	2026-10-11 15:10:17.468863+00
2332	Firestarter	firestarter | stephen king	1980	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.172923+00	2026-10-11 15:10:17.468882+00
2333	Seven Deaths of Evelyn Hardcastle	seven deaths of evelyn hardcastle | stuart turton	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.274208+00	2026-10-11 15:10:17.468892+00
2334	Only Human	only human | sylvain neuvel	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.28468+00	2026-10-11 15:10:17.468901+00
2335	Waking Gods	waking gods | sylvain neuvel	2017	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.376981+00	2026-10-11 15:10:17.468909+00
2336	The Twisted Ones	the twisted ones | t. kingfisher	2019	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.459452+00	2026-10-11 15:10:17.468918+00
2337	Savor It	savor it | tarah dewitt	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.482147+00	2026-10-11 15:10:17.468928+00
2338	Bury Our Bones in the Midnight Soil	bury our bones in the midnight soil | v. e. schwab	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.563786+00	2026-10-11 15:10:17.468937+00
2339	We Spread	we spread | iain reid	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.579144+00	2026-10-11 15:10:17.468945+00
2340	Dungeon Crawler Carl	dungeon crawler carl | matt dinniman	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:48.784022+00	2026-10-11 15:10:17.46896+00
2341	Still Beating	still beating | jennifer hartmann	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.075444+00	2026-10-11 15:10:17.468976+00
2342	Ready or Not	ready or not | cara bastone	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.379122+00	2026-10-11 15:10:17.468997+00
2343	The Housemaid Is Watching	the housemaid is watching | freida mcfadden	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.465339+00	2026-10-11 15:10:17.469007+00
2344	Ex Vows	ex vows | jessica joyce	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.483561+00	2026-10-11 15:10:17.469017+00
2345	Next to You	next to you | hannah bonam-young	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.572679+00	2026-10-11 15:10:17.469026+00
2346	The Fake Out	the fake out | stephanie archer	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.603413+00	2026-10-11 15:10:17.469035+00
2347	The Wingman	the wingman | stephanie archer	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.66621+00	2026-10-11 15:10:17.469043+00
2348	Revolve	revolve | bal khabra	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.725646+00	2026-10-11 15:10:17.469053+00
2349	Fall I Want	fall i want | lyra parish	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.764462+00	2026-10-11 15:10:17.469063+00
2350	Praise	praise | sara cate	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:49.971007+00	2026-10-11 15:10:17.469079+00
2351	Hopeless	hopeless | elsie silver	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.058183+00	2026-10-11 15:10:17.469088+00
2352	King of Pride	king of pride | ana huang	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.272023+00	2026-10-11 15:10:17.469101+00
2353	King of Greed	king of greed | ana huang	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.364714+00	2026-10-11 15:10:17.46911+00
2354	The Christmas Tree Farm	the christmas tree farm | laurie gilmore	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.381717+00	2026-10-11 15:10:17.469118+00
2355	Blood Over Bright Haven	blood over bright haven | m. l. wang	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.468731+00	2026-10-11 15:10:17.469128+00
2356	Willing Prey	willing prey | allie oleander	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.66103+00	2026-10-11 15:10:17.469141+00
2357	Daddy Issues	daddy issues | kate goldbeck	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.673102+00	2026-10-11 15:10:17.46915+00
2358	Count My Lies	count my lies | sophie stava	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.687683+00	2026-10-11 15:10:17.46916+00
2359	Haunting the Hunter	haunting the hunter | hanna harp	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.774179+00	2026-10-11 15:10:17.469171+00
2360	Furybound	furybound | sable sorensen	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.85978+00	2026-10-11 15:10:17.46918+00
2361	The Deep	the deep | nick cutter	2015	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.873126+00	2026-10-11 15:10:17.469188+00
2362	What Happens in Amsterdam	what happens in amsterdam | rachel lynn solomon	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.965082+00	2026-10-11 15:10:17.469197+00
2363	The Wild Card	the wild card | stephanie archer	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:50.976612+00	2026-10-11 15:10:17.469206+00
2364	Gloves Off	gloves off | stephanie archer	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.060242+00	2026-10-11 15:10:17.469216+00
2365	Broken Dove	broken dove | dani francis	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.269336+00	2026-10-11 15:10:17.469231+00
2366	Dear Reader	dear reader | tate james	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.28246+00	2026-10-11 15:10:17.469241+00
2367	Great Big Beautiful Life	great big beautiful life | emily henry	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.361307+00	2026-10-11 15:10:17.469249+00
2368	Rook & Rebel	rook & rebel | kate crew	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.375203+00	2026-10-11 15:10:17.471367+00
2369	Good Girls Don't Die	good girls don't die | christina henry	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.385658+00	2026-10-11 15:10:17.471405+00
2370	Just for the Summer	just for the summer | abby jimenez	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.466148+00	2026-10-11 15:10:17.471417+00
2371	Black Sheep	black sheep | rachel harrison	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.561179+00	2026-10-11 15:10:17.471427+00
2372	Embrace	embrace | bal khabra	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.577153+00	2026-10-11 15:10:17.471436+00
2373	Don't Let Him In	don't let him in | lisa jewell	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.755778+00	2026-10-11 15:10:17.471447+00
2374	Daggermouth	daggermouth | h. m. wolfe	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.775683+00	2026-10-11 15:10:17.471459+00
2375	Into the Fading Twilight	into the fading twilight | catherine cowles	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.86281+00	2026-10-11 15:10:17.471468+00
2376	Harvest Season	harvest season | brynne weaver	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.963073+00	2026-10-11 15:10:17.471479+00
2377	Prince of Swords	prince of swords | elise kova	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:51.974534+00	2026-10-11 15:10:17.471488+00
2378	Any Man	any man | amber tambglyn	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.074125+00	2026-10-11 15:10:17.4715+00
2379	Insatiable	insatiable | leigh rivers	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.255793+00	2026-10-11 15:10:17.471512+00
2380	The Divorce	the divorce | freida mcfadden	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.269779+00	2026-10-11 15:10:17.47152+00
2381	A Court of Thorns and Roses	a court of thorns and roses | sarah j. maas	2015	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.358317+00	2026-10-11 15:10:17.471529+00
2382	Bulletproof	bulletproof | k.m. moronova	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.374032+00	2026-10-11 15:10:17.471538+00
2383	The Night We Met	the night we met | abby jimenez	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.455695+00	2026-10-11 15:10:17.471547+00
2384	Bourbon & Lies	bourbon & lies | victoria wilder	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.558419+00	2026-10-11 15:10:17.471558+00
2385	There Is No Antimimetics Division	there is no antimimetics division | qntm	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.66969+00	2026-10-11 15:10:17.471571+00
2386	Free Falling	free falling | lyla sage	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.759479+00	2026-10-11 15:10:17.47158+00
2387	Bonfire and Bliss Bookstore	bonfire and bliss bookstore | brittanee nicole	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.773841+00	2026-10-11 15:10:17.47159+00
2388	They Know If You've Been Bad or Good	they know if you've been bad or good | alta hensley	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.858294+00	2026-10-11 15:10:17.471599+00
2389	Bourbon & Proof	bourbon & proof | victoria wilder	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.961087+00	2026-10-11 15:10:17.471611+00
2390	Little Stranger	little stranger | leigh rivers	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.972079+00	2026-10-11 15:10:17.471619+00
2391	Little Liar	little liar | leigh rivers	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:52.98323+00	2026-10-11 15:10:17.471628+00
2392	Extracurricular	extracurricular | rachel lynn solomon	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:53.062768+00	2026-10-11 15:10:17.471637+00
2393	Beneath a Midnight Moon	beneath a midnight moon | catherine cowles	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:53.074229+00	2026-10-11 15:10:17.471645+00
2394	Victorious	victorious | v. e. schwab	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:09:53.084664+00	2026-10-11 15:10:17.471654+00
2395	Lock Every Door	lock every door | riley sager	2019	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:09:53.369438+00	2026-10-11 15:10:17.471673+00
2396	Never Never	never never | colleen hoover; tarryn fisher	2015	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:09:56.468077+00	2026-10-11 15:10:17.471783+00
2398	City of Bones	city of bones | cassandra clare	2007	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:09:59.962057+00	2026-10-11 15:10:17.471923+00
2399	City of Ashes	city of ashes | cassandra clare	2008	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:09:59.973482+00	2026-10-11 15:10:17.471933+00
2400	Dark Places	dark places | gillian flynn	2009	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:00.075785+00	2026-10-11 15:10:17.471946+00
2401	Insatiable	insatiable | meg cabot	2010	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:00.663761+00	2026-10-11 15:10:17.471973+00
2402	Verity	verity | colleen hoover	2018	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:01.673027+00	2026-10-11 15:10:17.473331+00
2403	The Dark Forest	the dark forest | liu cixin	2008	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:01.762952+00	2026-10-11 15:10:17.473349+00
2404	The Bromance Book Club	the bromance book club | lyssa kay adams	2019	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:01.879219+00	2026-10-11 15:10:17.473365+00
2405	Die Again	die again | tess gerritsen	2014	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:02.863658+00	2026-10-11 15:10:17.473394+00
2406	Too Late	too late | colleen hoover	2016	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:03.264953+00	2026-10-11 15:10:17.473413+00
2407	Frankenstein	frankenstein | marry shelly	1818	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:03.865315+00	2026-10-11 15:10:17.473441+00
2408	The Elite	the elite | kiera cass	2013	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:03.962863+00	2026-10-11 15:10:17.473452+00
2409	The Selection	the selection | kiera cass	2012	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:03.974517+00	2026-10-11 15:10:17.473461+00
2410	Always and Forever, Lara Jean	always and forever, lara jean | jenny han	2017	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:04.055771+00	2026-10-11 15:10:17.473472+00
2411	The Sinner	the sinner | tess gerritsen	2003	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.078168+00	2026-10-11 15:10:17.473482+00
2412	The Silent Girl	the silent girl | tess gerritsen	2011	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.165322+00	2026-10-11 15:10:17.47349+00
2413	November 9	november 9 | colleen hoover	2015	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.369867+00	2026-10-11 15:10:17.47351+00
2414	Haunted	haunted | r. l. stine	1990	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.38323+00	2026-10-11 15:10:17.473519+00
2415	The Dead Lifeguard	the dead lifeguard | r. l. stine	1996	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.475846+00	2026-10-11 15:10:17.473528+00
2416	The Prom Queen	the prom queen | r. l. stine	1992	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.488842+00	2026-10-11 15:10:17.473537+00
2417	All-Night Party	all-night party | r. l. stine	1996	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.561337+00	2026-10-11 15:10:17.475299+00
2418	Sunburn	sunburn | r. l. stine	1992	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.57615+00	2026-10-11 15:10:17.475318+00
2419	The Face	the face | r. l. stine	1994	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.662035+00	2026-10-11 15:10:17.475328+00
2420	Locker 13	locker 13 | r. l. stine	2000	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.673956+00	2026-10-11 15:10:17.475337+00
2421	They Call Me Creature	they call me creature | r. l. stine	2001	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.760732+00	2026-10-11 15:10:17.475346+00
2422	The Fire Game	the fire game | r. l. stine	1991	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.774963+00	2026-10-11 15:10:17.475355+00
2423	Double Date	double date | r. l. stine	1993	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:04.975822+00	2026-10-11 15:10:17.475373+00
2424	The Wrong Number	the wrong number | r. l. stine	1990	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:05.067738+00	2026-10-11 15:10:17.475382+00
2425	Cat	cat | r. l. stine	1996	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:05.158861+00	2026-10-11 15:10:17.475391+00
2426	Don't Forget Me!	don't forget me! | r. l. stine	2000	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:05.272516+00	2026-10-11 15:10:17.475406+00
2427	My Name is Evil	my name is evil | r. l. stine	2000	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:05.284076+00	2026-10-11 15:10:17.475415+00
2428	The Surprise Party	the surprise party | r. l. stine	1989	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:05.36202+00	2026-10-11 15:10:17.475424+00
2429	The Hunting Party	the hunting party | lucy foley	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:05.8746+00	2026-10-11 15:10:17.475452+00
2430	Wilder Girls	wilder girls | rory power	2019	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:05.976216+00	2026-10-11 15:10:17.475466+00
2431	The Turn of the Key	the turn of the key | ruth ware	2019	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:06.061947+00	2026-10-11 15:10:17.475476+00
2432	Ready Player One	ready player one | ernest cline	2011	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:06.076373+00	2026-10-11 15:10:17.475486+00
2433	The Sun is Also a Star	the sun is also a star | nicola yoon	2016	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:06.162031+00	2026-10-11 15:10:17.475497+00
2434	3096 Days	3096 days | natascha kampusch	2010	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:06.475225+00	2026-10-11 15:10:17.475518+00
2435	An Anonymous Girl	an anonymous girl | greer hendricks; sarah pekkanen	2019	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:06.775817+00	2026-10-11 15:10:17.475533+00
2436	Hollow City	hollow city | ransom riggs	2014	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:07.167363+00	2026-10-11 15:10:17.47555+00
2437	Brain on Fire	brain on fire | susannah cahalan	2012	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:07.473024+00	2026-10-11 15:10:17.475569+00
2438	The Three-Body Problem	the three-body problem | liu cixin	2006	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:07.568534+00	2026-10-11 15:10:17.47558+00
2439	Fight Club	fight club | chuck palahniuk	1996	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:08.265656+00	2026-10-11 15:10:17.475609+00
2441	The Last Time I Lied	the last time i lied | riley sager	2018	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:09.179602+00	2026-10-11 15:10:17.475652+00
2442	The Chain	the chain | adrian mckinty	2019	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:09.466665+00	2026-10-11 15:10:17.475667+00
2443	Final Girls	final girls | riley sager	2017	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:09.960795+00	2026-10-11 15:10:17.475684+00
2444	The Chosen	the chosen | j.r. ward	2016	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.159708+00	2026-10-11 15:10:17.475696+00
2445	The Thief	the thief | j.r. ward	2017	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.17695+00	2026-10-11 15:10:17.475705+00
2446	The Declaration	the declaration | gemma malley	2007	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:10.574166+00	2026-10-11 15:10:17.475725+00
2447	Rapture	rapture | j.r. ward	2012	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.661722+00	2026-10-11 15:10:17.475733+00
2448	Immortal	immortal | j.r. ward	2013	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.676945+00	2026-10-11 15:10:17.475743+00
2449	Halloween Party	halloween party | r. l. stine	1990	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.855713+00	2026-10-11 15:10:17.475756+00
2450	The Sleepwalker	the sleepwalker | r. l. stine	1990	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.869311+00	2026-10-11 15:10:17.475765+00
2451	Bad Dreams	bad dreams | r. l. stine	1993	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.882123+00	2026-10-11 15:10:17.475774+00
2452	Lights Out	lights out | r. l. stine	1991	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:10.962674+00	2026-10-11 15:10:17.475784+00
2453	Bag of Bones	bag of bones | stephen king	1998	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:11.072689+00	2026-10-11 15:10:17.475797+00
2454	Gone Girl	gone girl | gillian flynn	2012	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:11.08408+00	2026-10-11 15:10:17.475806+00
2455	Into the Dark	into the dark | r. l. stine	1997	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:11.259803+00	2026-10-11 15:10:17.475818+00
2456	Marked	marked | p. c. cast	2007	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:11.292749+00	2026-10-11 15:10:17.475829+00
2457	Burned	burned | p. c. cast	2010	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:11.370591+00	2026-10-11 15:10:17.475838+00
2458	Lolita	lolita | vladimir nabokov	1955	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:11.463391+00	2026-10-11 15:10:17.475848+00
2459	Little Black Lies	little black lies | sharon bolton	2015	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:11.568205+00	2026-10-11 15:10:17.47586+00
2460	Sometimes I Lie	sometimes i lie | alice feeney	2017	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:11.975395+00	2026-10-11 15:10:17.475881+00
2461	You	you | caroline kepnes	2014	\N	\N	\N	\N	\N	\N	f	f	t	2026-10-11 15:10:12.274031+00	2026-10-11 15:10:17.475899+00
2463	Honey	honey | imani thompson	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.658431+00	2026-10-11 15:10:17.475923+00
2464	The Wax Child	the wax child | olga ravn	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.672886+00	2026-10-11 15:10:17.475932+00
2465	The Creeper	the creeper | a. m. shine	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.758871+00	2026-10-11 15:10:17.475941+00
2467	Part of Your World	part of your world | abby jimenez	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.770592+00	2026-10-11 15:10:17.475956+00
2470	The Ascent	the ascent | adam plantinga	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.798+00	2026-10-11 15:10:17.475982+00
2471	The Compound	the compound | aisling rawle	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.806973+00	2026-10-11 15:10:17.475993+00
2475	Truly, Madly, Deeply	truly, madly, deeply | alexandria bellefleur	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.842602+00	2026-10-11 15:10:17.476027+00
2476	Battle of the Bookstores	battle of the bookstores | ali brady	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.849477+00	2026-10-11 15:10:17.476037+00
2477	Bound	bound | ali hazelwood	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.860126+00	2026-10-11 15:10:17.476047+00
2478	Hot for Slayer	hot for slayer | ali hazelwood	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.864778+00	2026-10-11 15:10:17.476055+00
2481	Every Step She Takes	every step she takes | alison cochrun	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.883593+00	2026-10-11 15:10:17.476076+00
2482	The Charm Offensive	the charm offensive | alison cochrun	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.890246+00	2026-10-11 15:10:17.476085+00
2484	Shiver	shiver | allie reynolds	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.906311+00	2026-10-11 15:10:17.476104+00
2486	One of Us Knows	one of us knows | alyssa cole	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.91757+00	2026-10-11 15:10:17.476119+00
2487	You're Invited	you're invited | amanda jayatissa	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.926955+00	2026-10-11 15:10:17.476129+00
2488	Any Man	any man | amber tamblyn	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.936343+00	2026-10-11 15:10:17.476141+00
2489	Haven't Killed in Years	haven't killed in years | amy k. green	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.943446+00	2026-10-11 15:10:17.476151+00
2493	With Stars in Her Eyes	with stars in her eyes | andie burke	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.966626+00	2026-10-11 15:10:17.476178+00
2494	Fall for Him	fall for him | andie burke	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.973669+00	2026-10-11 15:10:17.476188+00
2495	The Spare Room	the spare room | andrea bartz	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:12.980478+00	2026-10-11 15:10:17.476198+00
2498	Just a Taste	just a taste | anise starre	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.005704+00	2026-10-11 15:10:17.476223+00
2499	Crash Landing	crash landing | annie mcquaid	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.013034+00	2026-10-11 15:10:17.476232+00
2500	Conform	conform | ariel sullivan	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.020432+00	2026-10-11 15:10:17.476243+00
2502	This Book Will Bury Me	this book will bury me | ashley winstead	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.032841+00	2026-10-11 15:10:17.476258+00
2505	Call the Coroner	call the coroner | avril ashton	2017	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.059294+00	2026-10-11 15:10:17.478339+00
2506	I, Medusa	i, medusa | ayana gray	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.067212+00	2026-10-11 15:10:17.478354+00
2513	Swept Away	swept away | beth o'leary	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.157373+00	2026-10-11 15:10:17.478404+00
2517	The Irresistible Urge to Fall for Your Enemy	the irresistible urge to fall for your enemy | brigitte knightley	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.192675+00	2026-10-11 15:10:17.478438+00
2528	Bad Tourists	bad tourists | caro carver	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.314096+00	2026-10-11 15:10:17.478518+00
2532	Every Time I Go On Vacation, Someone Dies	every time i go on vacation, someone dies | catherine mack	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.344556+00	2026-10-11 15:10:17.478549+00
2533	Run Time	run time | catherine ryan howard	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.354895+00	2026-10-11 15:10:17.478561+00
2534	Burn After Reading	burn after reading | catherine ryan howard	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.361728+00	2026-10-11 15:10:17.47857+00
2535	Look in the Mirror	look in the mirror | catherine steadman	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.366711+00	2026-10-11 15:10:17.478579+00
2538	Wild Dark Shore	wild dark shore | charlotte mcconaghy	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.38921+00	2026-10-11 15:10:17.478603+00
2541	The Hitchhikers	the hitchhikers | chevy stevens	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.411192+00	2026-10-11 15:10:17.478628+00
2542	The Darkest Deep	the darkest deep | chris butera	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.418051+00	2026-10-11 15:10:17.478638+00
2543	The Place Where They Buried Your Heart	the place where they buried your heart | christina henry	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.427432+00	2026-10-11 15:10:17.478649+00
2546	Lucky Day	lucky day | chuck tingle	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.44666+00	2026-10-11 15:10:17.478669+00
2547	The Romantic Agenda	the romantic agenda | claire kann	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.45596+00	2026-10-11 15:10:17.47868+00
2548	The Marriage Narrative	the marriage narrative | claire kann	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.460508+00	2026-10-11 15:10:17.478689+00
2555	The Sweetest Oblivion	the sweetest oblivion | danielle lori	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.507556+00	2026-10-11 15:10:17.478738+00
2556	The Dead Husband Cookbook	the dead husband cookbook | danielle valentine	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.514165+00	2026-10-11 15:10:17.478748+00
2557	Night Watcher	night watcher | daphne woolsoncroft	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.521029+00	2026-10-11 15:10:17.478759+00
2558	Where He Can't Find You	where he can't find you | darcy coates	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.527862+00	2026-10-11 15:10:17.478768+00
2559	Parasite	parasite | darcy coates	2016	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.534363+00	2026-10-11 15:10:17.478778+00
2560	How Bad Things Can Get	how bad things can get | darcy coates	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.539136+00	2026-10-11 15:10:17.478786+00
2568	It Will Only Hurt For a Moment	it will only hurt for a moment | delilah s. dawson	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.588729+00	2026-10-11 15:10:17.478838+00
2569	House of Idyll	house of idyll | delilah s. dawson	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.593356+00	2026-10-11 15:10:17.478848+00
2574	Wild Love	wild love | elsie silver	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.631053+00	2026-10-11 15:10:17.478889+00
2578	This Girl's a Killer	this girl's a killer | emma c. wells	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.661566+00	2026-10-11 15:10:17.47892+00
2587	Famous Last Words	famous last words | gillian mcallister	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.72215+00	2026-10-11 15:10:17.478985+00
2590	BadAsstronauts	badasstronauts | grady hendrix	2012	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.739871+00	2026-10-11 15:10:17.479006+00
2592	The Haunting of Velkwood	the haunting of velkwood | gwendolyn kiste	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.750729+00	2026-10-11 15:10:17.479021+00
2593	Haunting Adeline	haunting adeline | h.d. carlton	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.757361+00	2026-10-11 15:10:17.479031+00
2594	The Snowball Effect	the snowball effect | haley cass	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.76239+00	2026-10-11 15:10:17.479039+00
2600	Leech	leech | hiron ennes	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.81406+00	2026-10-11 15:10:17.481358+00
2603	Behind a Closed Door	behind a closed door | j.d. barker	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.840106+00	2026-10-11 15:10:17.481395+00
2607	The Will of the Many	the will of the many | james islington	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.866392+00	2026-10-11 15:10:17.481428+00
2609	What Kind of Paradise	what kind of paradise | janelle brown	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.877252+00	2026-10-11 15:10:17.481444+00
2613	Haunted Ever After	haunted ever after | jen deluca	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:13.908554+00	2026-10-11 15:10:17.48148+00
2626	Give Me Butterflies	give me butterflies | jillian meadows	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.015211+00	2026-10-11 15:10:17.481572+00
2627	An Academic Affair	an academic affair | jodi mcalister	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.023099+00	2026-10-11 15:10:17.481583+00
2629	The Stranger in Her House	the stranger in her house | john marrs	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.045523+00	2026-10-11 15:10:17.481599+00
2630	The Family Experiment	the family experiment | john marrs	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.052663+00	2026-10-11 15:10:17.481609+00
2631	The Marriage Act	the marriage act | john marrs	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.061089+00	2026-10-11 15:10:17.48162+00
2634	Heads Will Roll	heads will roll | josh winning	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.081116+00	2026-10-11 15:10:17.481643+00
2635	It's Different This Time	it's different this time | joss richard	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.08796+00	2026-10-11 15:10:17.481653+00
2639	Running Wild	running wild | k. a. tucker	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.119088+00	2026-10-11 15:10:17.481686+00
2640	Dead Space	dead space | kali wallace	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.12799+00	2026-10-11 15:10:17.481697+00
2641	Penance	penance | kanae minato	2009	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.132836+00	2026-10-11 15:10:17.481706+00
2643	Grave Matter	grave matter | karina halle	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.15088+00	2026-10-11 15:10:17.481725+00
2645	In Good Company	in good company | kat singleton	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.166604+00	2026-10-11 15:10:17.481742+00
2646	A Killing Cold	a killing cold | kate alice marshall	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.173326+00	2026-10-11 15:10:17.481752+00
2655	Kin	kin | kealan patrick burke	2011	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.249028+00	2026-10-11 15:10:17.481826+00
2657	All That We See or Seem	all that we see or seem | ken liu	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.263002+00	2026-10-11 15:10:17.481845+00
2661	The Nature of Disappearing	the nature of disappearing | kimi cunningham grant	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.291049+00	2026-10-11 15:10:17.481876+00
2662	Battle Royale	battle royale | koushun takami	1999	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.297879+00	2026-10-11 15:10:17.481886+00
2664	How To Solve Your Own Murder	how to solve your own murder | kristen perrin	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.311511+00	2026-10-11 15:10:17.481904+00
2665	The Neighbor Favor	the neighbor favor | kristina forest	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.320463+00	2026-10-11 15:10:17.481916+00
2666	The Partner Plot	the partner plot | kristina forest	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.325002+00	2026-10-11 15:10:17.481925+00
2667	Because You're Mine	because you're mine | kristopher triana	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.329571+00	2026-10-11 15:10:17.481934+00
2668	The Game Changer	the game changer | lana ferguson	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.334526+00	2026-10-11 15:10:17.481943+00
2669	The Mating Game	the mating game | lana ferguson	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.343365+00	2026-10-11 15:10:17.481954+00
2670	When the Reckoning Comes	when the reckoning comes | latanya mcqueen	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.349584+00	2026-10-11 15:10:17.481964+00
2672	One-Star Romance	one-star romance | laura hankin	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.36456+00	2026-10-11 15:10:17.481982+00
2673	The Day of the Door	the day of the door | laurel hightower	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.368854+00	2026-10-11 15:10:17.48199+00
2674	The Last Room on the Left	the last room on the left | leah konen	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.377302+00	2026-10-11 15:10:17.482001+00
2675	Guestbook	guestbook | leanne shapton	2019	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.386026+00	2026-10-11 15:10:17.482013+00
2676	One Yellow Eye	one yellow eye | leigh radford	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.392836+00	2026-10-11 15:10:17.482023+00
2677	If You're Seeing This, It's Meant For You	if you're seeing this, it's meant for you | leigh stein	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.405825+00	2026-10-11 15:10:17.482036+00
2678	Under the Same Stars	under the same stars | libba bray	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.412538+00	2026-10-11 15:10:17.482046+00
2679	Three Swedish Mountain Men	three swedish mountain men | lily gold	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.422425+00	2026-10-11 15:10:17.482057+00
2680	Vampires at Sea	vampires at sea | lindsay merbaum	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.4291+00	2026-10-11 15:10:17.482066+00
2681	Christmas Fling	christmas fling | lindsey kelk	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.436191+00	2026-10-11 15:10:17.482076+00
2682	Adrift	adrift | lisa brideau	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.442451+00	2026-10-11 15:10:17.483307+00
2683	Watching You	watching you | lisa jewell	2018	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.450824+00	2026-10-11 15:10:17.483325+00
2684	Invisible Girl	invisible girl | lisa jewell	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.455757+00	2026-10-11 15:10:17.483335+00
2685	First Light	first light | liz kerin	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.460559+00	2026-10-11 15:10:17.483343+00
2686	The God of the Woods	the god of the woods | liz moore	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.468011+00	2026-10-11 15:10:17.483354+00
2687	Saving Noah	saving noah | lucinda berry	2017	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.477467+00	2026-10-11 15:10:17.483365+00
2688	The Surf House	the surf house | lucy clarke	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.484356+00	2026-10-11 15:10:17.483375+00
2689	The Midnight Feast	the midnight feast | lucy foley	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.49067+00	2026-10-11 15:10:17.483386+00
2690	Thirsty	thirsty | lucy lehane	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.497684+00	2026-10-11 15:10:17.483396+00
2691	Story of My Life	story of my life | lucy score	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.504646+00	2026-10-11 15:10:17.483407+00
2692	Love in Focus	love in focus | lyla lee	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.511407+00	2026-10-11 15:10:17.483417+00
2693	A Very Merry Bromance	a very merry bromance | lyssa kay adams	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.517971+00	2026-10-11 15:10:17.483427+00
2694	Glass Houses	glass houses | madeline ashby	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.526781+00	2026-10-11 15:10:17.483438+00
2695	Breaking Point	breaking point | mads rafferty	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.533177+00	2026-10-11 15:10:17.483449+00
2696	Dust Storm	dust storm | maggie c. gates	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.539646+00	2026-10-11 15:10:17.483459+00
2697	The Ripple Effect	the ripple effect | maggie north	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.546769+00	2026-10-11 15:10:17.483468+00
2698	Blob	blob | maggie su	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.553687+00	2026-10-11 15:10:17.483478+00
2699	The Summer I Ate the Rich	the summer i ate the rich | maika moulite; maritza moulite	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.565034+00	2026-10-11 15:10:17.48349+00
2701	Red City	red city | marie lu	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.576195+00	2026-10-11 15:10:17.483505+00
2704	The World Gives Way	the world gives way | marissa levien	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.6015+00	2026-10-11 15:10:17.483531+00
2708	William	william | mason coile	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.6299+00	2026-10-11 15:10:17.48356+00
2709	The Build-a-Boyfriend Project	the build-a-boyfriend project | mason deaver	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.636852+00	2026-10-11 15:10:17.48357+00
2712	Grace & Henry's Holiday Movie Marathon	grace & henry's holiday movie marathon | matthew norman	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.666229+00	2026-10-11 15:10:17.483596+00
2715	Well, Actually	well, actually | mazey eddings	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.683992+00	2026-10-11 15:10:17.483621+00
2716	The Mad Wife	the mad wife | meagan church	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.69135+00	2026-10-11 15:10:17.483632+00
2725	Mary	mary | nat cassidy	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.763774+00	2026-10-11 15:10:17.483713+00
2730	The Poppy Fields	the poppy fields | nikki erlick	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.802428+00	2026-10-11 15:10:17.483759+00
2731	The Measure	the measure | nikki erlick	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.809129+00	2026-10-11 15:10:17.48377+00
2732	Such Quiet Girls	such quiet girls | noelle w. ihli	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.81616+00	2026-10-11 15:10:17.483781+00
2736	Sea of Ruin	sea of ruin | pam godwin	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.846918+00	2026-10-11 15:10:17.483849+00
2740	25 Days	25 days | per jacobsen	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.875156+00	2026-10-11 15:10:17.483886+00
2741	Unsteady	unsteady | peyton corinne	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.881637+00	2026-10-11 15:10:17.483898+00
2742	The Autumn Springs Retirement Home Massacre	the autumn springs retirement home massacre | philip fracassi	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.890907+00	2026-10-11 15:10:17.483909+00
2746	Fallen Gods	fallen gods | rachel van dyken	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.960496+00	2026-10-11 15:10:17.483958+00
2747	How I'll Kill You	how i'll kill you | ren destefano	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.967462+00	2026-10-11 15:10:17.483969+00
2748	The Impossible Fortune	the impossible fortune | richard osman	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.974999+00	2026-10-11 15:10:17.48398+00
2749	The Romance Recipe	the romance recipe | ruby barrett	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:14.990907+00	2026-10-11 15:10:17.483996+00
2754	Cold Eternity	cold eternity | s. a. barnes	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.020841+00	2026-10-11 15:10:17.484035+00
2755	Ghost Station	ghost station | s. a. barnes	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.027777+00	2026-10-11 15:10:17.484047+00
2757	Darling Girls	darling girls | sally hepworth	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.039605+00	2026-10-11 15:10:17.484064+00
2758	The Good Sister	the good sister | sally hepworth	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.046494+00	2026-10-11 15:10:17.484075+00
2759	Mad Mabel	mad mabel | sally hepworth	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.050804+00	2026-10-11 15:10:17.484085+00
2764	The Island	the island | sarah goodwin	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.086315+00	2026-10-11 15:10:17.484128+00
2765	Twice Shy	twice shy | sarah hogle	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.092985+00	2026-10-11 15:10:17.48414+00
2770	Serial Killer Support Group	serial killer support group | saratoga schaefer	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.118453+00	2026-10-11 15:10:17.484176+00
2771	Blood Sugar	blood sugar | sascha rothchild	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.127347+00	2026-10-11 15:10:17.484188+00
2779	The Hitchcock Hotel	the hitchcock hotel | stephanie wrobel	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.189175+00	2026-10-11 15:10:17.484254+00
2781	The Venue	the venue | t.j. payne	2020	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.208928+00	2026-10-11 15:10:17.484298+00
2782	Intercepts	intercepts | t.j. payne	2019	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.218427+00	2026-10-11 15:10:17.48431+00
2784	An Evil Premise	an evil premise | t. marie vandelly	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.234108+00	2026-10-11 15:10:17.484329+00
2795	Any Trope But You	any trope but you | victoria lavine	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.342473+00	2026-10-11 15:10:17.484421+00
2799	The Deep Sky	the deep sky | yume kitasei	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.373499+00	2026-10-11 15:10:17.484454+00
2800	Saltcrop	saltcrop | yume kitasei	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.38076+00	2026-10-11 15:10:17.484465+00
2801	Two Can Play	two can play | ali hazelwood	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.394768+00	2026-10-11 15:10:17.484478+00
2802	Playing for Keeps	playing for keeps | alexandria bellefleur	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.402308+00	2026-10-11 15:10:17.484487+00
2803	The Ritual	the ritual | shantel tessier	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.41472+00	2026-10-11 15:10:17.484505+00
2804	I Want You More	i want you more | swan huntley	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.426665+00	2026-10-11 15:10:17.484517+00
2805	Dolls & Daggers	dolls & daggers | d.l. darby	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.435498+00	2026-10-11 15:10:17.484528+00
2806	Shy Girl	shy girl | mia ballard	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.444091+00	2026-10-11 15:10:17.484539+00
2807	Broken Bonds	broken bonds | j. bree	2021	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.456557+00	2026-10-11 15:10:17.48455+00
2808	The Raven Scholar	the raven scholar | antonia hodgson	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.467336+00	2026-10-11 15:10:17.484562+00
2810	To Cage a Wild Bird	to cage a wild bird | brooke fast	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.481596+00	2026-10-11 15:10:17.484579+00
2812	The Serpent and the Wings of Night	the serpent and the wings of night | carissa broadbent	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.496387+00	2026-10-11 15:10:17.484612+00
2813	A Killer Kind of Romance	a killer kind of romance | letizia lorini	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.50336+00	2026-10-11 15:10:17.484625+00
2814	Detour	detour | jeff rake; rob hart	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.514997+00	2026-10-11 15:10:17.484637+00
2815	The Alpine Retreat	the alpine retreat | sarah goodwin	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.519593+00	2026-10-11 15:10:17.484647+00
2821	Meet the Newmans	meet the newmans | jennifer niven	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.558875+00	2026-10-11 15:10:17.48469+00
2823	A Box Full of Darkness	a box full of darkness | simone st. james	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.568661+00	2026-10-11 15:10:17.484706+00
2824	Just Watch Me	just watch me | lior torenberg	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.575937+00	2026-10-11 15:10:17.484717+00
2825	Dead in the Water	dead in the water | john marrs	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.580731+00	2026-10-11 15:10:17.484727+00
2826	The Future Saints	the future saints | ashley winstead	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.585401+00	2026-10-11 15:10:17.484737+00
2828	It's Not Her	it's not her | mary kubica	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.597089+00	2026-10-11 15:10:17.484755+00
2829	Greedy	greedy | callie kazumi	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.604048+00	2026-10-11 15:10:17.484766+00
2830	How to Kill a Guy in Ten Dates	how to kill a guy in ten dates | shailee thompson	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.610956+00	2026-10-11 15:10:17.484777+00
2831	How to Steal a Galaxy	how to steal a galaxy | beth revis	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.615833+00	2026-10-11 15:10:17.484788+00
2832	Last Chance to Save the World	last chance to save the world | beth revis	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.62041+00	2026-10-11 15:10:17.484797+00
2834	Operation Bounce House	operation bounce house | matt dinniman	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.632994+00	2026-10-11 15:10:17.484814+00
2836	For Human Use	for human use | sarah g. pierce	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.663654+00	2026-10-11 15:10:17.484832+00
2838	Game, Set, Match	game, set, match | jennifer iacopelli	2013	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.675829+00	2026-10-11 15:10:17.484848+00
2840	When I Kill You	when i kill you | b. a. paris	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.690028+00	2026-10-11 15:10:17.484867+00
2841	Crown of War and Shadow	crown of war and shadow | j.r. ward	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.69483+00	2026-10-11 15:10:17.484877+00
2846	Valentine's Slay	valentine's slay | navessa allen	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.722666+00	2026-10-11 15:10:17.484943+00
2849	The Girls Before	the girls before | kate alice marshall	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.73911+00	2026-10-11 15:10:17.484967+00
2850	Married to a Pirate	married to a pirate | athena rose	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.765979+00	2026-10-11 15:10:17.484978+00
2851	Evil Genius	evil genius | claire oshetsky	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.773424+00	2026-10-11 15:10:17.484988+00
2852	After the Fall	after the fall | edward ashton	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.777906+00	2026-10-11 15:10:17.484998+00
2853	Strange Buildings	strange buildings | uketsu	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.783424+00	2026-10-11 15:10:17.485007+00
2855	No Matter What	no matter what | cara bastone	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.804231+00	2026-10-11 15:10:17.485025+00
2857	In Her Own League	in her own league | liz tomforde	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.81791+00	2026-10-11 15:10:17.485044+00
2858	The Book Tour	the book tour | emily ohanjanians	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.825894+00	2026-10-11 15:10:17.485054+00
2861	Toe to Toe	toe to toe | falon ballard	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.850921+00	2026-10-11 15:10:17.485078+00
2862	This Story Might Save Your Life	this story might save your life | tiffany crum	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.867253+00	2026-10-11 15:10:17.485089+00
2863	The Starter Ex	the starter ex | mia sosa	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.878212+00	2026-10-11 15:10:17.485101+00
2864	The Truth About Ruby Cooper	the truth about ruby cooper | liz nugent	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.883689+00	2026-10-11 15:10:17.48511+00
2866	Blood & Roses Volume 1	blood & roses volume 1 | callie hart	2014	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.894114+00	2026-10-11 15:10:17.485126+00
2875	A Tongue So Sweet and Deadly	a tongue so sweet and deadly | sophia st. germain	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.957877+00	2026-10-11 15:10:17.485192+00
2879	Nothing Tastes As Good	nothing tastes as good | luke dumas	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:15.979279+00	2026-10-11 15:10:17.485222+00
2883	Love Is An Algorithm	love is an algorithm | laura brooke robson	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.007544+00	2026-10-11 15:10:17.485256+00
2887	Bodies of Work	bodies of work | clay mcleod chapman	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.039449+00	2026-10-11 15:10:17.48531+00
2888	Happy Ending	happy ending | chloe liese	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.043734+00	2026-10-11 15:10:17.48532+00
2890	Cherry Baby	cherry baby | rainbow rowell	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.057221+00	2026-10-11 15:10:17.485338+00
2892	Japanese Gothic	japanese gothic | kylie lee baker	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.068426+00	2026-10-11 15:10:17.485357+00
2894	The Dinner Party	the dinner party | freida mcfadden	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.081872+00	2026-10-11 15:10:17.485377+00
2896	Her First Lie	her first lie | lucinda berry	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.093135+00	2026-10-11 15:10:17.485394+00
2898	The Many	the many | sylvain neuvel	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.104359+00	2026-10-11 15:10:17.485411+00
2900	Love Galaxy	love galaxy | sierra branham	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.118059+00	2026-10-11 15:10:17.485429+00
2901	Molka	molka | monika kim	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.122957+00	2026-10-11 15:10:17.485439+00
2902	Blood Bound	blood bound | ellis hunter	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.129747+00	2026-10-11 15:10:17.485449+00
2904	The Library After Dark	the library after dark | ande pliego	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.146789+00	2026-10-11 15:10:17.485471+00
2905	Death's Daughter	death's daughter | s. a. barnes	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.152185+00	2026-10-11 15:10:17.485482+00
2907	Rules for the Summer	rules for the summer | meghan quinn	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.165321+00	2026-10-11 15:10:17.4855+00
2908	Cactus Heart	cactus heart | clio evans	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.171979+00	2026-10-11 15:10:17.485512+00
2913	Fever Dream	fever dream | elsie silver	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.203133+00	2026-10-11 15:10:17.485554+00
2914	Maneater	maneater | ellie graves	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.209589+00	2026-10-11 15:10:17.485567+00
2915	The Last Book Club	the last book club | joanne rock	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.219455+00	2026-10-11 15:10:17.48558+00
2916	Dead Weight	dead weight | hildur knutsdottir	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.224872+00	2026-10-11 15:10:17.485591+00
2918	The Boyfriend Goal	the boyfriend goal | lauren blakely	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.238623+00	2026-10-11 15:10:17.48561+00
2924	A Fortune of Sand	a fortune of sand | ruta sepetys	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.266228+00	2026-10-11 15:10:17.48565+00
2932	Crown Me Dead	crown me dead | liv zander	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.309792+00	2026-10-11 15:10:17.485709+00
2935	Prince of Hate	prince of hate | michelle thate	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.328025+00	2026-10-11 15:10:17.485736+00
2938	Sublimation	sublimation | isabel j. kim	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.353663+00	2026-10-11 15:10:17.485763+00
2939	Backstabbers	backstabbers | eliza jabore	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.360449+00	2026-10-11 15:10:17.485775+00
2940	Man of My Dreams	man of my dreams | olivia worley	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.36721+00	2026-10-11 15:10:17.485786+00
2941	Not Good Neighbors	not good neighbors | violet lumani	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.375992+00	2026-10-11 15:10:17.485799+00
2944	You First	you first | caroline kepnes	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.393898+00	2026-10-11 15:10:17.485824+00
2945	A Broken Promise	a broken promise | tetyana walker	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.403007+00	2026-10-11 15:10:17.485837+00
2946	A Simple Truth	a simple truth | tetyana walker	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.407434+00	2026-10-11 15:10:17.485847+00
2947	A Rising Hope	a rising hope | tetyana walker	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.41208+00	2026-10-11 15:10:17.485857+00
2948	A Deal With the Reaper	a deal with the reaper | madison lawson	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.418783+00	2026-10-11 15:10:17.485868+00
2949	A Sanctuary for Sin	a sanctuary for sin | madison lawson	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.423516+00	2026-10-11 15:10:17.485879+00
2950	The Summer Girlfriend	the summer girlfriend | kristina forest	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.428684+00	2026-10-11 15:10:17.485888+00
2951	This Kingdom Will Not Kill Me	this kingdom will not kill me | illona andrews	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.435726+00	2026-10-11 15:10:17.485899+00
2952	The Last Contract of Isako	the last contract of isako | fonda lee	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.442679+00	2026-10-11 15:10:17.485911+00
2953	North Country	north country | k. a. tucker	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.447314+00	2026-10-11 15:10:17.48592+00
2954	The Great Outdoors	the great outdoors | kayla olson	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.451766+00	2026-10-11 15:10:17.48593+00
2955	Dhampira	dhampira | amy pennza	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.4585+00	2026-10-11 15:10:17.485941+00
2956	Slasher Summer	slasher summer | e.l. chen	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.465165+00	2026-10-11 15:10:17.485953+00
2957	Nine Lives	nine lives | catherine steadman	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.469742+00	2026-10-11 15:10:17.485962+00
2958	Chase Me If You Can	chase me if you can | heather frances	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.476907+00	2026-10-11 15:10:17.485973+00
2959	It Could Have Been Her	it could have been her | lisa jewell	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.481519+00	2026-10-11 15:10:17.485983+00
2960	Crash	crash | kathy lockheart	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.488376+00	2026-10-11 15:10:17.485994+00
2961	Dead But Dreaming of Electric Sheep	dead but dreaming of electric sheep | paul tremblay	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.493301+00	2026-10-11 15:10:17.486004+00
2962	By Blade, I Protect	by blade, i protect | penelope sky	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.499937+00	2026-10-11 15:10:17.486015+00
2963	Ink Bleed	ink bleed | trinity lynn	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.506972+00	2026-10-11 15:10:17.486026+00
2964	Helpless	helpless | jessica knoll	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.511825+00	2026-10-11 15:10:17.486036+00
2965	Fabulous Bodies	fabulous bodies | chuck tingle	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.516788+00	2026-10-11 15:10:17.486046+00
2966	Ungodly Rich	ungodly rich | katharine mcgee	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.523977+00	2026-10-11 15:10:17.486056+00
2967	The Season of Sinking	the season of sinking | daphne woolsoncroft	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.528833+00	2026-10-11 15:10:17.486066+00
2969	Web of Vows and Vengeance	web of vows and vengeance | aria ashbrook	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.542992+00	2026-10-11 15:10:17.486084+00
2970	Given	given | elayna r. gallea	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.550416+00	2026-10-11 15:10:17.486094+00
2971	Hunted	hunted | elayna r. gallea	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.555068+00	2026-10-11 15:10:17.486104+00
2972	Die For Me	die for me | shirlene obuobi	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.562182+00	2026-10-11 15:10:17.486115+00
2973	Cross My Heart, I Hope You Die	cross my heart, i hope you die | mallory arnold	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.566796+00	2026-10-11 15:10:17.486125+00
2974	In Stormy Weather	in stormy weather | chelsea curto	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.573841+00	2026-10-11 15:10:17.486137+00
2975	The Last to Drown	the last to drown | noelle w. ihli	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.583142+00	2026-10-11 15:10:17.48615+00
2976	Yes, Chef	yes, chef | grace reilly	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.589748+00	2026-10-11 15:10:17.486161+00
2977	In Your Court	in your court | kit haley	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.597025+00	2026-10-11 15:10:17.486173+00
2978	Buyer Beware	buyer beware | catherine ryan howard	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.601668+00	2026-10-11 15:10:17.486183+00
2979	Plant Lady	plant lady | minyoung kang	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.610621+00	2026-10-11 15:10:17.486195+00
2980	Pink Ink	pink ink | avina st. graves	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.615595+00	2026-10-11 15:10:17.486205+00
2981	Lost and Found	lost and found | tarah dewitt	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.620255+00	2026-10-11 15:10:17.486214+00
2983	Let's Kiss and Tell	let's kiss and tell | joss richard	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.633994+00	2026-10-11 15:10:17.486235+00
2984	The Matchmaker's Cottage	the matchmaker's cottage | kat sloane	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.640798+00	2026-10-11 15:10:17.486247+00
2985	Devil Inside	devil inside | clay mcleod chapman	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.645224+00	2026-10-11 15:10:17.486257+00
2988	If Books Could Kill	if books could kill | kate eberle	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.663819+00	2026-10-11 15:10:17.486304+00
2989	The Death Row Club	the death row club | v. a. vazquez	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.670392+00	2026-10-11 15:10:17.486317+00
2990	Starside	starside | alex aster	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.675661+00	2026-10-11 15:10:17.486328+00
2991	The Secret Dinner	the secret dinner | raphael montes	2016	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.684125+00	2026-10-11 15:10:17.486341+00
2992	Scion	scion | james islington	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.688592+00	2026-10-11 15:10:17.48635+00
2994	Hunting Adeline	hunting adeline | h. g. carlton	2022	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.715505+00	2026-10-11 15:10:17.48638+00
2995	Blood & Steel	blood & steel | helen scheuerer	2023	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.722337+00	2026-10-11 15:10:17.486392+00
2996	Whidbey	whidbey | t kira madden	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.751596+00	2026-10-11 15:10:17.486424+00
2997	Him	him | elle kennedy; sarina bowen	2015	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.800126+00	2026-10-11 15:10:17.486454+00
2998	Bad Boy Era	bad boy era | amy daws	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.818127+00	2026-10-11 15:10:17.486465+00
2999	Beneath	beneath | ariel sullivan	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.863495+00	2026-10-11 15:10:17.486505+00
3001	King of Gluttony	king of gluttony | ana huang	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.914532+00	2026-10-11 15:10:17.486555+00
3002	King of Envy	king of envy | ana huang	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.924093+00	2026-10-11 15:10:17.486567+00
3003	King of Sloth	king of sloth | ana huang	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.928827+00	2026-10-11 15:10:17.486577+00
3004	The One Day You Were My Husband	the one day you were my husband | rosie walsh	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.942123+00	2026-10-11 15:10:17.486591+00
3005	My Blade, Your Back	my blade, your back | k.m. moronova	2025	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.952179+00	2026-10-11 15:10:17.486605+00
3006	The Reality Of It All	the reality of it all | allison speka	2024	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.964169+00	2026-10-11 15:10:17.486621+00
3007	The House That Eats the Dead	the house that eats the dead | max doty	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.984397+00	2026-10-11 15:10:17.486643+00
3008	One of the Family	one of the family | mark edwards	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:16.994009+00	2026-10-11 15:10:17.486656+00
3009	Heart of Glass	heart of glass | jennifer hillier	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.001029+00	2026-10-11 15:10:17.486668+00
3010	They Say a Girl Died Here	they say a girl died here | sarah pinborough	2016	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.005852+00	2026-10-11 15:10:17.486678+00
3013	Love Felt Like This	love felt like this | julie olivia	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.031905+00	2026-10-11 15:10:17.48671+00
3014	Doomsdate	doomsdate | laura piper lee	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.039132+00	2026-10-11 15:10:17.486722+00
3017	Love Antidote	love antidote | brynne weaver	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.161005+00	2026-10-11 15:10:17.486774+00
3018	Solace House	solace house | will maclean	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.172462+00	2026-10-11 15:10:17.486789+00
3019	Threshing Day	threshing day | rebecca yarros	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.179174+00	2026-10-11 15:10:17.486802+00
3020	Newbourne Park	newbourne park | jennifer thorne	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.184821+00	2026-10-11 15:10:17.486812+00
3021	XO Karma	xo karma | hailey dickert	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.19159+00	2026-10-11 15:10:17.486824+00
3022	The Code of You	the code of you | sabrina hoffmann	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.198336+00	2026-10-11 15:10:17.486836+00
3023	Bad Words	bad words | rioghnach robinson	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.204824+00	2026-10-11 15:10:17.486847+00
3024	The Witch	the witch | freida mcfadden	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.209134+00	2026-10-11 15:10:17.486857+00
3025	Driven	driven | mason coile	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.213763+00	2026-10-11 15:10:17.486866+00
3026	Dive Bar at the End of the Road	dive bar at the end of the road | kelley armstrong	2026	\N	\N	\N	\N	\N	\N	f	f	f	2026-10-11 15:10:17.228717+00	2026-10-11 15:10:17.486882+00
\.


--
-- Data for Name: book_author; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.book_author (book_id, "position", author_id) FROM stdin;
772	0	453
773	0	454
774	0	455
775	0	456
775	1	457
776	0	458
777	0	459
778	0	460
779	0	461
780	0	462
781	0	463
782	0	464
783	0	465
784	0	466
785	0	467
786	0	468
787	0	469
788	0	470
789	0	471
790	0	469
791	0	472
792	0	473
793	0	474
794	0	475
795	0	476
796	0	477
796	1	478
797	0	479
798	0	480
799	0	481
800	0	482
801	0	483
802	0	484
803	0	485
804	0	486
804	1	487
805	0	488
806	0	458
807	0	489
808	0	490
809	0	479
810	0	491
811	0	492
812	0	486
812	1	487
813	0	493
814	0	494
815	0	495
816	0	472
817	0	496
818	0	497
819	0	498
820	0	499
821	0	500
822	0	501
823	0	502
824	0	477
825	0	503
826	0	504
827	0	505
828	0	506
829	0	507
830	0	508
831	0	509
832	0	510
833	0	511
834	0	512
835	0	476
836	0	513
837	0	514
838	0	492
839	0	515
840	0	516
841	0	517
842	0	501
843	0	456
843	1	457
844	0	518
845	0	462
846	0	519
847	0	520
848	0	511
849	0	521
850	0	522
851	0	511
852	0	523
853	0	507
854	0	524
855	0	525
856	0	526
857	0	527
858	0	476
859	0	528
860	0	507
861	0	473
862	0	529
863	0	530
864	0	531
865	0	469
866	0	532
867	0	489
868	0	533
869	0	534
870	0	535
871	0	503
872	0	507
873	0	536
874	0	469
875	0	455
876	0	537
877	0	538
878	0	539
879	0	540
880	0	541
881	0	542
882	0	543
883	0	544
884	0	466
885	0	545
886	0	546
887	0	453
888	0	547
889	0	542
890	0	455
891	0	548
892	0	528
893	0	549
894	0	503
895	0	524
896	0	542
897	0	525
898	0	503
899	0	467
900	0	550
901	0	551
902	0	552
903	0	553
904	0	476
905	0	503
906	0	511
907	0	554
908	0	503
909	0	555
910	0	556
911	0	538
912	0	557
913	0	558
914	0	484
915	0	472
916	0	559
917	0	560
918	0	561
919	0	533
920	0	562
921	0	563
922	0	564
923	0	565
924	0	566
925	0	544
926	0	567
927	0	568
928	0	462
929	0	563
930	0	569
931	0	570
932	0	552
933	0	571
934	0	572
935	0	573
936	0	574
937	0	476
938	0	575
939	0	576
940	0	577
941	0	534
942	0	506
943	0	463
944	0	508
945	0	578
946	0	503
947	0	537
948	0	509
949	0	503
950	0	506
951	0	503
952	0	579
953	0	580
954	0	537
955	0	581
956	0	582
957	0	583
958	0	539
959	0	584
960	0	585
961	0	503
962	0	586
963	0	503
964	0	587
965	0	588
966	0	479
967	0	589
968	0	590
969	0	591
970	0	592
971	0	524
972	0	593
973	0	594
974	0	552
975	0	595
976	0	589
977	0	476
978	0	596
979	0	597
980	0	598
981	0	599
982	0	588
983	0	600
984	0	601
985	0	602
986	0	603
987	0	604
988	0	605
989	0	606
990	0	607
991	0	608
992	0	609
993	0	610
994	0	611
995	0	612
996	0	613
997	0	614
998	0	615
999	0	616
1000	0	503
1001	0	617
1002	0	618
1003	0	619
1004	0	620
1005	0	621
1006	0	622
1007	0	623
1008	0	539
1009	0	589
1010	0	624
1011	0	588
1012	0	625
1013	0	626
1014	0	548
1015	0	627
1016	0	628
1017	0	629
1018	0	623
1019	0	623
1020	0	630
1021	0	455
1022	0	623
1023	0	613
1024	0	454
1025	0	543
1026	0	613
1027	0	631
1028	0	632
1029	0	560
1030	0	589
1031	0	613
1032	0	633
1033	0	634
1034	0	635
1035	0	622
1036	0	636
1037	0	502
1038	0	637
1039	0	638
1040	0	639
1041	0	640
1042	0	614
1043	0	641
1044	0	552
1045	0	642
1046	0	592
1047	0	506
1048	0	643
1049	0	617
1050	0	644
1051	0	645
1052	0	646
1053	0	647
1054	0	616
1055	0	589
1056	0	648
1057	0	534
1058	0	649
1059	0	650
1060	0	651
1061	0	581
1062	0	652
1063	0	653
1064	0	593
1065	0	476
1066	0	654
1067	0	655
1068	0	656
1069	0	506
1070	0	508
1071	0	657
1072	0	622
1073	0	658
1074	0	659
1075	0	660
1076	0	661
1077	0	662
1078	0	591
1079	0	663
1080	0	535
1081	0	664
1082	0	665
1083	0	666
1084	0	664
1085	0	667
1086	0	454
1087	0	659
1088	0	458
1089	0	664
1090	0	668
1091	0	588
1092	0	669
1093	0	521
1094	0	543
1095	0	587
1096	0	601
1097	0	670
1098	0	621
1099	0	671
1100	0	576
1101	0	672
1102	0	619
1103	0	673
1104	0	591
1105	0	674
1106	0	454
1107	0	644
1108	0	675
1109	0	676
1110	0	508
1111	0	677
1112	0	678
1113	0	679
1114	0	476
1115	0	622
1116	0	680
1117	0	614
1118	0	681
1118	1	682
1119	0	683
1120	0	656
1121	0	684
1122	0	532
1123	0	622
1124	0	685
1125	0	613
1126	0	476
1127	0	507
1128	0	610
1129	0	686
1130	0	687
1131	0	610
1132	0	688
1133	0	560
1134	0	689
1135	0	668
1136	0	527
1137	0	690
1138	0	691
1139	0	606
1140	0	692
1141	0	685
1142	0	615
1143	0	693
1144	0	694
1145	0	695
1146	0	506
1147	0	696
1148	0	632
1149	0	697
1150	0	618
1151	0	698
1152	0	699
1153	0	700
1154	0	472
1155	0	701
1156	0	702
1157	0	703
1158	0	704
1159	0	678
1160	0	643
1161	0	705
1162	0	706
1163	0	587
1164	0	463
1165	0	605
1166	0	707
1167	0	708
1168	0	709
1169	0	710
1170	0	711
1171	0	663
1172	0	712
1173	0	713
1174	0	714
1175	0	468
1176	0	715
1177	0	716
1178	0	717
1179	0	718
1180	0	719
1181	0	606
1182	0	720
1183	0	593
1184	0	602
1185	0	721
1186	0	578
1187	0	656
1188	0	722
1189	0	462
1190	0	723
1191	0	724
1192	0	725
1193	0	468
1194	0	726
1195	0	591
1196	0	490
1197	0	727
1198	0	728
1199	0	601
1200	0	668
1201	0	729
1202	0	543
1203	0	730
1204	0	731
1205	0	534
1206	0	731
1207	0	731
1208	0	731
1209	0	731
1210	0	731
1211	0	732
1212	0	731
1213	0	733
1214	0	560
1215	0	613
1216	0	734
1217	0	575
1218	0	735
1219	0	736
1220	0	468
1221	0	616
1222	0	737
1223	0	738
1224	0	739
1225	0	622
1226	0	740
1227	0	617
1228	0	705
1229	0	503
1230	0	507
1231	0	591
1232	0	705
1233	0	527
1234	0	508
1235	0	468
1236	0	741
1236	1	742
1237	0	685
1238	0	502
1239	0	696
1240	0	743
1241	0	503
1242	0	533
1243	0	744
1244	0	468
1245	0	745
1246	0	746
1247	0	747
1248	0	748
1249	0	685
1250	0	533
1251	0	749
1252	0	750
1253	0	751
1254	0	752
1255	0	753
1256	0	754
1257	0	755
1258	0	756
1259	0	757
1260	0	744
1261	0	758
1262	0	468
1263	0	707
1264	0	476
1265	0	693
1266	0	759
1267	0	760
1268	0	761
1269	0	613
1270	0	762
1271	0	613
1272	0	763
1273	0	615
1274	0	764
1275	0	765
1275	1	766
1276	0	560
1277	0	613
1278	0	767
1279	0	768
1280	0	769
1281	0	725
1282	0	543
1283	0	673
1284	0	770
1285	0	771
1286	0	618
1287	0	463
1288	0	758
1289	0	772
1290	0	773
1291	0	774
1292	0	775
1293	0	776
1294	0	666
1295	0	777
1296	0	503
1297	0	778
1298	0	779
1299	0	562
1300	0	780
1301	0	781
1302	0	506
1303	0	782
1304	0	610
1305	0	613
1306	0	693
1307	0	468
1308	0	783
1309	0	784
1310	0	784
1311	0	784
1312	0	622
1313	0	785
1314	0	786
1315	0	784
1316	0	784
1317	0	787
1318	0	788
1319	0	789
1320	0	544
1321	0	538
1322	0	575
1323	0	790
1324	0	791
1325	0	792
1326	0	536
1327	0	793
1328	0	794
1329	0	795
1330	0	587
1331	0	684
1332	0	796
1333	0	797
1334	0	798
1335	0	482
1336	0	687
1337	0	799
1338	0	800
1339	0	605
1340	0	801
1341	0	605
1342	0	802
1343	0	803
1344	0	786
1345	0	804
1346	0	758
1347	0	805
1348	0	806
1349	0	807
1350	0	808
1351	0	809
1352	0	528
1353	0	588
1354	0	810
1355	0	811
1356	0	812
1357	0	483
1358	0	503
1359	0	813
1360	0	588
1361	0	768
1362	0	814
1363	0	552
1364	0	694
1365	0	776
1366	0	815
1367	0	816
1368	0	512
1369	0	467
1370	0	502
1371	0	710
1372	0	508
1373	0	817
1374	0	818
1375	0	704
1376	0	699
1377	0	688
1378	0	819
1379	0	820
1380	0	696
1381	0	503
1382	0	821
1383	0	822
1384	0	823
1385	0	777
1386	0	613
1387	0	750
1388	0	601
1389	0	824
1390	0	693
1391	0	824
1392	0	825
1393	0	824
1394	0	826
1395	0	564
1396	0	824
1397	0	827
1398	0	828
1399	0	829
1400	0	756
1401	0	467
1402	0	830
1403	0	831
1404	0	513
1405	0	587
1406	0	817
1407	0	832
1408	0	833
1409	0	834
1410	0	683
1411	0	591
1412	0	835
1413	0	613
1414	0	463
1415	0	693
1416	0	754
1417	0	720
1418	0	836
1419	0	837
1420	0	838
1421	0	839
1422	0	840
1423	0	837
1424	0	710
1425	0	841
1426	0	842
1427	0	800
1428	0	843
1429	0	844
1430	0	837
1431	0	845
1432	0	846
1433	0	847
1434	0	848
1435	0	817
1436	0	849
1437	0	850
1438	0	851
1439	0	852
1440	0	853
1441	0	854
1442	0	852
1443	0	696
1444	0	855
1445	0	779
1446	0	824
1447	0	759
1448	0	716
1449	0	856
1450	0	705
1451	0	591
1452	0	794
1453	0	673
1454	0	857
1455	0	858
1456	0	859
1457	0	860
1458	0	455
1459	0	861
1460	0	833
1461	0	837
1462	0	490
1463	0	857
1464	0	610
1465	0	848
1466	0	862
1467	0	863
1468	0	848
1469	0	864
1470	0	865
1471	0	815
1472	0	673
1473	0	837
1474	0	848
1475	0	866
1476	0	685
1477	0	867
1478	0	831
1479	0	868
1480	0	776
1481	0	533
1482	0	869
1483	0	870
1484	0	746
1485	0	871
1486	0	718
1487	0	872
1488	0	873
1489	0	874
1490	0	875
1491	0	876
1492	0	877
1493	0	821
1494	0	878
1495	0	879
1496	0	760
1497	0	578
1498	0	880
1499	0	597
1500	0	881
1501	0	882
1502	0	883
1503	0	870
1504	0	884
1505	0	885
1506	0	489
1507	0	768
1508	0	886
1509	0	543
1510	0	887
1511	0	888
1512	0	502
1513	0	889
1514	0	618
1515	0	890
1516	0	871
1517	0	476
1518	0	891
1519	0	848
1520	0	857
1521	0	614
1522	0	892
1523	0	893
1524	0	894
1525	0	895
1526	0	521
1527	0	896
1528	0	867
1529	0	897
1530	0	508
1531	0	544
1532	0	606
1533	0	898
1534	0	899
1535	0	900
1536	0	837
1537	0	901
1538	0	902
1539	0	903
1540	0	870
1541	0	476
1542	0	904
2286	0	1281
2287	0	1282
2288	0	1283
2289	0	768
2290	0	582
2291	0	519
2292	0	463
2293	0	611
2294	0	611
2295	0	1284
2296	0	1285
2297	0	746
2298	0	746
2299	0	1286
2300	0	837
2301	0	837
2302	0	837
2303	0	817
2304	0	802
2305	0	802
2306	0	457
2307	0	1287
2308	0	575
2309	0	575
2310	0	575
2311	0	601
2312	0	896
2313	0	1288
2314	0	1289
2315	0	1290
2316	0	1291
2317	0	1292
2318	0	493
2319	0	1293
2320	0	656
2321	0	1294
2322	0	795
2323	0	1295
2324	0	1296
2325	0	1297
2326	0	1298
2327	0	548
2328	0	507
2329	0	1299
2330	0	1300
2331	0	831
2332	0	476
2333	0	1301
2334	0	723
2335	0	723
2336	0	535
2337	0	1302
2338	0	479
2339	0	536
2340	0	1303
2341	0	1304
2342	0	1305
2343	0	837
2344	0	1306
2345	0	817
2346	0	859
2347	0	859
2348	0	800
2349	0	1307
2350	0	1308
2351	0	746
2352	0	848
2353	0	848
2354	0	756
2355	0	1309
2356	0	1310
2357	0	1289
2358	0	1311
2359	0	1312
2360	0	830
2361	0	638
2362	0	548
2363	0	859
2364	0	859
2365	0	838
2366	0	1313
2367	0	502
2368	0	1314
2369	0	617
2370	0	862
2371	0	705
2372	0	800
2373	0	668
2374	0	1315
2375	0	872
2376	0	693
2377	0	827
2378	0	1316
2379	0	1317
2380	0	837
2381	0	460
2382	0	896
2383	0	862
2384	0	1318
2385	0	1319
2386	0	824
2387	0	1320
2388	0	852
2389	0	1318
2390	0	1317
2391	0	1317
2392	0	548
2393	0	872
2394	0	479
2395	0	508
2396	0	455
2396	1	453
2397	0	1321
2398	0	1322
2399	0	1322
2400	0	1323
2401	0	1324
2402	0	455
2403	0	1325
2404	0	524
2405	0	509
2406	0	455
2407	0	1326
2408	0	1327
2409	0	1327
2410	0	1328
2411	0	509
2412	0	509
2413	0	455
2414	0	1329
2415	0	1329
2416	0	1329
2417	0	1329
2418	0	1329
2419	0	1329
2420	0	1329
2421	0	1329
2422	0	1329
2423	0	1329
2424	0	1329
2425	0	1329
2426	0	1329
2427	0	1329
2428	0	1329
2429	0	493
2430	0	1330
2431	0	507
2432	0	1331
2433	0	1332
2434	0	1333
2435	0	486
2435	1	487
2436	0	1334
2437	0	1335
2438	0	1325
2439	0	1336
2440	0	614
2441	0	508
2442	0	734
2443	0	508
2444	0	619
2445	0	619
2446	0	1337
2447	0	619
2448	0	619
2449	0	1329
2450	0	1329
2451	0	1329
2452	0	1329
2453	0	476
2454	0	1323
2455	0	1329
2456	0	1338
2457	0	1338
2458	0	1339
2459	0	1340
2460	0	610
2461	0	1341
2462	0	802
2463	0	1342
2464	0	893
2465	0	1281
2466	0	1343
2467	0	862
2468	0	862
2469	0	1344
2470	0	1345
2471	0	1346
2472	0	1347
2473	0	1282
2474	0	1282
2475	0	543
2476	0	1348
2477	0	613
2478	0	613
2479	0	613
2480	0	1349
2481	0	646
2482	0	646
2483	0	1350
2484	0	1351
2485	0	1351
2486	0	530
2487	0	1352
2488	0	1353
2489	0	1354
2490	0	660
2491	0	660
2492	0	1355
2493	0	1356
2494	0	1356
2495	0	1357
2496	0	1358
2497	0	1359
2498	0	1360
2499	0	1361
2500	0	1362
2501	0	768
2502	0	606
2503	0	1363
2504	0	742
2504	1	1364
2505	0	1365
2506	0	1366
2507	0	501
2508	0	699
2509	0	1367
2510	0	1368
2511	0	1369
2512	0	700
2513	0	582
2514	0	1370
2515	0	1371
2516	0	843
2517	0	1372
2518	0	1373
2519	0	1374
2520	0	772
2521	0	1375
2522	0	1376
2523	0	1376
2524	0	1377
2525	0	1378
2526	0	1379
2527	0	1380
2528	0	1381
2529	0	1382
2530	0	1383
2531	0	1384
2532	0	1385
2533	0	611
2534	0	611
2535	0	527
2536	0	527
2537	0	1386
2537	1	1387
2538	0	1388
2539	0	1389
2540	0	1390
2541	0	671
2542	0	1391
2543	0	617
2544	0	503
2545	0	695
2546	0	752
2547	0	1392
2548	0	1392
2549	0	666
2550	0	1284
2551	0	1393
2552	0	744
2553	0	1394
2554	0	1395
2555	0	1396
2556	0	1397
2557	0	1398
2558	0	618
2559	0	618
2560	0	618
2561	0	1399
2562	0	676
2563	0	1400
2564	0	754
2565	0	754
2566	0	754
2567	0	1401
2568	0	720
2569	0	720
2570	0	1402
2571	0	1403
2572	0	1404
2573	0	1405
2574	0	746
2575	0	746
2576	0	665
2577	0	1406
2578	0	1407
2579	0	591
2580	0	1408
2581	0	1409
2582	0	1410
2583	0	725
2584	0	1411
2585	0	1412
2586	0	727
2587	0	757
2588	0	1413
2589	0	506
2590	0	506
2591	0	486
2591	1	487
2592	0	1414
2593	0	1415
2594	0	810
2595	0	817
2596	0	714
2597	0	1416
2598	0	1417
2599	0	1418
2600	0	1419
2601	0	816
2602	0	468
2603	0	1420
2604	0	1421
2605	0	1422
2606	0	1423
2607	0	1424
2608	0	1424
2609	0	1425
2610	0	1426
2611	0	1427
2612	0	1428
2613	0	1429
2614	0	759
2615	0	901
2616	0	864
2617	0	1430
2618	0	1287
2619	0	587
2620	0	1431
2621	0	715
2622	0	1432
2623	0	1306
2624	0	1433
2625	0	1434
2626	0	1435
2627	0	1436
2628	0	1437
2629	0	575
2630	0	575
2631	0	575
2632	0	533
2633	0	1438
2634	0	1438
2635	0	1439
2636	0	1440
2637	0	1441
2638	0	1442
2639	0	462
2640	0	1443
2641	0	654
2642	0	1444
2643	0	1445
2644	0	1446
2645	0	1446
2646	0	663
2647	0	1447
2648	0	517
2649	0	1448
2650	0	1449
2651	0	1450
2652	0	1451
2653	0	1452
2654	0	1290
2655	0	703
2656	0	1453
2657	0	1454
2658	0	1455
2659	0	634
2660	0	1456
2661	0	630
2662	0	1457
2663	0	1458
2664	0	1459
2665	0	1460
2666	0	1460
2667	0	730
2668	0	748
2669	0	748
2670	0	1461
2671	0	1462
2672	0	1463
2673	0	643
2674	0	1464
2675	0	1465
2676	0	1466
2677	0	1467
2678	0	1468
2679	0	1469
2680	0	1470
2681	0	1471
2682	0	1472
2683	0	668
2684	0	668
2685	0	717
2686	0	1473
2687	0	564
2688	0	678
2689	0	493
2690	0	1474
2691	0	1475
2692	0	1476
2693	0	524
2694	0	1477
2695	0	1478
2696	0	1479
2697	0	1480
2698	0	1481
2699	0	1482
2699	1	1483
2700	0	1484
2701	0	580
2702	0	1485
2703	0	1486
2704	0	1487
2705	0	656
2706	0	656
2707	0	1294
2708	0	1488
2709	0	1489
2710	0	1490
2711	0	1491
2712	0	1492
2713	0	1493
2714	0	1494
2715	0	795
2716	0	1495
2717	0	1496
2718	0	1497
2719	0	1498
2720	0	458
2721	0	1499
2722	0	1500
2723	0	1501
2724	0	1502
2725	0	758
2726	0	1503
2727	0	737
2728	0	638
2728	1	1504
2729	0	1505
2730	0	1506
2731	0	1506
2732	0	833
2733	0	1507
2734	0	866
2735	0	1508
2736	0	1509
2737	0	1510
2738	0	532
2739	0	532
2740	0	1511
2741	0	1512
2742	0	1513
2743	0	1514
2744	0	705
2745	0	1515
2746	0	1516
2747	0	1517
2748	0	560
2749	0	1518
2750	0	628
2751	0	1519
2752	0	507
2753	0	507
2754	0	631
2755	0	631
2756	0	836
2757	0	576
2758	0	576
2759	0	576
2760	0	576
2761	0	1520
2762	0	1521
2763	0	1522
2764	0	696
2765	0	1523
2766	0	539
2767	0	487
2768	0	487
2769	0	487
2770	0	1524
2771	0	1525
2772	0	1526
2773	0	1527
2774	0	534
2775	0	1528
2776	0	644
2777	0	782
2778	0	1529
2779	0	546
2780	0	633
2781	0	1530
2782	0	1530
2783	0	535
2784	0	820
2785	0	1302
2786	0	840
2787	0	1531
2788	0	454
2789	0	1532
2790	0	1533
2791	0	1534
2792	0	1535
2793	0	1535
2794	0	1536
2795	0	1537
2796	0	1318
2797	0	1318
2798	0	1538
2799	0	1539
2800	0	1539
2801	0	613
2802	0	543
2803	0	1540
2804	0	1541
2805	0	1542
2806	0	1543
2807	0	1544
2808	0	1545
2809	0	883
2810	0	1546
2811	0	1547
2812	0	1548
2813	0	1549
2814	0	1550
2814	1	1551
2815	0	696
2816	0	883
2817	0	883
2818	0	883
2819	0	883
2820	0	1552
2821	0	459
2822	0	620
2823	0	534
2824	0	1553
2825	0	575
2826	0	606
2827	0	1554
2828	0	1294
2829	0	1555
2830	0	1556
2831	0	860
2832	0	860
2833	0	1557
2834	0	1303
2835	0	732
2836	0	1558
2837	0	454
2838	0	1559
2839	0	1560
2840	0	501
2841	0	619
2842	0	621
2843	0	1561
2844	0	503
2845	0	817
2846	0	776
2847	0	1442
2848	0	1562
2849	0	663
2850	0	1563
2851	0	1564
2852	0	1285
2853	0	821
2854	0	1565
2855	0	1305
2856	0	1566
2857	0	1567
2858	0	1568
2859	0	593
2860	0	1569
2861	0	725
2862	0	1570
2863	0	1571
2864	0	851
2865	0	782
2866	0	779
2867	0	601
2868	0	786
2869	0	1572
2870	0	743
2871	0	1573
2872	0	1538
2873	0	1574
2874	0	1575
2875	0	1576
2876	0	1576
2877	0	1576
2878	0	1576
2879	0	1577
2880	0	1578
2881	0	1579
2882	0	1580
2883	0	1581
2884	0	1582
2885	0	1583
2886	0	1584
2887	0	666
2888	0	697
2889	0	1585
2890	0	1586
2891	0	1587
2892	0	803
2893	0	1588
2894	0	837
2895	0	1589
2896	0	564
2897	0	1590
2898	0	723
2899	0	1591
2900	0	1592
2901	0	762
2902	0	1593
2903	0	1594
2904	0	783
2905	0	631
2906	0	1595
2907	0	1295
2908	0	1596
2909	0	1597
2909	1	1598
2910	0	788
2911	0	638
2912	0	1599
2913	0	746
2914	0	1600
2915	0	1601
2916	0	763
2917	0	1602
2918	0	1603
2919	0	1603
2920	0	1603
2921	0	1603
2922	0	1603
2923	0	1603
2924	0	521
2925	0	1604
2926	0	743
2927	0	743
2928	0	743
2929	0	743
2930	0	743
2931	0	743
2932	0	1605
2933	0	1605
2934	0	1606
2935	0	1607
2936	0	565
2937	0	1608
2938	0	1609
2939	0	1610
2940	0	1611
2941	0	1612
2942	0	1613
2943	0	1614
2944	0	1341
2945	0	1615
2946	0	1615
2947	0	1615
2948	0	1616
2949	0	1616
2950	0	1460
2951	0	1617
2952	0	1618
2953	0	462
2954	0	778
2955	0	1619
2956	0	1620
2957	0	527
2958	0	1621
2959	0	668
2960	0	1622
2961	0	532
2962	0	1623
2963	0	1624
2964	0	898
2965	0	752
2966	0	1625
2967	0	1398
2968	0	1626
2969	0	1627
2970	0	1628
2971	0	1628
2972	0	1629
2973	0	825
2974	0	1630
2975	0	833
2976	0	1631
2977	0	1632
2978	0	611
2979	0	1633
2980	0	1606
2981	0	1302
2982	0	1634
2983	0	1439
2984	0	1635
2985	0	666
2986	0	587
2987	0	1636
2988	0	1637
2989	0	1638
2990	0	1347
2991	0	1639
2992	0	1424
2993	0	705
2994	0	1640
2995	0	1641
2996	0	1642
2997	0	1643
2997	1	743
2998	0	1644
2999	0	1362
3000	0	1645
3001	0	848
3002	0	848
3003	0	848
3004	0	1646
3005	0	896
3006	0	1647
3007	0	1648
3008	0	656
3009	0	1287
3010	0	467
3011	0	487
3012	0	882
3013	0	902
3014	0	1649
3015	0	1650
3016	0	463
3017	0	693
3018	0	1651
3019	0	870
3020	0	736
3021	0	1652
3022	0	1653
3023	0	1654
3024	0	837
3025	0	1488
3026	0	1655
3027	0	1656
3028	0	827
\.


--
-- Data for Name: book_genre; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.book_genre (book_id, "position", genre) FROM stdin;
772	0	Thriller
773	0	Thriller
774	0	Romance
775	0	Science fiction
776	0	Horror
777	0	Romance
778	0	Fantasy
779	0	Horror
780	0	Romance
781	0	Thriller
782	0	Literary fiction
783	0	Fantasy
784	0	Thriller
785	0	Thriller
786	0	Romance
787	0	Fantasy
788	0	Literary fiction
789	0	Thriller
790	0	Fantasy
791	0	Thriller
792	0	Horror
793	0	Horror
794	0	Speculative
795	0	Horror
796	0	Romance
797	0	Science fiction
798	0	Thriller
799	0	Fantasy
800	0	Thriller
801	0	Speculative
802	0	Historical fiction
803	0	Fantasy
804	0	Thriller
805	0	Romance
806	0	Horror
807	0	Literary fiction
808	0	Dystopian
809	0	Science fiction
810	0	Thriller
811	0	Literary fiction
812	0	Thriller
813	0	Thriller
814	0	Literary fiction
815	0	Literary fiction
816	0	Thriller
817	0	Literary fiction
818	0	Fantasy
819	0	Non-fiction
820	0	Literary fiction
821	0	Literary fiction
822	0	Thriller
823	0	Romance
824	0	Literary fiction
825	0	Romance
826	0	Literary fiction
827	0	Thriller
828	0	Horror
829	0	Thriller
830	0	Thriller
831	0	Thriller
832	0	Thriller
833	0	Fantasy
834	0	Thriller
835	0	Horror
836	0	Horror
837	0	Fantasy
838	0	Literary fiction
839	0	Thriller
840	0	Literary fiction
841	0	Romance
842	0	Thriller
843	0	Science fiction
844	0	Speculative
845	0	Literary fiction
846	0	Science fiction
847	0	Thriller
848	0	Fantasy
849	0	Historical fiction
850	0	Romance
851	0	Fantasy
852	0	Horror
853	0	Thriller
854	0	Romance
855	0	Literary fiction
856	0	Literary fiction
857	0	Thriller
858	0	Horror
859	0	Thriller
860	0	Thriller
861	0	Horror
862	0	Horror
863	0	Thriller
864	0	Romance
865	0	Fantasy
866	0	Horror
867	0	Literary fiction
868	0	Horror
869	0	Thriller
870	0	Horror
871	0	Romance
872	0	Thriller
873	0	Horror
874	0	Fantasy
875	0	Romance
876	0	Romance
877	0	Horror
878	0	Romance
879	0	Non-fiction
880	0	Thriller
881	0	Science fiction
882	0	Romance
883	0	Literary fiction
884	0	Thriller
885	0	Thriller
886	0	Thriller
887	0	Thriller
888	0	Literary fiction
889	0	Science fiction
890	0	Romance
891	0	Romance
892	0	Thriller
893	0	Thriller
894	0	Romance
895	0	Romance
896	0	Science fiction
897	0	Fantasy
898	0	Romance
899	0	Thriller
900	0	Horror
901	0	Romance
902	0	Literary fiction
903	0	Fantasy
904	0	Speculative
905	0	Romance
906	0	Fantasy
907	0	Science fiction
908	0	Romance
909	0	Romance
910	0	Fantasy
911	0	Horror
912	0	Romance
913	0	Historical fiction
914	0	Fantasy
915	0	Thriller
916	0	Thriller
917	0	Thriller
918	0	Thriller
919	0	Horror
920	0	Thriller
921	0	Literary fiction
922	0	Thriller
923	0	Thriller
924	0	Thriller
925	0	Literary fiction
926	0	Literary fiction
927	0	Historical fiction
928	0	Romance
929	0	Literary fiction
930	0	Horror
931	0	Fantasy
932	0	Literary fiction
933	0	Speculative
934	0	Horror
935	0	Romance
936	0	Horror
937	0	Horror
938	0	Thriller
939	0	Thriller
940	0	Historical fiction
941	0	Thriller
942	0	Horror
943	0	Thriller
944	0	Thriller
945	0	Horror
946	0	Romance
947	0	Romance
948	0	Thriller
949	0	Romance
950	0	Horror
951	0	Romance
952	0	Romance
953	0	Science fiction
954	0	Romance
955	0	Thriller
956	0	Romance
957	0	Romance
958	0	Romance
959	0	Horror
960	0	Horror
961	0	Romance
962	0	Romance
963	0	Romance
964	0	Horror
965	0	Science fiction
966	0	Fantasy
967	0	Romance
968	0	Thriller
969	0	Horror
970	0	Horror
971	0	Romance
972	0	Romance
973	0	Historical fiction
974	0	Historical fiction
975	0	Horror
976	0	Romance
977	0	Horror
978	0	Thriller
979	0	Literary fiction
980	0	Thriller
981	0	Horror
982	0	Science fiction
983	0	Science fiction
984	0	Thriller
985	0	Thriller
986	0	Horror
987	0	Horror
988	0	Thriller
989	0	Thriller
990	0	Thriller
991	0	Romance
992	0	Horror
993	0	Thriller
994	0	Thriller
995	0	Literary fiction
996	0	Romance
997	0	Thriller
998	0	Thriller
999	0	Thriller
1000	0	Romance
1001	0	Horror
1002	0	Horror
1003	0	Fantasy
1004	0	Thriller
1005	0	Horror
1006	0	Romance
1007	0	Romance
1008	0	Romance
1009	0	Romance
1010	0	Horror
1011	0	Science fiction
1012	0	Thriller
1013	0	Thriller
1014	0	Romance
1015	0	Horror
1016	0	Romance
1017	0	Horror
1018	0	Romance
1019	0	Romance
1020	0	Thriller
1021	0	Romance
1022	0	Romance
1023	0	Romance
1024	0	Thriller
1025	0	Romance
1026	0	Romance
1027	0	Horror
1028	0	Romance
1029	0	Thriller
1030	0	Thriller
1031	0	Romance
1032	0	Romance
1033	0	Horror
1034	0	Thriller
1035	0	Romance
1036	0	Thriller
1037	0	Romance
1038	0	Thriller
1039	0	Horror
1040	0	Horror
1041	0	Historical fiction
1042	0	Thriller
1043	0	Horror
1044	0	Historical fiction
1045	0	Horror
1046	0	Horror
1047	0	Horror
1048	0	Horror
1049	0	Horror
1050	0	Thriller
1051	0	Horror
1052	0	Romance
1053	0	Horror
1054	0	Thriller
1055	0	Thriller
1056	0	Horror
1057	0	Horror
1058	0	Thriller
1059	0	Horror
1060	0	Dystopian
1061	0	Mystery
1062	0	Romance
1063	0	Horror
1064	0	Romance
1065	0	Dystopian
1066	0	Thriller
1067	0	Science fiction
1068	0	Thriller
1069	0	Horror
1070	0	Thriller
1071	0	Horror
1072	0	Romance
1073	0	Thriller
1074	0	Thriller
1075	0	Romance
1076	0	Literary fiction
1077	0	Speculative
1078	0	Horror
1079	0	Thriller
1080	0	Horror
1081	0	Thriller
1082	0	Thriller
1083	0	Horror
1084	0	Thriller
1085	0	Romance
1086	0	Thriller
1087	0	Thriller
1088	0	Horror
1089	0	Thriller
1090	0	Thriller
1091	0	Science fiction
1092	0	Mystery
1093	0	Historical fiction
1094	0	Romance
1095	0	Horror
1096	0	Thriller
1097	0	Romance
1098	0	Horror
1099	0	Thriller
1100	0	Thriller
1101	0	Horror
1102	0	Romance
1103	0	Romance
1104	0	Horror
1105	0	Literary fiction
1106	0	Horror
1107	0	Thriller
1108	0	Romance
1109	0	Horror
1110	0	Thriller
1111	0	Horror
1112	0	Thriller
1113	0	Literary fiction
1114	0	Literary fiction
1115	0	Romance
1116	0	Science fiction
1117	0	Thriller
1118	0	Dystopian
1119	0	Horror
1120	0	Thriller
1121	0	Horror
1122	0	Horror
1123	0	Romance
1124	0	Thriller
1125	0	Romance
1126	0	Thriller
1127	0	Thriller
1128	0	Thriller
1129	0	Thriller
1130	0	Romance
1131	0	Thriller
1132	0	Horror
1133	0	Mystery
1134	0	Horror
1135	0	Thriller
1136	0	Thriller
1137	0	Thriller
1138	0	Literary fiction
1139	0	Thriller
1140	0	Horror
1141	0	Thriller
1142	0	Thriller
1143	0	Romance
1144	0	Horror
1145	0	Horror
1146	0	Horror
1147	0	Thriller
1148	0	Romance
1149	0	Romance
1150	0	Horror
1151	0	Horror
1152	0	Romance
1153	0	Mystery
1154	0	Thriller
1155	0	Romance
1156	0	Thriller
1157	0	Horror
1158	0	Speculative
1159	0	Thriller
1160	0	Horror
1161	0	Horror
1162	0	Horror
1163	0	Horror
1164	0	Horror
1165	0	Thriller
1166	0	Thriller
1167	0	Mystery
1168	0	Speculative
1169	0	Literary fiction
1170	0	Mystery
1171	0	Thriller
1172	0	Horror
1173	0	Horror
1174	0	Romance
1175	0	Thriller
1176	0	Horror
1177	0	Horror
1178	0	Horror
1179	0	Thriller
1180	0	Science fiction
1181	0	Thriller
1182	0	Horror
1183	0	Romance
1184	0	Thriller
1185	0	Horror
1186	0	Horror
1187	0	Thriller
1188	0	Horror
1189	0	Thriller
1190	0	Science fiction
1191	0	Thriller
1192	0	Romance
1193	0	Thriller
1194	0	Mystery
1195	0	Horror
1196	0	Science fiction
1197	0	Horror
1198	0	Thriller
1199	0	Thriller
1200	0	Thriller
1201	0	Horror
1202	0	Romance
1203	0	Horror
1204	0	Fantasy
1205	0	Thriller
1206	0	Fantasy
1207	0	Fantasy
1208	0	Fantasy
1209	0	Fantasy
1210	0	Fantasy
1211	0	Thriller
1212	0	Fantasy
1213	0	Thriller
1214	0	Mystery
1215	0	Romance
1216	0	Thriller
1217	0	Thriller
1218	0	Science fiction
1219	0	Horror
1220	0	Thriller
1221	0	Thriller
1222	0	Horror
1223	0	Thriller
1224	0	Thriller
1225	0	Romance
1226	0	Horror
1227	0	Horror
1228	0	Horror
1229	0	Romance
1230	0	Thriller
1231	0	Horror
1232	0	Horror
1233	0	Thriller
1234	0	Thriller
1235	0	Thriller
1236	0	Romance
1237	0	Thriller
1238	0	Romance
1239	0	Thriller
1240	0	Romance
1241	0	Romance
1242	0	Horror
1243	0	Horror
1244	0	Thriller
1245	0	Thriller
1246	0	Romance
1247	0	Literary fiction
1248	0	Romance
1249	0	Thriller
1250	0	Horror
1251	0	Science fiction
1252	0	Thriller
1253	0	Romance
1254	0	Horror
1255	0	Horror
1256	0	Horror
1257	0	Horror
1258	0	Romance
1259	0	Thriller
1260	0	Horror
1261	0	Horror
1262	0	Thriller
1263	0	Thriller
1264	0	Horror
1265	0	Romance
1266	0	Thriller
1267	0	Horror
1268	0	Science fiction
1269	0	Romance
1270	0	Horror
1271	0	Romance
1272	0	Horror
1273	0	Thriller
1274	0	Mystery
1275	0	Horror
1276	0	Mystery
1277	0	Romance
1278	0	Horror
1279	0	Romance
1280	0	Mystery
1281	0	Romance
1282	0	Romance
1283	0	Romance
1284	0	Horror
1285	0	Horror
1286	0	Horror
1287	0	Horror
1288	0	Horror
1289	0	Thriller
1290	0	Historical fiction
1291	0	Literary fiction
1291	1	Mystery
1291	2	Historical fiction
1292	0	Romance
1292	1	Fantasy
1293	0	Romance
1294	0	Horror
1295	0	Fantasy
1295	1	Horror
1296	0	Romance
1297	0	Romance
1298	0	Fantasy
1298	1	Romance
1299	0	Literary fiction
1300	0	Thriller
1301	0	Thriller
1302	0	Horror
1303	0	Thriller
1304	0	Thriller
1305	0	Romance
1306	0	Romance
1307	0	Thriller
1308	0	Mystery
1308	1	Thriller
1309	0	Dystopian
1310	0	Dystopian
1311	0	Dystopian
1312	0	Romance
1313	0	Horror
1314	0	Thriller
1315	0	Dystopian
1316	0	Dystopian
1317	0	Horror
1318	0	Romance
1319	0	Historical fiction
1320	0	Literary fiction
1321	0	Horror
1322	0	Thriller
1323	0	Romance
1323	1	Fantasy
1324	0	Horror
1325	0	Thriller
1326	0	Science fiction
1326	1	Horror
1327	0	Thriller
1328	0	Fantasy
1328	1	Horror
1329	0	Romance
1330	0	Horror
1331	0	Horror
1332	0	Romance
1333	0	Thriller
1334	0	Romance
1334	1	Thriller
1335	0	Horror
1336	0	Romance
1337	0	Thriller
1338	0	Romance
1339	0	Thriller
1340	0	Horror
1340	1	Thriller
1341	0	Thriller
1342	0	Thriller
1343	0	Horror
1344	0	Thriller
1345	0	Romance
1346	0	Horror
1347	0	Horror
1348	0	Romance
1349	0	Thriller
1350	0	Horror
1351	0	Literary fiction
1352	0	Thriller
1353	0	Science fiction
1354	0	Romance
1355	0	Horror
1356	0	Horror
1357	0	Literary fiction
1357	1	Mystery
1358	0	Romance
1359	0	Literary fiction
1359	1	Thriller
1360	0	Science fiction
1361	0	Romance
1362	0	Romance
1363	0	Historical fiction
1364	0	Literary fiction
1365	0	Romance
1366	0	Thriller
1367	0	Horror
1367	1	Historical fiction
1368	0	Thriller
1369	0	Thriller
1370	0	Romance
1371	0	Fantasy
1372	0	Thriller
1373	0	Romance
1374	0	Speculative
1375	0	Literary fiction
1376	0	Romance
1377	0	Horror
1378	0	Thriller
1379	0	Thriller
1380	0	Thriller
1381	0	Romance
1382	0	Mystery
1383	0	Romance
1384	0	Horror
1385	0	Fantasy
1386	0	Romance
1387	0	Thriller
1388	0	Thriller
1389	0	Romance
1390	0	Romance
1391	0	Romance
1392	0	Horror
1393	0	Romance
1394	0	Horror
1395	0	Thriller
1396	0	Romance
1397	0	Fantasy
1397	1	Romance
1398	0	Literary fiction
1399	0	Non-fiction
1400	0	Romance
1401	0	Thriller
1402	0	Fantasy
1402	1	Romance
1403	0	Romance
1404	0	Horror
1404	1	Historical fiction
1405	0	Horror
1406	0	Romance
1407	0	Science fiction
1408	0	Thriller
1409	0	Thriller
1410	0	Horror
1411	0	Horror
1412	0	Horror
1413	0	Romance
1414	0	Horror
1415	0	Romance
1416	0	Horror
1417	0	Horror
1418	0	Horror
1419	0	Thriller
1420	0	Dystopian
1420	1	Romance
1421	0	Horror
1422	0	Thriller
1423	0	Thriller
1424	0	Fantasy
1425	0	Horror
1426	0	Historical fiction
1427	0	Romance
1428	0	Horror
1429	0	Dystopian
1430	0	Thriller
1431	0	Romance
1432	0	Literary fiction
1433	0	Fantasy
1434	0	Romance
1435	0	Romance
1436	0	Romance
1437	0	Historical fiction
1438	0	Literary fiction
1439	0	Romance
1440	0	Horror
1440	1	Historical fiction
1441	0	Romance
1442	0	Romance
1443	0	Thriller
1444	0	Literary fiction
1445	0	Fantasy
1445	1	Romance
1446	0	Romance
1447	0	Romance
1447	1	Horror
1447	2	Thriller
1447	3	Dystopian
1448	0	Horror
1449	0	Thriller
1450	0	Horror
1451	0	Horror
1452	0	Horror
1452	1	Historical fiction
1453	0	Romance
1454	0	Romance
1455	0	Fantasy
1455	1	Romance
1456	0	Romance
1457	0	Science fiction
1458	0	Thriller
1458	1	Romance
1459	0	Fantasy
1460	0	Thriller
1461	0	Thriller
1462	0	Horror
1462	1	Science fiction
1463	0	Romance
1464	0	Thriller
1465	0	Romance
1466	0	Romance
1467	0	Literary fiction
1468	0	Romance
1469	0	Literary fiction
1470	0	Romance
1471	0	Thriller
1472	0	Romance
1473	0	Thriller
1474	0	Romance
1475	0	Horror
1476	0	Thriller
1477	0	Romance
1478	0	Romance
1479	0	Mystery
1480	0	Romance
1481	0	Horror
1482	0	Thriller
1483	0	Fantasy
1483	1	Romance
1484	0	Romance
1485	0	Science fiction
1485	1	Horror
1486	0	Thriller
1487	0	Romance
1488	0	Historical fiction
1488	1	Mystery
1489	0	Horror
1490	0	Romance
1491	0	Literary fiction
1491	1	Mystery
1492	0	Literary fiction
1493	0	Horror
1493	1	Mystery
1494	0	Horror
1494	1	Science fiction
1495	0	Mystery
1496	0	Horror
1497	0	Horror
1498	0	Romance
1499	0	Dystopian
1499	1	Thriller
1499	2	Literary fiction
1500	0	Historical fiction
1500	1	Thriller
1501	0	Science fiction
1502	0	Romance
1503	0	Fantasy
1503	1	Romance
1504	0	Horror
1504	1	Historical fiction
1505	0	Literary fiction
1506	0	Romance
1507	0	Romance
1508	0	Romance
1509	0	Romance
1510	0	Literary fiction
1510	1	Thriller
1511	0	Literary fiction
1512	0	Romance
1513	0	Romance
1514	0	Horror
1515	0	Thriller
1516	0	Science fiction
1516	1	Horror
1517	0	Horror
1518	0	Thriller
1518	1	Literary fiction
1519	0	Romance
1520	0	Romance
1521	0	Thriller
1522	0	Historical fiction
1522	1	Literary fiction
1523	0	Science fiction
1523	1	Dystopian
1523	2	Horror
1524	0	Thriller
1525	0	Literary fiction
1525	1	Romance
1526	0	Historical fiction
1527	0	Romance
1528	0	Romance
1529	0	Literary fiction
1530	0	Thriller
1530	1	Horror
1531	0	Literary fiction
1532	0	Thriller
1533	0	Thriller
1533	1	Literary fiction
1534	0	Romance
1535	0	Horror
1536	0	Thriller
1537	0	Romance
1537	1	Fantasy
1538	0	Romance
1539	0	Literary fiction
1540	0	Fantasy
1540	1	Romance
1541	0	Horror
1542	0	Speculative
\.


--
-- Data for Name: book_setting; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.book_setting (book_id, "position", setting) FROM stdin;
772	0	USA
773	0	USA
774	0	USA
775	0	Space
776	0	Unknown
777	0	USA
778	0	Fictional
779	0	USA
780	0	USA
781	0	The United Kingdom
782	0	USA
783	0	Fictional
784	0	USA
785	0	USA
786	0	USA
787	0	USA
788	0	USA
789	0	The United Kingdom
790	0	USA
791	0	USA
792	0	USA
793	0	USA
794	0	Canada
795	0	USA
796	0	USA
797	0	USA
798	0	USA
799	0	Unknown
800	0	USA
801	0	USA
802	0	Greece
803	0	Fictional
804	0	USA
805	0	USA
806	0	Unknown
807	0	USA
808	0	USA
809	0	USA
810	0	USA
811	0	USA
812	0	USA
813	0	Ireland
814	0	USA
815	0	USA
816	0	USA
817	0	USA
818	0	Fictional
819	0	USA
820	0	The United Kingdom
821	0	USA
822	0	The United Kingdom
823	0	USA
824	0	USA
825	0	USA
826	0	Ireland
827	0	Australia
828	0	USA
829	0	The United Kingdom
830	0	USA
831	0	USA
832	0	USA
833	0	USA
834	0	USA
835	0	USA
836	0	Mexico
837	0	USA
838	0	Dominican Republic
839	0	The United Kingdom
840	0	Taiwan
841	0	USA
842	0	The United Kingdom
843	0	Space
844	0	Fictional
845	0	USA
846	0	USA
847	0	USA
848	0	Fictional
849	0	Lithuania
850	0	Ireland
851	0	Fictional
852	0	USA
853	0	Norway
854	0	USA
855	0	Nigeria
856	0	USA
857	0	France
858	0	USA
859	0	The United Kingdom
860	0	The United Kingdom
861	0	USA
862	0	USA
863	0	USA
864	0	Croatia
865	0	USA
866	0	USA
867	0	USA
868	0	USA
869	0	USA
870	0	USA
871	0	USA
872	0	France
873	0	Fictional
874	0	USA
875	0	USA
876	0	USA
877	0	USA
878	0	USA
879	0	USA
880	0	USA
881	0	USA
882	0	USA
883	0	Sweden
884	0	USA
885	0	Norway
886	0	USA
887	0	USA
888	0	Croatia
889	0	USA
890	0	USA
891	0	USA
892	0	The United Kingdom
893	0	USA
894	0	USA
895	0	USA
896	0	USA
897	0	Fictional
898	0	USA
899	0	The United Kingdom
900	0	Australia
901	0	USA
902	0	USA
903	0	USA
904	0	USA
905	0	USA
906	0	USA
907	0	Space
908	0	USA
909	0	USA
910	0	Fictional
911	0	USA
912	0	USA
913	0	Ireland
914	0	Greece
915	0	USA
916	0	The United Kingdom
917	0	The United Kingdom
918	0	Sweden
919	0	USA
920	0	USA
921	0	Croatia
922	0	USA
923	0	USA
924	0	Canada
925	0	Sweden
926	0	Italy
927	0	Italy
928	0	USA
929	0	Croatia
930	0	USA
931	0	USA
932	0	USA
933	0	Spain
934	0	USA
935	0	The United Kingdom
936	0	USA
937	0	USA
938	0	The United Kingdom
939	0	Australia
940	0	France
941	0	USA
942	0	USA
943	0	The United Kingdom
944	0	USA
945	0	USA
946	0	USA
947	0	USA
948	0	USA
949	0	USA
950	0	USA
951	0	USA
952	0	USA
953	0	Japan
954	0	Hungary
955	0	USA
956	0	The United Kingdom
957	0	USA
958	0	USA
959	0	Croatia
960	0	USA
961	0	USA
962	0	USA
963	0	USA
964	0	USA
965	0	Space
966	0	USA
967	0	USA
968	0	Croatia
969	0	USA
970	0	Argentina
971	0	USA
972	0	The United Kingdom
973	0	Poland
974	0	USA
975	0	South Korea
976	0	USA
977	0	USA
978	0	Switzerland
979	0	USA
980	0	The United Kingdom
981	0	The United Kingdom
982	0	Space
983	0	Space
984	0	USA
985	0	The United Kingdom
986	0	Denmark
987	0	USA
988	0	USA
989	0	USA
990	0	Germany
991	0	Fictional
992	0	The United Kingdom
993	0	The United Kingdom
994	0	Ireland
995	0	Croatia
996	0	USA
997	0	USA
998	0	USA
999	0	USA
1000	0	USA
1001	0	USA
1002	0	USA
1003	0	USA
1004	0	USA
1005	0	USA
1006	0	USA
1007	0	USA
1008	0	USA
1009	0	USA
1010	0	USA
1011	0	Fictional
1012	0	USA
1013	0	USA
1014	0	USA
1015	0	USA
1016	0	Space
1017	0	Fictional
1018	0	USA
1019	0	Greece
1020	0	USA
1021	0	USA
1022	0	USA
1023	0	USA
1024	0	USA
1025	0	USA
1026	0	USA
1027	0	USA
1028	0	USA
1029	0	The United Kingdom
1030	0	USA
1031	0	USA
1032	0	USA
1033	0	USA
1034	0	The United Kingdom
1035	0	USA
1036	0	USA
1037	0	USA
1038	0	USA
1039	0	Canada
1040	0	USA
1041	0	France
1042	0	USA
1043	0	USA
1044	0	USA
1045	0	South Korea
1046	0	Argentina
1047	0	USA
1048	0	USA
1049	0	USA
1050	0	USA
1051	0	USA
1052	0	USA
1053	0	USA
1054	0	USA
1055	0	USA
1056	0	USA
1057	0	Unknown
1058	0	USA
1059	0	The United Kingdom
1060	0	Fictional
1061	0	USA
1062	0	USA
1063	0	USA
1064	0	The United Kingdom
1065	0	USA
1066	0	Japan
1067	0	USA
1068	0	The United Kingdom
1069	0	USA
1070	0	USA
1071	0	USA
1072	0	USA
1073	0	USA
1074	0	USA
1075	0	Canada
1076	0	USA
1077	0	USA
1078	0	USA
1079	0	USA
1080	0	Fictional
1081	0	USA
1082	0	USA
1083	0	USA
1084	0	USA
1085	0	Trinidad and Tobago
1086	0	USA
1087	0	Unknown
1088	0	Fictional
1089	0	USA
1090	0	The United Kingdom
1091	0	Space
1092	0	Sweden
1093	0	Romania
1094	0	USA
1095	0	USA
1096	0	USA
1097	0	USA
1098	0	USA
1099	0	Canada
1100	0	Australia
1101	0	USA
1102	0	USA
1103	0	USA
1104	0	USA
1105	0	USA
1106	0	USA
1107	0	USA
1108	0	Ecuador
1109	0	USA
1110	0	USA
1111	0	USA
1112	0	The United Kingdom
1113	0	The United Kingdom
1114	0	USA
1115	0	USA
1116	0	Space
1117	0	USA
1118	0	Fictional
1119	0	Fictional
1120	0	The United Kingdom
1121	0	Unknown
1122	0	USA
1123	0	USA
1124	0	Sweden
1125	0	USA
1126	0	USA
1127	0	The United Kingdom
1128	0	The United Kingdom
1129	0	USA
1130	0	USA
1131	0	The United Kingdom
1132	0	USA
1133	0	The United Kingdom
1134	0	USA
1135	0	The United Kingdom
1136	0	USA
1137	0	Australia
1138	0	USA
1139	0	USA
1140	0	USA
1141	0	The United Kingdom
1142	0	USA
1143	0	USA
1144	0	USA
1145	0	USA
1146	0	Unknown
1147	0	Germany
1148	0	Unknown
1149	0	USA
1150	0	USA
1151	0	USA
1152	0	USA
1153	0	Australia
1154	0	The United Kingdom
1155	0	USA
1156	0	USA
1157	0	USA
1158	0	USA
1159	0	Norway
1160	0	USA
1161	0	USA
1162	0	Canada
1163	0	USA
1164	0	Unknown
1165	0	USA
1166	0	The United Kingdom
1167	0	USA
1168	0	Russia
1169	0	USA
1170	0	The United Kingdom
1171	0	USA
1172	0	USA
1173	0	USA
1174	0	USA
1175	0	USA
1176	0	USA
1177	0	USA
1178	0	USA
1179	0	USA
1180	0	Space
1181	0	USA
1182	0	USA
1183	0	The United Kingdom
1184	0	Greece
1185	0	Unknown
1186	0	USA
1187	0	The United Kingdom
1188	0	USA
1189	0	USA
1190	0	USA
1191	0	USA
1192	0	USA
1193	0	USA
1194	0	USA
1195	0	USA
1196	0	USA
1197	0	USA
1198	0	USA
1199	0	The United Kingdom
1200	0	The United Kingdom
1201	0	USA
1202	0	USA
1203	0	USA
1204	0	The United Kingdom
1205	0	USA
1206	0	The United Kingdom
1207	0	The United Kingdom
1208	0	The United Kingdom
1209	0	The United Kingdom
1210	0	The United Kingdom
1211	0	USA
1212	0	The United Kingdom
1213	0	Italy
1214	0	The United Kingdom
1215	0	USA
1216	0	Australia
1217	0	The United Kingdom
1218	0	Space
1219	0	Italy
1220	0	USA
1221	0	USA
1222	0	Ireland
1223	0	USA
1224	0	USA
1225	0	USA
1226	0	USA
1227	0	USA
1228	0	USA
1229	0	USA
1230	0	Indonesia
1231	0	USA
1232	0	USA
1233	0	The United Kingdom
1234	0	USA
1235	0	USA
1236	0	USA
1237	0	USA
1238	0	USA
1239	0	The United Kingdom
1240	0	Canada
1241	0	USA
1242	0	USA
1243	0	USA
1244	0	Italy
1245	0	Germany
1246	0	Canada
1247	0	USA
1248	0	USA
1249	0	The United Kingdom
1250	0	USA
1251	0	Space
1252	0	Greece
1253	0	Fiji
1254	0	USA
1255	0	France
1256	0	The United Kingdom
1257	0	USA
1258	0	USA
1259	0	The United Kingdom
1260	0	USA
1261	0	USA
1262	0	USA
1263	0	The United Kingdom
1264	0	USA
1265	0	USA
1266	0	USA
1267	0	Canada
1268	0	USA
1269	0	USA
1270	0	USA
1271	0	USA
1272	0	Iceland
1273	0	USA
1274	0	The United Kingdom
1275	0	USA
1276	0	The United Kingdom
1277	0	USA
1278	0	USA
1279	0	USA
1280	0	The United Kingdom
1281	0	USA
1282	0	USA
1283	0	USA
1284	0	Ecuador
1285	0	USA
1286	0	USA
1287	0	USA
1288	0	USA
1289	0	Norway
1290	0	USA
1291	0	USA
1292	0	Fictional
1293	0	USA
1294	0	USA
1295	0	Fictional
1296	0	USA
1297	0	USA
1298	0	Fictional
1299	0	USA
1300	0	USA
1301	0	USA
1302	0	USA
1303	0	USA
1304	0	The United Kingdom
1305	0	USA
1306	0	USA
1307	0	Mexico
1308	0	USA
1309	0	USA
1310	0	USA
1311	0	USA
1312	0	USA
1313	0	Canada
1314	0	Portugal
1315	0	USA
1316	0	USA
1317	0	USA
1318	0	USA
1319	0	Germany
1320	0	Sweden
1321	0	USA
1322	0	The United Kingdom
1323	0	USA
1324	0	The United Kingdom
1325	0	USA
1326	0	USA
1327	0	The United Kingdom
1328	0	USA
1329	0	USA
1330	0	USA
1331	0	USA
1332	0	USA
1333	0	South Korea
1334	0	USA
1335	0	USA
1336	0	USA
1337	0	USA
1338	0	USA
1339	0	USA
1340	0	USA
1341	0	USA
1342	0	The United Kingdom
1343	0	USA
1344	0	USA
1345	0	USA
1346	0	USA
1347	0	Ireland
1348	0	USA
1349	0	USA
1350	0	The Netherlands
1351	0	USA
1352	0	The United Kingdom
1353	0	Space
1354	0	USA
1355	0	USA
1356	0	USA
1357	0	USA
1358	0	USA
1359	0	USA
1360	0	Space
1361	0	USA
1362	0	USA
1363	0	USA
1364	0	USA
1365	0	USA
1366	0	USA
1367	0	Mexico
1368	0	USA
1369	0	The United Kingdom
1370	0	USA
1371	0	Fictional
1372	0	USA
1373	0	Canada
1374	0	The United Kingdom
1375	0	USA
1376	0	USA
1377	0	USA
1378	0	Italy
1379	0	USA
1380	0	Thailand
1381	0	Indonesia
1382	0	Japan
1383	0	Unknown
1384	0	USA
1385	0	Greece
1386	0	Italy
1387	0	France
1388	0	The United Kingdom
1389	0	USA
1390	0	Canada
1391	0	USA
1392	0	USA
1393	0	USA
1394	0	Argentina
1395	0	USA
1396	0	USA
1397	0	Fictional
1398	0	USA
1399	0	USA
1400	0	USA
1401	0	The United Kingdom
1402	0	Fictional
1403	0	USA
1404	0	USA
1405	0	USA
1406	0	Canada
1407	0	USA
1408	0	USA
1409	0	Norway
1410	0	USA
1411	0	USA
1412	0	USA
1413	0	USA
1414	0	USA
1415	0	Canada
1416	0	The United Kingdom
1417	0	USA
1418	0	Romania
1419	0	USA
1420	0	Fictional
1421	0	Nigeria
1422	0	USA
1423	0	USA
1424	0	Fictional
1425	0	USA
1426	0	The United Kingdom
1427	0	Canada
1428	0	USA
1429	0	Unknown
1430	0	USA
1431	0	USA
1432	0	The United Kingdom
1433	0	USA
1434	0	USA
1435	0	Canada
1436	0	USA
1437	0	Canada
1438	0	Ireland
1439	0	USA
1440	0	The United Kingdom
1441	0	USA
1442	0	USA
1443	0	Italy
1444	0	USA
1445	0	Fictional
1446	0	USA
1447	0	USA
1448	0	USA
1449	0	Antarctica
1450	0	USA
1451	0	USA
1452	0	Fictional
1453	0	USA
1454	0	USA
1455	0	Fictional
1456	0	Canada
1457	0	Space
1458	0	USA
1459	0	USA
1460	0	USA
1461	0	USA
1462	0	Space
1463	0	USA
1464	0	The United Kingdom
1465	0	USA
1466	0	USA
1467	0	Unknown
1468	0	USA
1469	0	USA
1470	0	USA
1471	0	Canada
1472	0	USA
1473	0	USA
1474	0	USA
1475	0	USA
1476	0	The United Kingdom
1477	0	USA
1478	0	USA
1479	0	Japan
1480	0	USA
1481	0	USA
1482	0	USA
1483	0	Fictional
1484	0	Canada
1485	0	USA
1486	0	USA
1487	0	USA
1488	0	USA
1489	0	Fictional
1490	0	USA
1491	0	Japan
1492	0	The United Kingdom
1493	0	Japan
1494	0	South Korea
1495	0	The United Kingdom
1496	0	USA
1497	0	USA
1498	0	Switzerland
1499	0	USA
1500	0	USA
1501	0	Space
1502	0	Canada
1503	0	Fictional
1504	0	The United Kingdom
1505	0	USA
1506	0	USA
1507	0	USA
1508	0	USA
1509	0	USA
1510	0	The United Kingdom
1511	0	USA
1512	0	USA
1513	0	USA
1514	0	Sweden
1515	0	USA
1516	0	USA
1517	0	USA
1518	0	USA
1519	0	USA
1520	0	USA
1521	0	USA
1522	0	USA
1523	0	Space
1524	0	USA
1525	0	USA
1526	0	Spain
1527	0	USA
1528	0	USA
1529	0	USA
1530	0	USA
1531	0	Sweden
1532	0	USA
1533	0	USA
1534	0	USA
1535	0	USA
1536	0	USA
1537	0	USA
1538	0	USA
1539	0	Japan
1540	0	Fictional
1541	0	USA
1542	0	The United Kingdom
\.


--
-- Data for Name: copy; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.copy (id, book_id, format, price, year_acquired, source, created_at, updated_at) FROM stdin;
1476	2286	Physical	8.34	2025	Libristo	2026-10-11 15:09:45.165662+00	2026-10-11 15:09:45.165662+00
1477	1466	Physical	8.36	2025	Libristo	2026-10-11 15:09:45.174107+00	2026-10-11 15:09:45.174107+00
1478	2287	Physical	6.90	2024	Interliber	2026-10-11 15:09:45.188348+00	2026-10-11 15:09:45.188348+00
1479	1452	Physical	8.26	2025	Libristo	2026-10-11 15:09:45.261627+00	2026-10-11 15:09:45.261627+00
1480	1519	Physical	8.46	2025	Libristo	2026-10-11 15:09:45.271245+00	2026-10-11 15:09:45.271245+00
1481	1448	Physical	7.50	2025	Facebook	2026-10-11 15:09:45.280418+00	2026-10-11 15:09:45.280418+00
1482	2288	Physical	6.00	2025	Interliber	2026-10-11 15:09:45.368247+00	2026-10-11 15:09:45.368247+00
1483	1507	Physical	8.36	2025	Libristo	2026-10-11 15:09:45.375958+00	2026-10-11 15:09:45.375958+00
1484	2289	Physical	8.41	2025	Libristo	2026-10-11 15:09:45.462079+00	2026-10-11 15:09:45.462079+00
1485	2290	Physical	7.00	2025	Interliber	2026-10-11 15:09:45.474412+00	2026-10-11 15:09:45.474412+00
1486	2291	Physical	6.45	2024	Facebook	2026-10-11 15:09:45.486299+00	2026-10-11 15:09:45.486299+00
1487	2292	Physical	5.00	2025	Interspar	2026-10-11 15:09:45.564662+00	2026-10-11 15:09:45.564662+00
1488	1445	Physical	13.53	2025	Libristo	2026-10-11 15:09:45.574461+00	2026-10-11 15:09:45.574461+00
1489	1489	Physical	14.00	2025	Facebook	2026-10-11 15:09:45.583219+00	2026-10-11 15:09:45.583219+00
1490	2293	Physical	8.25	2023	Wob	2026-10-11 15:09:45.669191+00	2026-10-11 15:09:45.669191+00
1491	2294	Physical	9.45	2022	Book Depository	2026-10-11 15:09:45.76526+00	2026-10-11 15:09:45.76526+00
1492	2295	Physical	5.00	2025	Interliber	2026-10-11 15:09:45.780297+00	2026-10-11 15:09:45.780297+00
1493	1514	Physical	9.87	2025	Libristo	2026-10-11 15:09:45.855724+00	2026-10-11 15:09:45.855724+00
1494	1494	Physical	8.41	2025	Libristo	2026-10-11 15:09:45.86663+00	2026-10-11 15:09:45.86663+00
1495	2296	Physical	7.80	2025	Libristo	2026-10-11 15:09:45.886087+00	2026-10-11 15:09:45.886087+00
1496	1484	Physical	8.13	2024	Wob	2026-10-11 15:09:45.967563+00	2026-10-11 15:09:45.967563+00
1497	2297	Physical	8.43	2025	Libristo	2026-10-11 15:09:45.981073+00	2026-10-11 15:09:45.981073+00
1498	2298	Physical	8.34	2025	Libristo	2026-10-11 15:09:46.065821+00	2026-10-11 15:09:46.065821+00
1499	1512	Physical	8.47	2025	Libristo	2026-10-11 15:09:46.074341+00	2026-10-11 15:09:46.074341+00
1500	2299	Physical	6.20	2025	Interliber	2026-10-11 15:09:46.156176+00	2026-10-11 15:09:46.156176+00
1501	2300	Physical	8.47	2025	Libristo	2026-10-11 15:09:46.16865+00	2026-10-11 15:09:46.16865+00
1502	2301	Physical	8.46	2025	Libristo	2026-10-11 15:09:46.179313+00	2026-10-11 15:09:46.179313+00
1503	2302	Physical	8.41	2025	Libristo	2026-10-11 15:09:46.189704+00	2026-10-11 15:09:46.189704+00
1504	2303	Physical	10.08	2025	Libristo	2026-10-11 15:09:46.264935+00	2026-10-11 15:09:46.264935+00
1505	2304	Physical	\N	2024	Interliber	2026-10-11 15:09:46.362744+00	2026-10-11 15:09:46.362744+00
1506	2305	Physical	\N	2024	Interliber	2026-10-11 15:09:46.375593+00	2026-10-11 15:09:46.375593+00
1507	2306	Physical	10.20	2023	Interliber	2026-10-11 15:09:46.455734+00	2026-10-11 15:09:46.455734+00
1508	2307	Physical	5.00	2025	Interliber	2026-10-11 15:09:46.469943+00	2026-10-11 15:09:46.469943+00
1509	1533	Physical	8.34	2025	Libristo	2026-10-11 15:09:46.477556+00	2026-10-11 15:09:46.477556+00
1510	2308	Physical	7.00	2024	Facebook	2026-10-11 15:09:46.487173+00	2026-10-11 15:09:46.487173+00
1511	2309	Physical	9.48	2025	Libristo	2026-10-11 15:09:46.56244+00	2026-10-11 15:09:46.56244+00
1512	2310	Physical	9.95	2021	Hoću knjigu Buzin	2026-10-11 15:09:46.575598+00	2026-10-11 15:09:46.575598+00
1513	1481	Physical	3.13	2024	Wob	2026-10-11 15:09:46.661936+00	2026-10-11 15:09:46.661936+00
1514	2311	Physical	8.36	2025	Libristo	2026-10-11 15:09:46.672196+00	2026-10-11 15:09:46.672196+00
1515	1505	Physical	5.00	2024	Interliber	2026-10-11 15:09:46.67976+00	2026-10-11 15:09:46.67976+00
1516	2312	Physical	8.46	2025	Libristo	2026-10-11 15:09:46.763583+00	2026-10-11 15:09:46.763583+00
1517	2313	Physical	8.34	2025	Libristo	2026-10-11 15:09:46.77634+00	2026-10-11 15:09:46.77634+00
1518	1504	Physical	8.00	2025	Facebook	2026-10-11 15:09:46.784233+00	2026-10-11 15:09:46.784233+00
1519	2314	Physical	8.34	2025	Libristo	2026-10-11 15:09:46.864602+00	2026-10-11 15:09:46.864602+00
1520	2315	Physical	9.18	2025	Libristo	2026-10-11 15:09:46.877486+00	2026-10-11 15:09:46.877486+00
1521	2316	Physical	13.75	2025	Libristo	2026-10-11 15:09:46.890139+00	2026-10-11 15:09:46.890139+00
1522	1459	Physical	5.36	2021	Book Depository	2026-10-11 15:09:46.958708+00	2026-10-11 15:09:46.958708+00
1523	2317	Physical	5.00	2025	Interliber	2026-10-11 15:09:46.973895+00	2026-10-11 15:09:46.973895+00
1524	2318	Physical	9.80	2023	Book Depository	2026-10-11 15:09:46.984829+00	2026-10-11 15:09:46.984829+00
1525	2319	Physical	8.67	2025	Libristo	2026-10-11 15:09:47.065347+00	2026-10-11 15:09:47.065347+00
1526	2320	Physical	7.71	2025	Libristo	2026-10-11 15:09:47.077244+00	2026-10-11 15:09:47.077244+00
1527	2321	Physical	5.00	2024	Facebook	2026-10-11 15:09:47.158563+00	2026-10-11 15:09:47.158563+00
1528	2322	Physical	6.50	2025	Interliber	2026-10-11 15:09:47.171101+00	2026-10-11 15:09:47.171101+00
1529	2323	Physical	8.43	2025	Libristo	2026-10-11 15:09:47.185126+00	2026-10-11 15:09:47.185126+00
1530	1500	Physical	8.36	2025	Libristo	2026-10-11 15:09:47.264601+00	2026-10-11 15:09:47.264601+00
1531	2324	Physical	5.00	2025	Facebook	2026-10-11 15:09:47.279794+00	2026-10-11 15:09:47.279794+00
1532	2325	Physical	0.00	2025	Facebook	2026-10-11 15:09:47.368768+00	2026-10-11 15:09:47.368768+00
1533	2326	Physical	7.50	2023	Facebook	2026-10-11 15:09:47.382813+00	2026-10-11 15:09:47.382813+00
1534	1513	Physical	8.85	2025	Libristo	2026-10-11 15:09:47.46058+00	2026-10-11 15:09:47.46058+00
1535	1460	Physical	6.00	2024	Facebook	2026-10-11 15:09:47.473999+00	2026-10-11 15:09:47.473999+00
1536	1450	Physical	8.00	2025	Facebook	2026-10-11 15:09:47.559115+00	2026-10-11 15:09:47.559115+00
1537	2327	Physical	8.34	2025	Libristo	2026-10-11 15:09:47.571662+00	2026-10-11 15:09:47.571662+00
1538	1526	Physical	6.90	2024	Interliber	2026-10-11 15:09:47.662378+00	2026-10-11 15:09:47.662378+00
1539	2328	Physical	8.39	2023	Wob	2026-10-11 15:09:47.672558+00	2026-10-11 15:09:47.672558+00
1540	2329	Physical	9.38	2024	Wob	2026-10-11 15:09:47.763664+00	2026-10-11 15:09:47.763664+00
1541	1443	Physical	3.13	2024	Wob	2026-10-11 15:09:47.774136+00	2026-10-11 15:09:47.774136+00
1542	2330	Physical	9.23	2025	Libristo	2026-10-11 15:09:47.855714+00	2026-10-11 15:09:47.855714+00
1543	1492	Physical	8.43	2025	Libristo	2026-10-11 15:09:47.865931+00	2026-10-11 15:09:47.865931+00
1544	2331	Physical	8.47	2025	Libristo	2026-10-11 15:09:47.879546+00	2026-10-11 15:09:47.879546+00
1545	1478	Physical	8.47	2025	Libristo	2026-10-11 15:09:47.962223+00	2026-10-11 15:09:47.962223+00
1546	1456	Physical	8.43	2025	Libristo	2026-10-11 15:09:47.972947+00	2026-10-11 15:09:47.972947+00
1547	1497	Physical	11.99	2022	Book Depository	2026-10-11 15:09:48.058965+00	2026-10-11 15:09:48.058965+00
1548	1541	Physical	10.49	2022	Interliber	2026-10-11 15:09:48.069343+00	2026-10-11 15:09:48.069343+00
1549	1517	Physical	9.16	2021	Men Art Avenue Mall	2026-10-11 15:09:48.082894+00	2026-10-11 15:09:48.082894+00
1550	2332	Physical	18.00	2024	Hoću knjigu	2026-10-11 15:09:48.255805+00	2026-10-11 15:09:48.255805+00
1551	2333	Physical	11.00	2024	Facebook	2026-10-11 15:09:48.276565+00	2026-10-11 15:09:48.276565+00
1552	2334	Physical	8.55	2024	Wob	2026-10-11 15:09:48.286865+00	2026-10-11 15:09:48.286865+00
1553	2335	Physical	7.84	2024	Wob	2026-10-11 15:09:48.37947+00	2026-10-11 15:09:48.37947+00
1554	2336	Physical	1.00	2025	Facebook	2026-10-11 15:09:48.463768+00	2026-10-11 15:09:48.463768+00
1555	2337	Physical	8.47	2025	Libristo	2026-10-11 15:09:48.485422+00	2026-10-11 15:09:48.485422+00
1556	2338	Physical	10.00	2025	Facebook	2026-10-11 15:09:48.566443+00	2026-10-11 15:09:48.566443+00
1557	2339	Physical	9.41	2026	Libristo	2026-10-11 15:09:48.581765+00	2026-10-11 15:09:48.581765+00
1558	1465	Physical	9.31	2026	Libristo	2026-10-11 15:09:48.665123+00	2026-10-11 15:09:48.665123+00
1559	1461	Physical	9.31	2026	Libristo	2026-10-11 15:09:48.681583+00	2026-10-11 15:09:48.681583+00
1560	1483	Physical	9.81	2026	Libristo	2026-10-11 15:09:48.76701+00	2026-10-11 15:09:48.76701+00
1561	2340	Physical	20.84	2026	Libristo	2026-10-11 15:09:48.787566+00	2026-10-11 15:09:48.787566+00
1562	1446	Physical	9.31	2026	Libristo	2026-10-11 15:09:48.865488+00	2026-10-11 15:09:48.865488+00
1563	1458	Physical	13.52	2026	Libristo	2026-10-11 15:09:48.879632+00	2026-10-11 15:09:48.879632+00
2084	2469	Ebook	\N	\N	\N	2026-10-11 15:10:12.793704+00	2026-10-11 15:10:12.793704+00
1564	1474	Physical	9.27	2026	Libristo	2026-10-11 15:09:48.970526+00	2026-10-11 15:09:48.970526+00
1565	1468	Physical	9.27	2026	Libristo	2026-10-11 15:09:48.982749+00	2026-10-11 15:09:48.982749+00
1566	2341	Physical	9.67	2026	Libristo	2026-10-11 15:09:49.083747+00	2026-10-11 15:09:49.083747+00
1567	1529	Physical	9.37	2026	Libristo	2026-10-11 15:09:49.16032+00	2026-10-11 15:09:49.16032+00
1568	1268	Physical	8.78	2026	Libristo	2026-10-11 15:09:49.171611+00	2026-10-11 15:09:49.171611+00
1569	1454	Physical	9.27	2026	Libristo	2026-10-11 15:09:49.258245+00	2026-10-11 15:09:49.258245+00
1570	1538	Physical	9.67	2026	Libristo	2026-10-11 15:09:49.267068+00	2026-10-11 15:09:49.267068+00
1571	1463	Physical	9.27	2026	Libristo	2026-10-11 15:09:49.274972+00	2026-10-11 15:09:49.274972+00
1572	1527	Physical	8.68	2026	Libristo	2026-10-11 15:09:49.359019+00	2026-10-11 15:09:49.359019+00
1573	1472	Physical	9.42	2026	Libristo	2026-10-11 15:09:49.367778+00	2026-10-11 15:09:49.367778+00
1574	2342	Physical	10.32	2026	Libristo	2026-10-11 15:09:49.381443+00	2026-10-11 15:09:49.381443+00
1575	1536	Physical	10.02	2026	Libristo	2026-10-11 15:09:49.455662+00	2026-10-11 15:09:49.455662+00
1576	2343	Physical	10.32	2026	Libristo	2026-10-11 15:09:49.467822+00	2026-10-11 15:09:49.467822+00
1577	2344	Physical	9.42	2026	Libristo	2026-10-11 15:09:49.485805+00	2026-10-11 15:09:49.485805+00
1578	2345	Physical	9.42	2026	Libristo	2026-10-11 15:09:49.578413+00	2026-10-11 15:09:49.578413+00
1579	2346	Physical	10.52	2026	Libristo	2026-10-11 15:09:49.605992+00	2026-10-11 15:09:49.605992+00
1580	2347	Physical	10.02	2026	Libristo	2026-10-11 15:09:49.671665+00	2026-10-11 15:09:49.671665+00
1581	1250	Physical	9.42	2026	Libristo	2026-10-11 15:09:49.693829+00	2026-10-11 15:09:49.693829+00
1582	2348	Physical	9.02	2026	Libristo	2026-10-11 15:09:49.728015+00	2026-10-11 15:09:49.728015+00
1583	2349	Physical	8.72	2026	Libristo	2026-10-11 15:09:49.767176+00	2026-10-11 15:09:49.767176+00
1584	1447	Physical	9.42	2026	Libristo	2026-10-11 15:09:49.777639+00	2026-10-11 15:09:49.777639+00
1585	1453	Physical	10.32	2026	Libristo	2026-10-11 15:09:49.861347+00	2026-10-11 15:09:49.861347+00
1586	1531	Physical	9.02	2026	Libristo	2026-10-11 15:09:49.872692+00	2026-10-11 15:09:49.872692+00
1587	1473	Physical	10.22	2026	Libristo	2026-10-11 15:09:49.95837+00	2026-10-11 15:09:49.95837+00
1588	2350	Physical	8.00	2026	Libristo	2026-10-11 15:09:49.973944+00	2026-10-11 15:09:49.973944+00
1589	2351	Physical	10.01	2026	Libristo	2026-10-11 15:09:50.060822+00	2026-10-11 15:09:50.060822+00
1590	1493	Physical	6.50	2026	Libristo	2026-10-11 15:09:50.072867+00	2026-10-11 15:09:50.072867+00
1591	1502	Physical	10.01	2026	Libristo	2026-10-11 15:09:50.16043+00	2026-10-11 15:09:50.16043+00
1592	1509	Physical	9.41	2026	Libristo	2026-10-11 15:09:50.172319+00	2026-10-11 15:09:50.172319+00
1593	1406	Physical	9.01	2026	Libristo	2026-10-11 15:09:50.25983+00	2026-10-11 15:09:50.25983+00
1594	2352	Physical	8.92	2026	Libristo	2026-10-11 15:09:50.274883+00	2026-10-11 15:09:50.274883+00
1595	2353	Physical	8.92	2026	Libristo	2026-10-11 15:09:50.36806+00	2026-10-11 15:09:50.36806+00
1596	2354	Physical	8.92	2026	Libristo	2026-10-11 15:09:50.384655+00	2026-10-11 15:09:50.384655+00
1597	2355	Physical	8.92	2026	Libristo	2026-10-11 15:09:50.471077+00	2026-10-11 15:09:50.471077+00
1598	1439	Physical	8.92	2026	Libristo	2026-10-11 15:09:50.560096+00	2026-10-11 15:09:50.560096+00
1599	1442	Physical	8.92	2026	Libristo	2026-10-11 15:09:50.573619+00	2026-10-11 15:09:50.573619+00
1600	2356	Physical	9.62	2026	Libristo	2026-10-11 15:09:50.663441+00	2026-10-11 15:09:50.663441+00
1601	2357	Physical	9.62	2026	Libristo	2026-10-11 15:09:50.675827+00	2026-10-11 15:09:50.675827+00
1602	2358	Physical	9.32	2026	Libristo	2026-10-11 15:09:50.689883+00	2026-10-11 15:09:50.689883+00
1603	1520	Physical	9.91	2026	Libristo	2026-10-11 15:09:50.76192+00	2026-10-11 15:09:50.76192+00
1604	2359	Physical	8.92	2026	Libristo	2026-10-11 15:09:50.776544+00	2026-10-11 15:09:50.776544+00
1605	2360	Physical	14.60	2026	Libristo	2026-10-11 15:09:50.862548+00	2026-10-11 15:09:50.862548+00
1606	2361	Physical	9.56	2026	Libristo	2026-10-11 15:09:50.876026+00	2026-10-11 15:09:50.876026+00
1607	868	Physical	9.46	2026	Libristo	2026-10-11 15:09:50.894252+00	2026-10-11 15:09:50.894252+00
1608	2362	Physical	10.17	2026	Libristo	2026-10-11 15:09:50.9676+00	2026-10-11 15:09:50.9676+00
1609	2363	Physical	9.66	2026	Libristo	2026-10-11 15:09:50.978986+00	2026-10-11 15:09:50.978986+00
1610	2364	Physical	9.06	2026	Libristo	2026-10-11 15:09:51.063684+00	2026-10-11 15:09:51.063684+00
1611	1496	Physical	14.60	2026	Libristo	2026-10-11 15:09:51.076348+00	2026-10-11 15:09:51.076348+00
1612	1503	Physical	9.94	2026	Libristo	2026-10-11 15:09:51.16346+00	2026-10-11 15:09:51.16346+00
1613	1540	Physical	9.94	2026	Libristo	2026-10-11 15:09:51.174133+00	2026-10-11 15:09:51.174133+00
1614	1477	Physical	11.95	2026	Libristo	2026-10-11 15:09:51.259987+00	2026-10-11 15:09:51.259987+00
1615	2365	Physical	14.26	2026	Libristo	2026-10-11 15:09:51.271614+00	2026-10-11 15:09:51.271614+00
1616	2366	Physical	10.74	2026	Libristo	2026-10-11 15:09:51.284776+00	2026-10-11 15:09:51.284776+00
1617	2367	Physical	10.14	2026	Libristo	2026-10-11 15:09:51.363983+00	2026-10-11 15:09:51.363983+00
1618	2368	Physical	10.54	2026	Libristo	2026-10-11 15:09:51.377447+00	2026-10-11 15:09:51.377447+00
1619	2369	Physical	10.14	2026	Libristo	2026-10-11 15:09:51.387943+00	2026-10-11 15:09:51.387943+00
1620	2370	Physical	9.96	2026	Libristo	2026-10-11 15:09:51.468747+00	2026-10-11 15:09:51.468747+00
1621	2371	Physical	9.66	2026	Libristo	2026-10-11 15:09:51.564173+00	2026-10-11 15:09:51.564173+00
1622	2372	Physical	9.05	2026	Libristo	2026-10-11 15:09:51.579731+00	2026-10-11 15:09:51.579731+00
1623	1316	Physical	9.05	2026	Libristo	2026-10-11 15:09:51.664773+00	2026-10-11 15:09:51.664773+00
1624	2373	Physical	10.06	2026	Libristo	2026-10-11 15:09:51.758848+00	2026-10-11 15:09:51.758848+00
1625	2374	Physical	12.17	2026	Libristo	2026-10-11 15:09:51.778582+00	2026-10-11 15:09:51.778582+00
1626	2375	Physical	9.66	2026	Libristo	2026-10-11 15:09:51.865303+00	2026-10-11 15:09:51.865303+00
1627	1470	Physical	9.66	2026	Libristo	2026-10-11 15:09:51.877298+00	2026-10-11 15:09:51.877298+00
1628	2376	Physical	9.96	2026	Libristo	2026-10-11 15:09:51.965537+00	2026-10-11 15:09:51.965537+00
1629	2377	Physical	15.09	2026	Libristo	2026-10-11 15:09:51.977156+00	2026-10-11 15:09:51.977156+00
1630	1287	Physical	10.08	2026	Libristo	2026-10-11 15:09:52.060196+00	2026-10-11 15:09:52.060196+00
1631	2378	Physical	8.36	2026	Libristo	2026-10-11 15:09:52.076516+00	2026-10-11 15:09:52.076516+00
1632	1511	Physical	10.08	2026	Libristo	2026-10-11 15:09:52.162925+00	2026-10-11 15:09:52.162925+00
1633	2379	Physical	10.38	2026	Libristo	2026-10-11 15:09:52.258478+00	2026-10-11 15:09:52.258478+00
1634	2380	Physical	9.07	2026	Libristo	2026-10-11 15:09:52.272304+00	2026-10-11 15:09:52.272304+00
1635	2381	Physical	9.07	2026	Libristo	2026-10-11 15:09:52.360795+00	2026-10-11 15:09:52.360795+00
1636	2382	Physical	9.07	2026	Libristo	2026-10-11 15:09:52.37645+00	2026-10-11 15:09:52.37645+00
1637	2383	Physical	9.98	2026	Libristo	2026-10-11 15:09:52.458435+00	2026-10-11 15:09:52.458435+00
1638	1534	Physical	10.08	2026	Libristo	2026-10-11 15:09:52.469631+00	2026-10-11 15:09:52.469631+00
1639	2384	Physical	9.67	2026	Libristo	2026-10-11 15:09:52.560803+00	2026-10-11 15:09:52.560803+00
1640	1487	Physical	7.88	2026	Libristo	2026-10-11 15:09:52.655723+00	2026-10-11 15:09:52.655723+00
1641	2385	Physical	9.70	2026	Libristo	2026-10-11 15:09:52.672505+00	2026-10-11 15:09:52.672505+00
1642	2386	Physical	10.00	2026	Libristo	2026-10-11 15:09:52.76192+00	2026-10-11 15:09:52.76192+00
1643	2387	Physical	9.70	2026	Libristo	2026-10-11 15:09:52.776203+00	2026-10-11 15:09:52.776203+00
1644	2388	Physical	10.81	2026	Libristo	2026-10-11 15:09:52.860767+00	2026-10-11 15:09:52.860767+00
1645	1430	Physical	10.11	2026	Libristo	2026-10-11 15:09:52.870755+00	2026-10-11 15:09:52.870755+00
1646	1423	Physical	10.11	2026	Libristo	2026-10-11 15:09:52.880194+00	2026-10-11 15:09:52.880194+00
1647	2389	Physical	9.70	2026	Libristo	2026-10-11 15:09:52.963556+00	2026-10-11 15:09:52.963556+00
1648	2390	Physical	10.00	2026	Libristo	2026-10-11 15:09:52.974325+00	2026-10-11 15:09:52.974325+00
1649	2391	Physical	10.00	2026	Libristo	2026-10-11 15:09:52.985469+00	2026-10-11 15:09:52.985469+00
1650	2392	Physical	9.09	2026	Libristo	2026-10-11 15:09:53.065336+00	2026-10-11 15:09:53.065336+00
1651	2393	Physical	9.70	2026	Libristo	2026-10-11 15:09:53.076559+00	2026-10-11 15:09:53.076559+00
2201	2547	Ebook	\N	\N	\N	2026-10-11 15:10:13.458232+00	2026-10-11 15:10:13.458232+00
1652	2394	Physical	9.09	2026	Libristo	2026-10-11 15:09:53.155784+00	2026-10-11 15:09:53.155784+00
1653	1506	Physical	10.81	2026	Libristo	2026-10-11 15:09:53.165384+00	2026-10-11 15:09:53.165384+00
1654	1522	Physical	13.75	2026	Libristo	2026-10-11 15:09:53.174649+00	2026-10-11 15:09:53.174649+00
1655	1389	Physical	10.00	2025	Facebook	2026-10-11 15:09:53.258895+00	2026-10-11 15:09:53.258895+00
1656	1391	Physical	10.00	2025	Facebook	2026-10-11 15:09:53.268228+00	2026-10-11 15:09:53.268228+00
1657	1323	Physical	7.00	2025	Facebook	2026-10-11 15:09:53.276474+00	2026-10-11 15:09:53.276474+00
1658	1335	Physical	9.00	2025	Facebook	2026-10-11 15:09:53.359523+00	2026-10-11 15:09:53.359523+00
1659	2395	Physical	11.03	2025	Libristo	2026-10-11 15:09:53.371908+00	2026-10-11 15:09:53.371908+00
1660	1101	Physical	9.83	2025	Libristo	2026-10-11 15:09:53.38043+00	2026-10-11 15:09:53.38043+00
1661	1219	Physical	11.73	2025	Libristo	2026-10-11 15:09:53.46046+00	2026-10-11 15:09:53.46046+00
1662	1280	Physical	20.57	2025	Libristo	2026-10-11 15:09:53.469484+00	2026-10-11 15:09:53.469484+00
1663	1293	Physical	11.73	2025	Libristo	2026-10-11 15:09:53.478132+00	2026-10-11 15:09:53.478132+00
1664	1298	Physical	20.92	2025	Mladinska knjiga	2026-10-11 15:09:53.56293+00	2026-10-11 15:09:53.56293+00
1665	1381	Physical	12.86	2025	Mladinska knjiga	2026-10-11 15:09:53.572391+00	2026-10-11 15:09:53.572391+00
1666	1326	Physical	10.30	2025	Mladinska knjiga	2026-10-11 15:09:53.58178+00	2026-10-11 15:09:53.58178+00
1667	1328	Physical	0.00	2025	Gift	2026-10-11 15:09:53.659936+00	2026-10-11 15:09:53.659936+00
1668	1306	Physical	9.60	2025	Libristo	2026-10-11 15:09:53.669123+00	2026-10-11 15:09:53.669123+00
1669	1299	Physical	15.79	2025	Libristo	2026-10-11 15:09:53.677066+00	2026-10-11 15:09:53.677066+00
1670	1305	Physical	10.39	2025	Libristo	2026-10-11 15:09:53.758773+00	2026-10-11 15:09:53.758773+00
1671	1281	Physical	12.19	2025	Libristo	2026-10-11 15:09:53.7678+00	2026-10-11 15:09:53.7678+00
1672	1290	Physical	9.60	2025	Libristo	2026-10-11 15:09:53.776323+00	2026-10-11 15:09:53.776323+00
1673	1283	Physical	11.09	2025	Libristo	2026-10-11 15:09:53.859721+00	2026-10-11 15:09:53.859721+00
1674	1315	Physical	9.10	2025	Libristo	2026-10-11 15:09:53.875606+00	2026-10-11 15:09:53.875606+00
1675	1270	Physical	13.96	2025	Facebook	2026-10-11 15:09:53.965339+00	2026-10-11 15:09:53.965339+00
1676	920	Physical	8.46	2025	Facebook	2026-10-11 15:09:53.977634+00	2026-10-11 15:09:53.977634+00
1677	1403	Physical	9.46	2025	Facebook	2026-10-11 15:09:54.064756+00	2026-10-11 15:09:54.064756+00
1678	1367	Physical	6.50	2025	Interspar	2026-10-11 15:09:54.074546+00	2026-10-11 15:09:54.074546+00
1679	1371	Physical	7.80	2025	Libristo	2026-10-11 15:09:54.160415+00	2026-10-11 15:09:54.160415+00
1680	1338	Physical	6.59	2025	Libristo	2026-10-11 15:09:54.170117+00	2026-10-11 15:09:54.170117+00
1681	1434	Physical	7.80	2025	Libristo	2026-10-11 15:09:54.179966+00	2026-10-11 15:09:54.179966+00
1682	1386	Physical	7.80	2025	Libristo	2026-10-11 15:09:54.262125+00	2026-10-11 15:09:54.262125+00
1683	1365	Physical	8.60	2025	Libristo	2026-10-11 15:09:54.270932+00	2026-10-11 15:09:54.270932+00
1684	1420	Physical	10.51	2025	Libristo	2026-10-11 15:09:54.279745+00	2026-10-11 15:09:54.279745+00
1685	1363	Physical	10.51	2025	Libristo	2026-10-11 15:09:54.3647+00	2026-10-11 15:09:54.3647+00
1686	1379	Physical	5.50	2025	Facebook	2026-10-11 15:09:54.374644+00	2026-10-11 15:09:54.374644+00
1687	1346	Physical	8.34	2025	Libristo	2026-10-11 15:09:54.458634+00	2026-10-11 15:09:54.458634+00
1688	1318	Physical	8.34	2025	Libristo	2026-10-11 15:09:54.467866+00	2026-10-11 15:09:54.467866+00
1689	1373	Physical	9.16	2025	Libristo	2026-10-11 15:09:54.476757+00	2026-10-11 15:09:54.476757+00
1690	1234	Physical	8.34	2025	Libristo	2026-10-11 15:09:54.559371+00	2026-10-11 15:09:54.559371+00
1691	819	Physical	8.85	2025	Libristo	2026-10-11 15:09:54.570367+00	2026-10-11 15:09:54.570367+00
1692	1429	Physical	8.34	2025	Libristo	2026-10-11 15:09:54.658225+00	2026-10-11 15:09:54.658225+00
1693	1427	Physical	8.34	2025	Libristo	2026-10-11 15:09:54.667239+00	2026-10-11 15:09:54.667239+00
1694	1400	Physical	8.34	2025	Libristo	2026-10-11 15:09:54.676375+00	2026-10-11 15:09:54.676375+00
1695	1413	Physical	8.36	2025	Libristo	2026-10-11 15:09:54.758775+00	2026-10-11 15:09:54.758775+00
1696	1322	Physical	9.48	2025	Libristo	2026-10-11 15:09:54.769386+00	2026-10-11 15:09:54.769386+00
1697	1537	Physical	8.36	2025	Libristo	2026-10-11 15:09:54.780623+00	2026-10-11 15:09:54.780623+00
1698	1350	Physical	0.00	2025	Facebook	2026-10-11 15:09:54.863963+00	2026-10-11 15:09:54.863963+00
1699	1343	Physical	25.00	2025	Facebook	2026-10-11 15:09:54.874737+00	2026-10-11 15:09:54.874737+00
1700	1397	Physical	12.00	2025	Facebook	2026-10-11 15:09:54.965543+00	2026-10-11 15:09:54.965543+00
1701	1324	Physical	8.00	2025	Facebook	2026-10-11 15:09:55.05846+00	2026-10-11 15:09:55.05846+00
1702	1418	Physical	10.08	2025	Libristo	2026-10-11 15:09:55.075705+00	2026-10-11 15:09:55.075705+00
1703	1393	Physical	8.43	2025	Libristo	2026-10-11 15:09:55.161751+00	2026-10-11 15:09:55.161751+00
1704	1392	Physical	10.39	2025	Libristo	2026-10-11 15:09:55.178537+00	2026-10-11 15:09:55.178537+00
1705	1139	Physical	7.00	2025	Facebook	2026-10-11 15:09:55.264553+00	2026-10-11 15:09:55.264553+00
1706	1424	Physical	25.03	2025	Shakespeare & Company	2026-10-11 15:09:55.355477+00	2026-10-11 15:09:55.355477+00
1707	1103	Physical	9.10	2025	Libristo	2026-10-11 15:09:55.369632+00	2026-10-11 15:09:55.369632+00
1708	1396	Physical	9.30	2025	Libristo	2026-10-11 15:09:55.464147+00	2026-10-11 15:09:55.464147+00
1709	1398	Physical	8.47	2025	Libristo	2026-10-11 15:09:55.476421+00	2026-10-11 15:09:55.476421+00
1710	1419	Physical	8.47	2025	Libristo	2026-10-11 15:09:55.570866+00	2026-10-11 15:09:55.570866+00
1711	1415	Physical	8.47	2025	Libristo	2026-10-11 15:09:55.659485+00	2026-10-11 15:09:55.659485+00
1712	910	Physical	8.00	2025	Interliber	2026-10-11 15:09:55.677475+00	2026-10-11 15:09:55.677475+00
1713	1402	Physical	16.90	2025	Interliber	2026-10-11 15:09:55.761887+00	2026-10-11 15:09:55.761887+00
1714	800	Physical	7.00	2025	Interliber	2026-10-11 15:09:55.775559+00	2026-10-11 15:09:55.775559+00
1715	1432	Physical	7.40	2025	Interliber	2026-10-11 15:09:55.861804+00	2026-10-11 15:09:55.861804+00
1716	1276	Physical	8.46	2025	Libristo	2026-10-11 15:09:55.87245+00	2026-10-11 15:09:55.87245+00
1717	974	Physical	8.10	2025	Libristo	2026-10-11 15:09:55.957976+00	2026-10-11 15:09:55.957976+00
1718	1382	Physical	8.41	2025	Libristo	2026-10-11 15:09:55.969234+00	2026-10-11 15:09:55.969234+00
1719	1480	Physical	9.23	2025	Libristo	2026-10-11 15:09:56.055666+00	2026-10-11 15:09:56.055666+00
1720	890	Physical	3.05	2024	Wob	2026-10-11 15:09:56.066956+00	2026-10-11 15:09:56.066956+00
1721	1187	Physical	8.92	2024	Wob	2026-10-11 15:09:56.077356+00	2026-10-11 15:09:56.077356+00
1722	1405	Physical	8.92	2024	Wob	2026-10-11 15:09:56.159437+00	2026-10-11 15:09:56.159437+00
1723	1289	Physical	9.17	2024	Wob	2026-10-11 15:09:56.170583+00	2026-10-11 15:09:56.170583+00
1724	1124	Physical	11.37	2024	Wob	2026-10-11 15:09:56.1801+00	2026-10-11 15:09:56.1801+00
1725	1182	Physical	15.43	2024	Wob	2026-10-11 15:09:56.262541+00	2026-10-11 15:09:56.262541+00
1726	1142	Physical	13.53	2024	Wob	2026-10-11 15:09:56.271969+00	2026-10-11 15:09:56.271969+00
1727	1086	Physical	19.30	2024	Wob	2026-10-11 15:09:56.358864+00	2026-10-11 15:09:56.358864+00
1728	1149	Physical	13.22	2024	Wob	2026-10-11 15:09:56.371535+00	2026-10-11 15:09:56.371535+00
1729	1147	Physical	14.27	2024	Wob	2026-10-11 15:09:56.459214+00	2026-10-11 15:09:56.459214+00
1730	2396	Physical	5.42	2024	Wob	2026-10-11 15:09:56.470404+00	2026-10-11 15:09:56.470404+00
1731	1258	Physical	10.68	2024	Wob	2026-10-11 15:09:56.479406+00	2026-10-11 15:09:56.479406+00
1732	1194	Physical	10.10	2024	Wob	2026-10-11 15:09:56.561071+00	2026-10-11 15:09:56.561071+00
1733	1199	Physical	9.86	2024	Wob	2026-10-11 15:09:56.572529+00	2026-10-11 15:09:56.572529+00
1734	1214	Physical	14.19	2024	Wob	2026-10-11 15:09:56.660369+00	2026-10-11 15:09:56.660369+00
1735	1225	Physical	2.93	2024	Wob	2026-10-11 15:09:56.669913+00	2026-10-11 15:09:56.669913+00
1736	1312	Physical	7.38	2024	Wob	2026-10-11 15:09:56.679439+00	2026-10-11 15:09:56.679439+00
1737	780	Physical	9.13	2024	Wob	2026-10-11 15:09:56.762594+00	2026-10-11 15:09:56.762594+00
1738	2397	Physical	9.13	2024	Facebook	2026-10-11 15:09:56.776715+00	2026-10-11 15:09:56.776715+00
1739	823	Physical	9.13	2024	Facebook	2026-10-11 15:09:56.859472+00	2026-10-11 15:09:56.859472+00
1740	1232	Physical	2.92	2024	Wob	2026-10-11 15:09:56.869402+00	2026-10-11 15:09:56.869402+00
1741	1228	Physical	9.46	2024	Wob	2026-10-11 15:09:56.877972+00	2026-10-11 15:09:56.877972+00
1742	1135	Physical	9.69	2024	Wob	2026-10-11 15:09:56.960804+00	2026-10-11 15:09:56.960804+00
1743	1248	Physical	9.69	2024	Wob	2026-10-11 15:09:56.970368+00	2026-10-11 15:09:56.970368+00
1744	1162	Physical	16.21	2024	Blackwell's	2026-10-11 15:09:56.981535+00	2026-10-11 15:09:56.981535+00
1745	1191	Physical	12.58	2024	Blackwell's	2026-10-11 15:09:57.061712+00	2026-10-11 15:09:57.061712+00
1746	1247	Physical	11.00	2024	Facebook	2026-10-11 15:09:57.070847+00	2026-10-11 15:09:57.070847+00
1747	1236	Physical	9.00	2024	Facebook	2026-10-11 15:09:57.079788+00	2026-10-11 15:09:57.079788+00
1748	1274	Physical	7.00	2024	Facebook	2026-10-11 15:09:57.164297+00	2026-10-11 15:09:57.164297+00
1749	1366	Physical	8.00	2024	Facebook	2026-10-11 15:09:57.175846+00	2026-10-11 15:09:57.175846+00
1750	1278	Physical	10.00	2024	Facebook	2026-10-11 15:09:57.262303+00	2026-10-11 15:09:57.262303+00
1751	1110	Physical	9.00	2024	Facebook	2026-10-11 15:09:57.271583+00	2026-10-11 15:09:57.271583+00
1752	1414	Physical	9.00	2024	Facebook	2026-10-11 15:09:57.280622+00	2026-10-11 15:09:57.280622+00
1753	1301	Physical	9.00	2024	Facebook	2026-10-11 15:09:57.362837+00	2026-10-11 15:09:57.362837+00
1754	1409	Physical	6.90	2024	Interliber	2026-10-11 15:09:57.371581+00	2026-10-11 15:09:57.371581+00
1755	1438	Physical	8.00	2024	Interliber	2026-10-11 15:09:57.37988+00	2026-10-11 15:09:57.37988+00
1756	1271	Physical	10.55	2024	Interliber	2026-10-11 15:09:57.463037+00	2026-10-11 15:09:57.463037+00
1757	1370	Physical	10.00	2024	Interliber	2026-10-11 15:09:57.47212+00	2026-10-11 15:09:57.47212+00
1758	1333	Physical	5.00	2024	Interliber	2026-10-11 15:09:57.555715+00	2026-10-11 15:09:57.555715+00
1759	1269	Physical	10.20	2024	Interliber	2026-10-11 15:09:57.568844+00	2026-10-11 15:09:57.568844+00
1760	1143	Physical	10.20	2024	Interliber	2026-10-11 15:09:57.664523+00	2026-10-11 15:09:57.664523+00
1761	1265	Physical	10.20	2024	Interliber	2026-10-11 15:09:57.759335+00	2026-10-11 15:09:57.759335+00
1762	1344	Physical	7.50	2024	Interliber	2026-10-11 15:09:57.768514+00	2026-10-11 15:09:57.768514+00
1763	1342	Physical	25.00	2024	Interliber	2026-10-11 15:09:57.776541+00	2026-10-11 15:09:57.776541+00
1764	1267	Physical	19.80	2024	Znanje	2026-10-11 15:09:57.860001+00	2026-10-11 15:09:57.860001+00
1765	1254	Physical	13.20	2024	Znanje	2026-10-11 15:09:57.87033+00	2026-10-11 15:09:57.87033+00
1766	1169	Physical	10.00	2024	Wob	2026-10-11 15:09:57.87957+00	2026-10-11 15:09:57.87957+00
1767	1230	Physical	12.13	2024	Wob	2026-10-11 15:09:57.9605+00	2026-10-11 15:09:57.9605+00
1768	1202	Physical	8.25	2024	Wob	2026-10-11 15:09:57.970619+00	2026-10-11 15:09:57.970619+00
1769	1226	Physical	9.38	2024	Wob	2026-10-11 15:09:57.979889+00	2026-10-11 15:09:57.979889+00
1770	1178	Physical	13.00	2024	Facebook	2026-10-11 15:09:58.0623+00	2026-10-11 15:09:58.0623+00
1771	1076	Physical	11.50	2023	Book Depository	2026-10-11 15:09:58.070938+00	2026-10-11 15:09:58.070938+00
1772	1048	Physical	12.07	2023	Book Depository	2026-10-11 15:09:58.155649+00	2026-10-11 15:09:58.155649+00
1773	1109	Physical	12.41	2023	Book Depository	2026-10-11 15:09:58.165712+00	2026-10-11 15:09:58.165712+00
1774	1020	Physical	13.93	2023	Book Depository	2026-10-11 15:09:58.186022+00	2026-10-11 15:09:58.186022+00
1775	1070	Physical	9.00	2023	Book Depository	2026-10-11 15:09:58.257949+00	2026-10-11 15:09:58.257949+00
1776	1047	Physical	15.38	2023	Book Depository	2026-10-11 15:09:58.266801+00	2026-10-11 15:09:58.266801+00
1777	1063	Physical	15.83	2023	Book Depository	2026-10-11 15:09:58.275289+00	2026-10-11 15:09:58.275289+00
1778	1061	Physical	10.36	2023	Book Depository	2026-10-11 15:09:58.283477+00	2026-10-11 15:09:58.283477+00
1779	1075	Physical	8.98	2023	Book Depository	2026-10-11 15:09:58.363284+00	2026-10-11 15:09:58.363284+00
1780	1361	Physical	9.74	2023	Book Depository	2026-10-11 15:09:58.372298+00	2026-10-11 15:09:58.372298+00
1781	1242	Physical	9.94	2023	Book Depository	2026-10-11 15:09:58.455697+00	2026-10-11 15:09:58.455697+00
1782	1181	Physical	11.50	2023	Book Depository	2026-10-11 15:09:58.466021+00	2026-10-11 15:09:58.466021+00
1783	1069	Physical	11.08	2023	Book Depository	2026-10-11 15:09:58.476974+00	2026-10-11 15:09:58.476974+00
1784	1105	Physical	9.75	2023	Book Depository	2026-10-11 15:09:58.563669+00	2026-10-11 15:09:58.563669+00
1785	1138	Physical	9.57	2023	Book Depository	2026-10-11 15:09:58.572393+00	2026-10-11 15:09:58.572393+00
1786	1080	Physical	8.85	2023	Book Depository	2026-10-11 15:09:58.65564+00	2026-10-11 15:09:58.65564+00
1787	1104	Physical	13.65	2023	Book Depository	2026-10-11 15:09:58.665156+00	2026-10-11 15:09:58.665156+00
1788	1078	Physical	13.79	2023	Book Depository	2026-10-11 15:09:58.673961+00	2026-10-11 15:09:58.673961+00
1789	1027	Physical	12.39	2023	Wordery	2026-10-11 15:09:58.761747+00	2026-10-11 15:09:58.761747+00
1790	932	Physical	2.85	2023	Wob	2026-10-11 15:09:58.770577+00	2026-10-11 15:09:58.770577+00
1791	1369	Physical	8.09	2023	Wob	2026-10-11 15:09:58.779218+00	2026-10-11 15:09:58.779218+00
1792	1123	Physical	2.85	2023	Wob	2026-10-11 15:09:58.859654+00	2026-10-11 15:09:58.859654+00
1793	909	Physical	7.64	2023	Wob	2026-10-11 15:09:58.870494+00	2026-10-11 15:09:58.870494+00
1794	1013	Physical	7.75	2023	Wob	2026-10-11 15:09:58.879509+00	2026-10-11 15:09:58.879509+00
1795	1087	Physical	7.75	2023	Wob	2026-10-11 15:09:58.962005+00	2026-10-11 15:09:58.962005+00
1796	997	Physical	7.75	2023	Wob	2026-10-11 15:09:58.97061+00	2026-10-11 15:09:58.97061+00
1797	1114	Physical	7.75	2023	Wob	2026-10-11 15:09:58.97971+00	2026-10-11 15:09:58.97971+00
1798	1134	Physical	12.82	2023	Other	2026-10-11 15:09:59.06568+00	2026-10-11 15:09:59.06568+00
1799	1093	Physical	8.99	2023	Wordery	2026-10-11 15:09:59.074507+00	2026-10-11 15:09:59.074507+00
1800	1095	Physical	9.88	2023	Wob	2026-10-11 15:09:59.155617+00	2026-10-11 15:09:59.155617+00
1801	1155	Physical	2.87	2023	Wob	2026-10-11 15:09:59.165049+00	2026-10-11 15:09:59.165049+00
1802	804	Physical	2.87	2023	Wob	2026-10-11 15:09:59.176061+00	2026-10-11 15:09:59.176061+00
1803	1263	Physical	7.47	2023	Wob	2026-10-11 15:09:59.184649+00	2026-10-11 15:09:59.184649+00
1804	1229	Physical	7.70	2023	Wob	2026-10-11 15:09:59.262748+00	2026-10-11 15:09:59.262748+00
1805	1251	Physical	8.39	2023	Wob	2026-10-11 15:09:59.271361+00	2026-10-11 15:09:59.271361+00
1806	1014	Physical	8.39	2023	Wob	2026-10-11 15:09:59.279853+00	2026-10-11 15:09:59.279853+00
1807	1388	Physical	8.39	2023	Wob	2026-10-11 15:09:59.36297+00	2026-10-11 15:09:59.36297+00
1808	1083	Physical	8.33	2023	Wob	2026-10-11 15:09:59.372547+00	2026-10-11 15:09:59.372547+00
1809	1043	Physical	9.60	2023	Wob	2026-10-11 15:09:59.462765+00	2026-10-11 15:09:59.462765+00
1810	1038	Physical	8.10	2023	Wob	2026-10-11 15:09:59.473319+00	2026-10-11 15:09:59.473319+00
1811	1200	Physical	8.91	2023	Wob	2026-10-11 15:09:59.55996+00	2026-10-11 15:09:59.55996+00
1812	1136	Physical	8.56	2023	Wob	2026-10-11 15:09:59.569165+00	2026-10-11 15:09:59.569165+00
1813	1374	Physical	2.89	2023	Wob	2026-10-11 15:09:59.577402+00	2026-10-11 15:09:59.577402+00
1814	1131	Physical	2.89	2023	Wob	2026-10-11 15:09:59.661123+00	2026-10-11 15:09:59.661123+00
1815	1116	Physical	7.27	2023	Wob	2026-10-11 15:09:59.671713+00	2026-10-11 15:09:59.671713+00
1816	1077	Physical	9.34	2023	Wob	2026-10-11 15:09:59.680537+00	2026-10-11 15:09:59.680537+00
1817	781	Physical	6.91	2023	Wob	2026-10-11 15:09:59.763935+00	2026-10-11 15:09:59.763935+00
1818	1309	Physical	2.89	2023	Wob	2026-10-11 15:09:59.775226+00	2026-10-11 15:09:59.775226+00
1819	1310	Physical	6.93	2023	Wob	2026-10-11 15:09:59.863112+00	2026-10-11 15:09:59.863112+00
1820	1311	Physical	6.93	2023	Wob	2026-10-11 15:09:59.873638+00	2026-10-11 15:09:59.873638+00
1821	2398	Physical	6.93	2023	Wob	2026-10-11 15:09:59.964404+00	2026-10-11 15:09:59.964404+00
1822	2399	Physical	7.29	2023	Wob	2026-10-11 15:09:59.975695+00	2026-10-11 15:09:59.975695+00
1823	1141	Physical	2.88	2023	Wob	2026-10-11 15:09:59.985053+00	2026-10-11 15:09:59.985053+00
1824	1190	Physical	6.00	2023	Other	2026-10-11 15:10:00.063061+00	2026-10-11 15:10:00.063061+00
1825	2400	Physical	10.00	2023	Other	2026-10-11 15:10:00.078017+00	2026-10-11 15:10:00.078017+00
1826	917	Physical	5.55	2023	Wob	2026-10-11 15:10:00.162914+00	2026-10-11 15:10:00.162914+00
1827	1029	Physical	8.00	2023	Wob	2026-10-11 15:10:00.172875+00	2026-10-11 15:10:00.172875+00
1828	1133	Physical	7.90	2023	Wob	2026-10-11 15:10:00.259723+00	2026-10-11 15:10:00.259723+00
1829	1125	Physical	7.80	2023	Wob	2026-10-11 15:10:00.269762+00	2026-10-11 15:10:00.269762+00
1830	1145	Physical	7.90	2023	Wob	2026-10-11 15:10:00.279208+00	2026-10-11 15:10:00.279208+00
1831	1153	Physical	8.40	2023	Wob	2026-10-11 15:10:00.361025+00	2026-10-11 15:10:00.361025+00
1832	798	Physical	7.29	2023	Wob	2026-10-11 15:10:00.369628+00	2026-10-11 15:10:00.369628+00
1833	1358	Physical	8.40	2023	Wob	2026-10-11 15:10:00.378703+00	2026-10-11 15:10:00.378703+00
1834	900	Physical	5.12	2023	Facebook	2026-10-11 15:10:00.46137+00	2026-10-11 15:10:00.46137+00
1835	1044	Physical	7.85	2023	Wob	2026-10-11 15:10:00.470921+00	2026-10-11 15:10:00.470921+00
1836	1237	Physical	6.51	2023	Wob	2026-10-11 15:10:00.555653+00	2026-10-11 15:10:00.555653+00
1837	1130	Physical	9.72	2023	Wob	2026-10-11 15:10:00.565808+00	2026-10-11 15:10:00.565808+00
1838	964	Physical	10.03	2023	Wob	2026-10-11 15:10:00.57503+00	2026-10-11 15:10:00.57503+00
1839	2401	Physical	3.50	2023	Interliber	2026-10-11 15:10:00.666822+00	2026-10-11 15:10:00.666822+00
1840	852	Physical	10.00	2023	Facebook	2026-10-11 15:10:00.67625+00	2026-10-11 15:10:00.67625+00
1841	1152	Physical	8.00	2023	Facebook	2026-10-11 15:10:00.685631+00	2026-10-11 15:10:00.685631+00
1842	1203	Physical	5.00	2023	Facebook	2026-10-11 15:10:00.763937+00	2026-10-11 15:10:00.763937+00
1843	1164	Physical	7.70	2023	Wob	2026-10-11 15:10:00.775615+00	2026-10-11 15:10:00.775615+00
1844	1239	Physical	8.25	2023	Wob	2026-10-11 15:10:00.862459+00	2026-10-11 15:10:00.862459+00
1845	1117	Physical	8.68	2023	Wob	2026-10-11 15:10:00.872535+00	2026-10-11 15:10:00.872535+00
1846	1150	Physical	12.44	2023	Wob	2026-10-11 15:10:00.88163+00	2026-10-11 15:10:00.88163+00
1847	1167	Physical	8.25	2023	Wob	2026-10-11 15:10:00.967154+00	2026-10-11 15:10:00.967154+00
1848	1216	Physical	6.83	2023	Wob	2026-10-11 15:10:00.980206+00	2026-10-11 15:10:00.980206+00
1849	1159	Physical	9.01	2023	Wob	2026-10-11 15:10:01.063074+00	2026-10-11 15:10:01.063074+00
1850	978	Physical	7.05	2023	Wob	2026-10-11 15:10:01.072123+00	2026-10-11 15:10:01.072123+00
1851	1246	Physical	6.82	2023	Wob	2026-10-11 15:10:01.159136+00	2026-10-11 15:10:01.159136+00
1852	1233	Physical	6.83	2023	Wob	2026-10-11 15:10:01.16937+00	2026-10-11 15:10:01.16937+00
1853	791	Physical	6.83	2023	Wob	2026-10-11 15:10:01.179692+00	2026-10-11 15:10:01.179692+00
1854	1091	Physical	10.25	2022	Book Depository	2026-10-11 15:10:01.263208+00	2026-10-11 15:10:01.263208+00
1855	1353	Physical	9.40	2022	Book Depository	2026-10-11 15:10:01.272968+00	2026-10-11 15:10:01.272968+00
1856	1186	Physical	11.30	2022	Book Depository	2026-10-11 15:10:01.362691+00	2026-10-11 15:10:01.362691+00
1857	870	Physical	11.31	2022	Book Depository	2026-10-11 15:10:01.459882+00	2026-10-11 15:10:01.459882+00
1858	1220	Physical	14.54	2022	Book Depository	2026-10-11 15:10:01.473562+00	2026-10-11 15:10:01.473562+00
1859	1015	Physical	8.22	2022	Book Depository	2026-10-11 15:10:01.56257+00	2026-10-11 15:10:01.56257+00
1860	1180	Physical	10.05	2022	Book Depository	2026-10-11 15:10:01.573498+00	2026-10-11 15:10:01.573498+00
1861	942	Physical	11.87	2022	Book Depository	2026-10-11 15:10:01.662678+00	2026-10-11 15:10:01.662678+00
1862	2402	Physical	9.67	2022	Book Depository	2026-10-11 15:10:01.675781+00	2026-10-11 15:10:01.675781+00
1863	2403	Physical	6.64	2022	Facebook	2026-10-11 15:10:01.765227+00	2026-10-11 15:10:01.765227+00
1864	891	Physical	6.77	2022	Instagram @inlibrum	2026-10-11 15:10:01.778335+00	2026-10-11 15:10:01.778335+00
1865	1094	Physical	11.60	2022	Book Depository	2026-10-11 15:10:01.862888+00	2026-10-11 15:10:01.862888+00
1866	2404	Physical	10.05	2022	Book Depository	2026-10-11 15:10:01.882686+00	2026-10-11 15:10:01.882686+00
1867	854	Physical	10.43	2022	Book Depository	2026-10-11 15:10:01.96734+00	2026-10-11 15:10:01.96734+00
1868	1115	Physical	11.77	2022	Book Depository	2026-10-11 15:10:01.980507+00	2026-10-11 15:10:01.980507+00
1869	1006	Physical	10.36	2022	Book Depository	2026-10-11 15:10:02.069142+00	2026-10-11 15:10:02.069142+00
1870	1037	Physical	10.49	2022	Book Depository	2026-10-11 15:10:02.165192+00	2026-10-11 15:10:02.165192+00
1871	1240	Physical	9.47	2022	Book Depository	2026-10-11 15:10:02.178065+00	2026-10-11 15:10:02.178065+00
1872	895	Physical	10.84	2022	Book Depository	2026-10-11 15:10:02.278793+00	2026-10-11 15:10:02.278793+00
1873	971	Physical	10.84	2022	Book Depository	2026-10-11 15:10:02.362458+00	2026-10-11 15:10:02.362458+00
1874	1025	Physical	11.97	2022	Book Depository	2026-10-11 15:10:02.383593+00	2026-10-11 15:10:02.383593+00
1875	1001	Physical	11.52	2022	Book Depository	2026-10-11 15:10:02.464102+00	2026-10-11 15:10:02.464102+00
1876	950	Physical	10.95	2022	Book Depository	2026-10-11 15:10:02.555862+00	2026-10-11 15:10:02.555862+00
1877	944	Physical	9.98	2022	Book Depository	2026-10-11 15:10:02.57186+00	2026-10-11 15:10:02.57186+00
1878	1021	Physical	12.71	2022	Book Depository	2026-10-11 15:10:02.673507+00	2026-10-11 15:10:02.673507+00
1879	774	Physical	10.89	2022	Book Depository	2026-10-11 15:10:02.76037+00	2026-10-11 15:10:02.76037+00
1880	882	Physical	12.36	2022	Book Depository	2026-10-11 15:10:02.776522+00	2026-10-11 15:10:02.776522+00
1881	2405	Physical	13.53	2022	Svijet knjige	2026-10-11 15:10:02.87048+00	2026-10-11 15:10:02.87048+00
1882	1238	Physical	9.07	2022	Book Depository	2026-10-11 15:10:02.960204+00	2026-10-11 15:10:02.960204+00
1883	1296	Physical	7.50	2022	Book Depository	2026-10-11 15:10:02.97382+00	2026-10-11 15:10:02.97382+00
1884	1035	Physical	10.25	2022	Book Depository	2026-10-11 15:10:03.063149+00	2026-10-11 15:10:03.063149+00
1885	902	Physical	8.39	2022	Book Depository	2026-10-11 15:10:03.075294+00	2026-10-11 15:10:03.075294+00
1886	1066	Physical	9.78	2022	Book Depository	2026-10-11 15:10:03.163373+00	2026-10-11 15:10:03.163373+00
1887	1285	Physical	12.21	2022	Book Depository	2026-10-11 15:10:03.175053+00	2026-10-11 15:10:03.175053+00
1888	2406	Physical	15.25	2022	Book Depository	2026-10-11 15:10:03.267527+00	2026-10-11 15:10:03.267527+00
1889	989	Physical	11.07	2022	Book Depository	2026-10-11 15:10:03.280108+00	2026-10-11 15:10:03.280108+00
1890	970	Physical	10.47	2022	Book Depository	2026-10-11 15:10:03.365197+00	2026-10-11 15:10:03.365197+00
1891	1163	Physical	13.59	2022	Book Depository	2026-10-11 15:10:03.4557+00	2026-10-11 15:10:03.4557+00
1892	1330	Physical	13.66	2022	Book Depository	2026-10-11 15:10:03.467795+00	2026-10-11 15:10:03.467795+00
1893	1122	Physical	10.06	2022	Book Depository	2026-10-11 15:10:03.555702+00	2026-10-11 15:10:03.555702+00
1894	1241	Physical	9.81	2022	Book Depository	2026-10-11 15:10:03.565734+00	2026-10-11 15:10:03.565734+00
1895	1360	Physical	7.58	2022	Book Depository	2026-10-11 15:10:03.575763+00	2026-10-11 15:10:03.575763+00
1896	982	Physical	8.13	2022	Book Depository	2026-10-11 15:10:03.659892+00	2026-10-11 15:10:03.659892+00
1897	1264	Physical	7.52	2022	Book Depository	2026-10-11 15:10:03.67046+00	2026-10-11 15:10:03.67046+00
1898	1046	Physical	8.94	2022	Book Depository	2026-10-11 15:10:03.679233+00	2026-10-11 15:10:03.679233+00
1899	1045	Physical	11.81	2022	Book Depository	2026-10-11 15:10:03.76102+00	2026-10-11 15:10:03.76102+00
1900	1215	Physical	8.75	2022	Book Depository	2026-10-11 15:10:03.770914+00	2026-10-11 15:10:03.770914+00
1901	1050	Physical	3.98	2022	Interliber	2026-10-11 15:10:03.779628+00	2026-10-11 15:10:03.779628+00
1902	2407	Physical	15.79	2022	Interliber	2026-10-11 15:10:03.867447+00	2026-10-11 15:10:03.867447+00
1903	987	Physical	3.98	2022	Interliber	2026-10-11 15:10:03.876093+00	2026-10-11 15:10:03.876093+00
1904	2408	Physical	3.27	2021	Svijet knjige	2026-10-11 15:10:03.96509+00	2026-10-11 15:10:03.96509+00
1905	2409	Physical	3.27	2021	Svijet knjige	2026-10-11 15:10:03.976713+00	2026-10-11 15:10:03.976713+00
1906	2410	Physical	8.91	2021	Svijet knjige	2026-10-11 15:10:04.058617+00	2026-10-11 15:10:04.058617+00
1907	948	Physical	2.52	2021	Facebook	2026-10-11 15:10:04.069087+00	2026-10-11 15:10:04.069087+00
1908	2411	Physical	2.52	2021	Facebook	2026-10-11 15:10:04.080442+00	2026-10-11 15:10:04.080442+00
1909	2412	Physical	5.97	2021	Facebook	2026-10-11 15:10:04.168069+00	2026-10-11 15:10:04.168069+00
1910	885	Physical	3.71	2021	Tisak	2026-10-11 15:10:04.180245+00	2026-10-11 15:10:04.180245+00
1911	951	Physical	6.57	2021	Stilus webshop	2026-10-11 15:10:04.262082+00	2026-10-11 15:10:04.262082+00
1912	1036	Physical	11.06	2021	Stilus webshop	2026-10-11 15:10:04.271445+00	2026-10-11 15:10:04.271445+00
1913	1102	Physical	3.71	2021	Tisak Media Pothodnik	2026-10-11 15:10:04.28286+00	2026-10-11 15:10:04.28286+00
1914	958	Physical	2.78	2021	Tisak Media Pothodnik	2026-10-11 15:10:04.359779+00	2026-10-11 15:10:04.359779+00
1915	2413	Physical	6.77	2021	Facebook	2026-10-11 15:10:04.372494+00	2026-10-11 15:10:04.372494+00
1916	2414	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.464854+00	2026-10-11 15:10:04.464854+00
1917	2415	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.479463+00	2026-10-11 15:10:04.479463+00
1918	2416	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.491097+00	2026-10-11 15:10:04.491097+00
1919	2417	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.564464+00	2026-10-11 15:10:04.564464+00
1920	2418	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.578608+00	2026-10-11 15:10:04.578608+00
1921	2419	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.664546+00	2026-10-11 15:10:04.664546+00
1922	2420	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.676364+00	2026-10-11 15:10:04.676364+00
1923	2421	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.763847+00	2026-10-11 15:10:04.763847+00
1924	2422	Physical	2.92	2021	Facebook	2026-10-11 15:10:04.777293+00	2026-10-11 15:10:04.777293+00
1925	922	Physical	1.73	2021	Facebook (zamjena za Izgubljene djevojčice)	2026-10-11 15:10:04.863391+00	2026-10-11 15:10:04.863391+00
1926	930	Physical	7.96	2021	Facebook	2026-10-11 15:10:04.872466+00	2026-10-11 15:10:04.872466+00
1927	925	Physical	13.14	2021	Hoću knjigu Buzin	2026-10-11 15:10:04.961995+00	2026-10-11 15:10:04.961995+00
1928	2423	Physical	3.05	2021	Facebook	2026-10-11 15:10:05.055773+00	2026-10-11 15:10:05.055773+00
1929	2424	Physical	3.05	2021	Facebook	2026-10-11 15:10:05.07011+00	2026-10-11 15:10:05.07011+00
1930	2425	Physical	3.05	2021	Facebook	2026-10-11 15:10:05.161412+00	2026-10-11 15:10:05.161412+00
1931	911	Physical	9.16	2021	eKnjižara	2026-10-11 15:10:05.172784+00	2026-10-11 15:10:05.172784+00
1932	912	Physical	4.65	2021	eKnjižara	2026-10-11 15:10:05.181319+00	2026-10-11 15:10:05.181319+00
1933	916	Physical	4.65	2021	eKnjižara	2026-10-11 15:10:05.260138+00	2026-10-11 15:10:05.260138+00
1934	2426	Physical	3.32	2021	eKnjižara	2026-10-11 15:10:05.275764+00	2026-10-11 15:10:05.275764+00
1935	2427	Physical	3.32	2021	eKnjižara	2026-10-11 15:10:05.286295+00	2026-10-11 15:10:05.286295+00
1936	2428	Physical	3.32	2021	eKnjižara	2026-10-11 15:10:05.364705+00	2026-10-11 15:10:05.364705+00
1937	947	Physical	3.98	2021	eKnjižara	2026-10-11 15:10:05.373656+00	2026-10-11 15:10:05.373656+00
1938	954	Physical	3.98	2021	eKnjižara	2026-10-11 15:10:05.458918+00	2026-10-11 15:10:05.458918+00
1939	921	Physical	12.64	2021	Naklada Fragment webshop	2026-10-11 15:10:05.470696+00	2026-10-11 15:10:05.470696+00
1940	1412	Physical	27.34	2021	Book Depository	2026-10-11 15:10:05.558089+00	2026-10-11 15:10:05.558089+00
1941	980	Physical	0.00	2021	Svijet knjige	2026-10-11 15:10:05.574726+00	2026-10-11 15:10:05.574726+00
1942	875	Physical	7.84	2021	World of Books	2026-10-11 15:10:05.665208+00	2026-10-11 15:10:05.665208+00
1943	913	Physical	8.06	2021	World of Books	2026-10-11 15:10:05.674801+00	2026-10-11 15:10:05.674801+00
1944	926	Physical	6.94	2021	World of Books	2026-10-11 15:10:05.760848+00	2026-10-11 15:10:05.760848+00
1945	1112	Physical	6.64	2021	Facebook	2026-10-11 15:10:05.771055+00	2026-10-11 15:10:05.771055+00
1946	1008	Physical	0.00	2021	Facebook (zamjena za Plač)	2026-10-11 15:10:05.782028+00	2026-10-11 15:10:05.782028+00
1947	956	Physical	3.98	2021	Facebook	2026-10-11 15:10:05.863682+00	2026-10-11 15:10:05.863682+00
1948	2429	Physical	5.71	2021	Facebook	2026-10-11 15:10:05.876854+00	2026-10-11 15:10:05.876854+00
1949	1245	Physical	0.00	2021	darivanje kod @lost.in.books.and.dreaming	2026-10-11 15:10:05.965057+00	2026-10-11 15:10:05.965057+00
1950	2430	Physical	7.03	2021	Instagram (@libraryofpeculiar)	2026-10-11 15:10:05.980463+00	2026-10-11 15:10:05.980463+00
1951	2431	Physical	8.36	2021	Facebook	2026-10-11 15:10:06.064703+00	2026-10-11 15:10:06.064703+00
1952	2432	Physical	3.45	2021	Facebook	2026-10-11 15:10:06.078525+00	2026-10-11 15:10:06.078525+00
1953	2433	Physical	4.91	2021	Facebook	2026-10-11 15:10:06.165074+00	2026-10-11 15:10:06.165074+00
1954	972	Physical	9.56	2021	Book Depository	2026-10-11 15:10:06.178558+00	2026-10-11 15:10:06.178558+00
1955	1096	Physical	4.71	2021	Book Depository	2026-10-11 15:10:06.265212+00	2026-10-11 15:10:06.265212+00
1956	856	Physical	10.62	2021	Instagram (@djevojka_koja_je_citala)	2026-10-11 15:10:06.358503+00	2026-10-11 15:10:06.358503+00
1957	892	Physical	5.31	2021	Instagram (@life.couch)	2026-10-11 15:10:06.373656+00	2026-10-11 15:10:06.373656+00
1958	1118	Physical	1.99	2021	Hrabre njuške aukcija	2026-10-11 15:10:06.461964+00	2026-10-11 15:10:06.461964+00
1959	2434	Physical	6.64	2021	Hrabre njuške aukcija	2026-10-11 15:10:06.477757+00	2026-10-11 15:10:06.477757+00
1960	1221	Physical	3.98	2021	Hrabre njuške aukcija	2026-10-11 15:10:06.563185+00	2026-10-11 15:10:06.563185+00
1961	1039	Physical	5.31	2021	Facebook	2026-10-11 15:10:06.576671+00	2026-10-11 15:10:06.576671+00
1962	1321	Physical	5.31	2021	Facebook	2026-10-11 15:10:06.667328+00	2026-10-11 15:10:06.667328+00
1963	986	Physical	10.51	2021	Hoću knjigu Buzin	2026-10-11 15:10:06.761916+00	2026-10-11 15:10:06.761916+00
1964	2435	Physical	11.93	2021	Svijet knjige	2026-10-11 15:10:06.855781+00	2026-10-11 15:10:06.855781+00
1965	1064	Physical	\N	2021	Book Depository	2026-10-11 15:10:06.869519+00	2026-10-11 15:10:06.869519+00
1966	993	Physical	\N	2021	Book Depository	2026-10-11 15:10:06.962776+00	2026-10-11 15:10:06.962776+00
1967	946	Physical	\N	2021	Book Depository	2026-10-11 15:10:07.058855+00	2026-10-11 15:10:07.058855+00
1968	995	Physical	13.14	2021	Put rukopisa webshop	2026-10-11 15:10:07.075386+00	2026-10-11 15:10:07.075386+00
1969	2436	Physical	9.29	2021	Facebook	2026-10-11 15:10:07.171192+00	2026-10-11 15:10:07.171192+00
1970	1010	Physical	15.00	2021	Book Depository	2026-10-11 15:10:07.259642+00	2026-10-11 15:10:07.259642+00
1971	830	Physical	0.00	2021	Secret Spooky Scary Sceleton @shelf_full_of_books	2026-10-11 15:10:07.274257+00	2026-10-11 15:10:07.274257+00
1972	992	Physical	0.00	2021	#readinginmelody giveaway	2026-10-11 15:10:07.36516+00	2026-10-11 15:10:07.36516+00
1973	998	Physical	9.29	2021	Interliber	2026-10-11 15:10:07.45918+00	2026-10-11 15:10:07.45918+00
1974	2437	Physical	3.85	2021	Interliber	2026-10-11 15:10:07.475615+00	2026-10-11 15:10:07.475615+00
1975	983	Physical	13.27	2021	Interliber online (Znanje.hr)	2026-10-11 15:10:07.558402+00	2026-10-11 15:10:07.558402+00
1976	2438	Physical	14.73	2021	Interliber online (Znanje.hr)	2026-10-11 15:10:07.570934+00	2026-10-11 15:10:07.570934+00
1977	809	Physical	9.29	2021	Interliber online (Znanje.hr)	2026-10-11 15:10:07.658901+00	2026-10-11 15:10:07.658901+00
1978	1024	Physical	3.98	2021	Interliber online (Znanje.hr)	2026-10-11 15:10:07.670469+00	2026-10-11 15:10:07.670469+00
1979	984	Physical	3.98	2021	Interliber online (Znanje.hr)	2026-10-11 15:10:07.680117+00	2026-10-11 15:10:07.680117+00
1980	1175	Physical	29.46	2021	Facebook	2026-10-11 15:10:07.764146+00	2026-10-11 15:10:07.764146+00
1981	1193	Physical	\N	2021	Facebook	2026-10-11 15:10:07.774991+00	2026-10-11 15:10:07.774991+00
1982	1235	Physical	\N	2021	Facebook	2026-10-11 15:10:07.863648+00	2026-10-11 15:10:07.863648+00
1983	1244	Physical	\N	2021	Facebook	2026-10-11 15:10:07.95796+00	2026-10-11 15:10:07.95796+00
1984	1262	Physical	\N	2021	Facebook	2026-10-11 15:10:07.972716+00	2026-10-11 15:10:07.972716+00
1985	1307	Physical	\N	2021	Facebook	2026-10-11 15:10:08.061873+00	2026-10-11 15:10:08.061873+00
1986	862	Physical	34.03	2021	Awesome Books	2026-10-11 15:10:08.074953+00	2026-10-11 15:10:08.074953+00
1987	977	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.159249+00	2026-10-11 15:10:08.159249+00
1988	1217	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.1698+00	2026-10-11 15:10:08.1698+00
1989	813	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.179986+00	2026-10-11 15:10:08.179986+00
1990	2439	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.268077+00	2026-10-11 15:10:08.268077+00
1991	825	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.277723+00	2026-10-11 15:10:08.277723+00
1992	999	Physical	25.55	2021	Awesome Books	2026-10-11 15:10:08.362511+00	2026-10-11 15:10:08.362511+00
1993	1042	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.372324+00	2026-10-11 15:10:08.372324+00
1994	1012	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.459909+00	2026-10-11 15:10:08.459909+00
1995	1068	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.469794+00	2026-10-11 15:10:08.469794+00
1996	1120	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.479247+00	2026-10-11 15:10:08.479247+00
1997	872	Physical	\N	2021	Awesome Books	2026-10-11 15:10:08.565486+00	2026-10-11 15:10:08.565486+00
1998	996	Physical	66.21	2021	Book Depository	2026-10-11 15:10:08.659777+00	2026-10-11 15:10:08.659777+00
1999	1108	Physical	\N	2021	Book Depository	2026-10-11 15:10:08.669852+00	2026-10-11 15:10:08.669852+00
2000	955	Physical	\N	2021	Book Depository	2026-10-11 15:10:08.678968+00	2026-10-11 15:10:08.678968+00
2001	1183	Physical	\N	2021	Book Depository	2026-10-11 15:10:08.76175+00	2026-10-11 15:10:08.76175+00
2002	1005	Physical	\N	2021	Book Depository	2026-10-11 15:10:08.77233+00	2026-10-11 15:10:08.77233+00
2003	982	Physical	6.64	2021	Interliber online (Hangar7)	2026-10-11 15:10:08.858358+00	2026-10-11 15:10:08.858358+00
2004	966	Physical	13.27	2021	Facebook	2026-10-11 15:10:08.868206+00	2026-10-11 15:10:08.868206+00
2005	836	Physical	9.95	2021	Facebook	2026-10-11 15:10:08.877184+00	2026-10-11 15:10:08.877184+00
2006	772	Physical	2.92	2021	Facebook	2026-10-11 15:10:08.961737+00	2026-10-11 15:10:08.961737+00
2007	834	Physical	6.64	2021	Facebook aukcija	2026-10-11 15:10:08.973481+00	2026-10-11 15:10:08.973481+00
2008	1049	Physical	11.81	2021	Hoću knjigu Arena Centar	2026-10-11 15:10:08.984991+00	2026-10-11 15:10:08.984991+00
2009	822	Physical	5.30	2020	Tisak Media Centar Pothodnik	2026-10-11 15:10:09.072256+00	2026-10-11 15:10:09.072256+00
2010	2440	Physical	13.14	2020	Tisak Media Centar Pothodnik	2026-10-11 15:10:09.163703+00	2026-10-11 15:10:09.163703+00
2011	2441	Physical	10.53	2020	Fokus Webshop	2026-10-11 15:10:09.25567+00	2026-10-11 15:10:09.25567+00
2012	938	Physical	10.53	2020	Fokus Webshop	2026-10-11 15:10:09.269744+00	2026-10-11 15:10:09.269744+00
2013	776	Physical	9.55	2020	Book Depository	2026-10-11 15:10:09.360647+00	2026-10-11 15:10:09.360647+00
2014	873	Physical	9.08	2020	Book Depository	2026-10-11 15:10:09.374697+00	2026-10-11 15:10:09.374697+00
2015	2442	Physical	8.25	2020	Book Depository	2026-10-11 15:10:09.469214+00	2026-10-11 15:10:09.469214+00
2016	1084	Physical	6.57	2020	Book Depository	2026-10-11 15:10:09.561162+00	2026-10-11 15:10:09.561162+00
2017	835	Physical	7.68	2020	Book Depository	2026-10-11 15:10:09.580108+00	2026-10-11 15:10:09.580108+00
2018	860	Physical	3.32	2020	Svijet knjige	2026-10-11 15:10:09.668616+00	2026-10-11 15:10:09.668616+00
2019	827	Physical	0.00	2020	Svijet knjige	2026-10-11 15:10:09.759386+00	2026-10-11 15:10:09.759386+00
2020	831	Physical	0.00	2020	Svijet knjige	2026-10-11 15:10:09.778352+00	2026-10-11 15:10:09.778352+00
2021	853	Physical	0.00	2020	Svijet knjige	2026-10-11 15:10:09.863765+00	2026-10-11 15:10:09.863765+00
2022	2443	Physical	10.62	2020	Ljetni sajam knjiga	2026-10-11 15:10:09.966136+00	2026-10-11 15:10:09.966136+00
2023	839	Physical	9.29	2020	Ljetni sajam knjiga	2026-10-11 15:10:09.979656+00	2026-10-11 15:10:09.979656+00
2024	1074	Physical	0.00	2020	Ljetni sajam knjiga	2026-10-11 15:10:10.067674+00	2026-10-11 15:10:10.067674+00
2025	2444	Physical	2.65	2020	Ljetni sajam knjiga	2026-10-11 15:10:10.16299+00	2026-10-11 15:10:10.16299+00
2026	2445	Physical	2.65	2020	Ljetni sajam knjiga	2026-10-11 15:10:10.179312+00	2026-10-11 15:10:10.179312+00
2027	832	Physical	3.32	2020	Ljetni sajam knjiga	2026-10-11 15:10:10.26432+00	2026-10-11 15:10:10.26432+00
2028	1099	Physical	3.32	2020	Ljetni sajam knjiga	2026-10-11 15:10:10.275136+00	2026-10-11 15:10:10.275136+00
2029	829	Physical	5.31	2020	Ljetni sajam knjiga	2026-10-11 15:10:10.364173+00	2026-10-11 15:10:10.364173+00
2030	857	Physical	6.62	2020	Hoću knjigu Arena Centar	2026-10-11 15:10:10.378692+00	2026-10-11 15:10:10.378692+00
2031	880	Physical	6.50	2020	Svijet knjige	2026-10-11 15:10:10.463538+00	2026-10-11 15:10:10.463538+00
2032	807	Physical	6.02	2020	Book Depository	2026-10-11 15:10:10.47354+00	2026-10-11 15:10:10.47354+00
2033	965	Physical	7.13	2020	Book Depository	2026-10-11 15:10:10.560666+00	2026-10-11 15:10:10.560666+00
2034	2446	Physical	6.64	2020	Facebook	2026-10-11 15:10:10.576471+00	2026-10-11 15:10:10.576471+00
2035	2447	Physical	1.99	2020	Interspar Supernova	2026-10-11 15:10:10.666999+00	2026-10-11 15:10:10.666999+00
2036	2448	Physical	1.99	2020	Interspar Supernova	2026-10-11 15:10:10.679295+00	2026-10-11 15:10:10.679295+00
2037	858	Physical	10.49	2020	Man Art Avenue Mall	2026-10-11 15:10:10.761527+00	2026-10-11 15:10:10.761527+00
2038	1090	Physical	11.81	2020	Hoću knjigu Arena Centar	2026-10-11 15:10:10.772405+00	2026-10-11 15:10:10.772405+00
2039	2449	Physical	2.65	2020	Facebook	2026-10-11 15:10:10.858518+00	2026-10-11 15:10:10.858518+00
2040	2450	Physical	2.65	2020	Facebook	2026-10-11 15:10:10.871718+00	2026-10-11 15:10:10.871718+00
2041	2451	Physical	2.65	2020	Facebook	2026-10-11 15:10:10.884484+00	2026-10-11 15:10:10.884484+00
2042	2452	Physical	2.65	2020	Facebook	2026-10-11 15:10:10.965308+00	2026-10-11 15:10:10.965308+00
2043	864	Physical	3.98	2020	Facebook	2026-10-11 15:10:10.974784+00	2026-10-11 15:10:10.974784+00
2044	990	Physical	0.00	2020	poklon od @throneofbookaholic	2026-10-11 15:10:11.063236+00	2026-10-11 15:10:11.063236+00
2045	2453	Physical	2.65	2020	Facebook aukcija	2026-10-11 15:10:11.074945+00	2026-10-11 15:10:11.074945+00
2046	2454	Physical	4.65	2020	Facebook	2026-10-11 15:10:11.086319+00	2026-10-11 15:10:11.086319+00
2047	939	Physical	11.81	2020	Svijet knjige	2026-10-11 15:10:11.164105+00	2026-10-11 15:10:11.164105+00
2048	943	Physical	13.26	2020	Svijet knjige	2026-10-11 15:10:11.174291+00	2026-10-11 15:10:11.174291+00
2049	2455	Physical	3.32	2020	eKnjižara	2026-10-11 15:10:11.263027+00	2026-10-11 15:10:11.263027+00
2050	1126	Physical	3.32	2020	eKnjižara	2026-10-11 15:10:11.272898+00	2026-10-11 15:10:11.272898+00
2051	2456	Physical	5.31	2020	Facebook aukcija	2026-10-11 15:10:11.355834+00	2026-10-11 15:10:11.355834+00
2052	2457	Physical	5.97	2020	Facebook aukcija	2026-10-11 15:10:11.373038+00	2026-10-11 15:10:11.373038+00
2053	2458	Physical	1.99	2020	Facebook aukcija	2026-10-11 15:10:11.465726+00	2026-10-11 15:10:11.465726+00
2054	981	Physical	11.95	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.480561+00	2026-10-11 15:10:11.480561+00
2055	2459	Physical	1.33	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.570468+00	2026-10-11 15:10:11.570468+00
2056	901	Physical	2.65	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.660025+00	2026-10-11 15:10:11.660025+00
2057	962	Physical	10.51	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.673819+00	2026-10-11 15:10:11.673819+00
2058	941	Physical	6.57	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.763915+00	2026-10-11 15:10:11.763915+00
2059	869	Physical	10.51	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.774031+00	2026-10-11 15:10:11.774031+00
2060	883	Physical	9.48	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.858382+00	2026-10-11 15:10:11.858382+00
2061	1054	Physical	7.96	2020	Webliber - Znanje webshop	2026-10-11 15:10:11.870243+00	2026-10-11 15:10:11.870243+00
2062	886	Physical	0.00	2020	Darivanje @readinglist1	2026-10-11 15:10:11.961661+00	2026-10-11 15:10:11.961661+00
2063	2460	Physical	6.50	2020	Webliber - Egmont webshop	2026-10-11 15:10:11.980007+00	2026-10-11 15:10:11.980007+00
2064	899	Physical	6.50	2020	Webliber - Egmont webshop	2026-10-11 15:10:12.062046+00	2026-10-11 15:10:12.062046+00
2065	1082	Physical	5.18	2020	Interspar Supernova	2026-10-11 15:10:12.073897+00	2026-10-11 15:10:12.073897+00
2066	877	Physical	13.14	2020	Webliber - Hangar7 webshop	2026-10-11 15:10:12.166308+00	2026-10-11 15:10:12.166308+00
2067	1065	Physical	9.95	2020	Webliber - Hangar7 webshop	2026-10-11 15:10:12.25861+00	2026-10-11 15:10:12.25861+00
2068	2461	Physical	6.50	2020	Hrvatska pošta Dugave	2026-10-11 15:10:12.27908+00	2026-10-11 15:10:12.27908+00
2069	896	Physical	8.36	2020	Facebook	2026-10-11 15:10:12.362238+00	2026-10-11 15:10:12.362238+00
2070	1127	Physical	0.00	2020	poklon od @throneofbookaholic	2026-10-11 15:10:12.373125+00	2026-10-11 15:10:12.373125+00
2071	878	Physical	0.00	2020	poklon od @throneofbookaholic	2026-10-11 15:10:12.461179+00	2026-10-11 15:10:12.461179+00
2072	937	Physical	0.00	2020	Secret Santa od @deusirae.library	2026-10-11 15:10:12.474656+00	2026-10-11 15:10:12.474656+00
2073	2462	Physical	19.00	2026	Travel	2026-10-11 15:10:12.562963+00	2026-10-11 15:10:12.562963+00
2074	2463	Physical	21.24	2026	Travel	2026-10-11 15:10:12.66081+00	2026-10-11 15:10:12.66081+00
2075	2464	Physical	26.00	2026	Travel	2026-10-11 15:10:12.675251+00	2026-10-11 15:10:12.675251+00
2076	2465	Ebook	\N	\N	\N	2026-10-11 15:10:12.761538+00	2026-10-11 15:10:12.761538+00
2077	2466	Ebook	\N	\N	\N	2026-10-11 15:10:12.768307+00	2026-10-11 15:10:12.768307+00
2078	2467	Audiobook	\N	\N	\N	2026-10-11 15:10:12.773007+00	2026-10-11 15:10:12.773007+00
2079	2467	Ebook	\N	\N	\N	2026-10-11 15:10:12.775238+00	2026-10-11 15:10:12.775238+00
2080	2468	Audiobook	\N	\N	\N	2026-10-11 15:10:12.77977+00	2026-10-11 15:10:12.77977+00
2081	2468	Ebook	\N	\N	\N	2026-10-11 15:10:12.782396+00	2026-10-11 15:10:12.782396+00
2082	2370	Audiobook	\N	\N	\N	2026-10-11 15:10:12.784929+00	2026-10-11 15:10:12.784929+00
2083	2370	Ebook	\N	\N	\N	2026-10-11 15:10:12.787156+00	2026-10-11 15:10:12.787156+00
2085	2470	Audiobook	\N	\N	\N	2026-10-11 15:10:12.800156+00	2026-10-11 15:10:12.800156+00
2086	2470	Ebook	\N	\N	\N	2026-10-11 15:10:12.802583+00	2026-10-11 15:10:12.802583+00
2087	2471	Audiobook	\N	\N	\N	2026-10-11 15:10:12.809145+00	2026-10-11 15:10:12.809145+00
2088	2471	Ebook	\N	\N	\N	2026-10-11 15:10:12.811438+00	2026-10-11 15:10:12.811438+00
2089	2472	Audiobook	\N	\N	\N	2026-10-11 15:10:12.818497+00	2026-10-11 15:10:12.818497+00
2090	2472	Ebook	\N	\N	\N	2026-10-11 15:10:12.82077+00	2026-10-11 15:10:12.82077+00
2091	2473	Audiobook	\N	\N	\N	2026-10-11 15:10:12.825357+00	2026-10-11 15:10:12.825357+00
2092	2473	Ebook	\N	\N	\N	2026-10-11 15:10:12.827559+00	2026-10-11 15:10:12.827559+00
2093	2474	Audiobook	\N	\N	\N	2026-10-11 15:10:12.83267+00	2026-10-11 15:10:12.83267+00
2094	2474	Ebook	\N	\N	\N	2026-10-11 15:10:12.834951+00	2026-10-11 15:10:12.834951+00
2095	1509	Audiobook	\N	\N	\N	2026-10-11 15:10:12.837461+00	2026-10-11 15:10:12.837461+00
2096	1509	Ebook	\N	\N	\N	2026-10-11 15:10:12.839635+00	2026-10-11 15:10:12.839635+00
2097	2475	Ebook	\N	\N	\N	2026-10-11 15:10:12.845101+00	2026-10-11 15:10:12.845101+00
2098	2476	Audiobook	\N	\N	\N	2026-10-11 15:10:12.855445+00	2026-10-11 15:10:12.855445+00
2099	2476	Ebook	\N	\N	\N	2026-10-11 15:10:12.85785+00	2026-10-11 15:10:12.85785+00
2100	2477	Audiobook	\N	\N	\N	2026-10-11 15:10:12.862563+00	2026-10-11 15:10:12.862563+00
2101	2478	Ebook	\N	\N	\N	2026-10-11 15:10:12.867005+00	2026-10-11 15:10:12.867005+00
2102	2479	Ebook	\N	\N	\N	2026-10-11 15:10:12.872191+00	2026-10-11 15:10:12.872191+00
2103	2480	Audiobook	\N	\N	\N	2026-10-11 15:10:12.878966+00	2026-10-11 15:10:12.878966+00
2104	2480	Ebook	\N	\N	\N	2026-10-11 15:10:12.881414+00	2026-10-11 15:10:12.881414+00
2105	2481	Audiobook	\N	\N	\N	2026-10-11 15:10:12.88574+00	2026-10-11 15:10:12.88574+00
2106	2481	Ebook	\N	\N	\N	2026-10-11 15:10:12.887985+00	2026-10-11 15:10:12.887985+00
2107	2482	Ebook	\N	\N	\N	2026-10-11 15:10:12.892522+00	2026-10-11 15:10:12.892522+00
2108	2483	Ebook	\N	\N	\N	2026-10-11 15:10:12.89925+00	2026-10-11 15:10:12.89925+00
2109	2356	Ebook	\N	\N	\N	2026-10-11 15:10:12.90171+00	2026-10-11 15:10:12.90171+00
2110	2484	Audiobook	\N	\N	\N	2026-10-11 15:10:12.90855+00	2026-10-11 15:10:12.90855+00
2111	2484	Ebook	\N	\N	\N	2026-10-11 15:10:12.910815+00	2026-10-11 15:10:12.910815+00
2112	2485	Ebook	\N	\N	\N	2026-10-11 15:10:12.91536+00	2026-10-11 15:10:12.91536+00
2113	2486	Audiobook	\N	\N	\N	2026-10-11 15:10:12.91987+00	2026-10-11 15:10:12.91987+00
2114	2486	Ebook	\N	\N	\N	2026-10-11 15:10:12.922367+00	2026-10-11 15:10:12.922367+00
2115	2487	Audiobook	\N	\N	\N	2026-10-11 15:10:12.929209+00	2026-10-11 15:10:12.929209+00
2116	2487	Ebook	\N	\N	\N	2026-10-11 15:10:12.93188+00	2026-10-11 15:10:12.93188+00
2117	2488	Ebook	\N	\N	\N	2026-10-11 15:10:12.93858+00	2026-10-11 15:10:12.93858+00
2118	2489	Ebook	\N	\N	\N	2026-10-11 15:10:12.945716+00	2026-10-11 15:10:12.945716+00
2119	2490	Ebook	\N	\N	\N	2026-10-11 15:10:12.950222+00	2026-10-11 15:10:12.950222+00
2120	2491	Ebook	\N	\N	\N	2026-10-11 15:10:12.955436+00	2026-10-11 15:10:12.955436+00
2121	2492	Ebook	\N	\N	\N	2026-10-11 15:10:12.962185+00	2026-10-11 15:10:12.962185+00
2122	2493	Audiobook	\N	\N	\N	2026-10-11 15:10:12.96886+00	2026-10-11 15:10:12.96886+00
2123	2493	Ebook	\N	\N	\N	2026-10-11 15:10:12.971464+00	2026-10-11 15:10:12.971464+00
2124	2494	Ebook	\N	\N	\N	2026-10-11 15:10:12.976121+00	2026-10-11 15:10:12.976121+00
2125	2495	Ebook	\N	\N	\N	2026-10-11 15:10:12.982946+00	2026-10-11 15:10:12.982946+00
2126	2496	Audiobook	\N	\N	\N	2026-10-11 15:10:12.990511+00	2026-10-11 15:10:12.990511+00
2127	2496	Ebook	\N	\N	\N	2026-10-11 15:10:12.992905+00	2026-10-11 15:10:12.992905+00
2128	2497	Ebook	\N	\N	\N	2026-10-11 15:10:12.999597+00	2026-10-11 15:10:12.999597+00
2129	2498	Ebook	\N	\N	\N	2026-10-11 15:10:13.008484+00	2026-10-11 15:10:13.008484+00
2130	2499	Ebook	\N	\N	\N	2026-10-11 15:10:13.015235+00	2026-10-11 15:10:13.015235+00
2131	2500	Ebook	\N	\N	\N	2026-10-11 15:10:13.022928+00	2026-10-11 15:10:13.022928+00
2132	2501	Audiobook	\N	\N	\N	2026-10-11 15:10:13.027935+00	2026-10-11 15:10:13.027935+00
2133	2501	Ebook	\N	\N	\N	2026-10-11 15:10:13.030471+00	2026-10-11 15:10:13.030471+00
2134	2502	Audiobook	\N	\N	\N	2026-10-11 15:10:13.035116+00	2026-10-11 15:10:13.035116+00
2135	2502	Ebook	\N	\N	\N	2026-10-11 15:10:13.038801+00	2026-10-11 15:10:13.038801+00
2136	2503	Ebook	\N	\N	\N	2026-10-11 15:10:13.046253+00	2026-10-11 15:10:13.046253+00
2137	2504	Ebook	\N	\N	\N	2026-10-11 15:10:13.054539+00	2026-10-11 15:10:13.054539+00
2138	2505	Ebook	\N	\N	\N	2026-10-11 15:10:13.061615+00	2026-10-11 15:10:13.061615+00
2139	2506	Audiobook	\N	\N	\N	2026-10-11 15:10:13.069459+00	2026-10-11 15:10:13.069459+00
2140	2506	Ebook	\N	\N	\N	2026-10-11 15:10:13.071708+00	2026-10-11 15:10:13.071708+00
2141	2507	Ebook	\N	\N	\N	2026-10-11 15:10:13.076142+00	2026-10-11 15:10:13.076142+00
2142	2508	Ebook	\N	\N	\N	2026-10-11 15:10:13.084802+00	2026-10-11 15:10:13.084802+00
2143	2509	Ebook	\N	\N	\N	2026-10-11 15:10:13.095589+00	2026-10-11 15:10:13.095589+00
2144	2348	Ebook	\N	\N	\N	2026-10-11 15:10:13.098443+00	2026-10-11 15:10:13.098443+00
2145	2510	Audiobook	\N	\N	\N	2026-10-11 15:10:13.107224+00	2026-10-11 15:10:13.107224+00
2146	2510	Ebook	\N	\N	\N	2026-10-11 15:10:13.112737+00	2026-10-11 15:10:13.112737+00
2147	2511	Ebook	\N	\N	\N	2026-10-11 15:10:13.143959+00	2026-10-11 15:10:13.143959+00
2148	2512	Ebook	\N	\N	\N	2026-10-11 15:10:13.154691+00	2026-10-11 15:10:13.154691+00
2149	2513	Audiobook	\N	\N	\N	2026-10-11 15:10:13.159858+00	2026-10-11 15:10:13.159858+00
2150	2513	Ebook	\N	\N	\N	2026-10-11 15:10:13.162533+00	2026-10-11 15:10:13.162533+00
2151	2291	Audiobook	\N	\N	\N	2026-10-11 15:10:13.164941+00	2026-10-11 15:10:13.164941+00
2152	2514	Ebook	\N	\N	\N	2026-10-11 15:10:13.174474+00	2026-10-11 15:10:13.174474+00
2153	2515	Ebook	\N	\N	\N	2026-10-11 15:10:13.181654+00	2026-10-11 15:10:13.181654+00
2154	2516	Ebook	\N	\N	\N	2026-10-11 15:10:13.187428+00	2026-10-11 15:10:13.187428+00
2155	2517	Ebook	\N	\N	\N	2026-10-11 15:10:13.195172+00	2026-10-11 15:10:13.195172+00
2156	2518	Ebook	\N	\N	\N	2026-10-11 15:10:13.20457+00	2026-10-11 15:10:13.20457+00
2157	2519	Audiobook	\N	\N	\N	2026-10-11 15:10:13.213814+00	2026-10-11 15:10:13.213814+00
2158	2519	Ebook	\N	\N	\N	2026-10-11 15:10:13.216561+00	2026-10-11 15:10:13.216561+00
2159	2520	Ebook	\N	\N	\N	2026-10-11 15:10:13.222002+00	2026-10-11 15:10:13.222002+00
2160	2521	Audiobook	\N	\N	\N	2026-10-11 15:10:13.228886+00	2026-10-11 15:10:13.228886+00
2161	2521	Ebook	\N	\N	\N	2026-10-11 15:10:13.231159+00	2026-10-11 15:10:13.231159+00
2162	2522	Ebook	\N	\N	\N	2026-10-11 15:10:13.23877+00	2026-10-11 15:10:13.23877+00
2163	2523	Ebook	\N	\N	\N	2026-10-11 15:10:13.24545+00	2026-10-11 15:10:13.24545+00
2164	2524	Ebook	\N	\N	\N	2026-10-11 15:10:13.254966+00	2026-10-11 15:10:13.254966+00
2165	2342	Ebook	\N	\N	\N	2026-10-11 15:10:13.257505+00	2026-10-11 15:10:13.257505+00
2166	2525	Ebook	\N	\N	\N	2026-10-11 15:10:13.283339+00	2026-10-11 15:10:13.283339+00
2167	2526	Audiobook	\N	\N	\N	2026-10-11 15:10:13.295076+00	2026-10-11 15:10:13.295076+00
2168	2526	Ebook	\N	\N	\N	2026-10-11 15:10:13.29789+00	2026-10-11 15:10:13.29789+00
2169	2527	Ebook	\N	\N	\N	2026-10-11 15:10:13.309476+00	2026-10-11 15:10:13.309476+00
2170	2528	Audiobook	\N	\N	\N	2026-10-11 15:10:13.316385+00	2026-10-11 15:10:13.316385+00
2171	2528	Ebook	\N	\N	\N	2026-10-11 15:10:13.318727+00	2026-10-11 15:10:13.318727+00
2172	2529	Ebook	\N	\N	\N	2026-10-11 15:10:13.325848+00	2026-10-11 15:10:13.325848+00
2173	2530	Ebook	\N	\N	\N	2026-10-11 15:10:13.332764+00	2026-10-11 15:10:13.332764+00
2174	2531	Ebook	\N	\N	\N	2026-10-11 15:10:13.339519+00	2026-10-11 15:10:13.339519+00
2175	2532	Ebook	\N	\N	\N	2026-10-11 15:10:13.346839+00	2026-10-11 15:10:13.346839+00
2176	2293	Audiobook	\N	\N	\N	2026-10-11 15:10:13.350462+00	2026-10-11 15:10:13.350462+00
2177	2294	Audiobook	\N	\N	\N	2026-10-11 15:10:13.352666+00	2026-10-11 15:10:13.352666+00
2178	2533	Audiobook	\N	\N	\N	2026-10-11 15:10:13.357148+00	2026-10-11 15:10:13.357148+00
2179	2533	Ebook	\N	\N	\N	2026-10-11 15:10:13.359396+00	2026-10-11 15:10:13.359396+00
2180	2534	Ebook	\N	\N	\N	2026-10-11 15:10:13.364197+00	2026-10-11 15:10:13.364197+00
2181	2535	Audiobook	\N	\N	\N	2026-10-11 15:10:13.368914+00	2026-10-11 15:10:13.368914+00
2182	2535	Ebook	\N	\N	\N	2026-10-11 15:10:13.371471+00	2026-10-11 15:10:13.371471+00
2183	2536	Ebook	\N	\N	\N	2026-10-11 15:10:13.376024+00	2026-10-11 15:10:13.376024+00
2184	2537	Ebook	\N	\N	\N	2026-10-11 15:10:13.384953+00	2026-10-11 15:10:13.384953+00
2185	2538	Audiobook	\N	\N	\N	2026-10-11 15:10:13.391641+00	2026-10-11 15:10:13.391641+00
2186	2538	Ebook	\N	\N	\N	2026-10-11 15:10:13.393799+00	2026-10-11 15:10:13.393799+00
2187	2539	Ebook	\N	\N	\N	2026-10-11 15:10:13.400392+00	2026-10-11 15:10:13.400392+00
2188	2540	Audiobook	\N	\N	\N	2026-10-11 15:10:13.406925+00	2026-10-11 15:10:13.406925+00
2189	2540	Ebook	\N	\N	\N	2026-10-11 15:10:13.409013+00	2026-10-11 15:10:13.409013+00
2190	2541	Ebook	\N	\N	\N	2026-10-11 15:10:13.413519+00	2026-10-11 15:10:13.413519+00
2191	2542	Ebook	\N	\N	\N	2026-10-11 15:10:13.420346+00	2026-10-11 15:10:13.420346+00
2192	2369	Audiobook	\N	\N	\N	2026-10-11 15:10:13.422851+00	2026-10-11 15:10:13.422851+00
2193	2369	Ebook	\N	\N	\N	2026-10-11 15:10:13.425187+00	2026-10-11 15:10:13.425187+00
2194	2543	Audiobook	\N	\N	\N	2026-10-11 15:10:13.429645+00	2026-10-11 15:10:13.429645+00
2195	2543	Ebook	\N	\N	\N	2026-10-11 15:10:13.431955+00	2026-10-11 15:10:13.431955+00
2196	2544	Ebook	\N	\N	\N	2026-10-11 15:10:13.437137+00	2026-10-11 15:10:13.437137+00
2197	2545	Audiobook	\N	\N	\N	2026-10-11 15:10:13.442027+00	2026-10-11 15:10:13.442027+00
2198	2545	Ebook	\N	\N	\N	2026-10-11 15:10:13.444455+00	2026-10-11 15:10:13.444455+00
2199	2546	Audiobook	\N	\N	\N	2026-10-11 15:10:13.44886+00	2026-10-11 15:10:13.44886+00
2200	2546	Ebook	\N	\N	\N	2026-10-11 15:10:13.45141+00	2026-10-11 15:10:13.45141+00
2202	2548	Ebook	\N	\N	\N	2026-10-11 15:10:13.463364+00	2026-10-11 15:10:13.463364+00
2203	2549	Ebook	\N	\N	\N	2026-10-11 15:10:13.468034+00	2026-10-11 15:10:13.468034+00
2204	2550	Ebook	\N	\N	\N	2026-10-11 15:10:13.472558+00	2026-10-11 15:10:13.472558+00
2205	1511	Audiobook	\N	\N	\N	2026-10-11 15:10:13.474845+00	2026-10-11 15:10:13.474845+00
2206	1511	Ebook	\N	\N	\N	2026-10-11 15:10:13.476995+00	2026-10-11 15:10:13.476995+00
2207	2551	Audiobook	\N	\N	\N	2026-10-11 15:10:13.483345+00	2026-10-11 15:10:13.483345+00
2208	2551	Ebook	\N	\N	\N	2026-10-11 15:10:13.485526+00	2026-10-11 15:10:13.485526+00
2209	2552	Ebook	\N	\N	\N	2026-10-11 15:10:13.489985+00	2026-10-11 15:10:13.489985+00
2210	2553	Ebook	\N	\N	\N	2026-10-11 15:10:13.496507+00	2026-10-11 15:10:13.496507+00
2211	2554	Ebook	\N	\N	\N	2026-10-11 15:10:13.503129+00	2026-10-11 15:10:13.503129+00
2212	2555	Ebook	\N	\N	\N	2026-10-11 15:10:13.509823+00	2026-10-11 15:10:13.509823+00
2213	2556	Ebook	\N	\N	\N	2026-10-11 15:10:13.516472+00	2026-10-11 15:10:13.516472+00
2214	2557	Audiobook	\N	\N	\N	2026-10-11 15:10:13.523516+00	2026-10-11 15:10:13.523516+00
2215	2557	Ebook	\N	\N	\N	2026-10-11 15:10:13.525682+00	2026-10-11 15:10:13.525682+00
2216	2558	Audiobook	\N	\N	\N	2026-10-11 15:10:13.530051+00	2026-10-11 15:10:13.530051+00
2217	2558	Ebook	\N	\N	\N	2026-10-11 15:10:13.532152+00	2026-10-11 15:10:13.532152+00
2218	2559	Ebook	\N	\N	\N	2026-10-11 15:10:13.536957+00	2026-10-11 15:10:13.536957+00
2219	2560	Ebook	\N	\N	\N	2026-10-11 15:10:13.541961+00	2026-10-11 15:10:13.541961+00
2220	2561	Audiobook	\N	\N	\N	2026-10-11 15:10:13.549986+00	2026-10-11 15:10:13.549986+00
2221	2561	Ebook	\N	\N	\N	2026-10-11 15:10:13.552482+00	2026-10-11 15:10:13.552482+00
2222	2562	Ebook	\N	\N	\N	2026-10-11 15:10:13.556773+00	2026-10-11 15:10:13.556773+00
2223	2563	Ebook	\N	\N	\N	2026-10-11 15:10:13.564007+00	2026-10-11 15:10:13.564007+00
2224	2564	Ebook	\N	\N	\N	2026-10-11 15:10:13.568582+00	2026-10-11 15:10:13.568582+00
2225	2565	Ebook	\N	\N	\N	2026-10-11 15:10:13.573051+00	2026-10-11 15:10:13.573051+00
2226	2566	Ebook	\N	\N	\N	2026-10-11 15:10:13.577416+00	2026-10-11 15:10:13.577416+00
2227	2567	Audiobook	\N	\N	\N	2026-10-11 15:10:13.583844+00	2026-10-11 15:10:13.583844+00
2228	2567	Ebook	\N	\N	\N	2026-10-11 15:10:13.585944+00	2026-10-11 15:10:13.585944+00
2229	2568	Ebook	\N	\N	\N	2026-10-11 15:10:13.59093+00	2026-10-11 15:10:13.59093+00
2230	2569	Ebook	\N	\N	\N	2026-10-11 15:10:13.595611+00	2026-10-11 15:10:13.595611+00
2231	2296	Audiobook	\N	\N	\N	2026-10-11 15:10:13.597788+00	2026-10-11 15:10:13.597788+00
2232	2570	Ebook	\N	\N	\N	2026-10-11 15:10:13.604831+00	2026-10-11 15:10:13.604831+00
2233	2571	Ebook	\N	\N	\N	2026-10-11 15:10:13.611087+00	2026-10-11 15:10:13.611087+00
2234	2572	Ebook	\N	\N	\N	2026-10-11 15:10:13.617378+00	2026-10-11 15:10:13.617378+00
2235	2573	Ebook	\N	\N	\N	2026-10-11 15:10:13.62469+00	2026-10-11 15:10:13.62469+00
2236	2297	Audiobook	\N	\N	\N	2026-10-11 15:10:13.626833+00	2026-10-11 15:10:13.626833+00
2237	2298	Audiobook	\N	\N	\N	2026-10-11 15:10:13.62892+00	2026-10-11 15:10:13.62892+00
2238	2574	Audiobook	\N	\N	\N	2026-10-11 15:10:13.63343+00	2026-10-11 15:10:13.63343+00
2239	2575	Audiobook	\N	\N	\N	2026-10-11 15:10:13.638008+00	2026-10-11 15:10:13.638008+00
2240	2575	Ebook	\N	\N	\N	2026-10-11 15:10:13.640079+00	2026-10-11 15:10:13.640079+00
2241	2576	Ebook	\N	\N	\N	2026-10-11 15:10:13.644754+00	2026-10-11 15:10:13.644754+00
2242	2367	Audiobook	\N	\N	\N	2026-10-11 15:10:13.647493+00	2026-10-11 15:10:13.647493+00
2243	2367	Ebook	\N	\N	\N	2026-10-11 15:10:13.649794+00	2026-10-11 15:10:13.649794+00
2244	2577	Ebook	\N	\N	\N	2026-10-11 15:10:13.657209+00	2026-10-11 15:10:13.657209+00
2245	2578	Audiobook	\N	\N	\N	2026-10-11 15:10:13.663991+00	2026-10-11 15:10:13.663991+00
2246	2578	Ebook	\N	\N	\N	2026-10-11 15:10:13.666144+00	2026-10-11 15:10:13.666144+00
2247	2579	Ebook	\N	\N	\N	2026-10-11 15:10:13.670678+00	2026-10-11 15:10:13.670678+00
2248	2580	Ebook	\N	\N	\N	2026-10-11 15:10:13.677194+00	2026-10-11 15:10:13.677194+00
2249	2581	Ebook	\N	\N	\N	2026-10-11 15:10:13.684065+00	2026-10-11 15:10:13.684065+00
2250	2582	Audiobook	\N	\N	\N	2026-10-11 15:10:13.691134+00	2026-10-11 15:10:13.691134+00
2251	2582	Ebook	\N	\N	\N	2026-10-11 15:10:13.693285+00	2026-10-11 15:10:13.693285+00
2252	2583	Ebook	\N	\N	\N	2026-10-11 15:10:13.697586+00	2026-10-11 15:10:13.697586+00
2253	2584	Ebook	\N	\N	\N	2026-10-11 15:10:13.705028+00	2026-10-11 15:10:13.705028+00
2254	1531	Audiobook	\N	\N	\N	2026-10-11 15:10:13.707339+00	2026-10-11 15:10:13.707339+00
2255	1531	Ebook	\N	\N	\N	2026-10-11 15:10:13.709462+00	2026-10-11 15:10:13.709462+00
2256	2585	Ebook	\N	2026	\N	2026-10-11 15:10:13.715705+00	2026-10-11 15:10:13.715705+00
2257	2586	Ebook	\N	\N	\N	2026-10-11 15:10:13.719995+00	2026-10-11 15:10:13.719995+00
2258	2587	Audiobook	\N	\N	\N	2026-10-11 15:10:13.72422+00	2026-10-11 15:10:13.72422+00
2259	2587	Ebook	\N	\N	\N	2026-10-11 15:10:13.726295+00	2026-10-11 15:10:13.726295+00
2260	2588	Ebook	\N	\N	\N	2026-10-11 15:10:13.73295+00	2026-10-11 15:10:13.73295+00
2261	2589	Ebook	\N	\N	\N	2026-10-11 15:10:13.737709+00	2026-10-11 15:10:13.737709+00
2262	2590	Ebook	\N	\N	\N	2026-10-11 15:10:13.742106+00	2026-10-11 15:10:13.742106+00
2263	2591	Ebook	\N	\N	\N	2026-10-11 15:10:13.746503+00	2026-10-11 15:10:13.746503+00
2264	2592	Ebook	\N	\N	\N	2026-10-11 15:10:13.753069+00	2026-10-11 15:10:13.753069+00
2265	2593	Ebook	\N	\N	\N	2026-10-11 15:10:13.759684+00	2026-10-11 15:10:13.759684+00
2266	2594	Audiobook	\N	\N	\N	2026-10-11 15:10:13.764711+00	2026-10-11 15:10:13.764711+00
2267	2594	Ebook	\N	\N	\N	2026-10-11 15:10:13.766809+00	2026-10-11 15:10:13.766809+00
2268	2359	Audiobook	\N	\N	\N	2026-10-11 15:10:13.76888+00	2026-10-11 15:10:13.76888+00
2269	2359	Ebook	\N	\N	\N	2026-10-11 15:10:13.771007+00	2026-10-11 15:10:13.771007+00
2270	2303	Audiobook	\N	\N	\N	2026-10-11 15:10:13.773306+00	2026-10-11 15:10:13.773306+00
2271	2345	Audiobook	\N	\N	\N	2026-10-11 15:10:13.775401+00	2026-10-11 15:10:13.775401+00
2272	2345	Ebook	\N	\N	\N	2026-10-11 15:10:13.777487+00	2026-10-11 15:10:13.777487+00
2273	2595	Ebook	\N	\N	\N	2026-10-11 15:10:13.782218+00	2026-10-11 15:10:13.782218+00
2274	2596	Audiobook	\N	\N	\N	2026-10-11 15:10:13.786947+00	2026-10-11 15:10:13.786947+00
2275	2596	Ebook	\N	\N	\N	2026-10-11 15:10:13.789123+00	2026-10-11 15:10:13.789123+00
2276	2597	Ebook	\N	\N	\N	2026-10-11 15:10:13.796344+00	2026-10-11 15:10:13.796344+00
2277	2598	Ebook	\N	\N	\N	2026-10-11 15:10:13.802878+00	2026-10-11 15:10:13.802878+00
2278	2599	Ebook	\N	\N	\N	2026-10-11 15:10:13.809513+00	2026-10-11 15:10:13.809513+00
2279	2600	Ebook	\N	\N	\N	2026-10-11 15:10:13.816206+00	2026-10-11 15:10:13.816206+00
2280	1542	Ebook	\N	\N	\N	2026-10-11 15:10:13.818378+00	2026-10-11 15:10:13.818378+00
2281	2462	Audiobook	\N	\N	\N	2026-10-11 15:10:13.82047+00	2026-10-11 15:10:13.82047+00
2282	2462	Ebook	\N	\N	\N	2026-10-11 15:10:13.822812+00	2026-10-11 15:10:13.822812+00
2283	2339	Audiobook	\N	\N	\N	2026-10-11 15:10:13.824965+00	2026-10-11 15:10:13.824965+00
2284	2339	Ebook	\N	\N	\N	2026-10-11 15:10:13.827156+00	2026-10-11 15:10:13.827156+00
2285	2601	Ebook	\N	\N	\N	2026-10-11 15:10:13.831495+00	2026-10-11 15:10:13.831495+00
2286	2602	Ebook	\N	\N	\N	2026-10-11 15:10:13.835913+00	2026-10-11 15:10:13.835913+00
2287	2603	Ebook	\N	\N	\N	2026-10-11 15:10:13.842416+00	2026-10-11 15:10:13.842416+00
2288	2604	Ebook	\N	\N	\N	2026-10-11 15:10:13.848846+00	2026-10-11 15:10:13.848846+00
2289	2605	Ebook	\N	\N	\N	2026-10-11 15:10:13.855309+00	2026-10-11 15:10:13.855309+00
2290	2606	Ebook	\N	\N	\N	2026-10-11 15:10:13.862023+00	2026-10-11 15:10:13.862023+00
2291	2607	Ebook	\N	\N	\N	2026-10-11 15:10:13.868517+00	2026-10-11 15:10:13.868517+00
2292	2608	Ebook	\N	\N	\N	2026-10-11 15:10:13.873032+00	2026-10-11 15:10:13.873032+00
2293	2609	Audiobook	\N	\N	\N	2026-10-11 15:10:13.87938+00	2026-10-11 15:10:13.87938+00
2294	2609	Ebook	\N	\N	\N	2026-10-11 15:10:13.88154+00	2026-10-11 15:10:13.88154+00
2295	2610	Audiobook	\N	\N	\N	2026-10-11 15:10:13.887854+00	2026-10-11 15:10:13.887854+00
2296	2610	Ebook	\N	\N	\N	2026-10-11 15:10:13.890069+00	2026-10-11 15:10:13.890069+00
2297	2611	Ebook	\N	\N	\N	2026-10-11 15:10:13.897108+00	2026-10-11 15:10:13.897108+00
2298	2612	Ebook	\N	\N	\N	2026-10-11 15:10:13.904005+00	2026-10-11 15:10:13.904005+00
2299	2613	Audiobook	\N	\N	\N	2026-10-11 15:10:13.910761+00	2026-10-11 15:10:13.910761+00
2300	2613	Ebook	\N	\N	\N	2026-10-11 15:10:13.91297+00	2026-10-11 15:10:13.91297+00
2301	2614	Audiobook	\N	\N	\N	2026-10-11 15:10:13.918067+00	2026-10-11 15:10:13.918067+00
2302	2614	Ebook	\N	\N	\N	2026-10-11 15:10:13.920215+00	2026-10-11 15:10:13.920215+00
2303	2615	Audiobook	\N	\N	\N	2026-10-11 15:10:13.924882+00	2026-10-11 15:10:13.924882+00
2304	2615	Ebook	\N	\N	\N	2026-10-11 15:10:13.928145+00	2026-10-11 15:10:13.928145+00
2305	2616	Ebook	\N	\N	\N	2026-10-11 15:10:13.93271+00	2026-10-11 15:10:13.93271+00
2306	2617	Audiobook	\N	\N	\N	2026-10-11 15:10:13.939389+00	2026-10-11 15:10:13.939389+00
2307	2617	Ebook	\N	\N	\N	2026-10-11 15:10:13.94312+00	2026-10-11 15:10:13.94312+00
2308	2341	Ebook	\N	\N	\N	2026-10-11 15:10:13.945779+00	2026-10-11 15:10:13.945779+00
2309	2618	Ebook	\N	\N	\N	2026-10-11 15:10:13.950703+00	2026-10-11 15:10:13.950703+00
2310	2619	Audiobook	\N	\N	\N	2026-10-11 15:10:13.955492+00	2026-10-11 15:10:13.955492+00
2311	2619	Ebook	\N	\N	\N	2026-10-11 15:10:13.95763+00	2026-10-11 15:10:13.95763+00
2312	2620	Ebook	\N	\N	\N	2026-10-11 15:10:13.964484+00	2026-10-11 15:10:13.964484+00
2313	2621	Audiobook	\N	\N	\N	2026-10-11 15:10:13.970017+00	2026-10-11 15:10:13.970017+00
2314	2621	Ebook	\N	\N	\N	2026-10-11 15:10:13.97337+00	2026-10-11 15:10:13.97337+00
2315	2622	Ebook	\N	\N	\N	2026-10-11 15:10:13.980161+00	2026-10-11 15:10:13.980161+00
2316	2623	Audiobook	\N	\N	\N	2026-10-11 15:10:13.984802+00	2026-10-11 15:10:13.984802+00
2317	2623	Ebook	\N	\N	\N	2026-10-11 15:10:13.987092+00	2026-10-11 15:10:13.987092+00
2318	2624	Audiobook	\N	\N	\N	2026-10-11 15:10:13.994941+00	2026-10-11 15:10:13.994941+00
2319	2624	Ebook	\N	\N	\N	2026-10-11 15:10:13.99753+00	2026-10-11 15:10:13.99753+00
2320	2625	Ebook	\N	\N	\N	2026-10-11 15:10:14.01021+00	2026-10-11 15:10:14.01021+00
2321	2626	Ebook	\N	\N	\N	2026-10-11 15:10:14.017708+00	2026-10-11 15:10:14.017708+00
2322	2627	Ebook	\N	\N	\N	2026-10-11 15:10:14.033562+00	2026-10-11 15:10:14.033562+00
2323	2628	Ebook	\N	\N	\N	2026-10-11 15:10:14.040706+00	2026-10-11 15:10:14.040706+00
2324	2308	Audiobook	\N	\N	\N	2026-10-11 15:10:14.043232+00	2026-10-11 15:10:14.043232+00
2325	2629	Audiobook	\N	\N	\N	2026-10-11 15:10:14.047645+00	2026-10-11 15:10:14.047645+00
2326	2629	Ebook	\N	\N	\N	2026-10-11 15:10:14.049698+00	2026-10-11 15:10:14.049698+00
2327	2630	Audiobook	\N	\N	\N	2026-10-11 15:10:14.054752+00	2026-10-11 15:10:14.054752+00
2328	2630	Ebook	\N	\N	\N	2026-10-11 15:10:14.056827+00	2026-10-11 15:10:14.056827+00
2329	2309	Audiobook	\N	\N	\N	2026-10-11 15:10:14.058937+00	2026-10-11 15:10:14.058937+00
2330	2631	Audiobook	\N	\N	\N	2026-10-11 15:10:14.063472+00	2026-10-11 15:10:14.063472+00
2331	2631	Ebook	\N	\N	\N	2026-10-11 15:10:14.065616+00	2026-10-11 15:10:14.065616+00
2332	2310	Audiobook	\N	\N	\N	2026-10-11 15:10:14.067719+00	2026-10-11 15:10:14.067719+00
2333	2632	Ebook	\N	\N	\N	2026-10-11 15:10:14.072519+00	2026-10-11 15:10:14.072519+00
2334	2633	Ebook	\N	\N	\N	2026-10-11 15:10:14.078812+00	2026-10-11 15:10:14.078812+00
2335	2634	Ebook	\N	\N	\N	2026-10-11 15:10:14.083523+00	2026-10-11 15:10:14.083523+00
2336	2635	Audiobook	\N	\N	\N	2026-10-11 15:10:14.090179+00	2026-10-11 15:10:14.090179+00
2337	2635	Ebook	\N	\N	\N	2026-10-11 15:10:14.093039+00	2026-10-11 15:10:14.093039+00
2338	2636	Ebook	\N	\N	\N	2026-10-11 15:10:14.099601+00	2026-10-11 15:10:14.099601+00
2339	2637	Ebook	\N	\N	\N	2026-10-11 15:10:14.106228+00	2026-10-11 15:10:14.106228+00
2340	1538	Audiobook	\N	\N	\N	2026-10-11 15:10:14.108451+00	2026-10-11 15:10:14.108451+00
2341	1538	Ebook	\N	\N	\N	2026-10-11 15:10:14.110574+00	2026-10-11 15:10:14.110574+00
2342	2638	Ebook	\N	\N	\N	2026-10-11 15:10:14.116977+00	2026-10-11 15:10:14.116977+00
2343	2639	Ebook	\N	\N	\N	2026-10-11 15:10:14.121636+00	2026-10-11 15:10:14.121636+00
2344	1527	Ebook	\N	\N	\N	2026-10-11 15:10:14.123767+00	2026-10-11 15:10:14.123767+00
2345	2640	Ebook	\N	\N	\N	2026-10-11 15:10:14.130223+00	2026-10-11 15:10:14.130223+00
2346	2641	Audiobook	\N	\N	\N	2026-10-11 15:10:14.13516+00	2026-10-11 15:10:14.13516+00
2347	2641	Ebook	\N	\N	\N	2026-10-11 15:10:14.137427+00	2026-10-11 15:10:14.137427+00
2348	2642	Audiobook	\N	\N	\N	2026-10-11 15:10:14.144584+00	2026-10-11 15:10:14.144584+00
2349	2642	Ebook	\N	\N	\N	2026-10-11 15:10:14.146759+00	2026-10-11 15:10:14.146759+00
2350	2643	Audiobook	\N	\N	\N	2026-10-11 15:10:14.153188+00	2026-10-11 15:10:14.153188+00
2351	2643	Ebook	\N	\N	\N	2026-10-11 15:10:14.155547+00	2026-10-11 15:10:14.155547+00
2352	2644	Audiobook	\N	\N	\N	2026-10-11 15:10:14.162022+00	2026-10-11 15:10:14.162022+00
2353	2644	Ebook	\N	\N	\N	2026-10-11 15:10:14.164446+00	2026-10-11 15:10:14.164446+00
2354	2645	Audiobook	\N	\N	\N	2026-10-11 15:10:14.168724+00	2026-10-11 15:10:14.168724+00
2355	2645	Ebook	\N	\N	\N	2026-10-11 15:10:14.170802+00	2026-10-11 15:10:14.170802+00
2356	2646	Audiobook	\N	\N	\N	2026-10-11 15:10:14.175492+00	2026-10-11 15:10:14.175492+00
2357	2646	Ebook	\N	\N	\N	2026-10-11 15:10:14.178439+00	2026-10-11 15:10:14.178439+00
2358	2368	Ebook	\N	\N	\N	2026-10-11 15:10:14.180641+00	2026-10-11 15:10:14.180641+00
2359	2314	Audiobook	\N	\N	\N	2026-10-11 15:10:14.182769+00	2026-10-11 15:10:14.182769+00
2360	2357	Ebook	\N	\N	\N	2026-10-11 15:10:14.18496+00	2026-10-11 15:10:14.18496+00
2361	2647	Audiobook	\N	\N	\N	2026-10-11 15:10:14.192501+00	2026-10-11 15:10:14.192501+00
2362	2647	Ebook	\N	\N	\N	2026-10-11 15:10:14.195131+00	2026-10-11 15:10:14.195131+00
2363	2648	Ebook	\N	\N	\N	2026-10-11 15:10:14.200235+00	2026-10-11 15:10:14.200235+00
2364	2649	Ebook	\N	\N	\N	2026-10-11 15:10:14.207653+00	2026-10-11 15:10:14.207653+00
2365	2650	Ebook	\N	\N	\N	2026-10-11 15:10:14.214431+00	2026-10-11 15:10:14.214431+00
2366	2651	Audiobook	\N	\N	\N	2026-10-11 15:10:14.22104+00	2026-10-11 15:10:14.22104+00
2367	2651	Ebook	\N	\N	\N	2026-10-11 15:10:14.224188+00	2026-10-11 15:10:14.224188+00
2368	2652	Ebook	\N	\N	\N	2026-10-11 15:10:14.230793+00	2026-10-11 15:10:14.230793+00
2369	2653	Ebook	\N	\N	\N	2026-10-11 15:10:14.237957+00	2026-10-11 15:10:14.237957+00
2370	2654	Audiobook	\N	\N	\N	2026-10-11 15:10:14.242423+00	2026-10-11 15:10:14.242423+00
2371	2654	Ebook	\N	\N	\N	2026-10-11 15:10:14.244679+00	2026-10-11 15:10:14.244679+00
2372	2315	Audiobook	\N	\N	\N	2026-10-11 15:10:14.246781+00	2026-10-11 15:10:14.246781+00
2373	2655	Ebook	\N	\N	\N	2026-10-11 15:10:14.251489+00	2026-10-11 15:10:14.251489+00
2374	2656	Ebook	\N	\N	\N	2026-10-11 15:10:14.258452+00	2026-10-11 15:10:14.258452+00
2375	2657	Audiobook	\N	\N	\N	2026-10-11 15:10:14.265243+00	2026-10-11 15:10:14.265243+00
2376	2657	Ebook	\N	\N	\N	2026-10-11 15:10:14.268186+00	2026-10-11 15:10:14.268186+00
2377	2658	Ebook	\N	\N	\N	2026-10-11 15:10:14.27473+00	2026-10-11 15:10:14.27473+00
2378	2659	Audiobook	\N	\N	\N	2026-10-11 15:10:14.27918+00	2026-10-11 15:10:14.27918+00
2379	2659	Ebook	\N	\N	\N	2026-10-11 15:10:14.281565+00	2026-10-11 15:10:14.281565+00
2380	2660	Ebook	\N	\N	\N	2026-10-11 15:10:14.288152+00	2026-10-11 15:10:14.288152+00
2381	2661	Ebook	\N	\N	\N	2026-10-11 15:10:14.293423+00	2026-10-11 15:10:14.293423+00
2382	2662	Ebook	\N	\N	\N	2026-10-11 15:10:14.300062+00	2026-10-11 15:10:14.300062+00
2383	2663	Ebook	\N	\N	\N	2026-10-11 15:10:14.306943+00	2026-10-11 15:10:14.306943+00
2384	2664	Audiobook	\N	\N	\N	2026-10-11 15:10:14.313721+00	2026-10-11 15:10:14.313721+00
2385	2664	Ebook	\N	\N	\N	2026-10-11 15:10:14.316279+00	2026-10-11 15:10:14.316279+00
2386	2665	Ebook	\N	\N	\N	2026-10-11 15:10:14.322803+00	2026-10-11 15:10:14.322803+00
2387	2666	Ebook	\N	\N	\N	2026-10-11 15:10:14.327315+00	2026-10-11 15:10:14.327315+00
2388	2667	Ebook	\N	\N	\N	2026-10-11 15:10:14.332203+00	2026-10-11 15:10:14.332203+00
2389	2668	Audiobook	\N	\N	\N	2026-10-11 15:10:14.33674+00	2026-10-11 15:10:14.33674+00
2390	2668	Ebook	\N	\N	\N	2026-10-11 15:10:14.338803+00	2026-10-11 15:10:14.338803+00
2391	2668	Ebook	\N	\N	\N	2026-10-11 15:10:14.340871+00	2026-10-11 15:10:14.340871+00
2392	2669	Ebook	\N	\N	\N	2026-10-11 15:10:14.345505+00	2026-10-11 15:10:14.345505+00
2393	2670	Audiobook	\N	\N	\N	2026-10-11 15:10:14.351996+00	2026-10-11 15:10:14.351996+00
2394	2670	Ebook	\N	\N	\N	2026-10-11 15:10:14.354066+00	2026-10-11 15:10:14.354066+00
2395	2671	Ebook	\N	\N	\N	2026-10-11 15:10:14.360354+00	2026-10-11 15:10:14.360354+00
2396	2672	Ebook	\N	\N	\N	2026-10-11 15:10:14.366677+00	2026-10-11 15:10:14.366677+00
2397	2673	Ebook	\N	\N	\N	2026-10-11 15:10:14.370949+00	2026-10-11 15:10:14.370949+00
2398	2354	Ebook	\N	\N	\N	2026-10-11 15:10:14.373111+00	2026-10-11 15:10:14.373111+00
2399	2674	Audiobook	\N	\N	\N	2026-10-11 15:10:14.37938+00	2026-10-11 15:10:14.37938+00
2400	2674	Ebook	\N	\N	\N	2026-10-11 15:10:14.381691+00	2026-10-11 15:10:14.381691+00
2401	2675	Ebook	\N	\N	\N	2026-10-11 15:10:14.388216+00	2026-10-11 15:10:14.388216+00
2402	2676	Ebook	\N	\N	\N	2026-10-11 15:10:14.394974+00	2026-10-11 15:10:14.394974+00
2403	2391	Audiobook	\N	\N	\N	2026-10-11 15:10:14.39718+00	2026-10-11 15:10:14.39718+00
2404	2391	Ebook	\N	\N	\N	2026-10-11 15:10:14.399339+00	2026-10-11 15:10:14.399339+00
2405	2390	Ebook	\N	\N	\N	2026-10-11 15:10:14.401594+00	2026-10-11 15:10:14.401594+00
2406	2677	Ebook	\N	\N	\N	2026-10-11 15:10:14.408011+00	2026-10-11 15:10:14.408011+00
2407	2678	Audiobook	\N	\N	\N	2026-10-11 15:10:14.415012+00	2026-10-11 15:10:14.415012+00
2408	2678	Ebook	\N	\N	\N	2026-10-11 15:10:14.41735+00	2026-10-11 15:10:14.41735+00
2409	2679	Ebook	\N	\N	\N	2026-10-11 15:10:14.424832+00	2026-10-11 15:10:14.424832+00
2410	2680	Ebook	\N	\N	\N	2026-10-11 15:10:14.431743+00	2026-10-11 15:10:14.431743+00
2411	2681	Ebook	\N	\N	\N	2026-10-11 15:10:14.438254+00	2026-10-11 15:10:14.438254+00
2412	2682	Ebook	\N	\N	\N	2026-10-11 15:10:14.444547+00	2026-10-11 15:10:14.444547+00
2413	2373	Audiobook	\N	\N	\N	2026-10-11 15:10:14.446692+00	2026-10-11 15:10:14.446692+00
2414	2373	Ebook	\N	\N	\N	2026-10-11 15:10:14.448763+00	2026-10-11 15:10:14.448763+00
2415	2683	Ebook	\N	\N	\N	2026-10-11 15:10:14.453635+00	2026-10-11 15:10:14.453635+00
2416	2684	Ebook	\N	\N	\N	2026-10-11 15:10:14.457992+00	2026-10-11 15:10:14.457992+00
2417	2685	Ebook	\N	\N	\N	2026-10-11 15:10:14.463153+00	2026-10-11 15:10:14.463153+00
2418	2686	Audiobook	\N	\N	\N	2026-10-11 15:10:14.470365+00	2026-10-11 15:10:14.470365+00
2419	2686	Ebook	\N	\N	\N	2026-10-11 15:10:14.475167+00	2026-10-11 15:10:14.475167+00
2420	2687	Audiobook	\N	\N	\N	2026-10-11 15:10:14.47954+00	2026-10-11 15:10:14.47954+00
2421	2687	Ebook	\N	\N	\N	2026-10-11 15:10:14.482112+00	2026-10-11 15:10:14.482112+00
2422	2688	Ebook	\N	\N	\N	2026-10-11 15:10:14.486486+00	2026-10-11 15:10:14.486486+00
2423	2318	Audiobook	\N	\N	\N	2026-10-11 15:10:14.488588+00	2026-10-11 15:10:14.488588+00
2424	2689	Ebook	\N	\N	\N	2026-10-11 15:10:14.493196+00	2026-10-11 15:10:14.493196+00
2425	2690	Ebook	\N	\N	\N	2026-10-11 15:10:14.499947+00	2026-10-11 15:10:14.499947+00
2426	2691	Ebook	\N	\N	\N	2026-10-11 15:10:14.506898+00	2026-10-11 15:10:14.506898+00
2427	2692	Ebook	\N	\N	\N	2026-10-11 15:10:14.513667+00	2026-10-11 15:10:14.513667+00
2428	2349	Ebook	\N	\N	\N	2026-10-11 15:10:14.515732+00	2026-10-11 15:10:14.515732+00
2429	2693	Audiobook	\N	\N	\N	2026-10-11 15:10:14.520197+00	2026-10-11 15:10:14.520197+00
2430	2693	Ebook	\N	\N	\N	2026-10-11 15:10:14.522412+00	2026-10-11 15:10:14.522412+00
2431	2694	Ebook	\N	\N	\N	2026-10-11 15:10:14.528918+00	2026-10-11 15:10:14.528918+00
2432	2695	Ebook	\N	\N	\N	2026-10-11 15:10:14.535406+00	2026-10-11 15:10:14.535406+00
2433	2696	Ebook	\N	\N	\N	2026-10-11 15:10:14.54217+00	2026-10-11 15:10:14.54217+00
2434	2697	Ebook	\N	\N	\N	2026-10-11 15:10:14.549033+00	2026-10-11 15:10:14.549033+00
2435	2698	Audiobook	\N	\N	\N	2026-10-11 15:10:14.555855+00	2026-10-11 15:10:14.555855+00
2436	2698	Ebook	\N	\N	\N	2026-10-11 15:10:14.557979+00	2026-10-11 15:10:14.557979+00
2437	2699	Ebook	\N	\N	\N	2026-10-11 15:10:14.567147+00	2026-10-11 15:10:14.567147+00
2438	2700	Ebook	\N	\N	\N	2026-10-11 15:10:14.573922+00	2026-10-11 15:10:14.573922+00
2439	2701	Audiobook	\N	\N	\N	2026-10-11 15:10:14.578327+00	2026-10-11 15:10:14.578327+00
2440	2701	Ebook	\N	\N	\N	2026-10-11 15:10:14.580488+00	2026-10-11 15:10:14.580488+00
2441	2702	Ebook	\N	\N	\N	2026-10-11 15:10:14.587164+00	2026-10-11 15:10:14.587164+00
2442	2703	Audiobook	\N	\N	\N	2026-10-11 15:10:14.594491+00	2026-10-11 15:10:14.594491+00
2443	2703	Ebook	\N	\N	\N	2026-10-11 15:10:14.596885+00	2026-10-11 15:10:14.596885+00
2444	2704	Ebook	\N	\N	\N	2026-10-11 15:10:14.604535+00	2026-10-11 15:10:14.604535+00
2445	2705	Audiobook	\N	\N	\N	2026-10-11 15:10:14.609018+00	2026-10-11 15:10:14.609018+00
2446	2705	Ebook	\N	\N	\N	2026-10-11 15:10:14.611708+00	2026-10-11 15:10:14.611708+00
2447	2320	Audiobook	\N	\N	\N	2026-10-11 15:10:14.613885+00	2026-10-11 15:10:14.613885+00
2448	2706	Ebook	\N	\N	\N	2026-10-11 15:10:14.618538+00	2026-10-11 15:10:14.618538+00
2449	2707	Audiobook	\N	\N	\N	2026-10-11 15:10:14.623168+00	2026-10-11 15:10:14.623168+00
2450	2707	Ebook	\N	\N	\N	2026-10-11 15:10:14.625489+00	2026-10-11 15:10:14.625489+00
2451	2708	Ebook	\N	\N	\N	2026-10-11 15:10:14.632417+00	2026-10-11 15:10:14.632417+00
2452	2709	Ebook	\N	\N	\N	2026-10-11 15:10:14.639009+00	2026-10-11 15:10:14.639009+00
2453	2340	Ebook	\N	\N	\N	2026-10-11 15:10:14.64155+00	2026-10-11 15:10:14.64155+00
2454	2710	Ebook	\N	\N	\N	2026-10-11 15:10:14.648086+00	2026-10-11 15:10:14.648086+00
2455	2711	Ebook	\N	\N	\N	2026-10-11 15:10:14.661983+00	2026-10-11 15:10:14.661983+00
2456	2712	Ebook	\N	\N	\N	2026-10-11 15:10:14.668371+00	2026-10-11 15:10:14.668371+00
2457	2713	Ebook	\N	\N	\N	2026-10-11 15:10:14.675107+00	2026-10-11 15:10:14.675107+00
2458	2714	Ebook	\N	\N	\N	2026-10-11 15:10:14.681682+00	2026-10-11 15:10:14.681682+00
2459	2715	Ebook	\N	\N	\N	2026-10-11 15:10:14.686171+00	2026-10-11 15:10:14.686171+00
2460	2716	Audiobook	\N	\N	\N	2026-10-11 15:10:14.693624+00	2026-10-11 15:10:14.693624+00
2461	2716	Ebook	\N	\N	\N	2026-10-11 15:10:14.695852+00	2026-10-11 15:10:14.695852+00
2462	2323	Audiobook	\N	\N	\N	2026-10-11 15:10:14.698047+00	2026-10-11 15:10:14.698047+00
2463	2717	Ebook	\N	\N	\N	2026-10-11 15:10:14.704877+00	2026-10-11 15:10:14.704877+00
2464	2718	Ebook	\N	\N	\N	2026-10-11 15:10:14.71188+00	2026-10-11 15:10:14.71188+00
2465	2719	Audiobook	\N	\N	\N	2026-10-11 15:10:14.718934+00	2026-10-11 15:10:14.718934+00
2466	2719	Ebook	\N	\N	\N	2026-10-11 15:10:14.721077+00	2026-10-11 15:10:14.721077+00
2467	2720	Audiobook	\N	\N	\N	2026-10-11 15:10:14.725568+00	2026-10-11 15:10:14.725568+00
2468	2720	Ebook	\N	\N	\N	2026-10-11 15:10:14.727686+00	2026-10-11 15:10:14.727686+00
2469	2721	Audiobook	\N	\N	\N	2026-10-11 15:10:14.734167+00	2026-10-11 15:10:14.734167+00
2470	2721	Ebook	\N	\N	\N	2026-10-11 15:10:14.73747+00	2026-10-11 15:10:14.73747+00
2471	2722	Ebook	\N	\N	\N	2026-10-11 15:10:14.744167+00	2026-10-11 15:10:14.744167+00
2472	2324	Audiobook	\N	\N	\N	2026-10-11 15:10:14.746345+00	2026-10-11 15:10:14.746345+00
2473	2723	Audiobook	\N	\N	\N	2026-10-11 15:10:14.752795+00	2026-10-11 15:10:14.752795+00
2474	2723	Ebook	\N	\N	\N	2026-10-11 15:10:14.754911+00	2026-10-11 15:10:14.754911+00
2475	2724	Ebook	\N	\N	\N	2026-10-11 15:10:14.761369+00	2026-10-11 15:10:14.761369+00
2476	2725	Ebook	\N	\N	\N	2026-10-11 15:10:14.765889+00	2026-10-11 15:10:14.765889+00
2477	2726	Ebook	\N	\N	\N	2026-10-11 15:10:14.772772+00	2026-10-11 15:10:14.772772+00
2478	2727	Audiobook	\N	\N	\N	2026-10-11 15:10:14.777111+00	2026-10-11 15:10:14.777111+00
2479	2727	Ebook	\N	\N	\N	2026-10-11 15:10:14.779172+00	2026-10-11 15:10:14.779172+00
2480	2361	Ebook	\N	\N	\N	2026-10-11 15:10:14.781211+00	2026-10-11 15:10:14.781211+00
2481	2728	Ebook	\N	\N	\N	2026-10-11 15:10:14.78781+00	2026-10-11 15:10:14.78781+00
2482	2326	Audiobook	\N	\N	\N	2026-10-11 15:10:14.789997+00	2026-10-11 15:10:14.789997+00
2483	2729	Ebook	\N	\N	\N	2026-10-11 15:10:14.79774+00	2026-10-11 15:10:14.79774+00
2484	2730	Audiobook	\N	\N	\N	2026-10-11 15:10:14.804701+00	2026-10-11 15:10:14.804701+00
2485	2730	Ebook	\N	\N	\N	2026-10-11 15:10:14.806935+00	2026-10-11 15:10:14.806935+00
2486	2731	Audiobook	\N	\N	\N	2026-10-11 15:10:14.811739+00	2026-10-11 15:10:14.811739+00
2487	2731	Ebook	\N	\N	\N	2026-10-11 15:10:14.813954+00	2026-10-11 15:10:14.813954+00
2488	2732	Audiobook	\N	\N	\N	2026-10-11 15:10:14.818536+00	2026-10-11 15:10:14.818536+00
2489	2732	Ebook	\N	\N	\N	2026-10-11 15:10:14.820777+00	2026-10-11 15:10:14.820777+00
2490	2733	Audiobook	\N	\N	\N	2026-10-11 15:10:14.827429+00	2026-10-11 15:10:14.827429+00
2491	2733	Ebook	\N	\N	\N	2026-10-11 15:10:14.829639+00	2026-10-11 15:10:14.829639+00
2492	2734	Ebook	\N	\N	\N	2026-10-11 15:10:14.834639+00	2026-10-11 15:10:14.834639+00
2493	2735	Ebook	\N	\N	\N	2026-10-11 15:10:14.841794+00	2026-10-11 15:10:14.841794+00
2494	2736	Audiobook	\N	\N	\N	2026-10-11 15:10:14.849132+00	2026-10-11 15:10:14.849132+00
2495	2736	Ebook	\N	\N	\N	2026-10-11 15:10:14.851505+00	2026-10-11 15:10:14.851505+00
2496	2737	Ebook	\N	\N	\N	2026-10-11 15:10:14.858931+00	2026-10-11 15:10:14.858931+00
2497	2738	Audiobook	\N	\N	\N	2026-10-11 15:10:14.863902+00	2026-10-11 15:10:14.863902+00
2498	2738	Ebook	\N	\N	\N	2026-10-11 15:10:14.866315+00	2026-10-11 15:10:14.866315+00
2499	2739	Ebook	\N	\N	\N	2026-10-11 15:10:14.870585+00	2026-10-11 15:10:14.870585+00
2500	2740	Ebook	\N	\N	\N	2026-10-11 15:10:14.877294+00	2026-10-11 15:10:14.877294+00
2501	2741	Audiobook	\N	\N	\N	2026-10-11 15:10:14.883713+00	2026-10-11 15:10:14.883713+00
2502	2741	Ebook	\N	\N	\N	2026-10-11 15:10:14.886346+00	2026-10-11 15:10:14.886346+00
2503	2742	Audiobook	\N	\N	\N	2026-10-11 15:10:14.893448+00	2026-10-11 15:10:14.893448+00
2504	2742	Ebook	\N	\N	\N	2026-10-11 15:10:14.895875+00	2026-10-11 15:10:14.895875+00
2505	2743	Ebook	\N	\N	\N	2026-10-11 15:10:14.904294+00	2026-10-11 15:10:14.904294+00
2506	2371	Audiobook	\N	\N	\N	2026-10-11 15:10:14.907158+00	2026-10-11 15:10:14.907158+00
2507	2371	Ebook	\N	\N	\N	2026-10-11 15:10:14.917987+00	2026-10-11 15:10:14.917987+00
2508	2744	Audiobook	\N	\N	\N	2026-10-11 15:10:14.928145+00	2026-10-11 15:10:14.928145+00
2509	2744	Ebook	\N	\N	\N	2026-10-11 15:10:14.934219+00	2026-10-11 15:10:14.934219+00
2510	2745	Audiobook	\N	\N	\N	2026-10-11 15:10:14.9419+00	2026-10-11 15:10:14.9419+00
2511	2745	Ebook	\N	\N	\N	2026-10-11 15:10:14.944258+00	2026-10-11 15:10:14.944258+00
2512	2327	Audiobook	\N	\N	\N	2026-10-11 15:10:14.946601+00	2026-10-11 15:10:14.946601+00
2513	2362	Audiobook	\N	\N	\N	2026-10-11 15:10:14.948904+00	2026-10-11 15:10:14.948904+00
2514	2362	Ebook	\N	\N	\N	2026-10-11 15:10:14.95134+00	2026-10-11 15:10:14.95134+00
2515	1502	Audiobook	\N	\N	\N	2026-10-11 15:10:14.953663+00	2026-10-11 15:10:14.953663+00
2516	1502	Ebook	\N	\N	\N	2026-10-11 15:10:14.956058+00	2026-10-11 15:10:14.956058+00
2517	2746	Ebook	\N	\N	\N	2026-10-11 15:10:14.963048+00	2026-10-11 15:10:14.963048+00
2518	2747	Audiobook	\N	\N	\N	2026-10-11 15:10:14.969649+00	2026-10-11 15:10:14.969649+00
2519	2747	Ebook	\N	\N	\N	2026-10-11 15:10:14.972534+00	2026-10-11 15:10:14.972534+00
2520	2748	Audiobook	\N	\N	\N	2026-10-11 15:10:14.977213+00	2026-10-11 15:10:14.977213+00
2521	2748	Ebook	\N	\N	\N	2026-10-11 15:10:14.9795+00	2026-10-11 15:10:14.9795+00
2522	1454	Audiobook	\N	\N	\N	2026-10-11 15:10:14.982072+00	2026-10-11 15:10:14.982072+00
2523	1454	Ebook	\N	\N	\N	2026-10-11 15:10:14.984317+00	2026-10-11 15:10:14.984317+00
2524	1463	Ebook	\N	\N	\N	2026-10-11 15:10:14.986601+00	2026-10-11 15:10:14.986601+00
2525	2749	Ebook	\N	\N	\N	2026-10-11 15:10:14.993839+00	2026-10-11 15:10:14.993839+00
2526	2750	Ebook	\N	\N	\N	2026-10-11 15:10:14.998427+00	2026-10-11 15:10:14.998427+00
2527	2751	Ebook	\N	\N	\N	2026-10-11 15:10:15.004962+00	2026-10-11 15:10:15.004962+00
2528	2328	Audiobook	\N	\N	\N	2026-10-11 15:10:15.007129+00	2026-10-11 15:10:15.007129+00
2529	2752	Audiobook	\N	\N	\N	2026-10-11 15:10:15.011586+00	2026-10-11 15:10:15.011586+00
2530	2752	Ebook	\N	\N	\N	2026-10-11 15:10:15.014006+00	2026-10-11 15:10:15.014006+00
2531	2753	Ebook	\N	\N	\N	2026-10-11 15:10:15.018701+00	2026-10-11 15:10:15.018701+00
2532	2754	Audiobook	\N	\N	\N	2026-10-11 15:10:15.023091+00	2026-10-11 15:10:15.023091+00
2533	2754	Ebook	\N	\N	\N	2026-10-11 15:10:15.025475+00	2026-10-11 15:10:15.025475+00
2534	2755	Audiobook	\N	\N	\N	2026-10-11 15:10:15.029949+00	2026-10-11 15:10:15.029949+00
2535	2755	Ebook	\N	\N	\N	2026-10-11 15:10:15.032745+00	2026-10-11 15:10:15.032745+00
2536	2756	Ebook	\N	\N	\N	2026-10-11 15:10:15.037395+00	2026-10-11 15:10:15.037395+00
2537	2757	Audiobook	\N	\N	\N	2026-10-11 15:10:15.042009+00	2026-10-11 15:10:15.042009+00
2538	2757	Ebook	\N	\N	\N	2026-10-11 15:10:15.044222+00	2026-10-11 15:10:15.044222+00
2539	2758	Ebook	\N	\N	\N	2026-10-11 15:10:15.04865+00	2026-10-11 15:10:15.04865+00
2540	2759	Ebook	\N	\N	\N	2026-10-11 15:10:15.053531+00	2026-10-11 15:10:15.053531+00
2541	2760	Ebook	\N	\N	\N	2026-10-11 15:10:15.058259+00	2026-10-11 15:10:15.058259+00
2542	2761	Audiobook	\N	\N	\N	2026-10-11 15:10:15.065852+00	2026-10-11 15:10:15.065852+00
2543	2761	Ebook	\N	\N	\N	2026-10-11 15:10:15.068002+00	2026-10-11 15:10:15.068002+00
2544	2762	Ebook	\N	\N	\N	2026-10-11 15:10:15.075193+00	2026-10-11 15:10:15.075193+00
2545	2329	Audiobook	\N	\N	\N	2026-10-11 15:10:15.077377+00	2026-10-11 15:10:15.077377+00
2546	2763	Ebook	\N	\N	\N	2026-10-11 15:10:15.08394+00	2026-10-11 15:10:15.08394+00
2547	2764	Ebook	\N	\N	\N	2026-10-11 15:10:15.088538+00	2026-10-11 15:10:15.088538+00
2548	2765	Ebook	\N	\N	\N	2026-10-11 15:10:15.095196+00	2026-10-11 15:10:15.095196+00
2549	2766	Ebook	\N	\N	\N	2026-10-11 15:10:15.099588+00	2026-10-11 15:10:15.099588+00
2550	2767	Ebook	\N	\N	\N	2026-10-11 15:10:15.10518+00	2026-10-11 15:10:15.10518+00
2551	2768	Ebook	\N	\N	\N	2026-10-11 15:10:15.109925+00	2026-10-11 15:10:15.109925+00
2552	2769	Ebook	\N	\N	\N	2026-10-11 15:10:15.114246+00	2026-10-11 15:10:15.114246+00
2553	2770	Audiobook	\N	\N	\N	2026-10-11 15:10:15.12051+00	2026-10-11 15:10:15.12051+00
2554	2770	Ebook	\N	\N	\N	2026-10-11 15:10:15.122921+00	2026-10-11 15:10:15.122921+00
2555	2771	Audiobook	\N	\N	\N	2026-10-11 15:10:15.129657+00	2026-10-11 15:10:15.129657+00
2556	2771	Ebook	\N	\N	\N	2026-10-11 15:10:15.132104+00	2026-10-11 15:10:15.132104+00
2557	2772	Ebook	\N	\N	\N	2026-10-11 15:10:15.138864+00	2026-10-11 15:10:15.138864+00
2558	2773	Ebook	\N	\N	\N	2026-10-11 15:10:15.145674+00	2026-10-11 15:10:15.145674+00
2559	2774	Ebook	\N	\N	\N	2026-10-11 15:10:15.152082+00	2026-10-11 15:10:15.152082+00
2560	2775	Ebook	\N	\N	\N	2026-10-11 15:10:15.158907+00	2026-10-11 15:10:15.158907+00
2561	2331	Audiobook	\N	\N	\N	2026-10-11 15:10:15.161445+00	2026-10-11 15:10:15.161445+00
2562	2358	Audiobook	\N	\N	\N	2026-10-11 15:10:15.163689+00	2026-10-11 15:10:15.163689+00
2563	2358	Ebook	\N	\N	\N	2026-10-11 15:10:15.165989+00	2026-10-11 15:10:15.165989+00
2564	2776	Audiobook	\N	\N	\N	2026-10-11 15:10:15.173514+00	2026-10-11 15:10:15.173514+00
2565	2776	Ebook	\N	\N	\N	2026-10-11 15:10:15.175799+00	2026-10-11 15:10:15.175799+00
2566	2777	Ebook	\N	\N	\N	2026-10-11 15:10:15.18037+00	2026-10-11 15:10:15.18037+00
2567	2778	Ebook	\N	\N	\N	2026-10-11 15:10:15.186983+00	2026-10-11 15:10:15.186983+00
2568	2779	Audiobook	\N	\N	\N	2026-10-11 15:10:15.191645+00	2026-10-11 15:10:15.191645+00
2569	2779	Ebook	\N	\N	\N	2026-10-11 15:10:15.194295+00	2026-10-11 15:10:15.194295+00
2570	2334	Audiobook	\N	\N	\N	2026-10-11 15:10:15.196635+00	2026-10-11 15:10:15.196635+00
2571	2335	Audiobook	\N	\N	\N	2026-10-11 15:10:15.199006+00	2026-10-11 15:10:15.199006+00
2572	2780	Ebook	\N	\N	\N	2026-10-11 15:10:15.203913+00	2026-10-11 15:10:15.203913+00
2573	2781	Audiobook	\N	\N	\N	2026-10-11 15:10:15.213602+00	2026-10-11 15:10:15.213602+00
2574	2781	Ebook	\N	\N	\N	2026-10-11 15:10:15.216045+00	2026-10-11 15:10:15.216045+00
2575	2782	Ebook	\N	\N	\N	2026-10-11 15:10:15.220719+00	2026-10-11 15:10:15.220719+00
2576	2336	Audiobook	\N	\N	\N	2026-10-11 15:10:15.223244+00	2026-10-11 15:10:15.223244+00
2577	2783	Audiobook	\N	\N	\N	2026-10-11 15:10:15.229211+00	2026-10-11 15:10:15.229211+00
2578	2783	Ebook	\N	\N	\N	2026-10-11 15:10:15.231786+00	2026-10-11 15:10:15.231786+00
2579	2784	Ebook	\N	\N	\N	2026-10-11 15:10:15.23863+00	2026-10-11 15:10:15.23863+00
2580	2337	Audiobook	\N	\N	\N	2026-10-11 15:10:15.24156+00	2026-10-11 15:10:15.24156+00
2581	2785	Audiobook	\N	\N	\N	2026-10-11 15:10:15.246355+00	2026-10-11 15:10:15.246355+00
2582	2785	Ebook	\N	\N	\N	2026-10-11 15:10:15.252458+00	2026-10-11 15:10:15.252458+00
2583	2786	Audiobook	\N	\N	\N	2026-10-11 15:10:15.259889+00	2026-10-11 15:10:15.259889+00
2584	2786	Ebook	\N	\N	\N	2026-10-11 15:10:15.263574+00	2026-10-11 15:10:15.263574+00
2585	2366	Audiobook	\N	\N	\N	2026-10-11 15:10:15.266186+00	2026-10-11 15:10:15.266186+00
2586	2787	Ebook	\N	\N	\N	2026-10-11 15:10:15.275922+00	2026-10-11 15:10:15.275922+00
2587	2788	Ebook	\N	\N	\N	2026-10-11 15:10:15.280748+00	2026-10-11 15:10:15.280748+00
2588	2789	Ebook	\N	\N	\N	2026-10-11 15:10:15.288483+00	2026-10-11 15:10:15.288483+00
2589	2338	Audiobook	\N	\N	\N	2026-10-11 15:10:15.291016+00	2026-10-11 15:10:15.291016+00
2590	2790	Ebook	\N	\N	\N	2026-10-11 15:10:15.299749+00	2026-10-11 15:10:15.299749+00
2591	2791	Ebook	\N	\N	\N	2026-10-11 15:10:15.308129+00	2026-10-11 15:10:15.308129+00
2592	2792	Audiobook	\N	\N	\N	2026-10-11 15:10:15.318478+00	2026-10-11 15:10:15.318478+00
2593	2792	Ebook	\N	\N	\N	2026-10-11 15:10:15.320956+00	2026-10-11 15:10:15.320956+00
2594	2793	Ebook	\N	\N	\N	2026-10-11 15:10:15.32709+00	2026-10-11 15:10:15.32709+00
2595	2794	Ebook	\N	\N	\N	2026-10-11 15:10:15.336826+00	2026-10-11 15:10:15.336826+00
2596	2795	Ebook	\N	\N	\N	2026-10-11 15:10:15.345519+00	2026-10-11 15:10:15.345519+00
2597	2796	Ebook	\N	\N	\N	2026-10-11 15:10:15.350129+00	2026-10-11 15:10:15.350129+00
2598	2797	Ebook	\N	\N	\N	2026-10-11 15:10:15.355604+00	2026-10-11 15:10:15.355604+00
2599	2384	Ebook	\N	\N	\N	2026-10-11 15:10:15.359141+00	2026-10-11 15:10:15.359141+00
2600	2798	Ebook	\N	\N	\N	2026-10-11 15:10:15.366241+00	2026-10-11 15:10:15.366241+00
2601	2799	Audiobook	\N	\N	\N	2026-10-11 15:10:15.375826+00	2026-10-11 15:10:15.375826+00
2602	2799	Ebook	\N	\N	\N	2026-10-11 15:10:15.378375+00	2026-10-11 15:10:15.378375+00
2603	2800	Ebook	\N	\N	\N	2026-10-11 15:10:15.383376+00	2026-10-11 15:10:15.383376+00
2604	1455	Audiobook	\N	\N	\N	2026-10-11 15:10:15.388514+00	2026-10-11 15:10:15.388514+00
2605	1455	Ebook	\N	\N	\N	2026-10-11 15:10:15.390937+00	2026-10-11 15:10:15.390937+00
2606	2801	Audiobook	\N	\N	\N	2026-10-11 15:10:15.398566+00	2026-10-11 15:10:15.398566+00
2607	2802	Ebook	\N	2026	\N	2026-10-11 15:10:15.404701+00	2026-10-11 15:10:15.404701+00
2608	2803	Ebook	\N	2026	\N	2026-10-11 15:10:15.418523+00	2026-10-11 15:10:15.418523+00
2609	2804	Ebook	\N	2026	\N	2026-10-11 15:10:15.429133+00	2026-10-11 15:10:15.429133+00
2610	2805	Ebook	\N	2026	\N	2026-10-11 15:10:15.439085+00	2026-10-11 15:10:15.439085+00
2611	2806	Ebook	\N	2026	\N	2026-10-11 15:10:15.448624+00	2026-10-11 15:10:15.448624+00
2612	2807	Ebook	\N	2026	\N	2026-10-11 15:10:15.459083+00	2026-10-11 15:10:15.459083+00
2613	2355	Ebook	\N	2026	\N	2026-10-11 15:10:15.461632+00	2026-10-11 15:10:15.461632+00
2614	2808	Ebook	\N	2026	\N	2026-10-11 15:10:15.469598+00	2026-10-11 15:10:15.469598+00
2615	2809	Ebook	\N	2026	\N	2026-10-11 15:10:15.476546+00	2026-10-11 15:10:15.476546+00
2616	2810	Ebook	\N	2026	\N	2026-10-11 15:10:15.48414+00	2026-10-11 15:10:15.48414+00
2617	2811	Ebook	\N	2026	\N	2026-10-11 15:10:15.491456+00	2026-10-11 15:10:15.491456+00
2618	2812	Ebook	\N	2026	\N	2026-10-11 15:10:15.498766+00	2026-10-11 15:10:15.498766+00
2619	2813	Ebook	\N	2026	\N	2026-10-11 15:10:15.507525+00	2026-10-11 15:10:15.507525+00
2620	2814	Ebook	\N	2026	\N	2026-10-11 15:10:15.517306+00	2026-10-11 15:10:15.517306+00
2621	2815	Ebook	\N	2026	\N	2026-10-11 15:10:15.522301+00	2026-10-11 15:10:15.522301+00
2622	2816	Ebook	\N	2026	\N	2026-10-11 15:10:15.527409+00	2026-10-11 15:10:15.527409+00
2623	2817	Ebook	\N	2026	\N	2026-10-11 15:10:15.532129+00	2026-10-11 15:10:15.532129+00
2624	2818	Ebook	\N	2026	\N	2026-10-11 15:10:15.536798+00	2026-10-11 15:10:15.536798+00
2625	2819	Ebook	\N	2026	\N	2026-10-11 15:10:15.542491+00	2026-10-11 15:10:15.542491+00
2626	2820	Ebook	\N	2026	\N	2026-10-11 15:10:15.549205+00	2026-10-11 15:10:15.549205+00
2627	2821	Ebook	\N	2026	\N	2026-10-11 15:10:15.561562+00	2026-10-11 15:10:15.561562+00
2628	2822	Ebook	\N	2026	\N	2026-10-11 15:10:15.566305+00	2026-10-11 15:10:15.566305+00
2629	2823	Ebook	\N	2026	\N	2026-10-11 15:10:15.571044+00	2026-10-11 15:10:15.571044+00
2630	2824	Ebook	\N	2026	\N	2026-10-11 15:10:15.578394+00	2026-10-11 15:10:15.578394+00
2631	2825	Ebook	\N	2026	\N	2026-10-11 15:10:15.583046+00	2026-10-11 15:10:15.583046+00
2632	2826	Ebook	\N	2026	\N	2026-10-11 15:10:15.58768+00	2026-10-11 15:10:15.58768+00
2633	2827	Ebook	\N	2026	\N	2026-10-11 15:10:15.594749+00	2026-10-11 15:10:15.594749+00
2634	2828	Ebook	\N	2026	\N	2026-10-11 15:10:15.599496+00	2026-10-11 15:10:15.599496+00
2635	2829	Ebook	\N	2026	\N	2026-10-11 15:10:15.606417+00	2026-10-11 15:10:15.606417+00
2636	2830	Ebook	\N	2026	\N	2026-10-11 15:10:15.613553+00	2026-10-11 15:10:15.613553+00
2637	2831	Ebook	\N	2026	\N	2026-10-11 15:10:15.618074+00	2026-10-11 15:10:15.618074+00
2638	2832	Ebook	\N	2026	\N	2026-10-11 15:10:15.623322+00	2026-10-11 15:10:15.623322+00
2639	2833	Ebook	\N	2026	\N	2026-10-11 15:10:15.630509+00	2026-10-11 15:10:15.630509+00
2640	2834	Ebook	\N	2026	\N	2026-10-11 15:10:15.635609+00	2026-10-11 15:10:15.635609+00
2641	2835	Ebook	\N	2026	\N	2026-10-11 15:10:15.658645+00	2026-10-11 15:10:15.658645+00
2642	2836	Ebook	\N	2026	\N	2026-10-11 15:10:15.666589+00	2026-10-11 15:10:15.666589+00
2643	2837	Ebook	\N	2026	\N	2026-10-11 15:10:15.671348+00	2026-10-11 15:10:15.671348+00
2644	2838	Ebook	\N	2026	\N	2026-10-11 15:10:15.678107+00	2026-10-11 15:10:15.678107+00
2645	2839	Ebook	\N	2026	\N	2026-10-11 15:10:15.684984+00	2026-10-11 15:10:15.684984+00
2646	2374	Ebook	\N	2026	\N	2026-10-11 15:10:15.687424+00	2026-10-11 15:10:15.687424+00
2647	2840	Ebook	\N	2026	\N	2026-10-11 15:10:15.692537+00	2026-10-11 15:10:15.692537+00
2648	2841	Ebook	\N	2026	\N	2026-10-11 15:10:15.69716+00	2026-10-11 15:10:15.69716+00
2649	2842	Ebook	\N	2026	\N	2026-10-11 15:10:15.702213+00	2026-10-11 15:10:15.702213+00
2650	2843	Ebook	\N	2026	\N	2026-10-11 15:10:15.709901+00	2026-10-11 15:10:15.709901+00
2651	2844	Ebook	\N	2026	\N	2026-10-11 15:10:15.71496+00	2026-10-11 15:10:15.71496+00
2652	2845	Ebook	\N	2026	\N	2026-10-11 15:10:15.719599+00	2026-10-11 15:10:15.719599+00
2653	2846	Ebook	\N	2026	\N	2026-10-11 15:10:15.725303+00	2026-10-11 15:10:15.725303+00
2654	2847	Ebook	\N	2026	\N	2026-10-11 15:10:15.729701+00	2026-10-11 15:10:15.729701+00
2655	2848	Ebook	\N	2026	\N	2026-10-11 15:10:15.736949+00	2026-10-11 15:10:15.736949+00
2656	2849	Ebook	\N	2026	\N	2026-10-11 15:10:15.760896+00	2026-10-11 15:10:15.760896+00
2657	2850	Ebook	\N	2026	\N	2026-10-11 15:10:15.768344+00	2026-10-11 15:10:15.768344+00
2658	2851	Ebook	\N	2026	\N	2026-10-11 15:10:15.775615+00	2026-10-11 15:10:15.775615+00
2659	2852	Ebook	\N	2026	\N	2026-10-11 15:10:15.780229+00	2026-10-11 15:10:15.780229+00
2660	2853	Ebook	\N	2026	\N	2026-10-11 15:10:15.787523+00	2026-10-11 15:10:15.787523+00
2661	2854	Ebook	\N	2026	\N	2026-10-11 15:10:15.801676+00	2026-10-11 15:10:15.801676+00
2662	2855	Ebook	\N	2026	\N	2026-10-11 15:10:15.806548+00	2026-10-11 15:10:15.806548+00
2663	2856	Ebook	\N	2026	\N	2026-10-11 15:10:15.813488+00	2026-10-11 15:10:15.813488+00
2664	2857	Ebook	\N	2026	\N	2026-10-11 15:10:15.820354+00	2026-10-11 15:10:15.820354+00
2665	2858	Ebook	\N	2026	\N	2026-10-11 15:10:15.82816+00	2026-10-11 15:10:15.82816+00
2666	2859	Ebook	\N	2026	\N	2026-10-11 15:10:15.83269+00	2026-10-11 15:10:15.83269+00
2667	2860	Ebook	\N	2026	\N	2026-10-11 15:10:15.845459+00	2026-10-11 15:10:15.845459+00
2668	1508	Ebook	\N	2026	\N	2026-10-11 15:10:15.84825+00	2026-10-11 15:10:15.84825+00
2669	2861	Ebook	\N	2026	\N	2026-10-11 15:10:15.853726+00	2026-10-11 15:10:15.853726+00
2670	2862	Ebook	\N	2026	\N	2026-10-11 15:10:15.871977+00	2026-10-11 15:10:15.871977+00
2671	2863	Ebook	\N	2026	\N	2026-10-11 15:10:15.880776+00	2026-10-11 15:10:15.880776+00
2672	2864	Ebook	\N	2026	\N	2026-10-11 15:10:15.886114+00	2026-10-11 15:10:15.886114+00
2673	2865	Ebook	\N	2026	\N	2026-10-11 15:10:15.89124+00	2026-10-11 15:10:15.89124+00
2674	2866	Ebook	\N	2026	\N	2026-10-11 15:10:15.896686+00	2026-10-11 15:10:15.896686+00
2675	2867	Ebook	\N	2026	\N	2026-10-11 15:10:15.901988+00	2026-10-11 15:10:15.901988+00
2676	2868	Ebook	\N	2026	\N	2026-10-11 15:10:15.906817+00	2026-10-11 15:10:15.906817+00
2677	2869	Ebook	\N	2026	\N	2026-10-11 15:10:15.913845+00	2026-10-11 15:10:15.913845+00
2678	2870	Ebook	\N	2026	\N	2026-10-11 15:10:15.918488+00	2026-10-11 15:10:15.918488+00
2679	2871	Ebook	\N	2026	\N	2026-10-11 15:10:15.925342+00	2026-10-11 15:10:15.925342+00
2680	2872	Ebook	\N	2026	\N	2026-10-11 15:10:15.929899+00	2026-10-11 15:10:15.929899+00
2681	2873	Ebook	\N	2026	\N	2026-10-11 15:10:15.936909+00	2026-10-11 15:10:15.936909+00
2682	2874	Ebook	\N	2026	\N	2026-10-11 15:10:15.944118+00	2026-10-11 15:10:15.944118+00
2683	2383	Ebook	\N	2026	\N	2026-10-11 15:10:15.94639+00	2026-10-11 15:10:15.94639+00
2684	2875	Ebook	\N	2026	\N	2026-10-11 15:10:15.960199+00	2026-10-11 15:10:15.960199+00
2685	2876	Ebook	\N	2026	\N	2026-10-11 15:10:15.965135+00	2026-10-11 15:10:15.965135+00
2686	2877	Ebook	\N	2026	\N	2026-10-11 15:10:15.969565+00	2026-10-11 15:10:15.969565+00
2687	2878	Ebook	\N	2026	\N	2026-10-11 15:10:15.974873+00	2026-10-11 15:10:15.974873+00
2688	2879	Ebook	\N	2026	\N	2026-10-11 15:10:15.981867+00	2026-10-11 15:10:15.981867+00
2689	2880	Ebook	\N	2026	\N	2026-10-11 15:10:15.988836+00	2026-10-11 15:10:15.988836+00
2690	2881	Ebook	\N	2026	\N	2026-10-11 15:10:15.995656+00	2026-10-11 15:10:15.995656+00
2691	2882	Ebook	\N	2026	\N	2026-10-11 15:10:16.00255+00	2026-10-11 15:10:16.00255+00
2692	2883	Ebook	\N	2026	\N	2026-10-11 15:10:16.011564+00	2026-10-11 15:10:16.011564+00
2693	1522	Ebook	\N	2026	\N	2026-10-11 15:10:16.014304+00	2026-10-11 15:10:16.014304+00
2694	2884	Ebook	\N	2026	\N	2026-10-11 15:10:16.021533+00	2026-10-11 15:10:16.021533+00
2695	2885	Ebook	\N	2026	\N	2026-10-11 15:10:16.029611+00	2026-10-11 15:10:16.029611+00
2696	2886	Ebook	\N	2026	\N	2026-10-11 15:10:16.037124+00	2026-10-11 15:10:16.037124+00
2697	2887	Ebook	\N	2026	\N	2026-10-11 15:10:16.041646+00	2026-10-11 15:10:16.041646+00
2698	2888	Ebook	\N	2026	\N	2026-10-11 15:10:16.046437+00	2026-10-11 15:10:16.046437+00
2699	2889	Ebook	\N	2026	\N	2026-10-11 15:10:16.05284+00	2026-10-11 15:10:16.05284+00
2700	2890	Ebook	\N	2026	\N	2026-10-11 15:10:16.059387+00	2026-10-11 15:10:16.059387+00
2701	2891	Ebook	\N	2026	\N	2026-10-11 15:10:16.066066+00	2026-10-11 15:10:16.066066+00
2702	2892	Ebook	\N	2026	\N	2026-10-11 15:10:16.070632+00	2026-10-11 15:10:16.070632+00
2703	1528	Ebook	\N	2026	\N	2026-10-11 15:10:16.072757+00	2026-10-11 15:10:16.072757+00
2704	2893	Ebook	\N	2026	\N	2026-10-11 15:10:16.079562+00	2026-10-11 15:10:16.079562+00
2705	2894	Ebook	\N	2026	\N	2026-10-11 15:10:16.084158+00	2026-10-11 15:10:16.084158+00
2706	2895	Ebook	\N	2026	\N	2026-10-11 15:10:16.090935+00	2026-10-11 15:10:16.090935+00
2707	2896	Ebook	\N	2026	\N	2026-10-11 15:10:16.095376+00	2026-10-11 15:10:16.095376+00
2708	2897	Ebook	\N	2026	\N	2026-10-11 15:10:16.102052+00	2026-10-11 15:10:16.102052+00
2709	2898	Ebook	\N	2026	\N	2026-10-11 15:10:16.106868+00	2026-10-11 15:10:16.106868+00
2710	2899	Ebook	\N	2026	\N	2026-10-11 15:10:16.113739+00	2026-10-11 15:10:16.113739+00
2711	2900	Ebook	\N	2026	\N	2026-10-11 15:10:16.120315+00	2026-10-11 15:10:16.120315+00
2712	2901	Ebook	\N	2026	\N	2026-10-11 15:10:16.125405+00	2026-10-11 15:10:16.125405+00
2713	2902	Ebook	\N	2026	\N	2026-10-11 15:10:16.132341+00	2026-10-11 15:10:16.132341+00
2714	2903	Ebook	\N	2026	\N	2026-10-11 15:10:16.139126+00	2026-10-11 15:10:16.139126+00
2715	2360	Ebook	\N	2026	\N	2026-10-11 15:10:16.141414+00	2026-10-11 15:10:16.141414+00
2716	2463	Ebook	\N	2026	\N	2026-10-11 15:10:16.143771+00	2026-10-11 15:10:16.143771+00
2717	2904	Ebook	\N	2026	\N	2026-10-11 15:10:16.149836+00	2026-10-11 15:10:16.149836+00
2718	2905	Ebook	\N	2026	\N	2026-10-11 15:10:16.15439+00	2026-10-11 15:10:16.15439+00
2719	2906	Ebook	\N	2026	\N	2026-10-11 15:10:16.160776+00	2026-10-11 15:10:16.160776+00
2720	1510	Ebook	\N	2026	\N	2026-10-11 15:10:16.163125+00	2026-10-11 15:10:16.163125+00
2721	2907	Ebook	\N	2026	\N	2026-10-11 15:10:16.167552+00	2026-10-11 15:10:16.167552+00
2722	2908	Ebook	\N	2026	\N	2026-10-11 15:10:16.174078+00	2026-10-11 15:10:16.174078+00
2723	2909	Ebook	\N	2026	\N	2026-10-11 15:10:16.182826+00	2026-10-11 15:10:16.182826+00
2724	2382	Ebook	\N	2026	\N	2026-10-11 15:10:16.184996+00	2026-10-11 15:10:16.184996+00
2725	2910	Ebook	\N	2026	\N	2026-10-11 15:10:16.189348+00	2026-10-11 15:10:16.189348+00
2726	2911	Ebook	\N	2026	\N	2026-10-11 15:10:16.194321+00	2026-10-11 15:10:16.194321+00
2727	2912	Ebook	\N	2026	\N	2026-10-11 15:10:16.200965+00	2026-10-11 15:10:16.200965+00
2728	2913	Ebook	\N	2026	\N	2026-10-11 15:10:16.205246+00	2026-10-11 15:10:16.205246+00
2729	2914	Ebook	\N	2026	\N	2026-10-11 15:10:16.212007+00	2026-10-11 15:10:16.212007+00
2730	2380	Ebook	\N	2026	\N	2026-10-11 15:10:16.214976+00	2026-10-11 15:10:16.214976+00
2731	2915	Ebook	\N	2026	\N	2026-10-11 15:10:16.222581+00	2026-10-11 15:10:16.222581+00
2732	2916	Ebook	\N	2026	\N	2026-10-11 15:10:16.227041+00	2026-10-11 15:10:16.227041+00
2733	2917	Ebook	\N	2026	\N	2026-10-11 15:10:16.233944+00	2026-10-11 15:10:16.233944+00
2734	2918	Ebook	\N	2026	\N	2026-10-11 15:10:16.240859+00	2026-10-11 15:10:16.240859+00
2735	2919	Ebook	\N	2026	\N	2026-10-11 15:10:16.245821+00	2026-10-11 15:10:16.245821+00
2736	2920	Ebook	\N	2026	\N	2026-10-11 15:10:16.250388+00	2026-10-11 15:10:16.250388+00
2737	2921	Ebook	\N	2026	\N	2026-10-11 15:10:16.254952+00	2026-10-11 15:10:16.254952+00
2738	2922	Ebook	\N	2026	\N	2026-10-11 15:10:16.25949+00	2026-10-11 15:10:16.25949+00
2739	2923	Ebook	\N	2026	\N	2026-10-11 15:10:16.263969+00	2026-10-11 15:10:16.263969+00
2740	2924	Ebook	\N	2026	\N	2026-10-11 15:10:16.268521+00	2026-10-11 15:10:16.268521+00
2741	2925	Ebook	\N	2026	\N	2026-10-11 15:10:16.275706+00	2026-10-11 15:10:16.275706+00
2742	2926	Ebook	\N	2026	\N	2026-10-11 15:10:16.280328+00	2026-10-11 15:10:16.280328+00
2743	2927	Ebook	\N	2026	\N	2026-10-11 15:10:16.285682+00	2026-10-11 15:10:16.285682+00
2744	2928	Ebook	\N	2026	\N	2026-10-11 15:10:16.290305+00	2026-10-11 15:10:16.290305+00
2745	2929	Ebook	\N	2026	\N	2026-10-11 15:10:16.295394+00	2026-10-11 15:10:16.295394+00
2746	2930	Ebook	\N	2026	\N	2026-10-11 15:10:16.300004+00	2026-10-11 15:10:16.300004+00
2747	2931	Ebook	\N	2026	\N	2026-10-11 15:10:16.305161+00	2026-10-11 15:10:16.305161+00
2748	2932	Ebook	\N	2026	\N	2026-10-11 15:10:16.312207+00	2026-10-11 15:10:16.312207+00
2749	2933	Ebook	\N	2026	\N	2026-10-11 15:10:16.316722+00	2026-10-11 15:10:16.316722+00
2750	2934	Ebook	\N	2026	\N	2026-10-11 15:10:16.323513+00	2026-10-11 15:10:16.323513+00
2751	2935	Ebook	\N	2026	\N	2026-10-11 15:10:16.330152+00	2026-10-11 15:10:16.330152+00
2752	2936	Ebook	\N	2026	\N	2026-10-11 15:10:16.3349+00	2026-10-11 15:10:16.3349+00
2753	2937	Ebook	\N	2026	\N	2026-10-11 15:10:16.341869+00	2026-10-11 15:10:16.341869+00
2754	2938	Ebook	\N	2026	\N	2026-10-11 15:10:16.355995+00	2026-10-11 15:10:16.355995+00
2755	2939	Ebook	\N	2026	\N	2026-10-11 15:10:16.362731+00	2026-10-11 15:10:16.362731+00
2756	2940	Ebook	\N	2026	\N	2026-10-11 15:10:16.369415+00	2026-10-11 15:10:16.369415+00
2757	1534	Ebook	\N	2026	\N	2026-10-11 15:10:16.371637+00	2026-10-11 15:10:16.371637+00
2758	2941	Ebook	\N	2026	\N	2026-10-11 15:10:16.378181+00	2026-10-11 15:10:16.378181+00
2759	2942	Ebook	\N	2026	\N	2026-10-11 15:10:16.38471+00	2026-10-11 15:10:16.38471+00
2760	2943	Ebook	\N	2026	\N	2026-10-11 15:10:16.39147+00	2026-10-11 15:10:16.39147+00
2761	2944	Ebook	\N	2026	\N	2026-10-11 15:10:16.396123+00	2026-10-11 15:10:16.396123+00
2762	2376	Ebook	\N	2026	\N	2026-10-11 15:10:16.398481+00	2026-10-11 15:10:16.398481+00
2763	2945	Ebook	\N	2026	\N	2026-10-11 15:10:16.405147+00	2026-10-11 15:10:16.405147+00
2764	2946	Ebook	\N	2026	\N	2026-10-11 15:10:16.409627+00	2026-10-11 15:10:16.409627+00
2765	2947	Ebook	\N	2026	\N	2026-10-11 15:10:16.414413+00	2026-10-11 15:10:16.414413+00
2766	2948	Ebook	\N	2026	\N	2026-10-11 15:10:16.421054+00	2026-10-11 15:10:16.421054+00
2767	2949	Ebook	\N	2026	\N	2026-10-11 15:10:16.426227+00	2026-10-11 15:10:16.426227+00
2768	2950	Ebook	\N	2026	\N	2026-10-11 15:10:16.430997+00	2026-10-11 15:10:16.430997+00
2769	2951	Ebook	\N	2026	\N	2026-10-11 15:10:16.438129+00	2026-10-11 15:10:16.438129+00
2770	2952	Ebook	\N	2026	\N	2026-10-11 15:10:16.445033+00	2026-10-11 15:10:16.445033+00
2771	2953	Ebook	\N	2026	\N	2026-10-11 15:10:16.449468+00	2026-10-11 15:10:16.449468+00
2772	2954	Ebook	\N	2026	\N	2026-10-11 15:10:16.454154+00	2026-10-11 15:10:16.454154+00
2773	2955	Ebook	\N	2026	\N	2026-10-11 15:10:16.460674+00	2026-10-11 15:10:16.460674+00
2774	2956	Ebook	\N	2026	\N	2026-10-11 15:10:16.467461+00	2026-10-11 15:10:16.467461+00
2775	2957	Ebook	\N	2026	\N	2026-10-11 15:10:16.472429+00	2026-10-11 15:10:16.472429+00
2776	2958	Ebook	\N	2026	\N	2026-10-11 15:10:16.479104+00	2026-10-11 15:10:16.479104+00
2777	2959	Ebook	\N	2026	\N	2026-10-11 15:10:16.483837+00	2026-10-11 15:10:16.483837+00
2778	2960	Ebook	\N	2026	\N	2026-10-11 15:10:16.490657+00	2026-10-11 15:10:16.490657+00
2779	2961	Ebook	\N	2026	\N	2026-10-11 15:10:16.495593+00	2026-10-11 15:10:16.495593+00
2780	2962	Ebook	\N	2026	\N	2026-10-11 15:10:16.502196+00	2026-10-11 15:10:16.502196+00
2781	2963	Ebook	\N	2026	\N	2026-10-11 15:10:16.509466+00	2026-10-11 15:10:16.509466+00
2782	2964	Ebook	\N	2026	\N	2026-10-11 15:10:16.514406+00	2026-10-11 15:10:16.514406+00
2783	2965	Ebook	\N	2026	\N	2026-10-11 15:10:16.519104+00	2026-10-11 15:10:16.519104+00
2784	2966	Ebook	\N	2026	\N	2026-10-11 15:10:16.526486+00	2026-10-11 15:10:16.526486+00
2785	2967	Ebook	\N	2026	\N	2026-10-11 15:10:16.531088+00	2026-10-11 15:10:16.531088+00
2786	2968	Ebook	\N	2026	\N	2026-10-11 15:10:16.538182+00	2026-10-11 15:10:16.538182+00
2787	2969	Ebook	\N	2026	\N	2026-10-11 15:10:16.545353+00	2026-10-11 15:10:16.545353+00
2788	2970	Ebook	\N	2026	\N	2026-10-11 15:10:16.552797+00	2026-10-11 15:10:16.552797+00
2789	2971	Ebook	\N	2026	\N	2026-10-11 15:10:16.557306+00	2026-10-11 15:10:16.557306+00
2790	2972	Ebook	\N	2026	\N	2026-10-11 15:10:16.564578+00	2026-10-11 15:10:16.564578+00
2791	2973	Ebook	\N	2026	\N	2026-10-11 15:10:16.56897+00	2026-10-11 15:10:16.56897+00
2792	2974	Ebook	\N	2026	\N	2026-10-11 15:10:16.576111+00	2026-10-11 15:10:16.576111+00
2793	1532	Ebook	\N	2026	\N	2026-10-11 15:10:16.578346+00	2026-10-11 15:10:16.578346+00
2794	2392	Ebook	\N	2026	\N	2026-10-11 15:10:16.580491+00	2026-10-11 15:10:16.580491+00
2795	2975	Ebook	\N	2026	\N	2026-10-11 15:10:16.585412+00	2026-10-11 15:10:16.585412+00
2796	2976	Ebook	\N	2026	\N	2026-10-11 15:10:16.592476+00	2026-10-11 15:10:16.592476+00
2797	2977	Ebook	\N	2026	\N	2026-10-11 15:10:16.599257+00	2026-10-11 15:10:16.599257+00
2798	2978	Ebook	\N	2026	\N	2026-10-11 15:10:16.60384+00	2026-10-11 15:10:16.60384+00
2799	1530	Ebook	\N	2026	\N	2026-10-11 15:10:16.606318+00	2026-10-11 15:10:16.606318+00
2800	2979	Ebook	\N	2026	\N	2026-10-11 15:10:16.613241+00	2026-10-11 15:10:16.613241+00
2801	2980	Ebook	\N	2026	\N	2026-10-11 15:10:16.617849+00	2026-10-11 15:10:16.617849+00
2802	2981	Ebook	\N	2026	\N	2026-10-11 15:10:16.62262+00	2026-10-11 15:10:16.62262+00
2803	2982	Ebook	\N	2026	\N	2026-10-11 15:10:16.629444+00	2026-10-11 15:10:16.629444+00
2804	1539	Ebook	\N	2026	\N	2026-10-11 15:10:16.631642+00	2026-10-11 15:10:16.631642+00
2805	2983	Ebook	\N	2026	\N	2026-10-11 15:10:16.636394+00	2026-10-11 15:10:16.636394+00
2806	2984	Ebook	\N	2026	\N	2026-10-11 15:10:16.643131+00	2026-10-11 15:10:16.643131+00
2807	2985	Ebook	\N	2026	\N	2026-10-11 15:10:16.647438+00	2026-10-11 15:10:16.647438+00
2808	2986	Ebook	\N	2026	\N	2026-10-11 15:10:16.652187+00	2026-10-11 15:10:16.652187+00
2809	2987	Ebook	\N	2026	\N	2026-10-11 15:10:16.659118+00	2026-10-11 15:10:16.659118+00
2810	2988	Ebook	\N	2026	\N	2026-10-11 15:10:16.666123+00	2026-10-11 15:10:16.666123+00
2811	2989	Ebook	\N	2026	\N	2026-10-11 15:10:16.672995+00	2026-10-11 15:10:16.672995+00
2812	2990	Ebook	\N	2026	\N	2026-10-11 15:10:16.67779+00	2026-10-11 15:10:16.67779+00
2813	2387	Ebook	\N	2026	\N	2026-10-11 15:10:16.679953+00	2026-10-11 15:10:16.679953+00
2814	2991	Ebook	\N	2026	\N	2026-10-11 15:10:16.686349+00	2026-10-11 15:10:16.686349+00
2815	2992	Ebook	\N	2026	\N	2026-10-11 15:10:16.690706+00	2026-10-11 15:10:16.690706+00
2816	2993	Ebook	\N	2026	\N	2026-10-11 15:10:16.695158+00	2026-10-11 15:10:16.695158+00
2817	2708	Audiobook	\N	2026	\N	2026-10-11 15:10:16.697318+00	2026-10-11 15:10:16.697318+00
2818	2671	Audiobook	\N	2026	\N	2026-10-11 15:10:16.699485+00	2026-10-11 15:10:16.699485+00
2819	2805	Audiobook	\N	2026	\N	2026-10-11 15:10:16.702254+00	2026-10-11 15:10:16.702254+00
2820	2357	Audiobook	\N	2026	\N	2026-10-11 15:10:16.704471+00	2026-10-11 15:10:16.704471+00
2821	2846	Audiobook	\N	2026	\N	2026-10-11 15:10:16.706665+00	2026-10-11 15:10:16.706665+00
2822	2806	Audiobook	\N	2026	\N	2026-10-11 15:10:16.708798+00	2026-10-11 15:10:16.708798+00
2823	2593	Audiobook	\N	2026	\N	2026-10-11 15:10:16.710931+00	2026-10-11 15:10:16.710931+00
2824	2994	Audiobook	\N	2026	\N	2026-10-11 15:10:16.717782+00	2026-10-11 15:10:16.717782+00
2825	2995	Audiobook	\N	2026	\N	2026-10-11 15:10:16.724636+00	2026-10-11 15:10:16.724636+00
2826	2828	Audiobook	\N	2026	\N	2026-10-11 15:10:16.726915+00	2026-10-11 15:10:16.726915+00
2827	2834	Audiobook	\N	2026	\N	2026-10-11 15:10:16.729322+00	2026-10-11 15:10:16.729322+00
2828	2746	Audiobook	\N	2026	\N	2026-10-11 15:10:16.731758+00	2026-10-11 15:10:16.731758+00
2829	2854	Audiobook	\N	2026	\N	2026-10-11 15:10:16.733979+00	2026-10-11 15:10:16.733979+00
2830	2853	Audiobook	\N	2026	\N	2026-10-11 15:10:16.736214+00	2026-10-11 15:10:16.736214+00
2831	2841	Audiobook	\N	2026	\N	2026-10-11 15:10:16.738418+00	2026-10-11 15:10:16.738418+00
2832	2855	Audiobook	\N	2026	\N	2026-10-11 15:10:16.740648+00	2026-10-11 15:10:16.740648+00
2833	2814	Audiobook	\N	2026	\N	2026-10-11 15:10:16.742732+00	2026-10-11 15:10:16.742732+00
2834	2588	Audiobook	\N	2026	\N	2026-10-11 15:10:16.744929+00	2026-10-11 15:10:16.744929+00
2835	2862	Audiobook	\N	2026	\N	2026-10-11 15:10:16.747051+00	2026-10-11 15:10:16.747051+00
2836	2996	Audiobook	\N	2026	\N	2026-10-11 15:10:16.753725+00	2026-10-11 15:10:16.753725+00
2837	2836	Audiobook	\N	2026	\N	2026-10-11 15:10:16.75596+00	2026-10-11 15:10:16.75596+00
2838	2759	Audiobook	\N	2026	\N	2026-10-11 15:10:16.758128+00	2026-10-11 15:10:16.758128+00
2839	2384	Audiobook	\N	2026	\N	2026-10-11 15:10:16.760197+00	2026-10-11 15:10:16.760197+00
2840	2898	Audiobook	\N	2026	\N	2026-10-11 15:10:16.762727+00	2026-10-11 15:10:16.762727+00
2841	2342	Audiobook	\N	2026	\N	2026-10-11 15:10:16.764817+00	2026-10-11 15:10:16.764817+00
2842	2360	Audiobook	\N	2026	\N	2026-10-11 15:10:16.76704+00	2026-10-11 15:10:16.76704+00
2843	2913	Audiobook	\N	2026	\N	2026-10-11 15:10:16.769143+00	2026-10-11 15:10:16.769143+00
2844	2826	Audiobook	\N	2026	\N	2026-10-11 15:10:16.771493+00	2026-10-11 15:10:16.771493+00
2845	2380	Audiobook	\N	2026	\N	2026-10-11 15:10:16.773678+00	2026-10-11 15:10:16.773678+00
2846	2892	Audiobook	\N	2026	\N	2026-10-11 15:10:16.775796+00	2026-10-11 15:10:16.775796+00
2847	2901	Audiobook	\N	2026	\N	2026-10-11 15:10:16.794811+00	2026-10-11 15:10:16.794811+00
2848	2997	Audiobook	\N	2026	\N	2026-10-11 15:10:16.803054+00	2026-10-11 15:10:16.803054+00
2849	2998	Audiobook	\N	2026	\N	2026-10-11 15:10:16.820832+00	2026-10-11 15:10:16.820832+00
2850	2830	Audiobook	\N	2026	\N	2026-10-11 15:10:16.823623+00	2026-10-11 15:10:16.823623+00
2851	2879	Audiobook	\N	2026	\N	2026-10-11 15:10:16.826109+00	2026-10-11 15:10:16.826109+00
2852	2849	Audiobook	\N	2026	\N	2026-10-11 15:10:16.82851+00	2026-10-11 15:10:16.82851+00
2853	2904	Audiobook	\N	2026	\N	2026-10-11 15:10:16.831538+00	2026-10-11 15:10:16.831538+00
2854	2939	Audiobook	\N	2026	\N	2026-10-11 15:10:16.833825+00	2026-10-11 15:10:16.833825+00
2855	2376	Audiobook	\N	2026	\N	2026-10-11 15:10:16.836006+00	2026-10-11 15:10:16.836006+00
2856	2938	Audiobook	\N	2026	\N	2026-10-11 15:10:16.838143+00	2026-10-11 15:10:16.838143+00
2857	2887	Audiobook	\N	2026	\N	2026-10-11 15:10:16.840322+00	2026-10-11 15:10:16.840322+00
2858	2944	Audiobook	\N	2026	\N	2026-10-11 15:10:16.842969+00	2026-10-11 15:10:16.842969+00
2859	2368	Audiobook	\N	2026	\N	2026-10-11 15:10:16.8452+00	2026-10-11 15:10:16.8452+00
2860	1540	Audiobook	\N	2026	\N	2026-10-11 15:10:16.84739+00	2026-10-11 15:10:16.84739+00
2861	2305	Audiobook	\N	2026	\N	2026-10-11 15:10:16.849572+00	2026-10-11 15:10:16.849572+00
2862	2304	Audiobook	\N	2026	\N	2026-10-11 15:10:16.85193+00	2026-10-11 15:10:16.85193+00
2863	2289	Audiobook	\N	2026	\N	2026-10-11 15:10:16.854233+00	2026-10-11 15:10:16.854233+00
2864	2361	Audiobook	\N	2026	\N	2026-10-11 15:10:16.856452+00	2026-10-11 15:10:16.856452+00
2865	1534	Audiobook	\N	2026	\N	2026-10-11 15:10:16.858617+00	2026-10-11 15:10:16.858617+00
2866	2953	Audiobook	\N	2026	\N	2026-10-11 15:10:16.860996+00	2026-10-11 15:10:16.860996+00
2867	2999	Audiobook	\N	2026	\N	2026-10-11 15:10:16.865723+00	2026-10-11 15:10:16.865723+00
2868	2866	Audiobook	\N	2026	\N	2026-10-11 15:10:16.868006+00	2026-10-11 15:10:16.868006+00
2869	2890	Audiobook	\N	2026	\N	2026-10-11 15:10:16.870132+00	2026-10-11 15:10:16.870132+00
2870	2937	Audiobook	\N	2026	\N	2026-10-11 15:10:16.872426+00	2026-10-11 15:10:16.872426+00
2871	2894	Audiobook	\N	2026	\N	2026-10-11 15:10:16.874692+00	2026-10-11 15:10:16.874692+00
2872	2908	Audiobook	\N	2026	\N	2026-10-11 15:10:16.876914+00	2026-10-11 15:10:16.876914+00
2873	2784	Audiobook	\N	2026	\N	2026-10-11 15:10:16.879085+00	2026-10-11 15:10:16.879085+00
2874	2958	Audiobook	\N	2026	\N	2026-10-11 15:10:16.881246+00	2026-10-11 15:10:16.881246+00
2875	2463	Audiobook	\N	2026	\N	2026-10-11 15:10:16.883521+00	2026-10-11 15:10:16.883521+00
2876	2960	Audiobook	\N	2026	\N	2026-10-11 15:10:16.885915+00	2026-10-11 15:10:16.885915+00
2877	2916	Audiobook	\N	2026	\N	2026-10-11 15:10:16.888249+00	2026-10-11 15:10:16.888249+00
2878	2959	Audiobook	\N	2026	\N	2026-10-11 15:10:16.890666+00	2026-10-11 15:10:16.890666+00
2879	2374	Audiobook	\N	2026	\N	2026-10-11 15:10:16.893666+00	2026-10-11 15:10:16.893666+00
2880	2935	Audiobook	\N	2026	\N	2026-10-11 15:10:16.895781+00	2026-10-11 15:10:16.895781+00
2881	2956	Audiobook	\N	2026	\N	2026-10-11 15:10:16.897849+00	2026-10-11 15:10:16.897849+00
2882	3000	Audiobook	\N	2026	\N	2026-10-11 15:10:16.905027+00	2026-10-11 15:10:16.905027+00
2883	2961	Audiobook	\N	2026	\N	2026-10-11 15:10:16.907485+00	2026-10-11 15:10:16.907485+00
2884	2932	Audiobook	\N	2026	\N	2026-10-11 15:10:16.909875+00	2026-10-11 15:10:16.909875+00
2885	2829	Audiobook	\N	2026	\N	2026-10-11 15:10:16.912252+00	2026-10-11 15:10:16.912252+00
2886	3001	Audiobook	\N	2026	\N	2026-10-11 15:10:16.916874+00	2026-10-11 15:10:16.916874+00
2887	2353	Audiobook	\N	2026	\N	2026-10-11 15:10:16.919259+00	2026-10-11 15:10:16.919259+00
2888	2352	Audiobook	\N	2026	\N	2026-10-11 15:10:16.921645+00	2026-10-11 15:10:16.921645+00
2889	3002	Audiobook	\N	2026	\N	2026-10-11 15:10:16.926488+00	2026-10-11 15:10:16.926488+00
2890	3003	Audiobook	\N	2026	\N	2026-10-11 15:10:16.931525+00	2026-10-11 15:10:16.931525+00
2891	2375	Audiobook	\N	2026	\N	2026-10-11 15:10:16.934084+00	2026-10-11 15:10:16.934084+00
2892	2975	Audiobook	\N	2026	\N	2026-10-11 15:10:16.936868+00	2026-10-11 15:10:16.936868+00
2893	3004	Audiobook	\N	2026	\N	2026-10-11 15:10:16.94468+00	2026-10-11 15:10:16.94468+00
2894	2377	Audiobook	\N	2026	\N	2026-10-11 15:10:16.947107+00	2026-10-11 15:10:16.947107+00
2895	1535	Audiobook	\N	2026	\N	2026-10-11 15:10:16.949537+00	2026-10-11 15:10:16.949537+00
2896	3005	Audiobook	\N	2026	\N	2026-10-11 15:10:16.954992+00	2026-10-11 15:10:16.954992+00
2897	2312	Audiobook	\N	2026	\N	2026-10-11 15:10:16.957643+00	2026-10-11 15:10:16.957643+00
2898	2382	Audiobook	\N	2026	\N	2026-10-11 15:10:16.959886+00	2026-10-11 15:10:16.959886+00
2899	3006	Audiobook	\N	2026	\N	2026-10-11 15:10:16.966556+00	2026-10-11 15:10:16.966556+00
2900	2372	Audiobook	\N	2026	\N	2026-10-11 15:10:16.968784+00	2026-10-11 15:10:16.968784+00
2901	2979	Audiobook	\N	2026	\N	2026-10-11 15:10:16.971047+00	2026-10-11 15:10:16.971047+00
2902	2973	Audiobook	\N	2026	\N	2026-10-11 15:10:16.973385+00	2026-10-11 15:10:16.973385+00
2903	2590	Audiobook	\N	2026	\N	2026-10-11 15:10:16.975534+00	2026-10-11 15:10:16.975534+00
2904	2974	Audiobook	\N	2026	\N	2026-10-11 15:10:16.977682+00	2026-10-11 15:10:16.977682+00
2905	2864	Audiobook	\N	2026	\N	2026-10-11 15:10:16.980039+00	2026-10-11 15:10:16.980039+00
2906	3007	Audiobook	\N	2026	\N	2026-10-11 15:10:16.986589+00	2026-10-11 15:10:16.986589+00
2907	2900	Audiobook	\N	2026	\N	2026-10-11 15:10:16.988816+00	2026-10-11 15:10:16.988816+00
2908	2764	Audiobook	\N	2026	\N	2026-10-11 15:10:16.991441+00	2026-10-11 15:10:16.991441+00
2909	3008	Audiobook	\N	2026	\N	2026-10-11 15:10:16.996499+00	2026-10-11 15:10:16.996499+00
2910	2986	Audiobook	\N	2026	\N	2026-10-11 15:10:16.998791+00	2026-10-11 15:10:16.998791+00
2911	3009	Audiobook	\N	2026	\N	2026-10-11 15:10:17.003478+00	2026-10-11 15:10:17.003478+00
2912	3010	Audiobook	\N	2026	\N	2026-10-11 15:10:17.00818+00	2026-10-11 15:10:17.00818+00
2913	2992	Audiobook	\N	2026	\N	2026-10-11 15:10:17.01035+00	2026-10-11 15:10:17.01035+00
2914	2993	Audiobook	\N	2026	\N	2026-10-11 15:10:17.01261+00	2026-10-11 15:10:17.01261+00
2915	3011	Audiobook	\N	2026	\N	2026-10-11 15:10:17.017119+00	2026-10-11 15:10:17.017119+00
2916	2534	Audiobook	\N	2026	\N	2026-10-11 15:10:17.019256+00	2026-10-11 15:10:17.019256+00
2917	2343	Audiobook	\N	2026	\N	2026-10-11 15:10:17.021611+00	2026-10-11 15:10:17.021611+00
2918	2976	Audiobook	\N	2026	\N	2026-10-11 15:10:17.024987+00	2026-10-11 15:10:17.024987+00
2919	3012	Audiobook	\N	2026	\N	2026-10-11 15:10:17.029714+00	2026-10-11 15:10:17.029714+00
2920	3013	Audiobook	\N	2026	\N	2026-10-11 15:10:17.034095+00	2026-10-11 15:10:17.034095+00
2921	3014	Audiobook	\N	2026	\N	2026-10-11 15:10:17.04198+00	2026-10-11 15:10:17.04198+00
2922	3015	Audiobook	\N	2026	\N	2026-10-11 15:10:17.04874+00	2026-10-11 15:10:17.04874+00
2923	3016	Audiobook	\N	2026	\N	2026-10-11 15:10:17.053312+00	2026-10-11 15:10:17.053312+00
2924	2386	Audiobook	\N	2026	\N	2026-10-11 15:10:17.055492+00	2026-10-11 15:10:17.055492+00
2925	2945	Audiobook	\N	2026	\N	2026-10-11 15:10:17.057634+00	2026-10-11 15:10:17.057634+00
2926	2947	Audiobook	\N	2026	\N	2026-10-11 15:10:17.059725+00	2026-10-11 15:10:17.059725+00
2927	2946	Audiobook	\N	2026	\N	2026-10-11 15:10:17.062196+00	2026-10-11 15:10:17.062196+00
2928	2957	Audiobook	\N	2026	\N	2026-10-11 15:10:17.064414+00	2026-10-11 15:10:17.064414+00
2929	2888	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.081619+00	2026-10-11 15:10:17.081619+00
2930	2356	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.084303+00	2026-10-11 15:10:17.084303+00
2931	3013	Ebook	\N	2026	\N	2026-10-11 15:10:17.155761+00	2026-10-11 15:10:17.155761+00
2932	3016	Ebook	\N	2026	\N	2026-10-11 15:10:17.15864+00	2026-10-11 15:10:17.15864+00
2933	3017	Ebook	\N	2026	\N	2026-10-11 15:10:17.163629+00	2026-10-11 15:10:17.163629+00
2934	3015	Ebook	\N	2026	\N	2026-10-11 15:10:17.165945+00	2026-10-11 15:10:17.165945+00
2935	3014	Ebook	\N	2026	\N	2026-10-11 15:10:17.168098+00	2026-10-11 15:10:17.168098+00
2936	3018	Ebook	\N	2026	\N	2026-10-11 15:10:17.174739+00	2026-10-11 15:10:17.174739+00
2937	2386	Ebook	\N	2026	\N	2026-10-11 15:10:17.177025+00	2026-10-11 15:10:17.177025+00
2938	3019	Ebook	\N	2026	ZLibrary	2026-10-11 15:10:17.182464+00	2026-10-11 15:10:17.182464+00
2939	3020	Ebook	\N	2026	ZLibrary	2026-10-11 15:10:17.18701+00	2026-10-11 15:10:17.18701+00
2940	3021	Ebook	\N	2026	ZLibrary	2026-10-11 15:10:17.193912+00	2026-10-11 15:10:17.193912+00
2941	3022	Ebook	\N	2026	ZLibrary	2026-10-11 15:10:17.200527+00	2026-10-11 15:10:17.200527+00
2942	3023	Ebook	\N	2026	ZLibrary	2026-10-11 15:10:17.206933+00	2026-10-11 15:10:17.206933+00
2943	3024	Ebook	\N	2026	ZLibrary	2026-10-11 15:10:17.211602+00	2026-10-11 15:10:17.211602+00
2944	3025	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.216043+00	2026-10-11 15:10:17.216043+00
2945	3019	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.218345+00	2026-10-11 15:10:17.218345+00
2946	3024	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.221457+00	2026-10-11 15:10:17.221457+00
2947	2500	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.223843+00	2026-10-11 15:10:17.223843+00
2948	3026	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.23104+00	2026-10-11 15:10:17.23104+00
2949	2394	Audiobook	\N	2026	Audiobookbay	2026-10-11 15:10:17.233627+00	2026-10-11 15:10:17.233627+00
2950	3026	Ebook	\N	2026	ZLibrary	2026-10-11 15:10:17.236025+00	2026-10-11 15:10:17.236025+00
\.


--
-- Data for Name: flyway_schema_history; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.flyway_schema_history (installed_rank, version, description, type, script, checksum, installed_by, installed_on, execution_time, success) FROM stdin;
1	1	baseline	SQL	V1__baseline.sql	569280777	neondb_owner	2026-10-09 10:42:31.143297	19	t
2	2	books authors readings lists	SQL	V2__books_authors_readings_lists.sql	430343316	neondb_owner	2026-10-09 12:16:50.009803	545	t
3	3	seed list values	SQL	V3__seed_list_values.sql	698802888	neondb_owner	2026-10-09 12:16:50.893319	186	t
4	4	copies and loans	SQL	V4__copies_and_loans.sql	-1441206169	neondb_owner	2026-10-11 15:04:43.271368	169	t
5	5	series	SQL	V5__series.sql	1942934954	neondb_owner	2026-10-11 15:54:23.007116	124	t
\.


--
-- Data for Name: library_loan; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.library_loan (id, book_id, library, date_due, returned, created_at, updated_at) FROM stdin;
10	1479	Knjižnica Virovitica	2026-04-08	t	2026-10-11 15:10:17.271341+00	2026-10-11 15:10:17.271341+00
11	1491	Knjižnica Savski Gaj	2026-06-02	t	2026-10-11 15:10:17.274669+00	2026-10-11 15:10:17.274669+00
12	1511	Knjižnica Sloboština	2026-08-17	t	2026-10-11 15:10:17.358028+00	2026-10-11 15:10:17.358028+00
13	3027	Knjižnica Sloboština	2026-08-21	t	2026-10-11 15:10:17.368793+00	2026-10-11 15:10:17.368793+00
14	1523	Knjižnica Sloboština	2026-09-07	t	2026-10-11 15:10:17.371762+00	2026-10-11 15:10:17.371762+00
15	1525	Knjižnica Sloboština	2026-09-08	t	2026-10-11 15:10:17.376306+00	2026-10-11 15:10:17.376306+00
16	1531	Knjižnica Sloboština	2026-09-29	t	2026-10-11 15:10:17.379676+00	2026-10-11 15:10:17.379676+00
17	3028	Knjižnica Sloboština	2026-09-29	t	2026-10-11 15:10:17.388823+00	2026-10-11 15:10:17.388823+00
18	1542	Knjižnica Virovitica	2026-11-05	f	2026-10-11 15:10:17.391491+00	2026-10-11 15:10:17.391491+00
\.


--
-- Data for Name: list_value; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.list_value (id, category, value, sort_order, hidden, created_at, updated_at) FROM stdin;
1	GENRE	Dystopian	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
2	GENRE	Fantasy	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
3	GENRE	Historical fiction	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
4	GENRE	Horror	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
5	GENRE	Literary fiction	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
6	GENRE	Mystery	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
7	GENRE	Non-fiction	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
8	GENRE	Romance	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
9	GENRE	Science fiction	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
10	GENRE	Speculative	10	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
11	GENRE	Thriller	11	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
12	FORMAT	Audiobook	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
13	FORMAT	Ebook	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
14	FORMAT	Physical	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
15	TYPE	Memoir	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
16	TYPE	Novel	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
17	TYPE	Novella	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
18	TYPE	Short stories	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
19	AUDIENCE	Adult	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
20	AUDIENCE	Young adult	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
21	AUDIENCE	Middle-grade	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
22	AUDIENCE	Children	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
23	ACQUIRED	Bought	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
24	ACQUIRED	Downloaded	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
25	ACQUIRED	Gifted	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
26	ACQUIRED	Library	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
27	ACQUIRED	Libro.fm	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
28	ACQUIRED	Owned	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
29	ACQUIRED	Scribd	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
30	LANGUAGE	Afrikaans	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
31	LANGUAGE	Albanian	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
32	LANGUAGE	Arabic	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
33	LANGUAGE	Armenian	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
34	LANGUAGE	Basque	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
35	LANGUAGE	Belarusian	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
36	LANGUAGE	Bengali	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
37	LANGUAGE	Bosnian	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
38	LANGUAGE	Bulgarian	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
39	LANGUAGE	Catalan	10	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
40	LANGUAGE	Chinese	11	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
41	LANGUAGE	Croatian	12	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
42	LANGUAGE	Czech	13	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
43	LANGUAGE	Danish	14	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
44	LANGUAGE	Dutch	15	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
45	LANGUAGE	English	16	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
46	LANGUAGE	Estonian	17	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
47	LANGUAGE	Filipino	18	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
48	LANGUAGE	Finnish	19	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
49	LANGUAGE	French	20	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
50	LANGUAGE	Georgian	21	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
51	LANGUAGE	German	22	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
52	LANGUAGE	Greek	23	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
53	LANGUAGE	Hebrew	24	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
54	LANGUAGE	Hindi	25	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
55	LANGUAGE	Hungarian	26	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
56	LANGUAGE	Icelandic	27	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
57	LANGUAGE	Indonesian	28	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
58	LANGUAGE	Irish	29	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
59	LANGUAGE	Italian	30	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
60	LANGUAGE	Japanese	31	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
61	LANGUAGE	Korean	32	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
62	LANGUAGE	Latin	33	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
63	LANGUAGE	Latvian	34	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
64	LANGUAGE	Lithuanian	35	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
65	LANGUAGE	Macedonian	36	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
66	LANGUAGE	Malay	37	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
67	LANGUAGE	Maltese	38	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
68	LANGUAGE	Norwegian	39	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
69	LANGUAGE	Persian	40	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
70	LANGUAGE	Polish	41	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
71	LANGUAGE	Portuguese	42	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
72	LANGUAGE	Romanian	43	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
73	LANGUAGE	Russian	44	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
74	LANGUAGE	Serbian	45	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
75	LANGUAGE	Slovak	46	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
76	LANGUAGE	Slovenian	47	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
77	LANGUAGE	Spanish	48	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
78	LANGUAGE	Swahili	49	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
79	LANGUAGE	Swedish	50	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
80	LANGUAGE	Tamil	51	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
81	LANGUAGE	Thai	52	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
82	LANGUAGE	Turkish	53	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
83	LANGUAGE	Ukrainian	54	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
84	LANGUAGE	Urdu	55	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
85	LANGUAGE	Vietnamese	56	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
86	LANGUAGE	Welsh	57	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
87	LANGUAGE	Yiddish	58	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
88	PURPOSE	Bookclub	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
89	PURPOSE	Buzzwordathon	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
90	PURPOSE	Readathon	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
91	PURPOSE	BRBN Bingo	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
92	PURPOSE	TBR Jar	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
93	PURPOSE	TBR Game	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
94	COUNTRY	Afghanistan	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
95	COUNTRY	Albania	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
96	COUNTRY	Algeria	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
97	COUNTRY	Antarctica	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
98	COUNTRY	Argentina	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
99	COUNTRY	Armenia	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
100	COUNTRY	Australia	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
101	COUNTRY	Austria	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
102	COUNTRY	Bangladesh	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
103	COUNTRY	Belarus	10	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
104	COUNTRY	Belgium	11	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
105	COUNTRY	Bolivia	12	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
106	COUNTRY	Bosnia and Herzegovina	13	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
107	COUNTRY	Botswana	14	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
108	COUNTRY	Brazil	15	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
109	COUNTRY	Bulgaria	16	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
110	COUNTRY	Cambodia	17	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
111	COUNTRY	Cameroon	18	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
112	COUNTRY	Canada	19	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
113	COUNTRY	Chile	20	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
114	COUNTRY	China	21	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
115	COUNTRY	Colombia	22	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
116	COUNTRY	Costa Rica	23	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
117	COUNTRY	Croatia	24	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
118	COUNTRY	Cuba	25	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
119	COUNTRY	Cyprus	26	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
120	COUNTRY	Denmark	27	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
121	COUNTRY	Dominican Republic	28	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
122	COUNTRY	Ecuador	29	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
123	COUNTRY	Egypt	30	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
124	COUNTRY	Estonia	31	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
125	COUNTRY	Ethiopia	32	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
126	COUNTRY	Falkland Islands	33	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
127	COUNTRY	Finland	34	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
128	COUNTRY	France	35	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
129	COUNTRY	Georgia	36	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
130	COUNTRY	Germany	37	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
131	COUNTRY	Ghana	38	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
132	COUNTRY	Greece	39	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
133	COUNTRY	Guatemala	40	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
134	COUNTRY	Haiti	41	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
135	COUNTRY	Hungary	42	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
136	COUNTRY	Iceland	43	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
137	COUNTRY	India	44	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
138	COUNTRY	Indonesia	45	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
139	COUNTRY	Iran	46	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
140	COUNTRY	Iraq	47	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
141	COUNTRY	Ireland	48	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
142	COUNTRY	Israel	49	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
143	COUNTRY	Italy	50	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
144	COUNTRY	Ivory Coast	51	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
145	COUNTRY	Jamaica	52	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
146	COUNTRY	Japan	53	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
147	COUNTRY	Jordan	54	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
148	COUNTRY	Kazakhstan	55	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
149	COUNTRY	Kenya	56	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
150	COUNTRY	Kuwait	57	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
151	COUNTRY	Laos	58	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
152	COUNTRY	Latvia	59	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
153	COUNTRY	Lebanon	60	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
154	COUNTRY	Libya	61	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
155	COUNTRY	Lithuania	62	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
156	COUNTRY	Luxembourg	63	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
157	COUNTRY	Malaysia	64	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
158	COUNTRY	Malta	65	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
159	COUNTRY	Mexico	66	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
160	COUNTRY	Mongolia	67	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
161	COUNTRY	Montenegro	68	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
162	COUNTRY	Morocco	69	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
163	COUNTRY	Myanmar	70	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
164	COUNTRY	Nepal	71	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
165	COUNTRY	New Zealand	72	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
166	COUNTRY	Nigeria	73	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
167	COUNTRY	North Korea	74	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
168	COUNTRY	North Macedonia	75	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
169	COUNTRY	Norway	76	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
170	COUNTRY	Pakistan	77	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
171	COUNTRY	Palestine	78	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
172	COUNTRY	Panama	79	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
173	COUNTRY	Peru	80	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
174	COUNTRY	Philippines	81	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
175	COUNTRY	Poland	82	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
176	COUNTRY	Portugal	83	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
177	COUNTRY	Puerto Rico	84	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
178	COUNTRY	Qatar	85	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
179	COUNTRY	Romania	86	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
180	COUNTRY	Russia	87	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
181	COUNTRY	Rwanda	88	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
182	COUNTRY	Saudi Arabia	89	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
183	COUNTRY	Senegal	90	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
184	COUNTRY	Serbia	91	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
185	COUNTRY	Singapore	92	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
186	COUNTRY	Slovakia	93	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
187	COUNTRY	Slovenia	94	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
188	COUNTRY	Somalia	95	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
189	COUNTRY	South Africa	96	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
190	COUNTRY	South Korea	97	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
191	COUNTRY	Spain	98	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
192	COUNTRY	Sri Lanka	99	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
193	COUNTRY	Sudan	100	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
194	COUNTRY	Sweden	101	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
195	COUNTRY	Switzerland	102	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
196	COUNTRY	Syria	103	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
197	COUNTRY	Taiwan	104	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
198	COUNTRY	Tanzania	105	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
199	COUNTRY	Thailand	106	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
200	COUNTRY	The Czech Republic	107	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
201	COUNTRY	The Netherlands	108	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
202	COUNTRY	The United Kingdom	109	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
203	COUNTRY	Trinidad and Tobago	110	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
204	COUNTRY	Tunisia	111	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
205	COUNTRY	Turkiye	112	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
206	COUNTRY	U.S. Virgin Islands	113	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
207	COUNTRY	USA	114	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
208	COUNTRY	Uganda	115	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
209	COUNTRY	Ukraine	116	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
210	COUNTRY	United Arab Emirates	117	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
211	COUNTRY	Uruguay	118	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
212	COUNTRY	Uzbekistan	119	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
213	COUNTRY	Venezuela	120	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
214	COUNTRY	Vietnam	121	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
215	COUNTRY	Zambia	122	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
216	COUNTRY	Zimbabwe	123	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
217	COUNTRY	Fiji	124	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
218	AUTHOR_GENDER	Male	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
219	AUTHOR_GENDER	Female	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
220	AUTHOR_GENDER	Non-binary	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
221	AUTHOR_STATUS	Debut	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
222	AUTHOR_STATUS	New to me	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
223	AUTHOR_STATUS	Read before	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
224	SERIAL	Series	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
225	SERIAL	Standalone	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
226	SERIAL	Collection	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
227	BOOKCLUB	IRL	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
228	BOOKCLUB	Literally Dead Bookclub	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
229	BOOKCLUB	The Book Troop	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
230	BOOKCLUB	Lights Out Bookclub	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
231	BOOKCLUB	The Thriller Troop Bookclub	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
232	BOOKCLUB	Full Moon Bookclub	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
233	BOOKCLUB	BRBN Bookclub	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
234	BOOKCLUB	Queer Bookclub	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
235	BOOKCLUB	Gin Tonic Bookaholics Bookclub	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
236	BUZZWORD	"before" and "after"	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
237	BUZZWORD	keyboard keys	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
238	BUZZWORD	this / that / these / those	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
239	BUZZWORD	ordinal numbers	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
240	BUZZWORD	"make"	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
241	BUZZWORD	one word title	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
242	BUZZWORD	occupation	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
243	BUZZWORD	groups, clubs and societies	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
244	BUZZWORD	me / my / mine	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
245	BUZZWORD	parts of a house	10	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
246	BUZZWORD	instructional title	11	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
247	BUZZWORD	superlatives	12	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
248	BUZZWORD	dream	13	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
249	BUZZWORD	color	14	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
250	BUZZWORD	name and title	15	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
251	BUZZWORD_COVER	internal body part	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
252	BUZZWORD_COVER	silhouette	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
253	BUZZWORD_COVER	action / movement	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
254	BUZZWORD_COVER	accessories	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
255	BUZZWORD_COVER	border	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
256	BUZZWORD_COVER	wings	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
257	BUZZWORD_COVER	metallic element	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
258	BUZZWORD_COVER	damage	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
259	BUZZWORD_COVER	fire / smoke	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
260	BUZZWORD_COVER	keys / doors / locks	10	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
261	BUZZWORD_COVER	reflection	11	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
262	BUZZWORD_COVER	music	12	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
263	COVER_COLOR	Beige	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
264	COVER_COLOR	Black	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
265	COVER_COLOR	Blue	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
266	COVER_COLOR	Brown	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
267	COVER_COLOR	Gray	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
268	COVER_COLOR	Green	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
269	COVER_COLOR	Orange	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
270	COVER_COLOR	Pink	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
271	COVER_COLOR	Purple	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
272	COVER_COLOR	Red	10	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
273	COVER_COLOR	Teal	11	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
274	COVER_COLOR	White	12	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
275	COVER_COLOR	Yellow	13	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
276	COVER_COLOR	Multicolor	14	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
277	PHYSICAL_SOURCE	Libristo	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
278	PHYSICAL_SOURCE	Facebook	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
279	PHYSICAL_SOURCE	Wob	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
280	PHYSICAL_SOURCE	Interliber	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
281	PHYSICAL_SOURCE	Znanje	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
282	PHYSICAL_SOURCE	Hoću knjigu	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
283	PHYSICAL_SOURCE	Gift	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
284	PHYSICAL_SOURCE	Interspar	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
285	PHYSICAL_SOURCE	Travel	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
286	DIGITAL_SOURCE	ZLibrary	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
287	DIGITAL_SOURCE	Audiobookbay	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
288	DIGITAL_SOURCE	Libro.fm	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
289	SETTING	Afghanistan	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
290	SETTING	Albania	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
291	SETTING	Algeria	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
292	SETTING	Antarctica	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
293	SETTING	Argentina	5	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
294	SETTING	Armenia	6	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
295	SETTING	Australia	7	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
296	SETTING	Austria	8	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
297	SETTING	Bangladesh	9	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
298	SETTING	Belarus	10	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
299	SETTING	Belgium	11	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
300	SETTING	Bolivia	12	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
301	SETTING	Bosnia and Herzegovina	13	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
302	SETTING	Botswana	14	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
303	SETTING	Brazil	15	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
304	SETTING	Bulgaria	16	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
305	SETTING	Cambodia	17	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
306	SETTING	Cameroon	18	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
307	SETTING	Canada	19	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
308	SETTING	Chile	20	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
309	SETTING	China	21	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
310	SETTING	Colombia	22	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
311	SETTING	Costa Rica	23	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
312	SETTING	Croatia	24	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
313	SETTING	Cuba	25	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
314	SETTING	Cyprus	26	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
315	SETTING	Denmark	27	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
316	SETTING	Dominican Republic	28	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
317	SETTING	Ecuador	29	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
318	SETTING	Egypt	30	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
319	SETTING	Estonia	31	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
320	SETTING	Ethiopia	32	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
321	SETTING	Falkland Islands	33	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
322	SETTING	Fictional	34	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
323	SETTING	Fiji	35	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
324	SETTING	Finland	36	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
325	SETTING	France	37	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
326	SETTING	Georgia	38	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
327	SETTING	Germany	39	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
328	SETTING	Ghana	40	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
329	SETTING	Greece	41	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
330	SETTING	Guatemala	42	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
331	SETTING	Haiti	43	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
332	SETTING	Hungary	44	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
333	SETTING	Iceland	45	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
334	SETTING	India	46	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
335	SETTING	Indonesia	47	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
336	SETTING	Iran	48	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
337	SETTING	Iraq	49	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
338	SETTING	Ireland	50	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
339	SETTING	Israel	51	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
340	SETTING	Italy	52	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
341	SETTING	Ivory Coast	53	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
342	SETTING	Jamaica	54	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
343	SETTING	Japan	55	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
344	SETTING	Jordan	56	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
345	SETTING	Kazakhstan	57	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
346	SETTING	Kenya	58	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
347	SETTING	Kuwait	59	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
348	SETTING	Laos	60	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
349	SETTING	Latvia	61	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
350	SETTING	Lebanon	62	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
351	SETTING	Libya	63	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
352	SETTING	Lithuania	64	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
353	SETTING	Luxembourg	65	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
354	SETTING	Malaysia	66	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
355	SETTING	Malta	67	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
356	SETTING	Mexico	68	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
357	SETTING	Mongolia	69	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
358	SETTING	Montenegro	70	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
359	SETTING	Morocco	71	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
360	SETTING	Myanmar	72	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
361	SETTING	Nepal	73	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
362	SETTING	New Zealand	74	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
363	SETTING	Nigeria	75	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
364	SETTING	North Korea	76	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
365	SETTING	North Macedonia	77	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
366	SETTING	Norway	78	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
367	SETTING	Pakistan	79	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
368	SETTING	Palestine	80	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
369	SETTING	Panama	81	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
370	SETTING	Peru	82	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
371	SETTING	Philippines	83	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
372	SETTING	Poland	84	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
373	SETTING	Portugal	85	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
374	SETTING	Puerto Rico	86	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
375	SETTING	Qatar	87	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
376	SETTING	Romania	88	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
377	SETTING	Russia	89	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
378	SETTING	Rwanda	90	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
379	SETTING	Saudi Arabia	91	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
380	SETTING	Senegal	92	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
381	SETTING	Serbia	93	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
382	SETTING	Singapore	94	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
383	SETTING	Slovakia	95	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
384	SETTING	Slovenia	96	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
385	SETTING	Somalia	97	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
386	SETTING	South Africa	98	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
387	SETTING	South Korea	99	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
388	SETTING	Space	100	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
389	SETTING	Spain	101	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
390	SETTING	Sri Lanka	102	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
391	SETTING	Sudan	103	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
392	SETTING	Sweden	104	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
393	SETTING	Switzerland	105	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
394	SETTING	Syria	106	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
395	SETTING	Taiwan	107	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
396	SETTING	Tanzania	108	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
397	SETTING	Thailand	109	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
398	SETTING	The Czech Republic	110	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
399	SETTING	The Netherlands	111	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
400	SETTING	The United Kingdom	112	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
401	SETTING	Trinidad and Tobago	113	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
402	SETTING	Tunisia	114	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
403	SETTING	Turkiye	115	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
404	SETTING	U.S. Virgin Islands	116	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
405	SETTING	Uganda	117	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
406	SETTING	Ukraine	118	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
407	SETTING	United Arab Emirates	119	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
408	SETTING	Unknown	120	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
409	SETTING	Uruguay	121	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
410	SETTING	USA	122	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
411	SETTING	Uzbekistan	123	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
412	SETTING	Venezuela	124	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
413	SETTING	Vietnam	125	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
414	SETTING	Zambia	126	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
415	SETTING	Zimbabwe	127	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
416	LIBRARY	Knjižnica Sloboština	1	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
417	LIBRARY	Knjižnica Dugave	2	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
418	LIBRARY	Knjižnica Savski Gaj	3	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
419	LIBRARY	Knjižnica Virovitica	4	f	2026-10-09 12:16:51.024662+00	2026-10-09 12:16:51.024662+00
483	TYPE	Verse	5	t	2026-10-10 09:49:28.569865+00	2026-10-10 09:49:28.569865+00
484	READATHON	The Backlist Readathon	1	t	2026-10-10 09:49:33.075602+00	2026-10-10 09:49:33.075602+00
485	READATHON	Bookopolathon	2	t	2026-10-10 09:49:33.555121+00	2026-10-10 09:49:33.555121+00
486	READATHON	Summerween	3	t	2026-10-10 09:49:36.065735+00	2026-10-10 09:49:36.065735+00
487	READATHON	Reading in Melody	4	t	2026-10-10 09:49:37.354084+00	2026-10-10 09:49:37.354084+00
488	READATHON	Escape the Readathon	5	t	2026-10-10 09:49:38.576033+00	2026-10-10 09:49:38.576033+00
489	BUZZWORD	book related words	16	t	2026-10-10 09:49:40.168455+00	2026-10-10 09:49:40.168455+00
490	BUZZWORD	directions	17	t	2026-10-10 09:49:40.280949+00	2026-10-10 09:49:40.280949+00
491	BUZZWORD	items	18	t	2026-10-10 09:49:40.758435+00	2026-10-10 09:49:40.758435+00
492	BUZZWORD	pronouns & possesives	19	t	2026-10-10 09:49:40.771693+00	2026-10-10 09:49:40.771693+00
493	BUZZWORD	locations	20	t	2026-10-10 09:49:41.164888+00	2026-10-10 09:49:41.164888+00
494	BUZZWORD	the 5 w's	21	t	2026-10-10 09:49:41.368051+00	2026-10-10 09:49:41.368051+00
495	BUZZWORD	"all"	22	t	2026-10-10 09:49:41.456011+00	2026-10-10 09:49:41.456011+00
496	BUZZWORD	numbers	23	t	2026-10-10 09:49:42.391063+00	2026-10-10 09:49:42.391063+00
497	BUZZWORD	character names	24	t	2026-10-10 09:49:42.583241+00	2026-10-10 09:49:42.583241+00
498	BUZZWORD	creatures & animals	25	t	2026-10-10 09:49:42.782064+00	2026-10-10 09:49:42.782064+00
499	BUZZWORD	light & dark	26	t	2026-10-10 09:49:43.15882+00	2026-10-10 09:49:43.15882+00
500	BUZZWORD	verbs	27	t	2026-10-10 09:49:43.658337+00	2026-10-10 09:49:43.658337+00
501	BUZZWORD	life & death	28	t	2026-10-10 09:49:43.967339+00	2026-10-10 09:49:43.967339+00
502	BUZZWORD	emotions	29	t	2026-10-10 09:49:44.677927+00	2026-10-10 09:49:44.677927+00
503	BUZZWORD	"secret"	30	t	2026-10-10 09:49:44.689833+00	2026-10-10 09:49:44.689833+00
504	BUZZWORD	game	31	t	2026-10-10 09:49:44.959286+00	2026-10-10 09:49:44.959286+00
505	BUZZWORD	"other"	32	t	2026-10-10 09:49:45.164909+00	2026-10-10 09:49:45.164909+00
506	BUZZWORD	sound	33	t	2026-10-10 09:49:45.484359+00	2026-10-10 09:49:45.484359+00
507	BUZZWORD	flavours	34	t	2026-10-10 09:49:45.657101+00	2026-10-10 09:49:45.657101+00
508	BUZZWORD	"good"	35	t	2026-10-10 09:49:46.066232+00	2026-10-10 09:49:46.066232+00
509	BUZZWORD	body parts	36	t	2026-10-10 09:49:48.558914+00	2026-10-10 09:49:48.558914+00
510	BUZZWORD	there/their/they're	37	t	2026-10-10 09:49:51.966454+00	2026-10-10 09:49:51.966454+00
511	READATHON	Winterween	6	t	2026-10-10 09:49:51.968459+00	2026-10-10 09:49:51.968459+00
512	READATHON	Jante's Inferno	7	t	2026-10-10 09:49:53.858055+00	2026-10-10 09:49:53.858055+00
513	BUZZWORD	positive words	38	t	2026-10-10 09:49:54.255734+00	2026-10-10 09:49:54.255734+00
514	BUZZWORD	nature words	39	t	2026-10-10 09:49:56.28983+00	2026-10-10 09:49:56.28983+00
515	BUZZWORD	"every"	40	t	2026-10-10 09:49:57.156208+00	2026-10-10 09:49:57.156208+00
516	BUZZWORD	repeating words	41	t	2026-10-10 09:49:57.95864+00	2026-10-10 09:49:57.95864+00
517	BUZZWORD	"like"	42	t	2026-10-10 09:49:58.467445+00	2026-10-10 09:49:58.467445+00
518	BUZZWORD	measurements	43	t	2026-10-10 09:49:58.675003+00	2026-10-10 09:49:58.675003+00
519	READATHON	Seasonal Spooky Challenge	8	t	2026-10-10 09:50:01.181241+00	2026-10-10 09:50:01.181241+00
520	BUZZWORD	senses	44	t	2026-10-10 09:50:02.758814+00	2026-10-10 09:50:02.758814+00
521	BUZZWORD	holiday words	45	t	2026-10-10 09:50:04.261327+00	2026-10-10 09:50:04.261327+00
522	BUZZWORD_COVER	pattern	13	t	2026-10-10 09:50:04.986897+00	2026-10-10 09:50:04.986897+00
523	BUZZWORD	water	46	t	2026-10-10 09:50:07.066965+00	2026-10-10 09:50:07.066965+00
524	BUZZWORD_COVER	skyline	14	t	2026-10-10 09:50:07.368684+00	2026-10-10 09:50:07.368684+00
525	BUZZWORD	"thing"	47	t	2026-10-10 09:50:08.570487+00	2026-10-10 09:50:08.570487+00
526	BUZZWORD_COVER	books	15	t	2026-10-10 09:50:09.259022+00	2026-10-10 09:50:09.259022+00
527	BUZZWORD	animals	48	t	2026-10-10 09:50:10.052743+00	2026-10-10 09:50:10.052743+00
528	BUZZWORD_COVER	animals	16	t	2026-10-10 09:50:10.259194+00	2026-10-10 09:50:10.259194+00
529	BUZZWORD_COVER	eyes	17	t	2026-10-10 09:50:10.860315+00	2026-10-10 09:50:10.860315+00
530	BUZZWORD	"to" and "too"	49	t	2026-10-10 09:50:12.267913+00	2026-10-10 09:50:12.267913+00
531	READATHON	The Amazing Readathon	9	t	2026-10-10 09:50:13.187119+00	2026-10-10 09:50:13.187119+00
532	BUZZWORD_COVER	celestial	18	t	2026-10-10 09:50:13.871717+00	2026-10-10 09:50:13.871717+00
533	READATHON	Sunrise on the Readathon	10	t	2026-10-10 09:50:15.463263+00	2026-10-10 09:50:15.463263+00
534	BUZZWORD	punctuation	50	t	2026-10-10 09:50:16.768774+00	2026-10-10 09:50:16.768774+00
535	BUZZWORD_COVER	technology	19	t	2026-10-10 09:50:16.770648+00	2026-10-10 09:50:16.770648+00
536	BUZZWORD	"with"	51	t	2026-10-10 09:50:16.861856+00	2026-10-10 09:50:16.861856+00
537	BUZZWORD_COVER	transportation	20	t	2026-10-10 09:50:17.277085+00	2026-10-10 09:50:17.277085+00
538	READATHON	BRBN 24 Hour Readathon	11	t	2026-10-10 09:50:17.580722+00	2026-10-10 09:50:17.580722+00
539	BUZZWORD	events	52	t	2026-10-10 09:50:19.859129+00	2026-10-10 09:50:19.859129+00
540	BUZZWORD_COVER	foliage	21	t	2026-10-10 09:50:20.857049+00	2026-10-10 09:50:20.857049+00
541	BUZZWORD	violent	53	t	2026-10-10 09:50:22.259086+00	2026-10-10 09:50:22.259086+00
542	BUZZWORD_COVER	food and drink	22	t	2026-10-10 09:50:23.665107+00	2026-10-10 09:50:23.665107+00
543	BUZZWORD	"never"	54	t	2026-10-10 09:50:24.458857+00	2026-10-10 09:50:24.458857+00
544	BUZZWORD_COVER	monochromatic	23	t	2026-10-10 09:50:25.364423+00	2026-10-10 09:50:25.364423+00
545	READATHON	Tarot Readathon	12	t	2026-10-10 09:50:35.763287+00	2026-10-10 09:50:35.763287+00
589	PHYSICAL_SOURCE	Book Depository	10	t	2026-10-11 15:09:45.762222+00	2026-10-11 15:09:45.762222+00
590	PHYSICAL_SOURCE	Hoću knjigu Buzin	11	t	2026-10-11 15:09:46.57334+00	2026-10-11 15:09:46.57334+00
591	PHYSICAL_SOURCE	Men Art Avenue Mall	12	t	2026-10-11 15:09:48.079586+00	2026-10-11 15:09:48.079586+00
592	PHYSICAL_SOURCE	Mladinska knjiga	13	t	2026-10-11 15:09:53.560156+00	2026-10-11 15:09:53.560156+00
593	PHYSICAL_SOURCE	Shakespeare & Company	14	t	2026-10-11 15:09:55.281782+00	2026-10-11 15:09:55.281782+00
594	PHYSICAL_SOURCE	Blackwell's	15	t	2026-10-11 15:09:56.97933+00	2026-10-11 15:09:56.97933+00
595	PHYSICAL_SOURCE	Wordery	16	t	2026-10-11 15:09:58.759445+00	2026-10-11 15:09:58.759445+00
596	PHYSICAL_SOURCE	Other	17	t	2026-10-11 15:09:59.063353+00	2026-10-11 15:09:59.063353+00
597	PHYSICAL_SOURCE	Instagram @inlibrum	18	t	2026-10-11 15:10:01.775825+00	2026-10-11 15:10:01.775825+00
598	PHYSICAL_SOURCE	Svijet knjige	19	t	2026-10-11 15:10:02.866217+00	2026-10-11 15:10:02.866217+00
599	PHYSICAL_SOURCE	Tisak	20	t	2026-10-11 15:10:04.178122+00	2026-10-11 15:10:04.178122+00
600	PHYSICAL_SOURCE	Stilus webshop	21	t	2026-10-11 15:10:04.259589+00	2026-10-11 15:10:04.259589+00
601	PHYSICAL_SOURCE	Tisak Media Pothodnik	22	t	2026-10-11 15:10:04.280329+00	2026-10-11 15:10:04.280329+00
602	PHYSICAL_SOURCE	Facebook (zamjena za Izgubljene djevojčice)	23	t	2026-10-11 15:10:04.861007+00	2026-10-11 15:10:04.861007+00
603	PHYSICAL_SOURCE	eKnjižara	24	t	2026-10-11 15:10:05.170505+00	2026-10-11 15:10:05.170505+00
604	PHYSICAL_SOURCE	Naklada Fragment webshop	25	t	2026-10-11 15:10:05.468455+00	2026-10-11 15:10:05.468455+00
605	PHYSICAL_SOURCE	World of Books	26	t	2026-10-11 15:10:05.662687+00	2026-10-11 15:10:05.662687+00
606	PHYSICAL_SOURCE	Facebook (zamjena za Plač)	27	t	2026-10-11 15:10:05.779464+00	2026-10-11 15:10:05.779464+00
607	PHYSICAL_SOURCE	darivanje kod @lost.in.books.and.dreaming	28	t	2026-10-11 15:10:05.962736+00	2026-10-11 15:10:05.962736+00
608	PHYSICAL_SOURCE	Instagram (@libraryofpeculiar)	29	t	2026-10-11 15:10:05.978445+00	2026-10-11 15:10:05.978445+00
609	PHYSICAL_SOURCE	Instagram (@djevojka_koja_je_citala)	30	t	2026-10-11 15:10:06.355748+00	2026-10-11 15:10:06.355748+00
610	PHYSICAL_SOURCE	Instagram (@life.couch)	31	t	2026-10-11 15:10:06.371206+00	2026-10-11 15:10:06.371206+00
611	PHYSICAL_SOURCE	Hrabre njuške aukcija	32	t	2026-10-11 15:10:06.459485+00	2026-10-11 15:10:06.459485+00
612	PHYSICAL_SOURCE	Put rukopisa webshop	33	t	2026-10-11 15:10:07.072979+00	2026-10-11 15:10:07.072979+00
613	PHYSICAL_SOURCE	Secret Spooky Scary Sceleton @shelf_full_of_books	34	t	2026-10-11 15:10:07.271855+00	2026-10-11 15:10:07.271855+00
614	PHYSICAL_SOURCE	#readinginmelody giveaway	35	t	2026-10-11 15:10:07.362718+00	2026-10-11 15:10:07.362718+00
615	PHYSICAL_SOURCE	Interliber online (Znanje.hr)	36	t	2026-10-11 15:10:07.555695+00	2026-10-11 15:10:07.555695+00
616	PHYSICAL_SOURCE	Awesome Books	37	t	2026-10-11 15:10:08.072234+00	2026-10-11 15:10:08.072234+00
617	PHYSICAL_SOURCE	Interliber online (Hangar7)	38	t	2026-10-11 15:10:08.855708+00	2026-10-11 15:10:08.855708+00
618	PHYSICAL_SOURCE	Facebook aukcija	39	t	2026-10-11 15:10:08.971116+00	2026-10-11 15:10:08.971116+00
619	PHYSICAL_SOURCE	Hoću knjigu Arena Centar	40	t	2026-10-11 15:10:08.982795+00	2026-10-11 15:10:08.982795+00
620	PHYSICAL_SOURCE	Tisak Media Centar Pothodnik	41	t	2026-10-11 15:10:09.069715+00	2026-10-11 15:10:09.069715+00
621	PHYSICAL_SOURCE	Fokus Webshop	42	t	2026-10-11 15:10:09.182714+00	2026-10-11 15:10:09.182714+00
622	PHYSICAL_SOURCE	Ljetni sajam knjiga	43	t	2026-10-11 15:10:09.963708+00	2026-10-11 15:10:09.963708+00
623	PHYSICAL_SOURCE	Interspar Supernova	44	t	2026-10-11 15:10:10.664764+00	2026-10-11 15:10:10.664764+00
624	PHYSICAL_SOURCE	Man Art Avenue Mall	45	t	2026-10-11 15:10:10.759069+00	2026-10-11 15:10:10.759069+00
625	PHYSICAL_SOURCE	poklon od @throneofbookaholic	46	t	2026-10-11 15:10:11.060923+00	2026-10-11 15:10:11.060923+00
626	PHYSICAL_SOURCE	Webliber - Znanje webshop	47	t	2026-10-11 15:10:11.478334+00	2026-10-11 15:10:11.478334+00
627	PHYSICAL_SOURCE	Darivanje @readinglist1	48	t	2026-10-11 15:10:11.959411+00	2026-10-11 15:10:11.959411+00
628	PHYSICAL_SOURCE	Webliber - Egmont webshop	49	t	2026-10-11 15:10:11.977812+00	2026-10-11 15:10:11.977812+00
629	PHYSICAL_SOURCE	Webliber - Hangar7 webshop	50	t	2026-10-11 15:10:12.163594+00	2026-10-11 15:10:12.163594+00
630	PHYSICAL_SOURCE	Hrvatska pošta Dugave	51	t	2026-10-11 15:10:12.276718+00	2026-10-11 15:10:12.276718+00
631	PHYSICAL_SOURCE	Secret Santa od @deusirae.library	52	t	2026-10-11 15:10:12.472423+00	2026-10-11 15:10:12.472423+00
\.


--
-- Data for Name: reading; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reading (id, book_id, date_started, date_finished, reading_year, month, pages_read, dnf, rating, reread, language_read, author_status, acquired, buzzword, buzzword_cover, bingo_prompt, notes, created_at, updated_at) FROM stdin;
777	772	2019-12-30	2020-01-10	2020	1	336	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:27.666472+00	2026-10-10 09:49:27.666472+00
778	773	2020-01-01	2020-01-03	2020	1	283	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:27.700013+00	2026-10-10 09:49:27.700013+00
779	774	2020-01-02	2020-01-06	2020	1	365	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:27.758753+00	2026-10-10 09:49:27.758753+00
780	775	2020-01-07	2020-01-10	2020	1	599	f	3.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:27.789349+00	2026-10-10 09:49:27.789349+00
781	776	2020-01-11	2020-01-17	2020	1	440	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:27.816045+00	2026-10-10 09:49:27.816045+00
782	777	2020-01-12	2020-01-27	2020	1	271	f	1.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:27.874616+00	2026-10-10 09:49:27.874616+00
783	778	2020-01-13	2020-01-22	2020	1	430	f	3.0	f	Croatian	New to me	Gifted	\N	\N	\N	\N	2026-10-10 09:49:27.904989+00	2026-10-10 09:49:27.904989+00
784	779	2020-01-23	2020-02-19	2020	2	706	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:27.972969+00	2026-10-10 09:49:27.972969+00
785	780	2020-02-02	2020-02-04	2020	2	390	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:27.995507+00	2026-10-10 09:49:27.995507+00
786	781	2020-02-05	2020-02-07	2020	2	400	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.056601+00	2026-10-10 09:49:28.056601+00
787	782	2020-02-10	2020-02-12	2020	2	336	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.088665+00	2026-10-10 09:49:28.088665+00
788	783	2020-02-12	2020-02-15	2020	2	311	f	3.0	f	Croatian	New to me	Gifted	\N	\N	\N	\N	2026-10-10 09:49:28.15498+00	2026-10-10 09:49:28.15498+00
789	784	2020-02-17	2020-02-21	2020	2	377	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.185777+00	2026-10-10 09:49:28.185777+00
790	785	2020-02-21	2020-02-26	2020	2	400	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.208806+00	2026-10-10 09:49:28.208806+00
791	786	2020-02-22	2020-02-25	2020	2	319	f	1.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:28.272807+00	2026-10-10 09:49:28.272807+00
792	787	2020-02-25	2020-03-01	2020	2	419	f	5.0	t	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:28.307749+00	2026-10-10 09:49:28.307749+00
793	788	2020-02-27	2020-02-29	2020	2	320	f	2.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.360578+00	2026-10-10 09:49:28.360578+00
794	789	2020-03-01	2020-03-03	2020	3	329	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.382861+00	2026-10-10 09:49:28.382861+00
795	790	2020-03-02	2020-05-30	2020	5	450	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:28.394954+00	2026-10-10 09:49:28.394954+00
796	791	2020-03-04	2020-03-05	2020	3	288	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.467773+00	2026-10-10 09:49:28.467773+00
797	792	2020-03-05	2020-03-07	2020	3	304	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.490272+00	2026-10-10 09:49:28.490272+00
798	793	2020-03-09	2020-03-12	2020	3	241	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.516671+00	2026-10-10 09:49:28.516671+00
799	794	2020-03-09	2020-03-10	2020	3	202	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.57474+00	2026-10-10 09:49:28.57474+00
800	795	2020-03-10	2020-03-20	2020	3	465	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:28.602926+00	2026-10-10 09:49:28.602926+00
801	796	2020-03-13	2020-03-16	2020	3	433	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:28.682514+00	2026-10-10 09:49:28.682514+00
802	797	2020-03-26	2020-04-28	2020	4	340	f	3.0	t	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:28.759802+00	2026-10-10 09:49:28.759802+00
803	798	2020-03-31	2020-04-10	2020	4	352	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.783923+00	2026-10-10 09:49:28.783923+00
804	799	2020-04-10	2020-04-10	2020	4	91	f	5.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:28.857512+00	2026-10-10 09:49:28.857512+00
805	800	2020-04-10	2020-04-27	2020	4	368	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:28.955131+00	2026-10-10 09:49:28.955131+00
806	801	2020-04-14	2020-04-30	2020	4	313	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:28.978831+00	2026-10-10 09:49:28.978831+00
807	802	2020-05-01	2020-05-19	2020	5	322	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:29.001046+00	2026-10-10 09:49:29.001046+00
808	803	2020-05-02	2020-05-24	2020	5	303	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.071402+00	2026-10-10 09:49:29.071402+00
809	804	2020-05-05	2020-05-15	2020	5	343	f	4.0	f	English	Read before	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.153313+00	2026-10-10 09:49:29.153313+00
810	805	2020-05-16	2020-05-20	2020	5	336	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.18043+00	2026-10-10 09:49:29.18043+00
811	806	2020-05-20	2020-05-20	2020	5	123	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:29.187953+00	2026-10-10 09:49:29.187953+00
812	807	2020-05-21	2020-05-22	2020	5	272	f	5.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.25359+00	2026-10-10 09:49:29.25359+00
813	808	2020-05-25	2020-05-25	2020	5	176	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.279917+00	2026-10-10 09:49:29.279917+00
814	809	2020-05-31	2020-06-07	2020	6	462	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:29.288063+00	2026-10-10 09:49:29.288063+00
815	810	2020-05-31	2020-06-05	2020	6	434	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:29.359221+00	2026-10-10 09:49:29.359221+00
816	811	2020-06-03	2020-06-03	2020	6	368	f	4.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.391718+00	2026-10-10 09:49:29.391718+00
817	812	2020-06-05	2020-06-14	2020	6	351	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:29.455174+00	2026-10-10 09:49:29.455174+00
818	813	2020-06-07	2020-06-11	2020	6	320	f	4.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:29.489702+00	2026-10-10 09:49:29.489702+00
819	814	2020-06-07	2020-06-16	2020	6	196	f	2.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.556103+00	2026-10-10 09:49:29.556103+00
820	815	2020-06-12	2020-06-15	2020	6	240	f	5.0	f	English	Read before	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.579604+00	2026-10-10 09:49:29.579604+00
821	816	2020-06-15	2020-06-20	2020	6	303	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:29.58651+00	2026-10-10 09:49:29.58651+00
822	817	2020-06-16	2020-06-17	2020	6	323	f	4.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.675994+00	2026-10-10 09:49:29.675994+00
823	818	2020-06-19	2020-06-19	2020	6	166	f	2.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.697505+00	2026-10-10 09:49:29.697505+00
824	819	2020-06-19	2020-06-20	2020	6	304	f	5.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.756603+00	2026-10-10 09:49:29.756603+00
825	820	2020-06-20	2020-06-20	2020	6	360	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.779349+00	2026-10-10 09:49:29.779349+00
826	821	2020-06-20	2020-06-21	2020	6	328	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.800685+00	2026-10-10 09:49:29.800685+00
827	822	2020-06-20	2020-06-21	2020	6	263	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:29.871954+00	2026-10-10 09:49:29.871954+00
828	823	2020-06-21	2020-06-25	2020	6	361	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:29.8986+00	2026-10-10 09:49:29.8986+00
829	824	2020-06-22	2020-06-28	2020	6	368	f	2.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:29.906266+00	2026-10-10 09:49:29.906266+00
830	825	2020-06-25	2020-06-27	2020	6	400	f	5.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:29.97854+00	2026-10-10 09:49:29.97854+00
831	826	2020-06-28	2020-06-30	2020	6	400	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.001025+00	2026-10-10 09:49:30.001025+00
832	827	2020-06-29	2020-06-30	2020	6	257	f	2.0	f	Croatian	New to me	Gifted	\N	\N	\N	\N	2026-10-10 09:49:30.068268+00	2026-10-10 09:49:30.068268+00
833	828	2020-07-01	2020-07-06	2020	7	400	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.165731+00	2026-10-10 09:49:30.165731+00
834	829	2020-07-03	2020-07-11	2020	7	325	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.18909+00	2026-10-10 09:49:30.18909+00
835	830	2020-07-06	2020-07-09	2020	7	384	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.275116+00	2026-10-10 09:49:30.275116+00
836	831	2020-07-12	2020-07-14	2020	7	346	f	4.0	f	Croatian	New to me	Gifted	\N	\N	\N	\N	2026-10-10 09:49:30.360044+00	2026-10-10 09:49:30.360044+00
837	832	2020-07-16	2020-07-19	2020	7	359	f	3.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.383139+00	2026-10-10 09:49:30.383139+00
838	833	2020-07-19	2020-07-19	2020	7	173	f	4.0	t	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.476174+00	2026-10-10 09:49:30.476174+00
839	834	2020-07-19	2020-07-21	2020	7	288	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.497601+00	2026-10-10 09:49:30.497601+00
840	835	2020-07-20	2020-07-21	2020	7	242	f	2.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.556084+00	2026-10-10 09:49:30.556084+00
841	836	2020-07-21	2020-07-23	2020	7	320	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.585152+00	2026-10-10 09:49:30.585152+00
842	837	2020-07-21	2020-07-23	2020	7	404	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.655803+00	2026-10-10 09:49:30.655803+00
843	838	2020-07-21	2020-07-25	2020	7	417	f	3.0	f	English	Read before	Scribd	\N	\N	\N	\N	2026-10-10 09:49:30.663644+00	2026-10-10 09:49:30.663644+00
844	839	2020-07-24	2020-07-26	2020	7	320	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.692928+00	2026-10-10 09:49:30.692928+00
845	840	2020-07-24	2020-07-26	2020	7	432	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:30.76975+00	2026-10-10 09:49:30.76975+00
846	841	2020-07-27	2020-07-31	2020	7	432	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.791151+00	2026-10-10 09:49:30.791151+00
847	842	2020-07-27	2020-07-29	2020	7	267	f	1.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.798229+00	2026-10-10 09:49:30.798229+00
848	843	2020-07-30	2020-08-06	2020	8	659	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.850508+00	2026-10-10 09:49:30.850508+00
849	844	2020-08-04	2020-08-05	2020	8	208	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.891682+00	2026-10-10 09:49:30.891682+00
850	845	2020-08-06	2020-08-10	2020	8	456	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.898443+00	2026-10-10 09:49:30.898443+00
851	846	2020-08-07	2020-08-17	2020	8	299	f	2.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:30.955666+00	2026-10-10 09:49:30.955666+00
852	847	2020-08-14	2020-08-17	2020	8	400	f	3.0	f	English	New to me	Scribd	\N	\N	\N	\N	2026-10-10 09:49:30.976618+00	2026-10-10 09:49:30.976618+00
853	848	2020-08-18	2020-08-18	2020	8	187	f	3.0	t	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:30.984048+00	2026-10-10 09:49:30.984048+00
854	849	2020-08-18	2020-12-15	2020	12	342	f	5.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.050593+00	2026-10-10 09:49:31.050593+00
855	850	2020-08-19	2020-08-21	2020	8	368	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.075701+00	2026-10-10 09:49:31.075701+00
856	851	2020-08-31	2020-08-31	2020	8	174	f	4.0	t	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.083655+00	2026-10-10 09:49:31.083655+00
857	852	2020-09-01	2020-09-04	2020	9	352	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.15698+00	2026-10-10 09:49:31.15698+00
858	853	2020-09-01	2020-09-11	2020	9	351	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.165778+00	2026-10-10 09:49:31.165778+00
859	854	2020-09-05	2020-09-07	2020	9	320	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.195587+00	2026-10-10 09:49:31.195587+00
860	855	2020-09-08	2020-09-15	2020	9	229	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.272652+00	2026-10-10 09:49:31.272652+00
861	856	2020-09-16	2020-09-30	2020	9	373	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.29565+00	2026-10-10 09:49:31.29565+00
862	857	2020-09-17	2020-09-22	2020	9	366	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.370793+00	2026-10-10 09:49:31.370793+00
863	858	2020-09-29	2020-10-25	2020	10	1376	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.378288+00	2026-10-10 09:49:31.378288+00
864	859	2020-10-04	2020-10-09	2020	10	336	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.453581+00	2026-10-10 09:49:31.453581+00
865	860	2020-10-06	2020-10-29	2020	10	381	f	4.0	f	Croatian	Read before	Gifted	\N	\N	\N	\N	2026-10-10 09:49:31.461672+00	2026-10-10 09:49:31.461672+00
866	861	2020-10-13	2020-10-17	2020	10	354	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.468932+00	2026-10-10 09:49:31.468932+00
867	862	2020-10-25	2020-10-30	2020	10	416	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.504627+00	2026-10-10 09:49:31.504627+00
868	863	2020-11-02	2020-11-04	2020	11	368	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.57181+00	2026-10-10 09:49:31.57181+00
869	864	2020-11-02	2020-11-07	2020	11	321	f	2.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.594744+00	2026-10-10 09:49:31.594744+00
870	865	2020-11-07	2020-11-24	2020	11	381	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.655129+00	2026-10-10 09:49:31.655129+00
871	866	2020-11-08	2020-11-12	2020	11	320	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.687324+00	2026-10-10 09:49:31.687324+00
872	867	2020-11-13	2020-11-15	2020	11	368	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.695522+00	2026-10-10 09:49:31.695522+00
873	868	2020-11-16	2020-11-21	2020	11	301	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.771561+00	2026-10-10 09:49:31.771561+00
874	869	2020-11-17	2020-12-05	2020	11	389	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.795717+00	2026-10-10 09:49:31.795717+00
875	870	2020-11-22	2020-11-29	2020	11	352	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.872295+00	2026-10-10 09:49:31.872295+00
876	871	2020-12-02	2020-12-04	2020	12	336	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.880398+00	2026-10-10 09:49:31.880398+00
877	872	2020-12-04	2020-12-18	2020	12	372	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:31.888586+00	2026-10-10 09:49:31.888586+00
878	873	2020-12-07	2020-12-11	2020	12	210	f	5.0	t	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.986858+00	2026-10-10 09:49:31.986858+00
879	874	2020-12-07	2020-12-16	2020	12	438	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:31.995364+00	2026-10-10 09:49:31.995364+00
880	875	2020-12-08	2020-12-12	2020	12	301	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:32.003313+00	2026-10-10 09:49:32.003313+00
881	876	2020-12-16	2020-12-17	2020	12	271	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:32.086899+00	2026-10-10 09:49:32.086899+00
882	877	2020-12-18	2021-01-25	2021	1	575	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:32.109358+00	2026-10-10 09:49:32.109358+00
883	878	2020-12-24	2020-12-29	2020	12	297	f	5.0	f	Croatian	New to me	Gifted	\N	\N	\N	\N	2026-10-10 09:49:32.173707+00	2026-10-10 09:49:32.173707+00
884	879	2021-01-04	2021-01-09	2021	1	251	f	4.0	f	English	New to me	Downloaded	dream	\N	\N	\N	2026-10-10 09:49:32.255285+00	2026-10-10 09:49:32.255285+00
885	880	2021-01-04	2021-01-10	2021	1	292	f	2.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:32.37473+00	2026-10-10 09:49:32.37473+00
886	881	2021-01-08	2021-01-13	2021	1	385	f	4.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:32.452947+00	2026-10-10 09:49:32.452947+00
887	882	2021-01-10	2021-01-18	2021	1	384	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:32.475418+00	2026-10-10 09:49:32.475418+00
888	883	2021-01-14	2021-01-28	2021	1	439	f	3.0	f	Croatian	New to me	Bought	\N	\N	\N	#tourdeeuropecc SWEDEN	2026-10-10 09:49:32.550572+00	2026-10-10 09:49:32.550572+00
889	884	2021-01-23	2021-01-31	2021	1	337	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:32.559081+00	2026-10-10 09:49:32.559081+00
890	885	2021-01-28	2021-01-31	2021	1	423	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	#tourdeeuropecc NORWAY	2026-10-10 09:49:32.590491+00	2026-10-10 09:49:32.590491+00
891	886	2021-01-31	2021-02-06	2021	2	307	f	4.0	f	Croatian	New to me	Gifted	color	\N	\N	\N	2026-10-10 09:49:32.661871+00	2026-10-10 09:49:32.661871+00
892	887	2021-02-02	2021-02-15	2021	2	336	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:32.683658+00	2026-10-10 09:49:32.683658+00
893	888	2021-02-06	2021-02-06	2021	2	144	f	4.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:32.780311+00	2026-10-10 09:49:32.780311+00
894	889	2021-02-11	2021-02-16	2021	2	364	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	#hrpicasrama	2026-10-10 09:49:32.78851+00	2026-10-10 09:49:32.78851+00
895	890	2021-02-16	2021-02-21	2021	2	338	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:32.796241+00	2026-10-10 09:49:32.796241+00
896	891	2021-02-22	2021-02-25	2021	2	336	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:32.881128+00	2026-10-10 09:49:32.881128+00
897	892	2021-02-23	2021-02-25	2021	2	321	f	4.0	f	Croatian	Read before	Library	\N	\N	\N	\N	2026-10-10 09:49:32.889316+00	2026-10-10 09:49:32.889316+00
898	893	2021-02-26	2021-02-28	2021	2	359	f	2.0	f	Croatian	New to me	Bought	color	\N	\N	\N	2026-10-10 09:49:32.968038+00	2026-10-10 09:49:32.968038+00
899	894	2021-02-28	2021-03-02	2021	3	252	f	3.0	f	Croatian	Read before	Library	\N	\N	\N	\N	2026-10-10 09:49:32.978188+00	2026-10-10 09:49:32.978188+00
900	895	2021-03-01	2021-03-05	2021	3	342	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:32.987515+00	2026-10-10 09:49:32.987515+00
901	896	2021-03-03	2021-03-10	2021	3	388	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:33.057336+00	2026-10-10 09:49:33.057336+00
902	897	2021-03-06	2021-03-07	2021	3	208	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	The Backlist Readathon: middlegrade	2026-10-10 09:49:33.077739+00	2026-10-10 09:49:33.077739+00
903	898	2021-03-07	2021-03-07	2021	3	175	f	2.0	f	Croatian	Read before	Bought	\N	\N	\N	The Backlist Readathon: published before 2017	2026-10-10 09:49:33.156888+00	2026-10-10 09:49:33.156888+00
904	899	2021-03-07	2021-03-10	2021	3	353	f	5.0	f	Croatian	Read before	Bought	\N	\N	\N	The Backlist Readathon: favorite genre	2026-10-10 09:49:33.166705+00	2026-10-10 09:49:33.166705+00
905	900	2021-03-07	2021-03-12	2021	3	207	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	The Backlist Readathon: recommended by a book influencer	2026-10-10 09:49:33.312924+00	2026-10-10 09:49:33.312924+00
906	901	2021-03-11	2021-03-13	2021	3	290	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	The Backlist Readathon: #OwnVoices	2026-10-10 09:49:33.356473+00	2026-10-10 09:49:33.356473+00
907	902	2021-03-15	2021-03-16	2021	3	416	f	4.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:33.389585+00	2026-10-10 09:49:33.389585+00
908	903	2021-03-18	2021-03-19	2021	3	336	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:33.47777+00	2026-10-10 09:49:33.47777+00
909	904	2021-03-20	2021-03-20	2021	3	146	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	#bookopolathon roll 1: dark cover & roll 4: other genre	2026-10-10 09:49:33.557565+00	2026-10-10 09:49:33.557565+00
910	905	2021-03-20	2021-03-21	2021	3	279	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	#bookopolathon roll 2: contemporary	2026-10-10 09:49:33.571321+00	2026-10-10 09:49:33.571321+00
911	906	2021-03-21	2021-03-21	2021	3	187	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	#bookopolathon roll 3: chance card & roll 1: fantasy	2026-10-10 09:49:33.590362+00	2026-10-10 09:49:33.590362+00
912	907	2021-03-21	2021-03-21	2021	3	96	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	#bookopolathon roll 2: POC representation & roll 3: first in a series	2026-10-10 09:49:33.722914+00	2026-10-10 09:49:33.722914+00
913	908	2021-03-21	2021-03-21	2021	3	173	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	#bookopolathon roll 4: set in present	2026-10-10 09:49:33.760434+00	2026-10-10 09:49:33.760434+00
914	909	2021-03-22	2021-04-10	2021	4	372	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	#choosemytbr: @sanda_reads	2026-10-10 09:49:33.858923+00	2026-10-10 09:49:33.858923+00
915	910	2021-04-02	2021-04-08	2021	4	454	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:33.893904+00	2026-10-10 09:49:33.893904+00
916	911	2021-04-07	2021-04-09	2021	4	265	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	#choosemytbr: @distance.your.shelf	2026-10-10 09:49:33.9617+00	2026-10-10 09:49:33.9617+00
917	912	2021-04-10	2021-04-11	2021	4	295	f	1.0	f	Croatian	New to me	Bought	\N	\N	\N	#choosemytbr: @from.cover.to.cover	2026-10-10 09:49:34.058677+00	2026-10-10 09:49:34.058677+00
918	913	2021-04-10	2021-04-23	2021	4	582	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	#choosemytbr: @sanda_reads	2026-10-10 09:49:34.096466+00	2026-10-10 09:49:34.096466+00
919	914	2021-04-11	2021-04-25	2021	4	347	f	4.0	f	Croatian	Read before	Library	\N	\N	\N	#tourdeeuropecc GREECE	2026-10-10 09:49:34.157678+00	2026-10-10 09:49:34.157678+00
920	915	2021-04-24	2021-04-30	2021	4	308	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:34.170749+00	2026-10-10 09:49:34.170749+00
921	916	2021-04-26	2021-05-01	2021	4	371	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	#choosemytbr: @svemir_knjiga	2026-10-10 09:49:34.286314+00	2026-10-10 09:49:34.286314+00
922	917	2021-05-01	2021-05-02	2021	5	324	f	3.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:34.358248+00	2026-10-10 09:49:34.358248+00
923	918	2021-05-03	2021-05-06	2021	5	290	f	3.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:34.457078+00	2026-10-10 09:49:34.457078+00
924	919	2021-05-05	2021-05-07	2021	5	118	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:34.467626+00	2026-10-10 09:49:34.467626+00
925	920	2021-05-07	2021-05-13	2021	5	378	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:34.564885+00	2026-10-10 09:49:34.564885+00
926	921	2021-05-07	2021-05-11	2021	5	335	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:34.594739+00	2026-10-10 09:49:34.594739+00
927	922	2021-05-12	2021-05-12	2021	5	365	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:34.703115+00	2026-10-10 09:49:34.703115+00
928	923	2021-05-12	2021-05-15	2021	5	408	f	3.0	f	English	Read before	Bought	\N	\N	\N	#hrpicasrama	2026-10-10 09:49:34.785098+00	2026-10-10 09:49:34.785098+00
929	924	2021-05-14	2021-05-26	2021	5	307	f	3.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:34.866784+00	2026-10-10 09:49:34.866784+00
930	925	2021-05-16	2021-05-25	2021	5	357	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:34.879811+00	2026-10-10 09:49:34.879811+00
931	926	2021-05-26	2021-05-29	2021	5	225	f	4.0	f	English	New to me	Bought	\N	\N	\N	#tourdeeuropecc ITALY	2026-10-10 09:49:35.086215+00	2026-10-10 09:49:35.086215+00
932	927	2021-05-26	2021-05-31	2021	5	349	f	2.0	f	Croatian	New to me	Library	\N	\N	\N	#tourdeeuropecc ITALY	2026-10-10 09:49:35.165306+00	2026-10-10 09:49:35.165306+00
933	928	2021-05-26	2021-05-30	2021	5	158	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:35.176492+00	2026-10-10 09:49:35.176492+00
934	929	2021-06-01	2021-06-01	2021	6	139	f	2.0	f	Croatian	Read before	Library	\N	\N	\N	\N	2026-10-10 09:49:35.191865+00	2026-10-10 09:49:35.191865+00
935	930	2021-06-01	2021-06-22	2021	6	473	f	2.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:35.503868+00	2026-10-10 09:49:35.503868+00
936	931	2021-06-01	2021-06-07	2021	6	352	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:35.531195+00	2026-10-10 09:49:35.531195+00
937	932	2021-06-07	2021-06-08	2021	6	384	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:35.557961+00	2026-10-10 09:49:35.557961+00
938	933	2021-06-09	2021-06-13	2021	6	351	f	2.0	t	Croatian	Read before	Bought	\N	\N	\N	#tourdeeuropecc	2026-10-10 09:49:35.597708+00	2026-10-10 09:49:35.597708+00
939	934	2021-06-10	2021-06-12	2021	6	280	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:35.675666+00	2026-10-10 09:49:35.675666+00
940	935	2021-06-13	2021-06-17	2021	6	348	f	2.0	f	Croatian	New to me	Bought	name and title	\N	\N	\N	2026-10-10 09:49:35.756857+00	2026-10-10 09:49:35.756857+00
941	936	2021-06-22	2021-06-30	2021	6	447	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:35.78437+00	2026-10-10 09:49:35.78437+00
942	937	2021-06-23	2021-06-25	2021	6	293	f	5.0	f	Croatian	Read before	Gifted	\N	\N	\N	\N	2026-10-10 09:49:35.79334+00	2026-10-10 09:49:35.79334+00
943	938	2021-06-25	2021-06-26	2021	6	437	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:35.88544+00	2026-10-10 09:49:35.88544+00
944	939	2021-06-27	2021-06-30	2021	6	316	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:35.973559+00	2026-10-10 09:49:35.973559+00
945	940	2021-07-01	2021-07-01	2021	7	149	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	#tourdeeuropecc FRANCE	2026-10-10 09:49:36.056258+00	2026-10-10 09:49:36.056258+00
946	941	2021-07-02	2021-07-16	2021	7	356	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.068226+00	2026-10-10 09:49:36.068226+00
947	942	2021-07-02	2021-07-05	2021	7	337	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.077231+00	2026-10-10 09:49:36.077231+00
948	943	2021-07-05	2021-07-08	2021	7	298	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.086799+00	2026-10-10 09:49:36.086799+00
949	944	2021-07-06	2021-07-07	2021	7	336	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.157529+00	2026-10-10 09:49:36.157529+00
950	945	2021-07-06	2021-07-08	2021	7	136	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.253241+00	2026-10-10 09:49:36.253241+00
951	946	2021-07-09	2021-07-11	2021	7	368	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.263239+00	2026-10-10 09:49:36.263239+00
952	947	2021-07-11	2021-07-12	2021	7	222	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.273317+00	2026-10-10 09:49:36.273317+00
953	948	2021-07-12	2021-07-15	2021	7	330	f	5.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.282902+00	2026-10-10 09:49:36.282902+00
954	949	2021-07-14	2021-07-16	2021	7	432	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.358574+00	2026-10-10 09:49:36.358574+00
955	950	2021-07-16	2022-08-21	2022	8	393	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.367595+00	2026-10-10 09:49:36.367595+00
956	951	2021-07-17	2021-07-19	2021	7	369	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.376552+00	2026-10-10 09:49:36.376552+00
957	952	2021-07-17	2021-07-23	2021	7	422	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.518154+00	2026-10-10 09:49:36.518154+00
958	953	2021-07-19	2021-07-28	2021	7	353	f	4.0	f	English	Read before	Bought	\N	\N	\N	#hrpicasrama	2026-10-10 09:49:36.576689+00	2026-10-10 09:49:36.576689+00
959	954	2021-07-20	2021-07-23	2021	7	259	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.584914+00	2026-10-10 09:49:36.584914+00
960	955	2021-07-21	2021-08-01	2021	7	314	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.662838+00	2026-10-10 09:49:36.662838+00
961	956	2021-07-24	2021-07-26	2021	7	414	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.687316+00	2026-10-10 09:49:36.687316+00
962	957	2021-07-26	2021-07-31	2021	7	325	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.772531+00	2026-10-10 09:49:36.772531+00
963	958	2021-07-29	2021-07-31	2021	7	297	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	#tourdeeuropecc	2026-10-10 09:49:36.780633+00	2026-10-10 09:49:36.780633+00
964	959	2021-08-01	2021-08-04	2021	8	414	f	1.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:36.856444+00	2026-10-10 09:49:36.856444+00
965	960	2021-08-01	2021-08-04	2021	8	244	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:36.883111+00	2026-10-10 09:49:36.883111+00
966	961	2021-08-02	2021-08-04	2021	8	241	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.953474+00	2026-10-10 09:49:36.953474+00
967	962	2021-08-07	2021-08-07	2021	8	417	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.990455+00	2026-10-10 09:49:36.990455+00
968	963	2021-08-08	2021-08-11	2021	8	129	f	2.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:36.999187+00	2026-10-10 09:49:36.999187+00
969	964	2021-08-09	2021-08-15	2021	8	307	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.081303+00	2026-10-10 09:49:37.081303+00
970	965	2021-08-11	2021-08-19	2021	8	415	f	5.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:37.158555+00	2026-10-10 09:49:37.158555+00
971	966	2021-08-12	2021-08-20	2021	8	442	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.167422+00	2026-10-10 09:49:37.167422+00
972	967	2021-08-19	2021-08-20	2021	8	105	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.273003+00	2026-10-10 09:49:37.273003+00
973	968	2021-08-20	2021-08-20	2021	8	160	f	3.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:37.356024+00	2026-10-10 09:49:37.356024+00
974	969	2021-08-20	2021-08-20	2021	8	102	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.389081+00	2026-10-10 09:49:37.389081+00
975	970	2021-08-23	2021-08-25	2021	8	207	f	4.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:49:37.475851+00	2026-10-10 09:49:37.475851+00
976	971	2021-08-23	2021-08-25	2021	8	350	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.485608+00	2026-10-10 09:49:37.485608+00
977	972	2021-08-25	2021-08-30	2021	8	369	f	4.0	f	English	New to me	Bought	\N	\N	\N	#tourdeeurooecc ENGLAND	2026-10-10 09:49:37.586188+00	2026-10-10 09:49:37.586188+00
978	973	2021-08-26	2021-08-26	2021	8	225	f	1.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:37.657438+00	2026-10-10 09:49:37.657438+00
979	974	2021-08-27	2021-08-30	2021	8	355	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.666648+00	2026-10-10 09:49:37.666648+00
980	975	2021-08-27	2021-08-28	2021	8	137	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.756875+00	2026-10-10 09:49:37.756875+00
981	976	2021-08-31	2021-08-31	2021	8	95	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.767162+00	2026-10-10 09:49:37.767162+00
982	977	2021-09-01	2021-09-08	2021	9	412	f	3.0	f	Croatian	Read before	Library	\N	\N	\N	\N	2026-10-10 09:49:37.777224+00	2026-10-10 09:49:37.777224+00
983	978	2021-09-02	2021-09-27	2021	9	346	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	#tourdeeuropecc ENGLAND	2026-10-10 09:49:37.95585+00	2026-10-10 09:49:37.95585+00
984	979	2021-09-02	2021-09-17	2021	9	282	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:37.982544+00	2026-10-10 09:49:37.982544+00
985	980	2021-09-08	2021-09-09	2021	9	295	f	3.0	f	Croatian	New to me	Bought	\N	\N	\N	#tourdeeuropecc ENGLAND	2026-10-10 09:49:38.072471+00	2026-10-10 09:49:38.072471+00
986	981	2021-09-10	2021-09-22	2021	9	326	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	#tourdeeuropecc ENGLAND	2026-10-10 09:49:38.155313+00	2026-10-10 09:49:38.155313+00
987	982	2021-09-14	2021-09-17	2021	9	175	f	5.0	f	Croatian	Read before	Library	\N	\N	\N	\N	2026-10-10 09:49:38.164203+00	2026-10-10 09:49:38.164203+00
988	983	2021-09-17	2021-10-29	2021	10	476	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:38.253205+00	2026-10-10 09:49:38.253205+00
989	983	2022-01-04	2022-01-31	2022	1	486	f	5.0	t	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:38.255557+00	2026-10-10 09:49:38.255557+00
990	984	2021-09-17	2021-09-20	2021	9	360	f	3.0	f	Croatian	Read before	Library	\N	\N	\N	#tourdeeuropecc ENGLAND	2026-10-10 09:49:38.287755+00	2026-10-10 09:49:38.287755+00
991	985	2021-09-20	2021-09-24	2021	9	337	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	#tourdeeuropecc ENGLAND	2026-10-10 09:49:38.375053+00	2026-10-10 09:49:38.375053+00
992	986	2021-09-22	2021-09-24	2021	9	246	f	5.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:38.456088+00	2026-10-10 09:49:38.456088+00
993	987	2021-09-27	2021-09-28	2021	9	224	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:38.484775+00	2026-10-10 09:49:38.484775+00
994	988	2021-09-27	2021-09-28	2021	9	220	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:38.573916+00	2026-10-10 09:49:38.573916+00
995	988	2025-05-09	2025-05-09	2025	5	228	f	4.5	t	English	Read before	Downloaded	\N	\N	red haired MC	\N	2026-10-10 09:49:38.577917+00	2026-10-10 09:49:38.577917+00
996	989	2021-09-28	2021-10-31	2021	10	329	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:38.657995+00	2026-10-10 09:49:38.657995+00
997	990	2021-10-01	2021-10-03	2021	10	277	f	3.0	f	Croatian	New to me	Gifted	\N	\N	\N	#tourdeeuropecc GERMANY	2026-10-10 09:49:38.755276+00	2026-10-10 09:49:38.755276+00
998	991	2021-10-03	2021-10-07	2021	10	297	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:38.787869+00	2026-10-10 09:49:38.787869+00
999	992	2021-10-09	2021-10-10	2021	10	292	f	4.0	f	English	New to me	Gifted	\N	\N	\N	\N	2026-10-10 09:49:38.873918+00	2026-10-10 09:49:38.873918+00
1000	993	2021-10-24	2021-10-28	2021	10	310	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:38.963139+00	2026-10-10 09:49:38.963139+00
1001	994	2021-11-02	2021-11-05	2021	11	305	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.057603+00	2026-10-10 09:49:39.057603+00
1002	995	2021-11-04	2021-11-08	2021	11	253	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	#tourdeeuropecc CROATIA	2026-10-10 09:49:39.082886+00	2026-10-10 09:49:39.082886+00
1003	996	2021-11-05	2021-11-07	2021	11	352	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.177495+00	2026-10-10 09:49:39.177495+00
1004	997	2021-11-07	2021-11-13	2021	11	347	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.256411+00	2026-10-10 09:49:39.256411+00
1005	998	2021-11-11	2021-11-12	2021	11	270	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:39.284369+00	2026-10-10 09:49:39.284369+00
1006	999	2021-11-13	2021-12-10	2021	12	435	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:39.373494+00	2026-10-10 09:49:39.373494+00
1007	1000	2021-11-14	2021-11-17	2021	11	307	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	#hrpicasrama	2026-10-10 09:49:39.456043+00	2026-10-10 09:49:39.456043+00
1008	1001	2021-11-16	2021-11-22	2021	11	336	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.496146+00	2026-10-10 09:49:39.496146+00
1009	1002	2021-11-23	2021-11-27	2021	11	256	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.575495+00	2026-10-10 09:49:39.575495+00
1010	1003	2021-12-01	2021-12-03	2021	12	455	f	4.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:39.676263+00	2026-10-10 09:49:39.676263+00
1011	1004	2021-12-02	2021-12-08	2021	12	290	f	1.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.763071+00	2026-10-10 09:49:39.763071+00
1012	1005	2021-12-14	2021-12-30	2021	12	363	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:39.859354+00	2026-10-10 09:49:39.859354+00
1013	1006	2021-12-17	2021-12-20	2021	12	258	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.950511+00	2026-10-10 09:49:39.950511+00
1014	1007	2021-12-21	2021-12-21	2021	12	55	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:39.979812+00	2026-10-10 09:49:39.979812+00
1015	1008	2021-12-22	2021-12-25	2021	12	336	f	4.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:40.055517+00	2026-10-10 09:49:40.055517+00
1016	1009	2021-12-22	2021-12-26	2021	12	114	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:40.06601+00	2026-10-10 09:49:40.06601+00
1017	1010	2021-12-27	2021-12-31	2021	12	298	f	3.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:40.158074+00	2026-10-10 09:49:40.158074+00
1018	1011	2022-01-01	2022-01-02	2022	1	131	f	4.0	f	English	Read before	Downloaded	book related words	\N	\N	\N	2026-10-10 09:49:40.170462+00	2026-10-10 09:49:40.170462+00
1019	1012	2022-01-04	2022-01-08	2022	1	356	f	3.0	f	English	New to me	Bought	directions	\N	\N	\N	2026-10-10 09:49:40.282874+00	2026-10-10 09:49:40.282874+00
1020	1013	2022-01-05	2022-01-09	2022	1	304	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:40.381773+00	2026-10-10 09:49:40.381773+00
1021	1014	2022-01-20	2022-01-29	2022	1	352	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:40.457655+00	2026-10-10 09:49:40.457655+00
1022	1015	2022-01-22	2022-11-18	2022	11	359	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:40.558124+00	2026-10-10 09:49:40.558124+00
1023	1016	2022-01-30	2022-01-30	2022	1	188	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:40.658718+00	2026-10-10 09:49:40.658718+00
1024	1017	2022-01-31	2022-01-31	2022	1	103	f	5.0	f	English	New to me	Downloaded	items	\N	\N	\N	2026-10-10 09:49:40.760538+00	2026-10-10 09:49:40.760538+00
1025	1018	2022-02-01	2022-02-01	2022	2	90	f	4.0	f	English	Read before	Downloaded	pronouns & possesives	\N	\N	\N	2026-10-10 09:49:40.773577+00	2026-10-10 09:49:40.773577+00
1026	1018	2022-02-09	2022-02-09	2022	2	90	f	4.0	t	English	Read before	Downloaded	pronouns & possesives	\N	\N	\N	2026-10-10 09:49:40.777181+00	2026-10-10 09:49:40.777181+00
1027	1019	2022-02-01	2022-02-02	2022	2	72	f	3.0	f	English	Read before	Downloaded	pronouns & possesives	\N	\N	\N	2026-10-10 09:49:40.85582+00	2026-10-10 09:49:40.85582+00
1028	1020	2022-02-02	2022-04-23	2022	4	239	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:40.955313+00	2026-10-10 09:49:40.955313+00
1029	1021	2022-02-02	2022-02-19	2022	2	327	f	5.0	f	English	Read before	Downloaded	pronouns & possesives	\N	\N	\N	2026-10-10 09:49:40.966297+00	2026-10-10 09:49:40.966297+00
1030	1022	2022-02-06	2022-02-06	2022	2	63	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:40.977892+00	2026-10-10 09:49:40.977892+00
1031	1023	2022-02-11	2022-02-11	2022	2	112	f	5.0	f	English	Read before	Downloaded	directions	\N	\N	\N	2026-10-10 09:49:41.065316+00	2026-10-10 09:49:41.065316+00
1032	1024	2022-03-03	2022-04-09	2022	4	287	f	5.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:41.155764+00	2026-10-10 09:49:41.155764+00
1033	1025	2022-03-05	2022-04-10	2022	4	364	f	5.0	f	English	New to me	Bought	locations	\N	\N	\N	2026-10-10 09:49:41.166787+00	2026-10-10 09:49:41.166787+00
1034	1026	2022-03-26	2022-03-26	2022	3	127	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:41.177005+00	2026-10-10 09:49:41.177005+00
1035	1027	2022-04-09	2022-07-10	2022	7	343	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:41.317479+00	2026-10-10 09:49:41.317479+00
1036	1028	2022-04-10	2022-04-10	2022	4	84	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:41.35766+00	2026-10-10 09:49:41.35766+00
1037	1029	2022-04-15	2022-04-17	2022	4	324	f	4.0	f	Croatian	Read before	Library	the 5 w's	\N	\N	\N	2026-10-10 09:49:41.369963+00	2026-10-10 09:49:41.369963+00
1038	1030	2022-05-07	2022-07-03	2022	7	141	f	3.0	f	English	Read before	Downloaded	"all"	\N	\N	\N	2026-10-10 09:49:41.457935+00	2026-10-10 09:49:41.457935+00
1039	1031	2022-05-07	2022-07-06	2022	7	139	f	4.0	f	English	Read before	Downloaded	directions	\N	\N	\N	2026-10-10 09:49:41.469524+00	2026-10-10 09:49:41.469524+00
1040	1032	2022-07-10	2022-08-15	2022	8	320	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:41.581801+00	2026-10-10 09:49:41.581801+00
1041	1033	2022-07-16	2022-07-18	2022	7	256	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:41.754125+00	2026-10-10 09:49:41.754125+00
1042	1034	2022-07-16	\N	2022	7	\N	t	\N	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:41.784685+00	2026-10-10 09:49:41.784685+00
1043	1035	2022-08-01	2022-08-04	2022	8	290	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:41.857602+00	2026-10-10 09:49:41.857602+00
1044	1036	2022-08-04	2022-08-05	2022	8	285	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:41.957081+00	2026-10-10 09:49:41.957081+00
1045	1037	2022-08-05	2022-08-07	2022	8	361	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:41.977317+00	2026-10-10 09:49:41.977317+00
1046	1038	2022-08-15	2022-08-31	2022	8	312	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:42.152499+00	2026-10-10 09:49:42.152499+00
1047	1039	2022-08-18	2022-08-30	2022	8	355	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:42.201069+00	2026-10-10 09:49:42.201069+00
1048	1040	2022-08-26	2022-08-27	2022	8	91	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:42.28491+00	2026-10-10 09:49:42.28491+00
1049	1041	2022-09-01	\N	2022	9	\N	t	\N	f	Croatian	New to me	Gifted	numbers	\N	\N	\N	2026-10-10 09:49:42.393133+00	2026-10-10 09:49:42.393133+00
1050	1042	2022-09-07	2022-09-09	2022	9	377	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:42.46535+00	2026-10-10 09:49:42.46535+00
1051	1043	2022-09-08	2022-12-30	2022	12	220	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:42.568883+00	2026-10-10 09:49:42.568883+00
1052	1044	2022-09-09	\N	2022	9	384	t	\N	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:42.580898+00	2026-10-10 09:49:42.580898+00
1053	1044	2024-03-17	2024-03-18	2024	3	364	f	5.0	f	English	Read before	Bought	character names	\N	\N	\N	2026-10-10 09:49:42.586825+00	2026-10-10 09:49:42.586825+00
1054	1045	2022-09-10	2022-11-02	2022	11	251	f	3.0	f	English	New to me	Bought	creatures & animals	\N	\N	\N	2026-10-10 09:49:42.784024+00	2026-10-10 09:49:42.784024+00
1055	1046	2022-09-10	2022-09-10	2022	9	151	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:42.850857+00	2026-10-10 09:49:42.850857+00
1056	1047	2022-09-11	2022-09-11	2022	9	248	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:42.870797+00	2026-10-10 09:49:42.870797+00
1057	1048	2022-09-11	2022-09-11	2022	9	115	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:42.994437+00	2026-10-10 09:49:42.994437+00
1058	1049	2022-11-02	2022-11-13	2022	11	347	f	4.0	f	English	Read before	Bought	creatures & animals	\N	\N	\N	2026-10-10 09:49:43.059433+00	2026-10-10 09:49:43.059433+00
1059	1050	2022-11-25	2022-12-11	2022	12	337	f	3.0	f	Croatian	New to me	Bought	light & dark	\N	\N	\N	2026-10-10 09:49:43.160946+00	2026-10-10 09:49:43.160946+00
1060	1051	2022-12-10	2022-12-11	2022	12	160	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:43.259268+00	2026-10-10 09:49:43.259268+00
1061	1052	2022-12-12	2022-12-19	2022	12	368	f	4.0	f	English	New to me	Downloaded	numbers	\N	\N	\N	2026-10-10 09:49:43.35662+00	2026-10-10 09:49:43.35662+00
1062	1053	2022-12-16	2022-12-18	2022	12	64	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:43.456556+00	2026-10-10 09:49:43.456556+00
1063	1054	2022-12-20	2022-12-26	2022	12	442	f	3.0	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:43.470369+00	2026-10-10 09:49:43.470369+00
1064	1055	2022-12-27	2022-12-30	2022	12	176	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:43.560007+00	2026-10-10 09:49:43.560007+00
1065	1056	2023-01-01	2023-01-06	2023	1	390	f	4.0	f	English	Debut	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:43.660532+00	2026-10-10 09:49:43.660532+00
1066	1057	2023-01-07	2023-01-07	2023	1	109	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:43.671937+00	2026-10-10 09:49:43.671937+00
1067	1058	2023-01-09	2023-01-15	2023	1	343	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:43.784157+00	2026-10-10 09:49:43.784157+00
1068	1059	2023-01-15	\N	2023	1	\N	t	\N	f	English	New to me	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:43.876694+00	2026-10-10 09:49:43.876694+00
1069	1060	2023-01-17	\N	2023	1	\N	t	\N	f	Croatian	New to me	Gifted	\N	\N	\N	\N	2026-10-10 09:49:43.957032+00	2026-10-10 09:49:43.957032+00
1070	1061	2023-02-04	2023-02-10	2023	2	357	f	3.0	f	English	Read before	Downloaded	life & death	\N	\N	\N	2026-10-10 09:49:43.969465+00	2026-10-10 09:49:43.969465+00
1071	1062	2023-02-04	2023-02-07	2023	2	344	f	2.5	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:44.068145+00	2026-10-10 09:49:44.068145+00
1072	1063	2023-02-11	2023-02-15	2023	2	246	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:44.157864+00	2026-10-10 09:49:44.157864+00
1073	1064	2023-02-15	2023-02-25	2023	2	361	f	5.0	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:44.167586+00	2026-10-10 09:49:44.167586+00
1074	1065	2023-02-17	2023-02-26	2023	2	270	f	3.0	f	Croatian	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:44.176807+00	2026-10-10 09:49:44.176807+00
1075	1066	2023-02-17	2023-02-18	2023	2	234	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:44.295352+00	2026-10-10 09:49:44.295352+00
1076	1067	2023-02-27	2023-03-01	2023	2	90	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:44.451856+00	2026-10-10 09:49:44.451856+00
1077	1068	2023-03-04	2023-03-05	2023	3	287	f	5.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:44.48406+00	2026-10-10 09:49:44.48406+00
1078	1069	2023-03-05	2023-03-10	2023	3	398	f	3.5	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:44.55618+00	2026-10-10 09:49:44.55618+00
1079	1070	2023-03-10	2023-03-14	2023	3	349	f	4.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:44.565858+00	2026-10-10 09:49:44.565858+00
1080	1071	2023-03-11	2023-03-22	2023	3	261	f	3.5	f	English	Debut	Downloaded	emotions	\N	\N	\N	2026-10-10 09:49:44.679853+00	2026-10-10 09:49:44.679853+00
1081	1072	2023-03-23	2023-03-31	2023	3	384	f	2.0	f	English	Read before	Downloaded	"secret"	\N	\N	\N	2026-10-10 09:49:44.692194+00	2026-10-10 09:49:44.692194+00
1082	1073	2023-04-01	2023-04-14	2023	4	313	f	3.0	f	English	Debut	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:44.792487+00	2026-10-10 09:49:44.792487+00
1083	1074	2023-04-06	2023-04-09	2023	4	289	f	3.5	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:44.879627+00	2026-10-10 09:49:44.879627+00
1084	1075	2023-04-09	2023-04-16	2023	4	361	f	4.0	f	English	New to me	Bought	game	\N	\N	\N	2026-10-10 09:49:44.961252+00	2026-10-10 09:49:44.961252+00
1085	1076	2023-04-17	2023-04-30	2023	4	300	f	2.5	f	English	New to me	Bought	emotions	\N	\N	\N	2026-10-10 09:49:45.061051+00	2026-10-10 09:49:45.061051+00
1086	1077	2023-04-19	2023-04-20	2023	4	219	f	3.5	f	English	New to me	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:45.155088+00	2026-10-10 09:49:45.155088+00
1087	1078	2023-04-20	2023-04-22	2023	4	275	f	3.5	f	English	Read before	Bought	"other"	\N	\N	\N	2026-10-10 09:49:45.166851+00	2026-10-10 09:49:45.166851+00
1088	1079	2023-04-24	2023-04-28	2023	4	322	f	4.0	f	English	New to me	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:45.257434+00	2026-10-10 09:49:45.257434+00
1089	1080	2023-05-01	2023-05-02	2023	5	169	f	3.0	f	English	Read before	Bought	life & death	\N	\N	\N	2026-10-10 09:49:45.267271+00	2026-10-10 09:49:45.267271+00
1090	1081	2023-05-02	2023-05-04	2023	5	336	f	4.0	t	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:45.365457+00	2026-10-10 09:49:45.365457+00
1091	1082	2023-05-04	2023-05-07	2023	5	306	f	4.0	f	Croatian	New to me	Bought	"secret"	\N	\N	\N	2026-10-10 09:49:45.454752+00	2026-10-10 09:49:45.454752+00
1092	1083	2023-05-05	2023-05-18	2023	5	316	f	3.0	f	English	New to me	Downloaded	sound	\N	\N	\N	2026-10-10 09:49:45.486164+00	2026-10-10 09:49:45.486164+00
1093	1084	2023-05-07	2023-05-12	2023	5	357	f	4.5	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:45.558255+00	2026-10-10 09:49:45.558255+00
1094	1085	2023-05-19	\N	2023	5	\N	t	\N	f	English	New to me	Bought	flavours	\N	\N	\N	2026-10-10 09:49:45.659052+00	2026-10-10 09:49:45.659052+00
1095	1086	2023-05-20	2023-05-21	2023	5	358	f	4.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:45.669856+00	2026-10-10 09:49:45.669856+00
1096	1087	2023-05-22	2023-05-24	2023	5	429	f	3.0	f	English	Read before	Bought	emotions	\N	\N	\N	2026-10-10 09:49:45.680107+00	2026-10-10 09:49:45.680107+00
1097	1088	2023-05-24	2023-05-24	2023	5	144	f	3.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:45.758195+00	2026-10-10 09:49:45.758195+00
1098	1089	2023-05-25	2023-05-30	2023	5	368	f	3.5	f	English	Read before	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:45.769819+00	2026-10-10 09:49:45.769819+00
1099	1090	2023-05-29	2023-06-01	2023	5	320	f	3.5	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:45.956249+00	2026-10-10 09:49:45.956249+00
1100	1091	2023-06-01	2023-06-11	2023	6	364	f	5.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:45.967478+00	2026-10-10 09:49:45.967478+00
1101	1092	2023-06-03	2023-06-07	2023	6	93	f	2.5	f	English	New to me	Downloaded	"good"	\N	\N	\N	2026-10-10 09:49:46.068324+00	2026-10-10 09:49:46.068324+00
1102	1093	2023-06-07	2023-06-10	2023	6	310	f	3.5	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:46.158935+00	2026-10-10 09:49:46.158935+00
1103	1094	2023-06-07	2023-06-11	2023	6	365	f	4.0	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:46.173186+00	2026-10-10 09:49:46.173186+00
1104	1095	2023-06-07	2023-06-11	2023	6	338	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:46.257991+00	2026-10-10 09:49:46.257991+00
1105	1096	2023-06-07	2023-06-17	2023	6	429	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:46.269584+00	2026-10-10 09:49:46.269584+00
1106	1097	2023-06-12	2023-06-19	2023	6	384	f	3.5	f	English	New to me	Downloaded	"other"	\N	\N	\N	2026-10-10 09:49:46.407917+00	2026-10-10 09:49:46.407917+00
1107	1098	2023-06-12	\N	2023	6	\N	t	\N	f	English	Read before	Downloaded	sound	\N	\N	\N	2026-10-10 09:49:46.453189+00	2026-10-10 09:49:46.453189+00
1108	1099	2023-06-18	2023-06-21	2023	6	356	f	4.0	f	Croatian	New to me	Bought	verbs	\N	\N	\N	2026-10-10 09:49:46.490196+00	2026-10-10 09:49:46.490196+00
1109	1100	2023-06-22	2023-06-23	2023	6	269	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:46.561835+00	2026-10-10 09:49:46.561835+00
1110	1101	2023-06-23	2023-06-26	2023	6	255	f	4.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:46.666494+00	2026-10-10 09:49:46.666494+00
1111	1102	2023-06-24	2023-06-29	2023	6	419	f	4.5	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:46.677159+00	2026-10-10 09:49:46.677159+00
1112	1103	2023-06-26	2023-07-01	2023	6	352	f	5.0	f	English	New to me	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:46.78588+00	2026-10-10 09:49:46.78588+00
1113	1104	2023-07-01	2023-07-20	2023	7	202	f	3.0	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:46.856273+00	2026-10-10 09:49:46.856273+00
1114	1105	2023-07-02	2023-07-05	2023	7	317	f	4.0	f	English	Debut	Bought	\N	\N	\N	\N	2026-10-10 09:49:46.958158+00	2026-10-10 09:49:46.958158+00
1115	1106	2023-07-02	\N	2023	7	\N	t	\N	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:46.970154+00	2026-10-10 09:49:46.970154+00
1116	1107	2023-07-03	2023-07-06	2023	7	326	f	1.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:47.058701+00	2026-10-10 09:49:47.058701+00
1117	1108	2023-07-05	2023-07-06	2023	7	321	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:47.160206+00	2026-10-10 09:49:47.160206+00
1118	1109	2023-07-07	2023-07-07	2023	7	238	f	5.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:47.274724+00	2026-10-10 09:49:47.274724+00
1119	1110	2023-07-07	2023-07-12	2023	7	368	f	2.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:47.358006+00	2026-10-10 09:49:47.358006+00
1120	1111	2023-07-07	2023-07-12	2023	7	135	f	2.0	f	English	New to me	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:47.460794+00	2026-10-10 09:49:47.460794+00
1121	1112	2023-07-08	2023-07-10	2023	7	409	f	3.5	f	Croatian	New to me	Bought	verbs	\N	\N	\N	2026-10-10 09:49:47.56636+00	2026-10-10 09:49:47.56636+00
1122	1113	2023-07-10	\N	2023	7	\N	t	\N	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:47.695598+00	2026-10-10 09:49:47.695598+00
1123	1114	2023-07-11	2023-07-17	2023	7	283	f	2.5	f	English	Read before	Bought	emotions	\N	\N	\N	2026-10-10 09:49:47.750547+00	2026-10-10 09:49:47.750547+00
1124	1115	2023-07-14	2023-07-30	2023	7	385	f	4.0	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:47.773123+00	2026-10-10 09:49:47.773123+00
1125	1116	2023-07-20	2023-07-23	2023	7	368	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:48.046375+00	2026-10-10 09:49:48.046375+00
1126	1117	2023-08-02	2023-08-09	2023	8	370	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:48.125161+00	2026-10-10 09:49:48.125161+00
1127	1118	2023-08-04	2023-08-10	2023	8	415	f	4.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:48.268929+00	2026-10-10 09:49:48.268929+00
1128	1119	2023-08-11	2023-08-17	2023	8	472	f	3.5	f	English	Debut	Downloaded	life & death	\N	\N	\N	2026-10-10 09:49:48.366908+00	2026-10-10 09:49:48.366908+00
1129	1120	2023-08-11	2023-08-16	2023	8	383	f	2.0	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:48.39085+00	2026-10-10 09:49:48.39085+00
1130	1121	2023-08-18	2023-08-20	2023	8	113	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:48.489332+00	2026-10-10 09:49:48.489332+00
1131	1122	2023-08-19	2023-08-28	2023	8	336	f	1.5	f	English	Read before	Bought	body parts	\N	\N	\N	2026-10-10 09:49:48.560986+00	2026-10-10 09:49:48.560986+00
1132	1123	2023-08-21	2023-08-27	2023	8	353	f	5.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:48.574289+00	2026-10-10 09:49:48.574289+00
1133	1124	2023-08-27	2023-09-03	2023	9	400	f	4.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:48.758077+00	2026-10-10 09:49:48.758077+00
1134	1125	2023-09-01	2023-09-07	2023	9	407	f	5.0	f	English	Read before	Downloaded	emotions	\N	\N	\N	2026-10-10 09:49:48.7695+00	2026-10-10 09:49:48.7695+00
1135	1126	2023-09-01	2023-09-17	2023	9	415	f	3.5	f	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:48.781189+00	2026-10-10 09:49:48.781189+00
1136	1127	2023-09-04	\N	2023	9	\N	t	\N	f	Croatian	Read before	Bought	game	\N	\N	\N	2026-10-10 09:49:48.860154+00	2026-10-10 09:49:48.860154+00
1137	1128	2023-09-08	2023-09-23	2023	9	289	f	3.5	f	English	Read before	Downloaded	"good"	\N	\N	\N	2026-10-10 09:49:48.870753+00	2026-10-10 09:49:48.870753+00
1138	1129	2023-09-10	\N	2023	9	\N	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:49.05719+00	2026-10-10 09:49:49.05719+00
1139	1130	2023-09-13	2023-09-19	2023	9	333	f	5.0	f	English	New to me	Downloaded	game	\N	\N	\N	2026-10-10 09:49:49.176118+00	2026-10-10 09:49:49.176118+00
1140	1131	2023-09-24	2023-09-28	2023	9	336	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:49.256981+00	2026-10-10 09:49:49.256981+00
1141	1132	2023-10-02	2023-11-02	2023	10	501	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:49.361784+00	2026-10-10 09:49:49.361784+00
1142	1133	2023-10-03	2023-10-18	2023	10	324	f	4.0	f	Croatian	Read before	Library	verbs	\N	\N	\N	2026-10-10 09:49:49.456007+00	2026-10-10 09:49:49.456007+00
1143	1134	2023-10-05	2023-10-21	2023	10	146	f	2.0	f	English	New to me	Bought	life & death	\N	\N	\N	2026-10-10 09:49:49.559128+00	2026-10-10 09:49:49.559128+00
1144	1135	2023-10-09	2023-10-15	2023	10	384	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:49.583115+00	2026-10-10 09:49:49.583115+00
1145	1136	2023-10-18	2023-10-27	2023	10	379	f	3.5	f	English	Read before	Bought	game	\N	\N	\N	2026-10-10 09:49:49.661178+00	2026-10-10 09:49:49.661178+00
1146	1137	2023-10-27	\N	2023	10	\N	t	\N	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:49.79733+00	2026-10-10 09:49:49.79733+00
1147	1138	2023-10-28	2023-11-03	2023	10	306	f	2.5	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:49.955517+00	2026-10-10 09:49:49.955517+00
1148	1139	2023-11-02	\N	2023	11	\N	t	\N	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:49.969448+00	2026-10-10 09:49:49.969448+00
1149	1140	2023-11-03	2023-11-07	2023	11	344	f	4.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:50.15302+00	2026-10-10 09:49:50.15302+00
1150	1141	2023-11-04	2023-11-05	2023	11	242	f	5.0	f	English	Read before	Bought	verbs	\N	\N	\N	2026-10-10 09:49:50.166604+00	2026-10-10 09:49:50.166604+00
1151	1142	2023-11-05	2023-11-15	2023	11	244	f	5.0	f	English	Read before	Downloaded	verbs	\N	\N	\N	2026-10-10 09:49:50.256713+00	2026-10-10 09:49:50.256713+00
1152	1143	2023-11-08	2023-11-12	2023	11	362	f	4.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:50.359989+00	2026-10-10 09:49:50.359989+00
1153	1144	2023-11-17	\N	2023	11	\N	t	\N	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:50.468431+00	2026-10-10 09:49:50.468431+00
1154	1145	2023-11-25	\N	2023	11	\N	t	\N	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:50.57697+00	2026-10-10 09:49:50.57697+00
1155	1145	2025-10-28	2025-11-02	2025	10	379	f	3.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:49:50.579085+00	2026-10-10 09:49:50.579085+00
1156	1146	2023-11-29	2023-11-29	2023	11	29	f	2.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:50.666548+00	2026-10-10 09:49:50.666548+00
1157	1147	2023-12-02	2023-12-05	2023	12	384	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:50.791801+00	2026-10-10 09:49:50.791801+00
1158	1148	2023-12-06	2023-12-06	2023	12	128	f	1.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:50.860103+00	2026-10-10 09:49:50.860103+00
1159	1149	2023-12-06	2023-12-10	2023	12	185	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:50.986627+00	2026-10-10 09:49:50.986627+00
1160	1150	2023-12-09	2023-12-13	2023	12	341	f	4.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:51.05832+00	2026-10-10 09:49:51.05832+00
1161	1151	2023-12-13	\N	2023	12	\N	t	\N	f	English	New to me	Downloaded	"secret"	\N	\N	\N	2026-10-10 09:49:51.159334+00	2026-10-10 09:49:51.159334+00
1162	1152	2023-12-13	2023-12-19	2023	12	332	f	2.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:51.259283+00	2026-10-10 09:49:51.259283+00
1163	1153	2023-12-19	2023-12-26	2023	12	367	f	3.5	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:51.380767+00	2026-10-10 09:49:51.380767+00
1164	1154	2023-12-21	2023-12-21	2023	12	102	f	2.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:51.463481+00	2026-10-10 09:49:51.463481+00
1165	1155	2023-12-22	2023-12-26	2023	12	330	f	3.5	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:51.595901+00	2026-10-10 09:49:51.595901+00
1166	1156	2023-12-26	\N	2023	12	\N	t	\N	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:51.756805+00	2026-10-10 09:49:51.756805+00
1167	1157	2023-12-26	2023-12-31	2023	12	84	f	5.0	f	English	Read before	Downloaded	flavours	\N	\N	\N	2026-10-10 09:49:51.859579+00	2026-10-10 09:49:51.859579+00
1168	1158	2024-01-02	2024-01-11	2024	1	256	f	4.0	f	English	New to me	Downloaded	there/their/they're	\N	\N	\N	2026-10-10 09:49:51.970372+00	2026-10-10 09:49:51.970372+00
1169	1159	2024-01-05	2024-01-06	2024	1	375	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:51.982321+00	2026-10-10 09:49:51.982321+00
1170	1160	2024-01-05	2024-01-05	2024	1	124	f	3.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:52.060154+00	2026-10-10 09:49:52.060154+00
1171	1161	2024-01-05	2024-01-09	2024	1	291	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:52.185303+00	2026-10-10 09:49:52.185303+00
1172	1162	2024-01-06	2024-01-06	2024	1	86	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:52.268752+00	2026-10-10 09:49:52.268752+00
1173	1163	2024-01-07	2024-01-10	2024	1	382	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:52.356717+00	2026-10-10 09:49:52.356717+00
1174	1164	2024-01-10	2024-01-16	2024	1	390	f	2.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:52.369543+00	2026-10-10 09:49:52.369543+00
1175	1165	2024-01-11	2024-01-21	2024	1	240	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:52.458366+00	2026-10-10 09:49:52.458366+00
1176	1166	2024-01-16	\N	2024	1	46	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:52.57584+00	2026-10-10 09:49:52.57584+00
1177	1167	2024-01-16	2024-01-20	2024	1	375	f	2.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:52.689057+00	2026-10-10 09:49:52.689057+00
1178	1168	2024-01-22	2024-01-26	2024	1	113	f	1.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:52.855905+00	2026-10-10 09:49:52.855905+00
1179	1169	2024-01-23	2024-01-25	2024	1	336	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:52.964834+00	2026-10-10 09:49:52.964834+00
1180	1170	2024-01-27	\N	2024	1	67	t	\N	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:53.091832+00	2026-10-10 09:49:53.091832+00
1181	1171	2024-01-28	2024-01-31	2024	1	328	f	4.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:53.16817+00	2026-10-10 09:49:53.16817+00
1182	1172	2024-01-31	\N	2024	2	56	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:53.360226+00	2026-10-10 09:49:53.360226+00
1183	1173	2024-02-02	\N	2024	2	89	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:53.465751+00	2026-10-10 09:49:53.465751+00
1184	1174	2024-02-02	2024-02-05	2024	2	435	f	2.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:53.588836+00	2026-10-10 09:49:53.588836+00
1185	1175	2024-02-04	2024-02-04	2024	2	309	f	4.5	t	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:53.669118+00	2026-10-10 09:49:53.669118+00
1186	1176	2024-02-06	2024-02-08	2024	2	276	f	3.5	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:53.860052+00	2026-10-10 09:49:53.860052+00
1187	1177	2024-02-06	2024-02-06	2024	2	283	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:53.96384+00	2026-10-10 09:49:53.96384+00
1188	1178	2024-02-08	2024-02-10	2024	2	288	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:54.087988+00	2026-10-10 09:49:54.087988+00
1189	1179	2024-02-10	2024-02-11	2024	2	340	f	4.5	f	English	New to me	Downloaded	positive words	\N	\N	\N	2026-10-10 09:49:54.257855+00	2026-10-10 09:49:54.257855+00
1190	1180	2024-02-12	2024-02-15	2024	2	342	f	3.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:54.363481+00	2026-10-10 09:49:54.363481+00
1191	1181	2024-02-14	2024-02-21	2024	2	382	f	4.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:54.458726+00	2026-10-10 09:49:54.458726+00
1192	1182	2024-02-15	2024-02-15	2024	2	162	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:54.564074+00	2026-10-10 09:49:54.564074+00
1193	1183	2024-02-24	2024-03-02	2024	2	375	f	2.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:54.656753+00	2026-10-10 09:49:54.656753+00
1194	1184	2024-03-03	2024-03-04	2024	3	250	f	1.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:54.668146+00	2026-10-10 09:49:54.668146+00
1195	1185	2024-03-03	2024-03-08	2024	3	236	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:54.799939+00	2026-10-10 09:49:54.799939+00
1196	1186	2024-03-05	2024-03-07	2024	3	349	f	1.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:54.853336+00	2026-10-10 09:49:54.853336+00
1197	1187	2024-03-06	2024-03-10	2024	3	315	f	3.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:54.864423+00	2026-10-10 09:49:54.864423+00
1198	1188	2024-03-08	2024-03-13	2024	3	134	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:54.965808+00	2026-10-10 09:49:54.965808+00
1199	1189	2024-03-12	2024-03-16	2024	3	341	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:54.980506+00	2026-10-10 09:49:54.980506+00
1200	1190	2024-03-12	2024-03-16	2024	3	376	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:55.163744+00	2026-10-10 09:49:55.163744+00
1201	1191	2024-03-14	2024-03-23	2024	3	346	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:55.258259+00	2026-10-10 09:49:55.258259+00
1202	1192	2024-03-18	2024-03-20	2024	3	332	f	4.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:55.371102+00	2026-10-10 09:49:55.371102+00
1203	1193	2024-03-20	2024-03-23	2024	3	283	f	4.0	t	English	Read before	Bought	character names	\N	\N	\N	2026-10-10 09:49:55.466156+00	2026-10-10 09:49:55.466156+00
1204	1194	2024-03-24	2024-03-25	2024	3	334	f	4.0	f	English	New to me	Bought	character names	\N	\N	\N	2026-10-10 09:49:55.562013+00	2026-10-10 09:49:55.562013+00
1205	1195	2024-03-25	2024-03-26	2024	3	236	f	3.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:55.657982+00	2026-10-10 09:49:55.657982+00
1206	1196	2024-03-26	2024-03-28	2024	3	256	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:55.671903+00	2026-10-10 09:49:55.671903+00
1207	1197	2024-03-26	2024-03-26	2024	3	111	f	3.0	f	English	New to me	Downloaded	character names	\N	\N	\N	2026-10-10 09:49:55.800374+00	2026-10-10 09:49:55.800374+00
1208	1198	2024-03-27	2024-03-31	2024	3	194	f	2.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:55.878426+00	2026-10-10 09:49:55.878426+00
1209	1199	2024-03-28	2024-03-31	2024	3	385	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:55.960327+00	2026-10-10 09:49:55.960327+00
1210	1200	2024-04-01	2024-04-05	2024	4	465	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:56.053118+00	2026-10-10 09:49:56.053118+00
1211	1201	2024-04-01	\N	2024	4	116	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:56.159196+00	2026-10-10 09:49:56.159196+00
1212	1202	2024-04-02	2024-04-10	2024	4	384	f	3.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:56.169954+00	2026-10-10 09:49:56.169954+00
1213	1203	2024-04-06	2024-04-07	2024	4	165	f	3.5	f	English	New to me	Bought	nature words	\N	\N	\N	2026-10-10 09:49:56.35074+00	2026-10-10 09:49:56.35074+00
1214	1204	2024-04-08	2024-04-10	2024	4	332	f	4.0	t	English	Read before	Bought	nature words	\N	\N	\N	2026-10-10 09:49:56.457812+00	2026-10-10 09:49:56.457812+00
1215	1205	2024-04-10	2024-04-30	2024	4	341	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:56.473011+00	2026-10-10 09:49:56.473011+00
1216	1206	2024-04-11	2024-04-13	2024	4	270	f	4.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:56.559223+00	2026-10-10 09:49:56.559223+00
1217	1207	2024-04-13	2024-04-15	2024	4	345	f	5.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:56.57191+00	2026-10-10 09:49:56.57191+00
1218	1208	2024-04-15	2024-04-18	2024	4	577	f	5.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:56.661724+00	2026-10-10 09:49:56.661724+00
1219	1209	2024-04-18	2024-04-22	2024	4	793	f	4.5	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:56.755666+00	2026-10-10 09:49:56.755666+00
1220	1210	2024-04-23	2024-04-26	2024	4	519	f	4.0	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:56.7701+00	2026-10-10 09:49:56.7701+00
1221	1211	2024-04-29	\N	2024	4	77	t	\N	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:56.961299+00	2026-10-10 09:49:56.961299+00
1222	1212	2024-05-01	2024-05-04	2024	5	610	f	4.5	t	Croatian	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:57.05767+00	2026-10-10 09:49:57.05767+00
1223	1213	2024-05-05	2024-05-16	2024	5	279	f	4.0	f	English	New to me	Downloaded	"every"	\N	\N	\N	2026-10-10 09:49:57.158057+00	2026-10-10 09:49:57.158057+00
1224	1214	2024-05-05	2024-05-12	2024	5	417	f	3.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:57.169256+00	2026-10-10 09:49:57.169256+00
1225	1215	2024-05-13	2024-05-13	2024	5	352	f	5.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:57.256629+00	2026-10-10 09:49:57.256629+00
1226	1216	2024-05-16	2024-05-24	2024	5	370	f	3.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:57.357958+00	2026-10-10 09:49:57.357958+00
1227	1217	2024-05-25	2024-05-29	2024	5	404	f	3.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:57.369598+00	2026-10-10 09:49:57.369598+00
1228	1218	2024-05-29	2024-05-29	2024	5	144	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:57.497374+00	2026-10-10 09:49:57.497374+00
1229	1219	2024-05-30	2024-06-01	2024	5	305	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:57.666759+00	2026-10-10 09:49:57.666759+00
1230	1220	2024-05-30	2024-05-30	2024	5	294	f	5.0	t	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:57.756343+00	2026-10-10 09:49:57.756343+00
1231	1221	2024-06-01	2024-06-04	2024	6	500	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:57.768519+00	2026-10-10 09:49:57.768519+00
1232	1222	2024-06-02	\N	2024	6	33	t	\N	f	English	New to me	Downloaded	repeating words	\N	\N	\N	2026-10-10 09:49:57.960735+00	2026-10-10 09:49:57.960735+00
1233	1223	2024-06-04	2024-06-06	2024	6	390	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:58.153106+00	2026-10-10 09:49:58.153106+00
1234	1224	2024-06-07	\N	2024	6	170	t	\N	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:58.261916+00	2026-10-10 09:49:58.261916+00
1235	1225	2024-06-07	2024-06-22	2024	6	356	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:58.357429+00	2026-10-10 09:49:58.357429+00
1236	1226	2024-06-09	2024-06-13	2024	6	320	f	4.5	f	English	New to me	Downloaded	"like"	\N	\N	\N	2026-10-10 09:49:58.469341+00	2026-10-10 09:49:58.469341+00
1237	1227	2024-06-14	2024-06-27	2024	6	317	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:58.557018+00	2026-10-10 09:49:58.557018+00
1238	1228	2024-06-23	2024-06-29	2024	6	296	f	1.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:58.572262+00	2026-10-10 09:49:58.572262+00
1239	1229	2024-06-29	2024-07-13	2024	7	303	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:58.663531+00	2026-10-10 09:49:58.663531+00
1240	1230	2024-07-01	2024-07-08	2024	7	360	f	5.0	f	English	Read before	Downloaded	measurements	\N	\N	\N	2026-10-10 09:49:58.67684+00	2026-10-10 09:49:58.67684+00
1241	1231	2024-07-06	2024-07-08	2024	7	80	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:58.762088+00	2026-10-10 09:49:58.762088+00
1242	1232	2024-07-06	2024-07-07	2024	7	315	f	4.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:58.853342+00	2026-10-10 09:49:58.853342+00
1243	1233	2024-07-07	2024-07-10	2024	7	344	f	2.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:58.865715+00	2026-10-10 09:49:58.865715+00
1244	1234	2024-07-09	2024-07-13	2024	7	366	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:58.953346+00	2026-10-10 09:49:58.953346+00
1245	1235	2024-07-11	2024-07-12	2024	7	247	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:58.966752+00	2026-10-10 09:49:58.966752+00
1246	1236	2024-07-14	2024-07-15	2024	7	313	f	5.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.255811+00	2026-10-10 09:49:59.255811+00
1247	1237	2024-07-15	2024-07-17	2024	7	358	f	2.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.270216+00	2026-10-10 09:49:59.270216+00
1248	1238	2024-07-17	2024-07-20	2024	7	373	f	5.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.36025+00	2026-10-10 09:49:59.36025+00
1249	1239	2024-07-20	2024-07-23	2024	7	390	f	5.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.459007+00	2026-10-10 09:49:59.459007+00
1250	1240	2024-07-24	2024-07-26	2024	7	355	f	3.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.610849+00	2026-10-10 09:49:59.610849+00
1251	1241	2024-07-26	2024-07-29	2024	7	361	f	2.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.658992+00	2026-10-10 09:49:59.658992+00
1252	1242	2024-08-04	\N	2024	8	47	t	\N	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.673254+00	2026-10-10 09:49:59.673254+00
1253	1243	2024-08-10	\N	2024	8	146	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:49:59.857131+00	2026-10-10 09:49:59.857131+00
1254	1244	2024-08-11	2024-08-13	2024	8	280	f	4.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:49:59.869641+00	2026-10-10 09:49:59.869641+00
1255	1245	2024-08-13	2024-08-15	2024	8	326	f	3.5	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:00.059957+00	2026-10-10 09:50:00.059957+00
1256	1246	2024-08-15	2024-08-17	2024	8	397	f	3.5	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:00.165521+00	2026-10-10 09:50:00.165521+00
1257	1247	2024-08-17	2024-08-18	2024	8	268	f	2.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:00.283556+00	2026-10-10 09:50:00.283556+00
1258	1248	2024-08-19	2024-08-24	2024	8	403	f	2.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:00.459939+00	2026-10-10 09:50:00.459939+00
1259	1249	2024-08-20	2024-09-04	2024	9	303	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:00.473954+00	2026-10-10 09:50:00.473954+00
1260	1250	2024-08-21	2024-08-23	2024	8	298	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:00.563066+00	2026-10-10 09:50:00.563066+00
1261	1251	2024-08-24	\N	2024	8	119	t	\N	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:00.753282+00	2026-10-10 09:50:00.753282+00
1262	1252	2024-09-01	2024-09-04	2024	9	382	f	4.5	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:00.856256+00	2026-10-10 09:50:00.856256+00
1263	1253	2024-09-04	2024-09-16	2024	9	419	f	4.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:00.963102+00	2026-10-10 09:50:00.963102+00
1264	1254	2024-09-13	2024-09-14	2024	9	318	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:01.06105+00	2026-10-10 09:50:01.06105+00
1265	1255	2024-09-13	2024-09-15	2024	9	118	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:01.183492+00	2026-10-10 09:50:01.183492+00
1266	1256	2024-09-14	2024-09-17	2024	9	206	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:01.285616+00	2026-10-10 09:50:01.285616+00
1267	1257	2024-09-17	\N	2024	9	105	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:01.457601+00	2026-10-10 09:50:01.457601+00
1268	1258	2024-09-17	2024-09-19	2024	9	286	f	2.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:01.560969+00	2026-10-10 09:50:01.560969+00
1269	1259	2024-09-20	\N	2024	9	162	t	\N	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:50:01.679985+00	2026-10-10 09:50:01.679985+00
1270	1260	2024-10-01	2024-10-05	2024	10	433	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:01.759931+00	2026-10-10 09:50:01.759931+00
1271	1261	2024-10-05	2024-11-11	2024	11	367	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:01.888161+00	2026-10-10 09:50:01.888161+00
1272	1262	2024-10-08	2024-10-12	2024	10	220	f	2.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:01.95823+00	2026-10-10 09:50:01.95823+00
1273	1263	2024-10-24	2024-11-04	2024	11	345	f	2.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:01.970886+00	2026-10-10 09:50:01.970886+00
1274	1264	2024-11-05	2024-11-09	2024	11	154	f	1.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:02.05981+00	2026-10-10 09:50:02.05981+00
1275	1265	2024-11-12	2024-11-16	2024	11	390	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:02.155481+00	2026-10-10 09:50:02.155481+00
1276	1266	2024-11-16	2024-11-17	2024	11	266	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:02.260359+00	2026-10-10 09:50:02.260359+00
1277	1267	2024-11-18	2024-11-22	2024	11	264	f	4.5	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:02.363621+00	2026-10-10 09:50:02.363621+00
1278	1268	2024-11-22	2024-11-24	2024	11	252	f	5.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:02.481877+00	2026-10-10 09:50:02.481877+00
1279	1269	2024-11-24	2024-11-29	2024	11	379	f	3.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:02.55796+00	2026-10-10 09:50:02.55796+00
1280	1270	2024-11-26	2024-11-28	2024	11	283	f	4.0	f	English	Debut	Downloaded	senses	\N	\N	\N	2026-10-10 09:50:02.760783+00	2026-10-10 09:50:02.760783+00
1281	1271	2024-11-30	2024-11-30	2024	11	396	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:02.775168+00	2026-10-10 09:50:02.775168+00
1282	1272	2024-12-01	2024-12-01	2024	12	197	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:02.96318+00	2026-10-10 09:50:02.96318+00
1283	1273	2024-12-02	2024-12-06	2024	12	307	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:03.060821+00	2026-10-10 09:50:03.060821+00
1284	1274	2024-12-03	2024-12-07	2024	12	368	f	2.0	f	Croatian	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:03.185298+00	2026-10-10 09:50:03.185298+00
1285	1275	2024-12-05	2024-12-14	2024	12	201	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:03.461768+00	2026-10-10 09:50:03.461768+00
1286	1276	2024-12-07	2024-12-11	2024	12	380	f	3.5	f	Croatian	Read before	Library	\N	\N	\N	\N	2026-10-10 09:50:03.555907+00	2026-10-10 09:50:03.555907+00
1287	1277	2024-12-10	2024-12-10	2024	12	60	f	1.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:03.576227+00	2026-10-10 09:50:03.576227+00
1288	1278	2024-12-12	2024-12-27	2024	12	292	f	3.0	f	English	Debut	Bought	\N	\N	\N	\N	2026-10-10 09:50:03.7679+00	2026-10-10 09:50:03.7679+00
1289	1279	2024-12-15	2024-12-16	2024	12	341	f	2.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:03.959204+00	2026-10-10 09:50:03.959204+00
1290	1280	2024-12-17	2024-12-22	2024	12	390	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:04.073835+00	2026-10-10 09:50:04.073835+00
1291	1281	2024-12-22	2025-01-01	2024	12	234	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:04.164138+00	2026-10-10 09:50:04.164138+00
1292	1282	2024-12-24	2024-12-24	2024	12	46	f	2.0	f	English	Read before	Downloaded	holiday words	\N	\N	\N	2026-10-10 09:50:04.2637+00	2026-10-10 09:50:04.2637+00
1293	1283	2025-01-01	2025-01-09	2025	1	343	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:04.358454+00	2026-10-10 09:50:04.358454+00
1294	1284	2025-01-03	\N	2025	1	93	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:04.55864+00	2026-10-10 09:50:04.55864+00
1295	1285	2025-01-03	2025-01-22	2025	1	525	f	3.0	f	English	New to me	Owned	\N	\N	\N	\N	2026-10-10 09:50:04.685547+00	2026-10-10 09:50:04.685547+00
1296	1286	2025-01-10	2025-01-10	2025	1	278	f	3.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:04.763623+00	2026-10-10 09:50:04.763623+00
1297	1287	2025-01-10	2025-01-15	2025	1	372	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:04.863973+00	2026-10-10 09:50:04.863973+00
1298	1288	2025-01-11	2025-01-11	2025	1	110	f	2.0	f	English	Read before	Downloaded	\N	pattern	\N	\N	2026-10-10 09:50:04.989406+00	2026-10-10 09:50:04.989406+00
1299	1289	2025-01-12	2025-01-15	2025	1	394	f	3.0	f	English	New to me	Owned	\N	\N	\N	\N	2026-10-10 09:50:05.471507+00	2026-10-10 09:50:05.471507+00
1300	1290	2025-01-16	2025-01-17	2025	1	409	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:05.633404+00	2026-10-10 09:50:05.633404+00
1301	1291	2025-01-18	\N	2025	1	176	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:05.755522+00	2026-10-10 09:50:05.755522+00
1302	1292	2025-01-18	\N	2025	1	106	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:05.86214+00	2026-10-10 09:50:05.86214+00
1303	1293	2025-01-20	2025-01-24	2025	1	414	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:05.986783+00	2026-10-10 09:50:05.986783+00
1304	1294	2025-01-23	2025-01-27	2025	1	396	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:06.062559+00	2026-10-10 09:50:06.062559+00
1305	1295	2025-01-23	2025-02-01	2025	1	320	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:06.258246+00	2026-10-10 09:50:06.258246+00
1306	1296	2025-01-23	2025-01-27	2025	1	306	f	3.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:06.358528+00	2026-10-10 09:50:06.358528+00
1307	1297	2025-01-27	2025-01-30	2025	1	304	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:06.495868+00	2026-10-10 09:50:06.495868+00
1308	1298	2025-02-01	2025-02-05	2025	2	632	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:06.660019+00	2026-10-10 09:50:06.660019+00
1309	1299	2025-02-01	2025-02-05	2025	2	466	f	4.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:06.758234+00	2026-10-10 09:50:06.758234+00
1310	1300	2025-02-01	2025-02-28	2025	2	306	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:06.869911+00	2026-10-10 09:50:06.869911+00
1311	1301	2025-02-01	2025-02-25	2025	2	341	f	4.0	f	English	New to me	Owned	water	\N	\N	\N	2026-10-10 09:50:07.069008+00	2026-10-10 09:50:07.069008+00
1312	1302	2025-02-06	2025-02-08	2025	2	433	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:07.160577+00	2026-10-10 09:50:07.160577+00
1313	1303	2025-02-09	2025-02-12	2025	2	229	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:07.290094+00	2026-10-10 09:50:07.290094+00
1314	1304	2025-02-12	2025-02-19	2025	2	290	f	3.5	f	English	Read before	Downloaded	\N	skyline	\N	\N	2026-10-10 09:50:07.37065+00	2026-10-10 09:50:07.37065+00
1315	1305	2025-02-16	2025-02-21	2025	2	436	f	4.0	f	English	Read before	Downloaded	water	\N	\N	\N	2026-10-10 09:50:07.461012+00	2026-10-10 09:50:07.461012+00
1316	1306	2025-02-24	2025-02-28	2025	2	416	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:07.567728+00	2026-10-10 09:50:07.567728+00
1317	1307	2025-02-25	2025-03-01	2025	2	283	f	3.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:07.658986+00	2026-10-10 09:50:07.658986+00
1318	1308	2025-03-01	2025-03-09	2025	3	374	f	3.5	f	English	Debut	Downloaded	\N	\N	set on an island	\N	2026-10-10 09:50:07.862148+00	2026-10-10 09:50:07.862148+00
1319	1309	2025-03-01	2025-03-02	2025	3	454	f	5.0	t	English	Read before	Owned	\N	\N	starts with "the"	\N	2026-10-10 09:50:08.071753+00	2026-10-10 09:50:08.071753+00
1320	1310	2025-03-03	2025-03-04	2025	3	472	f	5.0	t	English	Read before	Owned	\N	\N	even number of pages	\N	2026-10-10 09:50:08.168263+00	2026-10-10 09:50:08.168263+00
1321	1311	2025-03-05	2025-03-08	2025	3	455	f	4.0	t	English	Read before	Owned	\N	\N	continue a series	\N	2026-10-10 09:50:08.265312+00	2026-10-10 09:50:08.265312+00
1322	1312	2025-03-09	\N	2025	3	113	t	\N	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:08.354728+00	2026-10-10 09:50:08.354728+00
1323	1313	2025-03-09	2025-03-14	2025	3	250	f	2.5	f	English	New to me	Downloaded	"thing"	\N	a book by a new to you author	\N	2026-10-10 09:50:08.572755+00	2026-10-10 09:50:08.572755+00
1324	1314	2025-03-13	2025-03-28	2025	3	366	f	1.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:08.757619+00	2026-10-10 09:50:08.757619+00
1325	1315	2025-03-15	2025-03-17	2025	3	517	f	2.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:08.774789+00	2026-10-10 09:50:08.774789+00
1326	1316	2025-03-18	2025-03-19	2025	3	348	f	5.0	f	English	Read before	Downloaded	\N	\N	reference to time in the title	\N	2026-10-10 09:50:08.868155+00	2026-10-10 09:50:08.868155+00
1327	1317	2025-03-22	\N	2025	3	76	t	\N	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:09.069537+00	2026-10-10 09:50:09.069537+00
1328	1318	2025-03-23	2025-03-31	2025	3	368	f	4.5	f	English	New to me	Downloaded	\N	books	grumpy x sunshine	\N	2026-10-10 09:50:09.261044+00	2026-10-10 09:50:09.261044+00
1329	1319	2025-03-23	\N	2025	3	219	t	\N	t	English	Read before	Owned	\N	\N	title appears in the text	\N	2026-10-10 09:50:09.457854+00	2026-10-10 09:50:09.457854+00
1330	1320	2025-03-31	2025-03-31	2025	3	55	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:09.473721+00	2026-10-10 09:50:09.473721+00
1331	1321	2025-04-01	\N	2025	4	126	t	\N	f	English	Read before	Owned	\N	\N	written my male author	\N	2026-10-10 09:50:09.567075+00	2026-10-10 09:50:09.567075+00
1332	1322	2025-04-01	2025-04-06	2025	4	299	f	4.0	f	English	Read before	Downloaded	\N	\N	booksta favorite	\N	2026-10-10 09:50:09.662671+00	2026-10-10 09:50:09.662671+00
1333	1323	2025-04-03	2025-04-20	2025	4	363	f	2.5	f	English	New to me	Bought	\N	\N	dedication that you love	\N	2026-10-10 09:50:09.861046+00	2026-10-10 09:50:09.861046+00
1334	1324	2025-04-07	2025-04-30	2025	4	245	f	3.0	f	English	Debut	Downloaded	animals	\N	\N	\N	2026-10-10 09:50:10.05557+00	2026-10-10 09:50:10.05557+00
1335	1325	2025-04-10	2025-04-10	2025	4	365	f	4.0	f	English	New to me	Downloaded	\N	\N	written by male author	\N	2026-10-10 09:50:10.165474+00	2026-10-10 09:50:10.165474+00
1336	1326	2025-04-10	2025-04-13	2025	4	260	f	3.0	f	English	Read before	Bought	\N	animals	insect on the cover	\N	2026-10-10 09:50:10.261124+00	2026-10-10 09:50:10.261124+00
1337	1327	2025-04-12	2025-04-21	2025	4	332	f	3.5	f	English	New to me	Downloaded	\N	\N	weapon on the cover	\N	2026-10-10 09:50:10.456099+00	2026-10-10 09:50:10.456099+00
1338	1328	2025-04-15	2025-04-28	2025	4	450	f	3.5	f	English	New to me	Gifted	\N	animals	shocking twist	\N	2026-10-10 09:50:10.564469+00	2026-10-10 09:50:10.564469+00
1339	1329	2025-04-22	2025-04-24	2025	4	304	f	3.5	f	English	New to me	Downloaded	\N	\N	"bloom" in the text	\N	2026-10-10 09:50:10.759688+00	2026-10-10 09:50:10.759688+00
1340	1330	2025-04-29	2025-04-30	2025	4	399	f	3.0	f	English	Read before	Owned	\N	\N	clouds on the cover	\N	2026-10-10 09:50:10.774536+00	2026-10-10 09:50:10.774536+00
1341	1331	2025-05-01	\N	2025	5	54	t	\N	f	English	Read before	Downloaded	\N	eyes	\N	\N	2026-10-10 09:50:10.862508+00	2026-10-10 09:50:10.862508+00
1342	1332	2025-05-02	2025-05-05	2025	5	229	f	3.0	f	English	New to me	Downloaded	\N	\N	title in the text	\N	2026-10-10 09:50:11.057748+00	2026-10-10 09:50:11.057748+00
1343	1333	2025-05-03	2025-05-11	2025	5	242	f	3.5	f	Croatian	New to me	Owned	\N	\N	featuring mental health	AAPI month	2026-10-10 09:50:11.17368+00	2026-10-10 09:50:11.17368+00
1344	1334	2025-05-05	2025-05-07	2025	5	239	f	2.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:11.360984+00	2026-10-10 09:50:11.360984+00
1345	1335	2025-05-08	2025-05-08	2025	5	108	f	1.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:11.455854+00	2026-10-10 09:50:11.455854+00
1346	1336	2025-05-09	2025-05-11	2025	5	289	f	5.0	f	English	Read before	Downloaded	\N	\N	pastel colors on the cover	AAPI month	2026-10-10 09:50:11.472785+00	2026-10-10 09:50:11.472785+00
1347	1337	2025-05-11	2025-05-26	2025	5	300	f	2.0	f	English	New to me	Downloaded	\N	eyes	set in a small town	\N	2026-10-10 09:50:11.666166+00	2026-10-10 09:50:11.666166+00
1348	1338	2025-05-12	2025-05-13	2025	5	371	f	3.5	f	English	New to me	Downloaded	\N	\N	involving sport	AAPI month	2026-10-10 09:50:11.859629+00	2026-10-10 09:50:11.859629+00
1349	1339	2025-05-14	2025-05-14	2025	5	214	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:11.874695+00	2026-10-10 09:50:11.874695+00
1350	1340	2025-05-16	2025-05-18	2025	5	324	f	4.0	f	English	Debut	Downloaded	\N	\N	admin's choice	AAPI month	2026-10-10 09:50:12.062005+00	2026-10-10 09:50:12.062005+00
1351	1341	2025-05-17	2025-05-17	2025	5	215	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:12.156617+00	2026-10-10 09:50:12.156617+00
1352	1342	2025-05-18	2025-05-22	2025	5	433	f	4.0	f	English	New to me	Owned	"to" and "too"	\N	\N	\N	2026-10-10 09:50:12.270193+00	2026-10-10 09:50:12.270193+00
1353	1343	2025-05-19	2025-05-24	2025	5	304	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	AAPI month	2026-10-10 09:50:12.460627+00	2026-10-10 09:50:12.460627+00
1354	1344	2025-05-26	2025-12-28	2025	12	379	f	3.0	f	Croatian	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:12.556891+00	2026-10-10 09:50:12.556891+00
1355	1345	2025-05-26	2025-05-31	2025	5	319	f	4.0	f	English	Debut	Downloaded	\N	\N	alliterative title	\N	2026-10-10 09:50:12.672574+00	2026-10-10 09:50:12.672574+00
1356	1346	2025-05-26	2025-06-01	2025	5	371	f	4.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:12.763628+00	2026-10-10 09:50:12.763628+00
1357	1347	2025-06-01	\N	2025	6	67	t	\N	f	English	New to me	Downloaded	\N	\N	\N	Pride month	2026-10-10 09:50:13.0509+00	2026-10-10 09:50:13.0509+00
1358	1348	2025-06-01	2025-06-17	2025	6	320	f	1.0	f	English	New to me	Downloaded	\N	\N	vibrant cover	Pride month	2026-10-10 09:50:13.189057+00	2026-10-10 09:50:13.189057+00
1359	1349	2025-06-03	2025-06-04	2025	6	288	f	2.5	f	English	New to me	Downloaded	\N	\N	adjective in the title	Pride month	2026-10-10 09:50:13.368739+00	2026-10-10 09:50:13.368739+00
1360	1350	2025-06-04	2025-06-07	2025	6	283	f	3.5	f	English	New to me	Downloaded	\N	\N	odd number of pages	Pride month	2026-10-10 09:50:13.567219+00	2026-10-10 09:50:13.567219+00
1361	1351	2025-06-08	2025-06-08	2025	6	283	f	3.0	f	English	New to me	Downloaded	\N	\N	number in the title	Pride month	2026-10-10 09:50:13.762687+00	2026-10-10 09:50:13.762687+00
1362	1352	2025-06-09	2025-07-01	2025	6	301	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:13.858246+00	2026-10-10 09:50:13.858246+00
1363	1353	2025-06-09	2025-06-12	2025	6	358	f	4.0	f	English	Read before	Owned	\N	celestial	multiple POVs	Pride month	2026-10-10 09:50:13.873608+00	2026-10-10 09:50:13.873608+00
1364	1354	2025-06-10	2025-06-17	2025	6	505	f	4.0	f	English	New to me	Downloaded	\N	\N	epilogue	Pride month	2026-10-10 09:50:14.065455+00	2026-10-10 09:50:14.065455+00
1365	1355	2025-06-13	2025-06-14	2025	6	198	f	2.0	f	English	New to me	Downloaded	\N	\N	LGBTQIA+ main character	Pride month	2026-10-10 09:50:14.254896+00	2026-10-10 09:50:14.254896+00
1366	1356	2025-06-14	2025-06-14	2025	6	90	f	3.5	f	English	New to me	Downloaded	\N	\N	without 'the', 'a' or 'and'	Pride month	2026-10-10 09:50:14.467091+00	2026-10-10 09:50:14.467091+00
1367	1357	2025-06-15	2025-06-16	2025	6	381	f	3.0	f	English	Read before	Downloaded	\N	\N	no chapter titles/numbers	Pride month	2026-10-10 09:50:14.560158+00	2026-10-10 09:50:14.560158+00
1368	1358	2025-06-18	2025-06-28	2025	6	401	f	5.0	f	English	Read before	Owned	\N	\N	sand on the cover	Pride month	2026-10-10 09:50:14.657082+00	2026-10-10 09:50:14.657082+00
1369	1359	2025-06-18	2025-06-24	2025	6	360	f	4.5	f	English	New to me	Downloaded	\N	\N	word 'cocktail' in text	Pride month	2026-10-10 09:50:14.865447+00	2026-10-10 09:50:14.865447+00
1370	1360	2025-06-20	2025-06-21	2025	6	324	f	5.0	f	English	Read before	Owned	\N	\N	interconnected standalone	Pride month	2026-10-10 09:50:14.960617+00	2026-10-10 09:50:14.960617+00
1371	1361	2025-06-21	2025-06-22	2025	6	371	f	4.0	f	English	Read before	Owned	\N	\N	MC owns a business	Pride month	2026-10-10 09:50:15.050957+00	2026-10-10 09:50:15.050957+00
1372	1362	2025-06-22	2025-06-23	2025	6	235	f	1.0	f	English	New to me	Downloaded	\N	\N	vacation or road trip	Pride month	2026-10-10 09:50:15.257673+00	2026-10-10 09:50:15.257673+00
1373	1363	2025-06-25	2025-06-27	2025	6	332	f	5.0	f	English	Read before	Bought	\N	\N	published in June, July, or August	Pride month	2026-10-10 09:50:15.278181+00	2026-10-10 09:50:15.278181+00
1374	1364	2025-06-27	\N	2025	6	34	t	\N	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:15.368665+00	2026-10-10 09:50:15.368665+00
1375	1365	2025-07-02	2025-07-05	2025	7	332	f	5.0	f	English	Read before	Bought	\N	\N	bought without reading the blurb	\N	2026-10-10 09:50:15.465319+00	2026-10-10 09:50:15.465319+00
1376	1366	2025-07-06	2025-07-08	2025	7	332	f	4.0	f	Croatian	New to me	Owned	\N	\N	\N	Disability month	2026-10-10 09:50:15.665806+00	2026-10-10 09:50:15.665806+00
1377	1367	2025-07-08	2025-07-10	2025	7	331	f	3.0	f	Croatian	New to me	Bought	\N	\N	late to the party to read	\N	2026-10-10 09:50:15.860317+00	2026-10-10 09:50:15.860317+00
1378	1368	2025-07-08	2025-07-13	2025	7	328	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:15.956695+00	2026-10-10 09:50:15.956695+00
1379	1369	2025-07-11	2025-07-13	2025	7	340	f	5.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:15.970689+00	2026-10-10 09:50:15.970689+00
1380	1370	2025-07-14	2025-07-16	2025	7	385	f	3.5	f	English	Read before	Owned	\N	\N	sunrise/sunset on the cover	\N	2026-10-10 09:50:16.060934+00	2026-10-10 09:50:16.060934+00
1381	1371	2025-07-16	2025-07-22	2025	7	527	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:16.15377+00	2026-10-10 09:50:16.15377+00
1382	1372	2025-07-20	2025-07-24	2025	7	311	f	2.0	f	English	Read before	Downloaded	\N	\N	water on the cover	\N	2026-10-10 09:50:16.253238+00	2026-10-10 09:50:16.253238+00
1383	1373	2025-07-23	2025-07-30	2025	7	348	f	5.0	f	English	New to me	Downloaded	\N	\N	favorite genre	Disability month	2026-10-10 09:50:16.4596+00	2026-10-10 09:50:16.4596+00
1384	1374	2025-07-23	2025-07-26	2025	7	291	f	4.0	f	English	New to me	Bought	\N	\N	\N	Disability month	2026-10-10 09:50:16.657155+00	2026-10-10 09:50:16.657155+00
1385	1375	2025-07-24	2025-07-28	2025	7	285	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:16.753321+00	2026-10-10 09:50:16.753321+00
1386	1376	2025-07-30	2025-07-31	2025	7	391	f	2.0	f	English	Read before	Downloaded	punctuation	technology	\N	\N	2026-10-10 09:50:16.772699+00	2026-10-10 09:50:16.772699+00
1387	1377	2025-07-31	2025-08-14	2025	8	462	f	3.5	f	English	Read before	Downloaded	"with"	\N	\N	\N	2026-10-10 09:50:16.864468+00	2026-10-10 09:50:16.864468+00
1388	1378	2025-07-31	2025-08-04	2025	8	355	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:17.073448+00	2026-10-10 09:50:17.073448+00
1389	1379	2025-08-02	2025-08-29	2025	8	383	f	2.5	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:17.25891+00	2026-10-10 09:50:17.25891+00
1390	1380	2025-08-04	2025-08-22	2025	8	287	f	3.0	f	English	Read before	Downloaded	\N	transportation	set in a tropical country	\N	2026-10-10 09:50:17.286033+00	2026-10-10 09:50:17.286033+00
1391	1381	2025-08-09	2025-08-15	2025	8	336	f	3.5	f	English	Read before	Bought	\N	\N	book I started and haven't finished	\N	2026-10-10 09:50:17.365913+00	2026-10-10 09:50:17.365913+00
1392	1382	2025-08-16	2025-08-16	2025	8	180	f	4.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:17.614614+00	2026-10-10 09:50:17.614614+00
1393	1383	2025-08-16	2025-08-16	2025	8	186	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:17.877279+00	2026-10-10 09:50:17.877279+00
1394	1384	2025-08-16	2025-08-17	2025	8	69	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:18.06318+00	2026-10-10 09:50:18.06318+00
1395	1385	2025-08-17	2025-08-31	2025	8	400	f	3.0	f	English	Read before	Downloaded	\N	\N	related to Greek mythology	\N	2026-10-10 09:50:18.157546+00	2026-10-10 09:50:18.157546+00
1396	1386	2025-08-17	2025-08-25	2025	8	397	f	5.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:18.171125+00	2026-10-10 09:50:18.171125+00
1397	1387	2025-08-17	2025-08-31	2025	8	335	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:18.26192+00	2026-10-10 09:50:18.26192+00
1398	1388	2025-08-17	2025-08-20	2025	8	422	f	4.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:18.357338+00	2026-10-10 09:50:18.357338+00
1399	1389	2025-08-17	2025-09-01	2025	9	321	f	3.5	f	English	New to me	Bought	\N	\N	leftover from summer TBR	\N	2026-10-10 09:50:18.516122+00	2026-10-10 09:50:18.516122+00
1400	1390	2025-08-26	2025-08-26	2025	8	61	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:18.56461+00	2026-10-10 09:50:18.56461+00
1401	1391	2025-09-01	2025-09-02	2025	9	285	f	4.0	f	English	Read before	Bought	\N	\N	three word title	\N	2026-10-10 09:50:18.663079+00	2026-10-10 09:50:18.663079+00
1402	1392	2025-09-02	2025-09-04	2025	9	353	f	4.0	f	English	Debut	Downloaded	\N	\N	word 'haunted' in the text	\N	2026-10-10 09:50:18.880145+00	2026-10-10 09:50:18.880145+00
1403	1393	2025-09-02	2025-09-06	2025	9	368	f	4.0	f	English	Read before	Downloaded	\N	\N	author surname could be a first name	\N	2026-10-10 09:50:18.977745+00	2026-10-10 09:50:18.977745+00
1404	1394	2025-09-04	2025-09-05	2025	9	164	f	1.0	f	English	New to me	Downloaded	\N	\N	with an epigraph	\N	2026-10-10 09:50:19.260194+00	2026-10-10 09:50:19.260194+00
1405	1395	2025-09-05	2025-09-12	2025	9	245	f	1.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:19.364033+00	2026-10-10 09:50:19.364033+00
1406	1396	2025-09-06	2025-09-08	2025	9	368	f	4.0	f	English	Read before	Downloaded	\N	\N	set in a world or place you want to visit	\N	2026-10-10 09:50:19.468245+00	2026-10-10 09:50:19.468245+00
1407	1397	2025-09-07	2025-09-13	2025	9	544	f	4.0	f	English	New to me	Bought	\N	\N	book with chapter art	\N	2026-10-10 09:50:19.67119+00	2026-10-10 09:50:19.67119+00
1408	1398	2025-09-09	2025-09-12	2025	9	381	f	3.5	f	English	New to me	Downloaded	events	\N	\N	\N	2026-10-10 09:50:19.86113+00	2026-10-10 09:50:19.86113+00
1409	1399	2025-09-10	2025-09-27	2025	9	256	f	2.5	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:19.975366+00	2026-10-10 09:50:19.975366+00
1410	1400	2025-09-11	2025-09-14	2025	9	347	f	2.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:20.06391+00	2026-10-10 09:50:20.06391+00
1411	1401	2025-09-12	2025-09-24	2025	9	283	f	3.5	f	English	Read before	Downloaded	\N	\N	"witches" in text	\N	2026-10-10 09:50:20.16255+00	2026-10-10 09:50:20.16255+00
1412	1402	2025-09-14	2025-09-20	2025	9	619	f	5.0	f	English	Debut	Downloaded	\N	\N	animal companion	\N	2026-10-10 09:50:20.362074+00	2026-10-10 09:50:20.362074+00
1413	1403	2025-09-19	2025-09-27	2025	9	293	f	3.5	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:20.557187+00	2026-10-10 09:50:20.557187+00
1414	1404	2025-09-21	2025-09-29	2025	9	383	f	3.0	f	English	Read before	Downloaded	\N	\N	set in the past	\N	2026-10-10 09:50:20.659098+00	2026-10-10 09:50:20.659098+00
1415	1405	2025-09-26	2025-09-28	2025	9	369	f	4.0	f	English	Read before	Owned	\N	\N	moody cover	\N	2026-10-10 09:50:20.756358+00	2026-10-10 09:50:20.756358+00
1416	1406	2025-09-27	2025-09-30	2025	9	328	f	4.5	f	English	Read before	Downloaded	\N	foliage	leaves on the cover	\N	2026-10-10 09:50:20.859161+00	2026-10-10 09:50:20.859161+00
1417	1407	2025-09-28	2025-09-29	2025	9	128	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:21.064766+00	2026-10-10 09:50:21.064766+00
1418	1408	2025-10-01	2025-10-04	2025	10	289	f	5.0	f	English	New to me	Downloaded	\N	\N	gradient spine	\N	2026-10-10 09:50:21.257332+00	2026-10-10 09:50:21.257332+00
1419	1409	2025-10-02	2025-10-26	2025	10	301	f	1.0	f	Croatian	New to me	Owned	\N	\N	with a funeral	\N	2026-10-10 09:50:21.369054+00	2026-10-10 09:50:21.369054+00
1420	1410	2025-10-04	2025-10-09	2025	10	372	f	5.0	f	English	Read before	Downloaded	\N	\N	perfect read for a rainy day	\N	2026-10-10 09:50:21.464298+00	2026-10-10 09:50:21.464298+00
1421	1411	2025-10-09	2025-10-16	2025	10	186	f	2.0	f	English	Read before	Downloaded	\N	\N	short story collection	\N	2026-10-10 09:50:21.560731+00	2026-10-10 09:50:21.560731+00
1422	1412	2025-10-13	\N	2025	10	24	t	\N	f	English	New to me	Owned	\N	\N	\N	\N	2026-10-10 09:50:21.763106+00	2026-10-10 09:50:21.763106+00
1423	1413	2025-10-13	2025-10-19	2025	10	446	f	4.0	f	English	Read before	Bought	\N	\N	supernatural MC	\N	2026-10-10 09:50:21.865265+00	2026-10-10 09:50:21.865265+00
1424	1414	2025-10-17	2025-10-25	2025	10	384	f	3.0	f	English	Read before	Owned	\N	\N	MC with gender neutral name	\N	2026-10-10 09:50:21.960588+00	2026-10-10 09:50:21.960588+00
1425	1415	2025-10-17	2025-11-17	2025	11	428	f	4.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:22.063634+00	2026-10-10 09:50:22.063634+00
1426	1416	2025-10-17	2025-11-01	2025	10	209	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:22.161742+00	2026-10-10 09:50:22.161742+00
1427	1417	2025-10-19	2025-10-20	2025	10	163	f	3.0	f	English	Read before	Downloaded	violent	\N	\N	\N	2026-10-10 09:50:22.261056+00	2026-10-10 09:50:22.261056+00
1428	1418	2025-10-24	2025-10-30	2025	10	292	f	4.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:22.464922+00	2026-10-10 09:50:22.464922+00
1429	1419	2025-11-01	2025-11-06	2025	11	256	f	4.5	f	English	New to me	Downloaded	\N	\N	purple cover	\N	2026-10-10 09:50:22.663268+00	2026-10-10 09:50:22.663268+00
1430	1420	2025-11-03	2025-11-08	2025	11	512	f	3.5	f	English	Debut	Bought	\N	\N	\N	\N	2026-10-10 09:50:22.864339+00	2026-10-10 09:50:22.864339+00
1431	1421	2025-11-04	\N	2025	11	19	t	\N	f	English	New to me	Downloaded	\N	pattern	\N	\N	2026-10-10 09:50:23.066857+00	2026-10-10 09:50:23.066857+00
1432	1422	2025-11-09	2025-11-13	2025	11	303	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:23.264516+00	2026-10-10 09:50:23.264516+00
1433	1423	2025-11-14	2025-11-14	2025	11	285	f	3.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:23.36413+00	2026-10-10 09:50:23.36413+00
1434	1424	2025-11-15	2025-11-19	2025	11	541	f	2.5	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:23.462461+00	2026-10-10 09:50:23.462461+00
1435	1425	2025-11-15	2025-11-30	2025	11	237	f	2.5	f	English	New to me	Downloaded	\N	food and drink	female rage	\N	2026-10-10 09:50:23.667144+00	2026-10-10 09:50:23.667144+00
1436	1426	2025-11-19	2025-11-21	2025	11	262	f	4.0	f	English	New to me	Downloaded	\N	\N	poll pick	\N	2026-10-10 09:50:23.866712+00	2026-10-10 09:50:23.866712+00
1437	1427	2025-11-20	2025-11-23	2025	11	338	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:24.050539+00	2026-10-10 09:50:24.050539+00
1438	1428	2025-11-24	2025-11-27	2025	11	259	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:24.257852+00	2026-10-10 09:50:24.257852+00
1439	1429	2025-11-27	2025-11-29	2025	11	188	f	4.0	f	English	New to me	Bought	"never"	\N	\N	\N	2026-10-10 09:50:24.461052+00	2026-10-10 09:50:24.461052+00
1440	1430	2025-11-30	2025-12-01	2025	11	368	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:24.559071+00	2026-10-10 09:50:24.559071+00
1441	1431	2025-12-01	2025-12-17	2025	12	303	f	2.0	f	English	New to me	Downloaded	\N	\N	hat, scarf or gloves on the cover	\N	2026-10-10 09:50:24.763924+00	2026-10-10 09:50:24.763924+00
1442	1432	2025-12-01	2025-12-05	2025	12	203	f	1.0	f	English	New to me	Bought	\N	\N	word 'library' in the title	\N	2026-10-10 09:50:24.968657+00	2026-10-10 09:50:24.968657+00
1443	1433	2025-12-02	\N	2025	12	97	t	\N	f	English	Read before	Downloaded	\N	\N	MC with a geographical first name	\N	2026-10-10 09:50:25.171806+00	2026-10-10 09:50:25.171806+00
1444	1434	2025-12-06	2025-12-07	2025	12	343	f	3.5	f	English	New to me	Bought	\N	monochromatic	bilingual MC	\N	2026-10-10 09:50:25.366621+00	2026-10-10 09:50:25.366621+00
1445	1435	2025-12-09	2025-12-09	2025	12	169	f	3.0	f	English	Read before	Downloaded	\N	\N	Christmas novella	\N	2026-10-10 09:50:25.462174+00	2026-10-10 09:50:25.462174+00
1446	1436	2025-12-10	2025-12-14	2025	12	279	f	2.5	f	English	New to me	Downloaded	\N	\N	Christmas decoration on the cover	\N	2026-10-10 09:50:25.67119+00	2026-10-10 09:50:25.67119+00
1447	1437	2025-12-10	\N	2025	12	105	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:25.957654+00	2026-10-10 09:50:25.957654+00
1448	1438	2025-12-11	2025-12-14	2025	12	374	f	4.0	f	Croatian	New to me	Owned	\N	\N	split into parts	\N	2026-10-10 09:50:26.161135+00	2026-10-10 09:50:26.161135+00
1449	1439	2025-12-18	2025-12-23	2025	12	270	f	3.5	f	English	New to me	Downloaded	\N	\N	set during winter or in a snowy setting	\N	2026-10-10 09:50:26.451627+00	2026-10-10 09:50:26.451627+00
1450	1440	2025-12-18	2025-12-19	2025	12	149	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:26.572745+00	2026-10-10 09:50:26.572745+00
1451	1441	2025-12-20	2025-12-20	2025	12	147	f	5.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:26.850638+00	2026-10-10 09:50:26.850638+00
1452	1442	2025-12-23	2025-12-31	2025	12	298	f	3.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:26.868222+00	2026-10-10 09:50:26.868222+00
1453	1443	2026-01-01	2026-01-03	2026	1	305	f	3.5	f	English	Read before	Owned	\N	\N	first book of 2026	\N	2026-10-10 09:50:26.962821+00	2026-10-10 09:50:26.962821+00
1454	1444	2026-01-01	2026-01-06	2026	1	181	f	2.0	f	English	New to me	Downloaded	\N	\N	a book with a blue or white cover	\N	2026-10-10 09:50:27.161744+00	2026-10-10 09:50:27.161744+00
1455	1445	2026-01-03	2026-01-08	2026	1	660	f	3.0	f	English	Read before	Owned	\N	\N	a book your younger self would've loved	\N	2026-10-10 09:50:27.250719+00	2026-10-10 09:50:27.250719+00
1456	1446	2026-01-03	2026-01-05	2026	1	192	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:27.267082+00	2026-10-10 09:50:27.267082+00
1457	1447	2026-01-06	2026-01-08	2026	1	308	f	4.5	f	English	Read before	Downloaded	"before" and "after"	\N	a book blurbed by one of your favorite authors	\N	2026-10-10 09:50:27.358816+00	2026-10-10 09:50:27.358816+00
1458	1448	2026-01-09	2026-01-10	2026	1	319	f	2.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:27.455258+00	2026-10-10 09:50:27.455258+00
1459	1449	2026-01-10	2026-01-16	2026	1	256	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:27.660675+00	2026-10-10 09:50:27.660675+00
1460	1450	2026-01-10	2026-01-12	2026	1	315	f	3.5	f	English	Read before	Owned	\N	internal body part	a book featuring strong female friendship	\N	2026-10-10 09:50:27.759698+00	2026-10-10 09:50:27.759698+00
1461	1451	2026-01-11	2026-01-11	2026	1	174	f	2.5	f	English	Read before	Downloaded	\N	\N	a book with footnotes	\N	2026-10-10 09:50:27.861836+00	2026-10-10 09:50:27.861836+00
1462	1452	2026-01-16	2026-01-29	2026	1	288	f	3.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:27.964033+00	2026-10-10 09:50:27.964033+00
1463	1453	2026-01-16	2026-01-22	2026	1	330	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:28.065238+00	2026-10-10 09:50:28.065238+00
1464	1454	2026-01-23	2026-01-28	2026	1	484	f	2.5	f	English	New to me	Downloaded	\N	\N	a book featuring a winter sport	\N	2026-10-10 09:50:28.353767+00	2026-10-10 09:50:28.353767+00
1465	1455	2026-01-23	\N	2026	1	107	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:28.480587+00	2026-10-10 09:50:28.480587+00
1466	1456	2026-01-29	2026-01-31	2026	1	404	f	3.5	f	English	New to me	Owned	\N	\N	a book by a Canadian author	\N	2026-10-10 09:50:28.664537+00	2026-10-10 09:50:28.664537+00
1467	1457	2026-02-01	2026-02-06	2026	2	187	f	4.0	f	English	Read before	Downloaded	\N	silhouette	\N	\N	2026-10-10 09:50:28.865089+00	2026-10-10 09:50:28.865089+00
1468	1458	2026-02-02	2026-02-04	2026	2	299	f	3.0	f	English	Read before	Bought	\N	\N	a book with a MC with a geographical first name	\N	2026-10-10 09:50:28.963689+00	2026-10-10 09:50:28.963689+00
1469	1459	2026-02-02	2026-02-26	2026	2	450	f	2.0	f	English	Read before	Owned	\N	\N	a book with a title that starts with your first initial	\N	2026-10-10 09:50:29.167021+00	2026-10-10 09:50:29.167021+00
1470	1460	2026-02-06	2026-02-07	2026	2	267	f	4.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:29.266702+00	2026-10-10 09:50:29.266702+00
1471	1461	2026-02-07	2026-02-08	2026	2	328	f	4.0	f	English	Read before	Bought	\N	\N	a book with prologue and and epilogue	\N	2026-10-10 09:50:29.363498+00	2026-10-10 09:50:29.363498+00
1472	1462	2026-02-09	2026-02-10	2026	2	146	f	2.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:29.464118+00	2026-10-10 09:50:29.464118+00
1473	1463	2026-02-11	2026-02-14	2026	2	441	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:29.562027+00	2026-10-10 09:50:29.562027+00
1474	1464	2026-02-14	2026-02-16	2026	2	289	f	4.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:29.663124+00	2026-10-10 09:50:29.663124+00
1475	1465	2026-02-18	2026-02-22	2026	2	438	f	4.0	f	English	Read before	Bought	\N	\N	a book featuring royalty	\N	2026-10-10 09:50:29.763635+00	2026-10-10 09:50:29.763635+00
1476	1466	2026-02-24	2026-02-27	2026	2	353	f	2.0	f	English	New to me	Owned	\N	\N	\N	\N	2026-10-10 09:50:29.972695+00	2026-10-10 09:50:29.972695+00
1477	1467	2026-02-24	2026-02-28	2026	2	424	f	3.0	f	English	Debut	Libro.fm	keyboard keys	\N	\N	\N	2026-10-10 09:50:30.166098+00	2026-10-10 09:50:30.166098+00
1478	1468	2026-03-01	2026-03-02	2026	3	504	f	5.0	f	English	Read before	Bought	\N	\N	MC works in a hospital	\N	2026-10-10 09:50:30.265099+00	2026-10-10 09:50:30.265099+00
1479	1469	2026-03-03	2026-03-03	2026	3	238	f	1.0	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:30.550535+00	2026-10-10 09:50:30.550535+00
1480	1470	2026-03-04	2026-03-07	2026	3	352	f	4.0	f	English	Debut	Libro.fm	\N	\N	emoji story poll	\N	2026-10-10 09:50:30.66293+00	2026-10-10 09:50:30.66293+00
1481	1471	2026-03-07	\N	2026	3	32	t	\N	f	English	Read before	Downloaded	\N	action / movement	a book with a four word title	\N	2026-10-10 09:50:30.764181+00	2026-10-10 09:50:30.764181+00
1482	1472	2026-03-07	2026-03-08	2026	3	306	f	3.5	f	English	Read before	Bought	\N	action / movement	a book with 'butterfly' in the text	\N	2026-10-10 09:50:30.859794+00	2026-10-10 09:50:30.859794+00
1483	1473	2026-03-09	2026-03-11	2026	3	315	f	4.5	f	English	Read before	Bought	\N	\N	book title appears in the text	\N	2026-10-10 09:50:30.956948+00	2026-10-10 09:50:30.956948+00
1484	1474	2026-03-12	2026-03-15	2026	3	558	f	4.0	f	English	Read before	Bought	\N	\N	a book over 500 pages long	\N	2026-10-10 09:50:31.058468+00	2026-10-10 09:50:31.058468+00
1485	1475	2026-03-14	\N	2026	3	60	t	\N	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:31.271092+00	2026-10-10 09:50:31.271092+00
1486	1476	2026-03-15	2026-03-27	2026	3	300	f	2.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:31.376977+00	2026-10-10 09:50:31.376977+00
1487	1477	2026-03-23	2026-03-25	2026	3	312	f	5.0	f	English	Read before	Libro.fm	this / that / these / those	\N	a book with a four word title	\N	2026-10-10 09:50:31.662869+00	2026-10-10 09:50:31.662869+00
1488	1478	2026-03-26	2026-03-31	2026	3	281	f	2.5	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:31.769748+00	2026-10-10 09:50:31.769748+00
1489	1479	2026-04-04	2026-04-11	2026	4	275	f	3.0	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:50:31.970143+00	2026-10-10 09:50:31.970143+00
1490	1480	2026-04-15	2026-04-19	2026	4	370	f	3.5	f	English	Read before	Bought	\N	\N	a book you're in the mood to read	\N	2026-10-10 09:50:32.071104+00	2026-10-10 09:50:32.071104+00
1491	1481	2026-04-19	2026-04-26	2026	4	254	f	1.5	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:32.167162+00	2026-10-10 09:50:32.167162+00
1492	1482	2026-04-22	2026-04-26	2026	4	257	f	4.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:32.459406+00	2026-10-10 09:50:32.459406+00
1493	1483	2026-04-26	2026-05-01	2026	4	561	f	5.0	f	English	New to me	Bought	ordinal numbers	\N	MC with a botanical first name	\N	2026-10-10 09:50:32.663062+00	2026-10-10 09:50:32.663062+00
1494	1484	2026-05-01	2026-05-02	2026	5	432	f	4.0	f	English	Read before	Owned	\N	\N	a book set on a ranch or a farm	\N	2026-10-10 09:50:32.76512+00	2026-10-10 09:50:32.76512+00
1495	1485	2026-05-02	2026-05-02	2026	5	83	f	3.0	f	English	New to me	Downloaded	\N	\N	the shortest book on your TBR	\N	2026-10-10 09:50:33.363027+00	2026-10-10 09:50:33.363027+00
1496	1486	2026-05-02	2026-05-03	2026	5	314	f	2.5	f	English	Read before	Downloaded	\N	\N	random number generator / count across your TBR	\N	2026-10-10 09:50:33.461919+00	2026-10-10 09:50:33.461919+00
1497	1487	2026-05-02	2026-05-06	2026	5	493	f	5.0	f	English	New to me	Downloaded	\N	\N	title starts with the same letter as your last read	\N	2026-10-10 09:50:33.663582+00	2026-10-10 09:50:33.663582+00
1498	1488	2026-05-03	\N	2026	5	155	t	\N	f	English	Debut	Downloaded	\N	accessories	a book with all female POVs	\N	2026-10-10 09:50:33.859642+00	2026-10-10 09:50:33.859642+00
1499	1489	2026-05-08	2026-05-15	2026	5	266	f	1.0	f	English	New to me	Owned	\N	border	a book with a book related word in the title	\N	2026-10-10 09:50:34.06337+00	2026-10-10 09:50:34.06337+00
1500	1490	2026-05-08	2026-05-10	2026	5	292	f	1.0	f	English	Debut	Downloaded	\N	accessories	a book with a bird on the front cover	\N	2026-10-10 09:50:34.258756+00	2026-10-10 09:50:34.258756+00
1501	1491	2026-05-13	2026-05-23	2026	5	474	f	1.0	f	Croatian	New to me	Library	\N	\N	2025 award	\N	2026-10-10 09:50:34.461574+00	2026-10-10 09:50:34.461574+00
1502	1492	2026-05-18	2026-05-18	2026	5	203	f	3.0	f	English	New to me	Owned	\N	\N	a book that's not your usual genre	\N	2026-10-10 09:50:34.658872+00	2026-10-10 09:50:34.658872+00
1503	1493	2026-05-19	2026-05-19	2026	5	197	f	3.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:34.75787+00	2026-10-10 09:50:34.75787+00
1504	1494	2026-05-19	2026-05-19	2026	5	160	f	3.0	f	English	New to me	Bought	\N	\N	\N	\N	2026-10-10 09:50:34.965731+00	2026-10-10 09:50:34.965731+00
1505	1495	2026-05-20	2026-05-30	2026	5	385	f	3.0	f	English	Read before	Downloaded	\N	\N	a book with multiple authors	\N	2026-10-10 09:50:35.256781+00	2026-10-10 09:50:35.256781+00
1506	1496	2026-05-24	2026-05-25	2026	5	291	f	4.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:35.359847+00	2026-10-10 09:50:35.359847+00
1507	1497	2026-05-28	\N	2026	5	60	t	\N	f	English	Read before	Owned	\N	\N	a book you've been putting off	\N	2026-10-10 09:50:35.46298+00	2026-10-10 09:50:35.46298+00
1508	1498	2026-05-31	2026-05-31	2026	5	334	f	2.0	f	English	New to me	Libro.fm	"make"	\N	\N	\N	2026-10-10 09:50:35.668721+00	2026-10-10 09:50:35.668721+00
1509	1499	2026-06-01	2026-06-08	2026	6	380	f	2.0	f	English	Read before	Downloaded	\N	\N	LGBTQ+ main character	\N	2026-10-10 09:50:35.765152+00	2026-10-10 09:50:35.765152+00
1510	1500	2026-06-03	2026-06-07	2026	6	460	f	2.0	f	English	New to me	Owned	\N	\N	a book with an academic setting	\N	2026-10-10 09:50:35.962043+00	2026-10-10 09:50:35.962043+00
1511	1501	2026-06-09	\N	2026	6	78	t	\N	f	English	New to me	Downloaded	\N	\N	a book with 'and' in the title	\N	2026-10-10 09:50:36.16565+00	2026-10-10 09:50:36.16565+00
1512	1502	2026-06-10	2026-06-12	2026	6	337	f	2.5	f	English	New to me	Bought	\N	\N	a book recommended by a friend	\N	2026-10-10 09:50:36.45407+00	2026-10-10 09:50:36.45407+00
1513	1503	2026-06-13	2026-06-14	2026	6	786	f	4.0	f	English	Read before	Bought	\N	wings	average rating of 4 stars or above on Goodreads	\N	2026-10-10 09:50:36.555543+00	2026-10-10 09:50:36.555543+00
1514	1504	2026-06-15	\N	2026	6	112	t	\N	f	English	New to me	Owned	one word title	\N	\N	\N	2026-10-10 09:50:36.763266+00	2026-10-10 09:50:36.763266+00
1515	1505	2026-06-16	2026-06-20	2026	6	292	f	2.0	f	Croatian	New to me	Owned	one word title	\N	a book that uses Roman numerals for chapters	\N	2026-10-10 09:50:37.050745+00	2026-10-10 09:50:37.050745+00
1516	1506	2026-06-17	2026-08-26	2026	8	324	f	4.0	f	English	Read before	Downloaded	\N	\N	a book by a transgender author	\N	2026-10-10 09:50:37.159462+00	2026-10-10 09:50:37.159462+00
1517	1507	2026-06-17	2026-06-22	2026	6	363	f	4.0	f	English	Read before	Owned	\N	\N	a book with 'rainbow' in the text	\N	2026-10-10 09:50:37.261037+00	2026-10-10 09:50:37.261037+00
1518	1508	2026-06-17	2026-06-29	2026	6	306	f	3.5	f	English	Debut	Downloaded	\N	\N	main characters are rivals	\N	2026-10-10 09:50:37.561296+00	2026-10-10 09:50:37.561296+00
1519	1509	2026-06-17	\N	2026	6	170	t	\N	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:37.663852+00	2026-10-10 09:50:37.663852+00
1520	1510	2026-06-17	2026-06-30	2026	6	230	f	3.0	f	English	New to me	Downloaded	\N	\N	a book with 'sunshine' in the text	\N	2026-10-10 09:50:37.958628+00	2026-10-10 09:50:37.958628+00
1521	1511	2026-06-22	2026-06-26	2026	6	371	f	3.5	f	Croatian	New to me	Library	\N	\N	\N	\N	2026-10-10 09:50:38.253912+00	2026-10-10 09:50:38.253912+00
1522	1512	2026-06-26	2026-07-01	2026	6	384	f	5.0	f	English	Read before	Owned	\N	\N	characters visit a beach or lake	\N	2026-10-10 09:50:38.361835+00	2026-10-10 09:50:38.361835+00
1523	1513	2026-07-01	2026-07-02	2026	7	335	f	3.0	f	English	New to me	Owned	\N	\N	a book left over from last summer	\N	2026-10-10 09:50:38.654695+00	2026-10-10 09:50:38.654695+00
1524	1514	2026-07-03	2026-07-06	2026	7	469	f	2.0	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:38.759604+00	2026-10-10 09:50:38.759604+00
1525	1515	2026-07-03	2026-07-03	2026	7	368	f	3.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:39.082836+00	2026-10-10 09:50:39.082836+00
1526	1516	2026-07-05	2026-07-05	2026	7	152	f	5.0	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:39.162578+00	2026-10-10 09:50:39.162578+00
1527	1517	2026-07-06	\N	2026	7	192	t	\N	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:39.262469+00	2026-10-10 09:50:39.262469+00
1528	1518	2026-07-06	2026-07-09	2026	7	277	f	3.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:39.568226+00	2026-10-10 09:50:39.568226+00
1529	1519	2026-07-10	2026-07-11	2026	7	379	f	3.0	f	English	Read before	Owned	\N	metallic element	\N	\N	2026-10-10 09:50:39.675081+00	2026-10-10 09:50:39.675081+00
1530	1520	2026-07-12	2026-07-14	2026	7	564	f	2.0	f	English	Read before	Bought	\N	\N	\N	\N	2026-10-10 09:50:39.857628+00	2026-10-10 09:50:39.857628+00
1531	1521	2026-07-16	2026-07-20	2026	7	316	f	4.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:39.963282+00	2026-10-10 09:50:39.963282+00
1532	1522	2026-07-16	2026-07-28	2026	7	427	f	4.5	f	English	Debut	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:40.259894+00	2026-10-10 09:50:40.259894+00
1533	1523	2026-07-16	2026-07-18	2026	7	155	f	3.0	f	Croatian	New to me	Library	occupation	\N	\N	\N	2026-10-10 09:50:40.553374+00	2026-10-10 09:50:40.553374+00
1534	1524	2026-07-16	2026-08-02	2026	7	294	f	2.0	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:40.857464+00	2026-10-10 09:50:40.857464+00
1535	1525	2026-07-18	\N	2026	7	55	t	\N	f	Croatian	Debut	Library	\N	\N	\N	\N	2026-10-10 09:50:41.067752+00	2026-10-10 09:50:41.067752+00
1536	1526	2026-08-02	2026-08-15	2026	8	492	f	4.0	f	Croatian	Read before	Owned	\N	\N	a book based on real life events	\N	2026-10-10 09:50:41.170763+00	2026-10-10 09:50:41.170763+00
1537	1527	2026-08-03	2026-08-22	2026	8	301	f	2.0	f	English	New to me	Bought	\N	\N	a book with punctuation in the title	\N	2026-10-10 09:50:41.484299+00	2026-10-10 09:50:41.484299+00
1538	1528	2026-08-04	2026-08-06	2026	8	291	f	5.0	f	English	Read before	Libro.fm	\N	\N	a book with fruit on the front cover	\N	2026-10-10 09:50:41.650934+00	2026-10-10 09:50:41.650934+00
1539	1529	2026-08-09	2026-08-15	2026	8	397	f	3.0	f	English	New to me	Bought	\N	\N	a book with 'and' in the title	\N	2026-10-10 09:50:41.861178+00	2026-10-10 09:50:41.861178+00
1540	1530	2026-08-16	2026-08-22	2026	8	366	f	3.5	f	English	Read before	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:41.970883+00	2026-10-10 09:50:41.970883+00
1541	1531	2026-08-17	\N	2026	8	72	t	\N	f	Croatian	Read before	Bought	\N	\N	a book with swimwear on the front cover	\N	2026-10-10 09:50:42.150917+00	2026-10-10 09:50:42.150917+00
1542	1532	2026-08-23	\N	2026	8	81	t	\N	f	English	Read before	Downloaded	groups, clubs and societies	\N	\N	\N	2026-10-10 09:50:42.256762+00	2026-10-10 09:50:42.256762+00
1543	1533	2026-08-23	\N	2026	8	135	t	\N	f	English	Read before	Owned	\N	\N	cover color random generator	\N	2026-10-10 09:50:42.460064+00	2026-10-10 09:50:42.460064+00
1544	1534	2026-08-26	2026-08-31	2026	8	351	f	4.0	f	English	Debut	Bought	\N	\N	a book featuring a game or competition	\N	2026-10-10 09:50:42.670192+00	2026-10-10 09:50:42.670192+00
1545	1535	2026-09-01	2026-09-04	2026	9	253	f	2.0	f	English	Read before	Downloaded	groups, clubs and societies	damage	a book with 'cobweb' in the text	\N	2026-10-10 09:50:42.877125+00	2026-10-10 09:50:42.877125+00
1546	1536	2026-09-03	2026-09-05	2026	9	327	f	3.5	f	English	Read before	Bought	\N	\N	key or keyhole on the front cover	\N	2026-10-10 09:50:42.969839+00	2026-10-10 09:50:42.969839+00
1547	1537	2026-09-06	2026-09-07	2026	9	337	f	4.0	f	English	New to me	Owned	me / my / mine	\N	a book with text messages	\N	2026-10-10 09:50:43.267067+00	2026-10-10 09:50:43.267067+00
1548	1538	2026-09-08	2026-09-13	2026	9	491	f	4.0	f	English	New to me	Bought	\N	\N	perfect autumn read	\N	2026-10-10 09:50:43.559266+00	2026-10-10 09:50:43.559266+00
1549	1539	2026-09-16	2026-09-17	2026	9	127	f	2.5	f	English	New to me	Downloaded	\N	\N	\N	\N	2026-10-10 09:50:43.760733+00	2026-10-10 09:50:43.760733+00
1550	1540	2026-09-19	\N	2026	9	190	f	\N	f	English	Read before	Bought	\N	\N	a book featuring an invisible disability	\N	2026-10-10 09:50:43.871792+00	2026-10-10 09:50:43.871792+00
1551	1541	2026-09-25	\N	2026	9	70	t	\N	f	English	Read before	Owned	\N	\N	\N	\N	2026-10-10 09:50:43.982027+00	2026-10-10 09:50:43.982027+00
1552	1542	2026-10-07	\N	\N	\N	104	f	\N	f	Croatian	New to me	Library	\N	\N	a book that has been a celebrity book club pick	\N	2026-10-10 09:50:44.358303+00	2026-10-11 15:20:07.741843+00
\.


--
-- Data for Name: reading_bookclub; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reading_bookclub (reading_id, bookclub) FROM stdin;
892	The Book Troop
908	Queer Bookclub
918	Queer Bookclub
920	The Book Troop
920	Literally Dead Bookclub
925	Literally Dead Bookclub
936	Queer Bookclub
949	The Book Troop
949	Literally Dead Bookclub
957	Queer Bookclub
965	The Book Troop
971	Gin Tonic Bookaholics Bookclub
992	Gin Tonic Bookaholics Bookclub
1002	Gin Tonic Bookaholics Bookclub
1006	The Book Troop
1012	The Book Troop
1028	The Book Troop
1041	Literally Dead Bookclub
1067	The Book Troop
1072	The Book Troop
1078	The Book Troop
1080	Literally Dead Bookclub
1082	Literally Dead Bookclub
1088	The Book Troop
1092	Literally Dead Bookclub
1095	The Book Troop
1109	The Book Troop
1119	The Book Troop
1126	The Book Troop
1137	The Book Troop
1145	Literally Dead Bookclub
1146	The Book Troop
1148	The Book Troop
1149	Lights Out Bookclub
1182	The Book Troop
1183	Literally Dead Bookclub
1186	Lights Out Bookclub
1194	The Book Troop
1204	Literally Dead Bookclub
1215	The Book Troop
1221	Literally Dead Bookclub
1229	The Book Troop
1233	The Book Troop
1244	The Book Troop
1262	Lights Out Bookclub
1276	Lights Out Bookclub
1277	The Book Troop
1282	Literally Dead Bookclub
1301	The Thriller Troop Bookclub
1303	Full Moon Bookclub
1312	Literally Dead Bookclub
1312	Full Moon Bookclub
1314	The Book Troop
1314	The Thriller Troop Bookclub
1318	Literally Dead Bookclub
1324	The Thriller Troop Bookclub
1327	The Book Troop
1329	IRL
1335	The Book Troop
1343	IRL
1347	The Thriller Troop Bookclub
1353	Literally Dead Bookclub
1356	The Book Troop
1357	Literally Dead Bookclub
1360	Full Moon Bookclub
1362	The Thriller Troop Bookclub
1374	The Book Troop
1378	The Thriller Troop Bookclub
1381	IRL
1382	The Book Troop
1382	Literally Dead Bookclub
1385	Full Moon Bookclub
1402	The Book Troop
1411	The Thriller Troop Bookclub
1414	Full Moon Bookclub
1420	The Book Troop
1431	Literally Dead Bookclub
1432	The Book Troop
1442	IRL
1443	Full Moon Bookclub
1465	BRBN Bookclub
1474	The Book Troop
1474	BRBN Bookclub
1485	Full Moon Bookclub
1489	IRL
1492	Literally Dead Bookclub
1501	Full Moon Bookclub
1505	Literally Dead Bookclub
1505	BRBN Bookclub
1506	The Book Troop
1520	Literally Dead Bookclub
1531	Full Moon Bookclub
1540	The Book Troop
1549	IRL
1552	IRL
\.


--
-- Data for Name: reading_format; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reading_format (reading_id, format) FROM stdin;
777	Audiobook
778	Physical
779	Audiobook
780	Physical
781	Audiobook
782	Audiobook
782	Physical
783	Audiobook
783	Physical
784	Physical
785	Audiobook
786	Audiobook
787	Audiobook
788	Audiobook
788	Physical
789	Audiobook
790	Audiobook
791	Physical
792	Physical
793	Audiobook
794	Audiobook
795	Physical
796	Audiobook
797	Audiobook
798	Audiobook
799	Audiobook
800	Audiobook
800	Physical
801	Audiobook
801	Physical
802	Physical
803	Audiobook
804	Physical
805	Audiobook
806	Ebook
807	Physical
808	Ebook
809	Audiobook
810	Audiobook
811	Audiobook
812	Audiobook
813	Audiobook
814	Audiobook
815	Physical
816	Audiobook
817	Physical
818	Audiobook
819	Ebook
820	Audiobook
821	Physical
822	Audiobook
823	Audiobook
824	Audiobook
825	Audiobook
826	Audiobook
827	Physical
828	Audiobook
829	Physical
830	Audiobook
831	Audiobook
832	Physical
833	Audiobook
834	Physical
835	Audiobook
836	Physical
837	Audiobook
837	Physical
838	Audiobook
839	Audiobook
840	Physical
841	Audiobook
842	Physical
843	Audiobook
844	Physical
845	Audiobook
846	Audiobook
847	Physical
848	Audiobook
848	Physical
849	Audiobook
850	Audiobook
851	Physical
852	Audiobook
853	Audiobook
854	Physical
855	Audiobook
856	Audiobook
857	Audiobook
858	Physical
859	Audiobook
860	Audiobook
861	Audiobook
862	Physical
863	Audiobook
863	Physical
864	Audiobook
865	Physical
866	Audiobook
867	Audiobook
868	Audiobook
869	Physical
870	Physical
871	Audiobook
872	Audiobook
873	Audiobook
874	Physical
875	Audiobook
876	Audiobook
877	Audiobook
878	Physical
879	Audiobook
879	Physical
880	Audiobook
881	Physical
882	Physical
883	Physical
884	Audiobook
885	Physical
886	Physical
887	Audiobook
888	Physical
889	Audiobook
890	Physical
891	Physical
892	Audiobook
893	Physical
894	Physical
895	Audiobook
896	Audiobook
897	Physical
898	Physical
899	Physical
900	Audiobook
901	Physical
902	Audiobook
903	Physical
904	Physical
905	Audiobook
906	Physical
907	Physical
908	Audiobook
909	Audiobook
910	Physical
911	Audiobook
912	Audiobook
913	Physical
914	Ebook
915	Audiobook
916	Physical
917	Physical
918	Audiobook
919	Physical
920	Audiobook
921	Physical
922	Physical
923	Physical
924	Audiobook
925	Audiobook
926	Physical
927	Physical
928	Physical
929	Audiobook
930	Physical
931	Physical
932	Audiobook
932	Physical
933	Audiobook
934	Physical
935	Physical
936	Audiobook
937	Audiobook
938	Physical
939	Audiobook
940	Physical
941	Audiobook
942	Physical
943	Physical
944	Physical
945	Audiobook
946	Physical
947	Audiobook
948	Physical
949	Audiobook
950	Audiobook
951	Audiobook
952	Physical
953	Physical
954	Audiobook
955	Physical
956	Physical
957	Audiobook
958	Physical
959	Physical
960	Ebook
961	Physical
962	Audiobook
963	Physical
964	Physical
965	Audiobook
966	Physical
967	Physical
968	Physical
969	Ebook
970	Physical
971	Audiobook
972	Ebook
973	Physical
974	Audiobook
975	Physical
976	Audiobook
977	Physical
978	Physical
979	Audiobook
980	Audiobook
981	Ebook
982	Physical
983	Ebook
984	Audiobook
985	Physical
986	Physical
987	Physical
988	Audiobook
989	Audiobook
989	Physical
990	Physical
991	Audiobook
992	Physical
993	Audiobook
994	Ebook
995	Audiobook
996	Ebook
997	Physical
998	Audiobook
999	Audiobook
999	Physical
1000	Audiobook
1000	Physical
1001	Audiobook
1002	Physical
1003	Audiobook
1004	Audiobook
1005	Physical
1006	Audiobook
1006	Physical
1007	Physical
1008	Audiobook
1009	Audiobook
1010	Physical
1011	Audiobook
1012	Audiobook
1012	Physical
1013	Audiobook
1014	Ebook
1015	Physical
1016	Ebook
1017	Physical
1018	Ebook
1019	Audiobook
1019	Physical
1020	Audiobook
1021	Audiobook
1022	Audiobook
1022	Physical
1023	Audiobook
1023	Ebook
1024	Audiobook
1024	Ebook
1025	Ebook
1026	Ebook
1027	Ebook
1028	Ebook
1029	Audiobook
1030	Ebook
1031	Audiobook
1032	Physical
1033	Audiobook
1033	Physical
1034	Audiobook
1035	Audiobook
1035	Ebook
1036	Audiobook
1036	Ebook
1037	Physical
1038	Ebook
1039	Audiobook
1040	Audiobook
1041	Audiobook
1042	Physical
1043	Physical
1044	Physical
1045	Physical
1046	Audiobook
1047	Audiobook
1047	Physical
1048	Ebook
1049	Physical
1050	Audiobook
1050	Physical
1051	Audiobook
1051	Ebook
1052	Audiobook
1053	Audiobook
1053	Physical
1054	Physical
1055	Audiobook
1055	Physical
1056	Audiobook
1057	Ebook
1058	Physical
1059	Physical
1060	Ebook
1061	Audiobook
1061	Ebook
1062	Ebook
1063	Physical
1064	Ebook
1065	Audiobook
1065	Ebook
1066	Ebook
1067	Ebook
1068	Ebook
1069	Physical
1070	Audiobook
1071	Physical
1072	Audiobook
1072	Physical
1073	Audiobook
1073	Physical
1074	Physical
1075	Audiobook
1075	Physical
1076	Ebook
1077	Physical
1078	Audiobook
1078	Physical
1079	Physical
1080	Audiobook
1080	Ebook
1081	Audiobook
1081	Ebook
1082	Audiobook
1082	Ebook
1083	Physical
1084	Physical
1085	Physical
1086	Ebook
1087	Physical
1088	Audiobook
1089	Audiobook
1089	Ebook
1090	Audiobook
1090	Physical
1091	Physical
1092	Ebook
1093	Audiobook
1093	Physical
1094	Physical
1095	Ebook
1096	Audiobook
1096	Physical
1097	Audiobook
1097	Ebook
1098	Audiobook
1099	Physical
1100	Audiobook
1100	Physical
1101	Ebook
1102	Audiobook
1102	Physical
1103	Audiobook
1103	Physical
1104	Physical
1105	Physical
1106	Audiobook
1107	Ebook
1108	Physical
1109	Audiobook
1109	Ebook
1110	Audiobook
1110	Ebook
1111	Physical
1112	Audiobook
1113	Physical
1114	Physical
1115	Ebook
1116	Audiobook
1117	Audiobook
1117	Physical
1118	Physical
1119	Audiobook
1120	Ebook
1121	Physical
1122	Physical
1123	Physical
1124	Audiobook
1124	Physical
1125	Ebook
1126	Audiobook
1126	Ebook
1127	Physical
1128	Audiobook
1128	Ebook
1129	Physical
1130	Ebook
1131	Audiobook
1131	Physical
1132	Audiobook
1132	Physical
1133	Ebook
1134	Audiobook
1135	Physical
1136	Physical
1137	Ebook
1138	Audiobook
1139	Audiobook
1140	Audiobook
1140	Physical
1141	Ebook
1142	Physical
1143	Audiobook
1143	Physical
1144	Audiobook
1144	Ebook
1145	Audiobook
1145	Physical
1146	Audiobook
1146	Ebook
1147	Audiobook
1147	Physical
1148	Ebook
1149	Audiobook
1149	Ebook
1150	Physical
1151	Audiobook
1151	Ebook
1152	Audiobook
1153	Audiobook
1154	Physical
1155	Audiobook
1155	Physical
1156	Ebook
1157	Audiobook
1157	Physical
1158	Audiobook
1158	Ebook
1159	Ebook
1160	Audiobook
1161	Ebook
1162	Audiobook
1162	Physical
1163	Physical
1164	Audiobook
1164	Ebook
1165	Audiobook
1165	Physical
1166	Physical
1167	Ebook
1168	Ebook
1169	Audiobook
1169	Physical
1170	Ebook
1171	Audiobook
1172	Ebook
1173	Audiobook
1173	Physical
1174	Audiobook
1174	Physical
1175	Audiobook
1175	Ebook
1176	Ebook
1177	Audiobook
1177	Physical
1178	Audiobook
1178	Ebook
1179	Audiobook
1180	Physical
1181	Audiobook
1181	Ebook
1182	Audiobook
1182	Ebook
1183	Ebook
1184	Audiobook
1185	Audiobook
1185	Physical
1186	Audiobook
1186	Ebook
1187	Audiobook
1187	Ebook
1188	Audiobook
1188	Ebook
1189	Audiobook
1189	Ebook
1190	Audiobook
1190	Physical
1191	Audiobook
1191	Physical
1192	Ebook
1193	Audiobook
1193	Physical
1194	Audiobook
1195	Ebook
1196	Audiobook
1196	Physical
1197	Physical
1198	Ebook
1199	Audiobook
1200	Audiobook
1200	Physical
1201	Audiobook
1201	Ebook
1202	Audiobook
1203	Audiobook
1203	Physical
1204	Audiobook
1204	Physical
1205	Audiobook
1206	Audiobook
1207	Ebook
1208	Ebook
1209	Physical
1210	Physical
1211	Ebook
1212	Audiobook
1213	Audiobook
1213	Physical
1214	Audiobook
1214	Physical
1215	Audiobook
1216	Physical
1217	Physical
1218	Physical
1219	Physical
1220	Physical
1221	Audiobook
1222	Physical
1223	Ebook
1224	Audiobook
1224	Ebook
1225	Audiobook
1225	Physical
1226	Audiobook
1226	Ebook
1227	Audiobook
1227	Physical
1228	Audiobook
1228	Ebook
1229	Audiobook
1229	Ebook
1230	Audiobook
1230	Physical
1231	Audiobook
1231	Physical
1232	Ebook
1233	Audiobook
1233	Ebook
1234	Ebook
1235	Physical
1236	Audiobook
1237	Audiobook
1238	Physical
1239	Physical
1240	Audiobook
1241	Ebook
1242	Audiobook
1242	Physical
1243	Audiobook
1243	Ebook
1244	Audiobook
1245	Audiobook
1245	Physical
1246	Audiobook
1246	Physical
1247	Physical
1248	Physical
1249	Physical
1250	Physical
1251	Physical
1252	Physical
1253	Audiobook
1254	Audiobook
1254	Physical
1255	Physical
1256	Audiobook
1256	Physical
1257	Physical
1258	Physical
1259	Ebook
1260	Audiobook
1260	Ebook
1261	Physical
1262	Audiobook
1262	Ebook
1263	Ebook
1264	Audiobook
1264	Ebook
1265	Ebook
1266	Audiobook
1267	Ebook
1268	Audiobook
1269	Physical
1270	Audiobook
1270	Ebook
1271	Audiobook
1271	Ebook
1272	Physical
1273	Audiobook
1273	Physical
1274	Physical
1275	Audiobook
1275	Physical
1276	Audiobook
1276	Ebook
1277	Audiobook
1277	Ebook
1278	Audiobook
1278	Ebook
1279	Audiobook
1279	Physical
1280	Audiobook
1281	Audiobook
1281	Physical
1282	Audiobook
1283	Audiobook
1283	Ebook
1284	Physical
1285	Ebook
1286	Physical
1287	Audiobook
1287	Ebook
1288	Physical
1289	Audiobook
1290	Audiobook
1290	Ebook
1291	Ebook
1292	Audiobook
1292	Ebook
1293	Ebook
1294	Audiobook
1294	Ebook
1295	Physical
1296	Audiobook
1296	Ebook
1297	Audiobook
1297	Ebook
1298	Ebook
1299	Audiobook
1299	Physical
1300	Audiobook
1300	Ebook
1301	Audiobook
1302	Ebook
1303	Audiobook
1303	Ebook
1304	Ebook
1305	Audiobook
1305	Ebook
1306	Physical
1307	Ebook
1308	Audiobook
1308	Ebook
1309	Audiobook
1310	Ebook
1311	Physical
1312	Audiobook
1312	Ebook
1313	Ebook
1314	Ebook
1315	Audiobook
1316	Audiobook
1317	Physical
1318	Audiobook
1319	Audiobook
1319	Physical
1320	Audiobook
1320	Physical
1321	Audiobook
1321	Physical
1322	Physical
1323	Audiobook
1324	Ebook
1325	Audiobook
1325	Physical
1326	Audiobook
1326	Ebook
1327	Audiobook
1327	Ebook
1328	Ebook
1329	Audiobook
1329	Ebook
1330	Audiobook
1330	Ebook
1331	Audiobook
1331	Physical
1332	Audiobook
1332	Ebook
1333	Physical
1334	Audiobook
1334	Ebook
1335	Audiobook
1336	Physical
1337	Audiobook
1338	Physical
1339	Audiobook
1340	Audiobook
1340	Physical
1341	Ebook
1342	Audiobook
1342	Ebook
1343	Physical
1344	Audiobook
1344	Ebook
1345	Audiobook
1345	Physical
1346	Audiobook
1346	Ebook
1347	Ebook
1348	Audiobook
1348	Ebook
1349	Audiobook
1350	Audiobook
1351	Audiobook
1352	Physical
1353	Audiobook
1354	Physical
1355	Audiobook
1355	Ebook
1356	Audiobook
1356	Ebook
1357	Audiobook
1358	Ebook
1359	Audiobook
1359	Ebook
1360	Audiobook
1360	Ebook
1361	Audiobook
1361	Ebook
1362	Ebook
1363	Audiobook
1363	Physical
1364	Audiobook
1365	Audiobook
1366	Ebook
1367	Audiobook
1367	Ebook
1368	Audiobook
1368	Physical
1369	Audiobook
1370	Audiobook
1370	Physical
1371	Audiobook
1371	Physical
1372	Audiobook
1373	Audiobook
1373	Physical
1374	Audiobook
1375	Audiobook
1375	Physical
1376	Physical
1377	Physical
1378	Audiobook
1379	Physical
1380	Audiobook
1380	Physical
1381	Audiobook
1381	Physical
1382	Audiobook
1382	Ebook
1383	Audiobook
1383	Ebook
1384	Audiobook
1384	Physical
1385	Audiobook
1385	Ebook
1386	Audiobook
1386	Ebook
1387	Ebook
1388	Audiobook
1389	Physical
1390	Audiobook
1390	Ebook
1391	Audiobook
1391	Physical
1392	Audiobook
1392	Ebook
1393	Audiobook
1394	Ebook
1395	Audiobook
1395	Ebook
1396	Audiobook
1396	Physical
1397	Ebook
1398	Audiobook
1398	Physical
1399	Audiobook
1399	Physical
1400	Audiobook
1401	Audiobook
1401	Physical
1402	Ebook
1403	Audiobook
1404	Audiobook
1404	Ebook
1405	Ebook
1406	Audiobook
1407	Audiobook
1407	Physical
1408	Audiobook
1409	Ebook
1410	Audiobook
1410	Physical
1411	Audiobook
1411	Ebook
1412	Audiobook
1412	Ebook
1413	Physical
1414	Audiobook
1414	Ebook
1415	Audiobook
1415	Physical
1416	Audiobook
1417	Audiobook
1417	Ebook
1418	Audiobook
1418	Ebook
1419	Physical
1420	Audiobook
1420	Ebook
1421	Ebook
1422	Physical
1423	Audiobook
1423	Physical
1424	Audiobook
1424	Physical
1425	Audiobook
1425	Ebook
1426	Ebook
1427	Audiobook
1427	Ebook
1428	Physical
1429	Audiobook
1429	Ebook
1430	Audiobook
1430	Physical
1431	Ebook
1432	Audiobook
1433	Audiobook
1434	Audiobook
1434	Physical
1435	Ebook
1436	Audiobook
1436	Ebook
1437	Audiobook
1437	Physical
1438	Audiobook
1438	Ebook
1439	Audiobook
1439	Physical
1440	Audiobook
1441	Ebook
1442	Audiobook
1442	Physical
1443	Audiobook
1443	Ebook
1444	Audiobook
1444	Physical
1445	Audiobook
1445	Ebook
1446	Audiobook
1447	Audiobook
1447	Ebook
1448	Physical
1449	Ebook
1450	Audiobook
1450	Ebook
1451	Audiobook
1452	Ebook
1453	Audiobook
1453	Physical
1454	Ebook
1455	Audiobook
1455	Physical
1456	Audiobook
1457	Audiobook
1457	Ebook
1458	Audiobook
1458	Physical
1459	Ebook
1460	Audiobook
1460	Physical
1461	Audiobook
1461	Ebook
1462	Physical
1463	Audiobook
1463	Ebook
1464	Audiobook
1464	Ebook
1465	Audiobook
1465	Ebook
1466	Audiobook
1466	Physical
1467	Ebook
1468	Audiobook
1468	Physical
1469	Audiobook
1469	Physical
1470	Audiobook
1470	Physical
1471	Audiobook
1471	Physical
1472	Audiobook
1472	Ebook
1473	Audiobook
1473	Physical
1474	Audiobook
1474	Ebook
1475	Audiobook
1475	Physical
1476	Audiobook
1476	Physical
1477	Audiobook
1477	Ebook
1478	Audiobook
1478	Physical
1479	Audiobook
1479	Ebook
1480	Audiobook
1480	Ebook
1481	Ebook
1482	Audiobook
1482	Physical
1483	Audiobook
1483	Physical
1484	Audiobook
1484	Physical
1485	Audiobook
1485	Ebook
1486	Ebook
1487	Audiobook
1487	Ebook
1488	Physical
1489	Physical
1490	Audiobook
1490	Physical
1491	Audiobook
1491	Physical
1492	Audiobook
1492	Ebook
1493	Audiobook
1493	Physical
1494	Audiobook
1494	Physical
1495	Ebook
1496	Audiobook
1496	Ebook
1497	Audiobook
1497	Ebook
1498	Ebook
1499	Physical
1500	Audiobook
1500	Ebook
1501	Physical
1502	Audiobook
1502	Physical
1503	Audiobook
1503	Physical
1504	Audiobook
1504	Physical
1505	Audiobook
1505	Ebook
1506	Audiobook
1506	Physical
1507	Physical
1508	Audiobook
1508	Ebook
1509	Audiobook
1509	Ebook
1510	Audiobook
1510	Physical
1511	Audiobook
1511	Ebook
1512	Audiobook
1512	Physical
1513	Audiobook
1513	Physical
1514	Audiobook
1514	Physical
1515	Physical
1516	Ebook
1517	Audiobook
1517	Physical
1518	Audiobook
1518	Ebook
1519	Audiobook
1519	Physical
1520	Audiobook
1520	Ebook
1521	Physical
1522	Audiobook
1523	Audiobook
1524	Audiobook
1524	Physical
1525	Audiobook
1526	Audiobook
1527	Audiobook
1527	Physical
1528	Audiobook
1528	Ebook
1529	Audiobook
1529	Physical
1530	Audiobook
1530	Physical
1531	Audiobook
1532	Audiobook
1532	Ebook
1533	Physical
1534	Audiobook
1535	Physical
1536	Physical
1537	Audiobook
1537	Physical
1538	Audiobook
1539	Audiobook
1539	Physical
1540	Audiobook
1540	Ebook
1541	Physical
1542	Audiobook
1542	Ebook
1543	Audiobook
1543	Physical
1544	Audiobook
1544	Physical
1545	Audiobook
1545	Ebook
1546	Audiobook
1546	Physical
1547	Audiobook
1547	Physical
1548	Audiobook
1548	Physical
1549	Audiobook
1549	Ebook
1550	Audiobook
1550	Physical
1551	Audiobook
1551	Physical
1552	Physical
\.


--
-- Data for Name: reading_purpose; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reading_purpose (reading_id, purpose) FROM stdin;
884	Buzzwordathon
891	Buzzwordathon
892	Bookclub
898	Buzzwordathon
902	Readathon
903	Readathon
904	Readathon
905	Readathon
906	Readathon
908	Bookclub
909	Readathon
910	Readathon
911	Readathon
912	Readathon
913	Readathon
915	Buzzwordathon
918	Bookclub
920	Bookclub
924	Buzzwordathon
925	Bookclub
936	Bookclub
940	Buzzwordathon
946	Readathon
947	Readathon
948	Readathon
949	Readathon
949	Bookclub
950	Readathon
957	Buzzwordathon
957	Bookclub
965	Bookclub
971	Bookclub
973	Readathon
974	Readathon
975	Readathon
976	Readathon
977	Readathon
978	Readathon
979	Readathon
980	Readathon
992	Bookclub
995	Readathon
995	BRBN Bingo
1002	Bookclub
1006	Bookclub
1012	Bookclub
1028	Bookclub
1041	Bookclub
1067	Bookclub
1072	Bookclub
1078	Bookclub
1080	Bookclub
1082	Bookclub
1088	Bookclub
1092	Bookclub
1095	Bookclub
1109	Bookclub
1119	Bookclub
1126	Bookclub
1137	Bookclub
1145	Bookclub
1146	Bookclub
1148	Bookclub
1149	Bookclub
1155	BRBN Bingo
1168	Readathon
1169	Readathon
1170	Readathon
1171	Readathon
1172	Readathon
1173	Readathon
1182	Bookclub
1183	Bookclub
1186	Readathon
1186	Bookclub
1187	Readathon
1188	Readathon
1189	Readathon
1190	Readathon
1192	Readathon
1194	Bookclub
1204	Bookclub
1215	Bookclub
1221	Bookclub
1229	Bookclub
1233	Bookclub
1240	Readathon
1241	Readathon
1242	Readathon
1243	Readathon
1244	Bookclub
1244	Readathon
1262	Bookclub
1265	Readathon
1270	Readathon
1271	Readathon
1276	Bookclub
1277	Bookclub
1280	Readathon
1282	Bookclub
1293	BRBN Bingo
1294	BRBN Bingo
1295	TBR Jar
1295	BRBN Bingo
1296	Readathon
1296	BRBN Bingo
1297	Readathon
1297	BRBN Bingo
1298	Buzzwordathon
1298	Readathon
1298	BRBN Bingo
1299	Readathon
1299	BRBN Bingo
1300	BRBN Bingo
1301	Bookclub
1301	BRBN Bingo
1302	BRBN Bingo
1303	Bookclub
1303	BRBN Bingo
1304	BRBN Bingo
1305	BRBN Bingo
1306	BRBN Bingo
1307	BRBN Bingo
1308	BRBN Bingo
1309	BRBN Bingo
1310	BRBN Bingo
1311	TBR Jar
1311	BRBN Bingo
1311	Buzzwordathon
1312	Bookclub
1312	Readathon
1312	BRBN Bingo
1313	Readathon
1313	BRBN Bingo
1314	Bookclub
1314	Buzzwordathon
1314	Readathon
1314	BRBN Bingo
1315	BRBN Bingo
1315	Buzzwordathon
1316	BRBN Bingo
1317	BRBN Bingo
1318	Bookclub
1318	BRBN Bingo
1319	BRBN Bingo
1320	BRBN Bingo
1321	BRBN Bingo
1322	TBR Jar
1322	BRBN Bingo
1323	Buzzwordathon
1323	BRBN Bingo
1324	Bookclub
1324	BRBN Bingo
1325	BRBN Bingo
1326	BRBN Bingo
1327	Bookclub
1328	Buzzwordathon
1328	BRBN Bingo
1329	Bookclub
1329	BRBN Bingo
1330	BRBN Bingo
1331	BRBN Bingo
1332	BRBN Bingo
1333	BRBN Bingo
1334	Buzzwordathon
1334	BRBN Bingo
1335	Bookclub
1335	BRBN Bingo
1336	BRBN Bingo
1336	Buzzwordathon
1337	BRBN Bingo
1338	BRBN Bingo
1338	Buzzwordathon
1339	BRBN Bingo
1340	TBR Jar
1340	BRBN Bingo
1341	Buzzwordathon
1341	Readathon
1342	Readathon
1342	BRBN Bingo
1343	Bookclub
1343	BRBN Bingo
1343	Readathon
1344	Readathon
1344	BRBN Bingo
1345	Readathon
1346	Readathon
1346	BRBN Bingo
1347	Bookclub
1347	Buzzwordathon
1347	BRBN Bingo
1347	Readathon
1348	BRBN Bingo
1348	Readathon
1349	Readathon
1350	Readathon
1350	BRBN Bingo
1351	Readathon
1352	Buzzwordathon
1352	Readathon
1352	BRBN Bingo
1353	Bookclub
1353	Readathon
1353	BRBN Bingo
1354	TBR Jar
1355	Readathon
1355	BRBN Bingo
1356	Bookclub
1356	Readathon
1356	BRBN Bingo
1357	Bookclub
1358	Readathon
1358	BRBN Bingo
1359	BRBN Bingo
1359	Readathon
1360	Readathon
1360	Bookclub
1360	BRBN Bingo
1361	Readathon
1361	BRBN Bingo
1362	Bookclub
1363	Buzzwordathon
1363	Readathon
1363	BRBN Bingo
1364	Readathon
1364	BRBN Bingo
1365	Readathon
1365	BRBN Bingo
1366	Readathon
1366	BRBN Bingo
1367	Readathon
1367	BRBN Bingo
1368	Readathon
1368	BRBN Bingo
1368	TBR Jar
1369	Readathon
1369	BRBN Bingo
1370	Readathon
1370	Buzzwordathon
1370	BRBN Bingo
1371	Readathon
1371	BRBN Bingo
1372	Readathon
1372	BRBN Bingo
1373	Readathon
1373	BRBN Bingo
1374	Bookclub
1375	Readathon
1375	BRBN Bingo
1376	Readathon
1376	BRBN Bingo
1377	Readathon
1377	BRBN Bingo
1378	Readathon
1378	BRBN Bingo
1378	Bookclub
1379	Readathon
1379	BRBN Bingo
1380	Readathon
1380	BRBN Bingo
1381	Bookclub
1381	BRBN Bingo
1382	Bookclub
1382	BRBN Bingo
1382	Readathon
1383	Readathon
1383	BRBN Bingo
1384	TBR Jar
1384	Readathon
1385	Bookclub
1385	BRBN Bingo
1386	Buzzwordathon
1386	BRBN Bingo
1386	Readathon
1387	Buzzwordathon
1387	BRBN Bingo
1388	BRBN Bingo
1389	BRBN Bingo
1390	Buzzwordathon
1390	BRBN Bingo
1391	BRBN Bingo
1392	BRBN Bingo
1392	Readathon
1393	Readathon
1394	Readathon
1395	BRBN Bingo
1396	BRBN Bingo
1397	BRBN Bingo
1398	TBR Jar
1399	BRBN Bingo
1400	BRBN Bingo
1401	BRBN Bingo
1402	BRBN Bingo
1402	Bookclub
1403	BRBN Bingo
1404	BRBN Bingo
1406	BRBN Bingo
1407	BRBN Bingo
1408	Buzzwordathon
1409	BRBN Bingo
1410	BRBN Bingo
1411	Bookclub
1411	BRBN Bingo
1412	BRBN Bingo
1414	Bookclub
1414	BRBN Bingo
1415	TBR Jar
1415	BRBN Bingo
1416	BRBN Bingo
1416	Buzzwordathon
1417	BRBN Bingo
1419	BRBN Bingo
1420	Bookclub
1420	BRBN Bingo
1421	BRBN Bingo
1422	TBR Jar
1422	BRBN Bingo
1423	BRBN Bingo
1424	BRBN Bingo
1425	BRBN Bingo
1426	BRBN Bingo
1427	Buzzwordathon
1429	BRBN Bingo
1431	Bookclub
1432	Bookclub
1432	BRBN Bingo
1433	BRBN Bingo
1434	BRBN Bingo
1435	Buzzwordathon
1435	BRBN Bingo
1436	BRBN Bingo
1437	BRBN Bingo
1438	BRBN Bingo
1439	Buzzwordathon
1441	BRBN Bingo
1442	Bookclub
1442	BRBN Bingo
1443	Bookclub
1443	BRBN Bingo
1444	Buzzwordathon
1444	BRBN Bingo
1445	Readathon
1445	BRBN Bingo
1446	Readathon
1446	BRBN Bingo
1447	BRBN Bingo
1448	TBR Jar
1448	BRBN Bingo
1449	BRBN Bingo
1451	BRBN Bingo
1453	BRBN Bingo
1454	TBR Game
1454	BRBN Bingo
1455	TBR Game
1455	BRBN Bingo
1457	Buzzwordathon
1457	BRBN Bingo
1458	Readathon
1458	TBR Game
1459	Readathon
1460	Readathon
1460	BRBN Bingo
1460	Buzzwordathon
1461	Readathon
1461	BRBN Bingo
1464	BRBN Bingo
1465	Bookclub
1466	TBR Jar
1466	BRBN Bingo
1467	Buzzwordathon
1468	BRBN Bingo
1469	BRBN Bingo
1470	Readathon
1471	BRBN Bingo
1471	Readathon
1472	Readathon
1473	Readathon
1474	Bookclub
1475	BRBN Bingo
1476	TBR Jar
1477	Buzzwordathon
1478	BRBN Bingo
1479	TBR Game
1480	BRBN Bingo
1481	Buzzwordathon
1482	Buzzwordathon
1482	BRBN Bingo
1482	TBR Game
1483	BRBN Bingo
1484	BRBN Bingo
1485	Bookclub
1487	Buzzwordathon
1489	Bookclub
1490	BRBN Bingo
1491	TBR Jar
1492	Bookclub
1493	Buzzwordathon
1493	BRBN Bingo
1494	BRBN Bingo
1494	Readathon
1495	BRBN Bingo
1495	Readathon
1496	BRBN Bingo
1496	Readathon
1497	BRBN Bingo
1497	Readathon
1498	Buzzwordathon
1498	BRBN Bingo
1498	Readathon
1499	Buzzwordathon
1499	Readathon
1499	BRBN Bingo
1500	Buzzwordathon
1500	Readathon
1500	BRBN Bingo
1501	Bookclub
1501	Readathon
1502	BRBN Bingo
1502	Readathon
1503	Readathon
1504	Readathon
1505	Bookclub
1505	Readathon
1505	BRBN Bingo
1506	Bookclub
1506	Readathon
1507	TBR Jar
1507	BRBN Bingo
1508	Buzzwordathon
1508	Readathon
1509	Readathon
1509	BRBN Bingo
1510	Readathon
1510	BRBN Bingo
1511	BRBN Bingo
1511	TBR Game
1511	Readathon
1512	Readathon
1512	BRBN Bingo
1513	Buzzwordathon
1513	BRBN Bingo
1513	Readathon
1514	Buzzwordathon
1514	Readathon
1515	TBR Jar
1515	Readathon
1515	Buzzwordathon
1515	BRBN Bingo
1516	Readathon
1516	BRBN Bingo
1517	Readathon
1518	Readathon
1518	BRBN Bingo
1519	Readathon
1519	TBR Game
1520	Bookclub
1520	Readathon
1521	Readathon
1522	BRBN Bingo
1522	Readathon
1523	BRBN Bingo
1523	Readathon
1524	Readathon
1525	Readathon
1526	Readathon
1527	Readathon
1527	TBR Jar
1528	Readathon
1529	Buzzwordathon
1529	Readathon
1530	Readathon
1531	Bookclub
1531	Readathon
1532	TBR Game
1532	Readathon
1533	Buzzwordathon
1533	Readathon
1534	TBR Game
1535	Readathon
1536	BRBN Bingo
1537	BRBN Bingo
1537	TBR Game
1538	BRBN Bingo
1539	BRBN Bingo
1540	Bookclub
1541	BRBN Bingo
1542	Buzzwordathon
1543	TBR Jar
1543	BRBN Bingo
1544	BRBN Bingo
1545	Buzzwordathon
1545	BRBN Bingo
1546	BRBN Bingo
1547	Buzzwordathon
1547	BRBN Bingo
1548	BRBN Bingo
1549	Bookclub
1550	BRBN Bingo
1551	TBR Jar
1552	Bookclub
1552	BRBN Bingo
1087	Buzzwordathon
\.


--
-- Data for Name: reading_readathon; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reading_readathon (reading_id, readathon) FROM stdin;
902	The Backlist Readathon
903	The Backlist Readathon
904	The Backlist Readathon
905	The Backlist Readathon
906	The Backlist Readathon
909	Bookopolathon
910	Bookopolathon
911	Bookopolathon
912	Bookopolathon
913	Bookopolathon
946	Summerween
947	Summerween
948	Summerween
949	Summerween
950	Summerween
973	Reading in Melody
974	Reading in Melody
975	Reading in Melody
976	Reading in Melody
977	Reading in Melody
978	Reading in Melody
979	Reading in Melody
980	Reading in Melody
995	Escape the Readathon
1168	Winterween
1169	Winterween
1170	Winterween
1171	Winterween
1172	Winterween
1173	Winterween
1186	Jante's Inferno
1187	Jante's Inferno
1188	Jante's Inferno
1189	Jante's Inferno
1190	Jante's Inferno
1192	Jante's Inferno
1240	Summerween
1241	Summerween
1242	Summerween
1243	Summerween
1244	Summerween
1265	Seasonal Spooky Challenge
1270	Seasonal Spooky Challenge
1271	Seasonal Spooky Challenge
1280	Seasonal Spooky Challenge
1296	Winterween
1297	Winterween
1298	Winterween
1299	Winterween
1312	Jante's Inferno
1313	Jante's Inferno
1314	Jante's Inferno
1341	Escape the Readathon
1342	Escape the Readathon
1343	Escape the Readathon
1344	Escape the Readathon
1345	Escape the Readathon
1346	Escape the Readathon
1347	Escape the Readathon
1348	Escape the Readathon
1349	Escape the Readathon
1350	Escape the Readathon
1351	Escape the Readathon
1352	Escape the Readathon
1353	Escape the Readathon
1355	Escape the Readathon
1356	Escape the Readathon
1358	The Amazing Readathon
1359	The Amazing Readathon
1360	The Amazing Readathon
1361	The Amazing Readathon
1362	The Amazing Readathon
1363	The Amazing Readathon
1364	The Amazing Readathon
1365	The Amazing Readathon
1366	The Amazing Readathon
1367	The Amazing Readathon
1368	The Amazing Readathon
1369	The Amazing Readathon
1370	The Amazing Readathon
1371	The Amazing Readathon
1372	The Amazing Readathon
1373	The Amazing Readathon
1375	Sunrise on the Readathon
1376	Sunrise on the Readathon
1376	Summerween
1377	Sunrise on the Readathon
1377	Summerween
1378	Sunrise on the Readathon
1378	Summerween
1379	Sunrise on the Readathon
1379	Summerween
1380	Sunrise on the Readathon
1381	Sunrise on the Readathon
1382	Sunrise on the Readathon
1383	Sunrise on the Readathon
1384	Sunrise on the Readathon
1385	Sunrise on the Readathon
1386	Sunrise on the Readathon
1392	BRBN 24 Hour Readathon
1393	BRBN 24 Hour Readathon
1394	BRBN 24 Hour Readathon
1458	Winterween
1459	Winterween
1460	Winterween
1461	Winterween
1470	Jante's Inferno
1471	Jante's Inferno
1472	Jante's Inferno
1473	Jante's Inferno
1494	Escape the Readathon
1495	Escape the Readathon
1496	Escape the Readathon
1497	Escape the Readathon
1498	Escape the Readathon
1499	Escape the Readathon
1500	Escape the Readathon
1501	Escape the Readathon
1502	Escape the Readathon
1503	Escape the Readathon
1504	Escape the Readathon
1505	Escape the Readathon
1506	Escape the Readathon
1507	Escape the Readathon
1508	Escape the Readathon
1509	Tarot Readathon
1509	The Amazing Readathon
1510	Tarot Readathon
1510	The Amazing Readathon
1511	Tarot Readathon
1511	The Amazing Readathon
1512	Tarot Readathon
1512	The Amazing Readathon
1513	Tarot Readathon
1513	The Amazing Readathon
1514	Tarot Readathon
1514	The Amazing Readathon
1515	Tarot Readathon
1515	The Amazing Readathon
1516	Tarot Readathon
1516	The Amazing Readathon
1517	Tarot Readathon
1517	The Amazing Readathon
1518	Tarot Readathon
1518	The Amazing Readathon
1519	Tarot Readathon
1519	The Amazing Readathon
1520	Tarot Readathon
1520	The Amazing Readathon
1521	Tarot Readathon
1521	The Amazing Readathon
1522	Tarot Readathon
1522	The Amazing Readathon
1523	Sunrise on the Readathon
1524	Sunrise on the Readathon
1524	Summerween
1525	Sunrise on the Readathon
1525	Summerween
1526	Sunrise on the Readathon
1526	Summerween
1527	Sunrise on the Readathon
1527	Summerween
1528	Sunrise on the Readathon
1528	Summerween
1529	Sunrise on the Readathon
1530	Sunrise on the Readathon
1531	Sunrise on the Readathon
1532	Sunrise on the Readathon
1533	Sunrise on the Readathon
1534	Sunrise on the Readathon
1535	Sunrise on the Readathon
\.


--
-- Data for Name: reading_tbr_prompt; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.reading_tbr_prompt (reading_id, prompt) FROM stdin;
1053	tarot: buzzwordathon
1065	book over 400 pages
1068	pink cover
1077	challenge: house in the title
1078	challenge: house in the title
1079	challenge: house in the title
1080	challenge: house in the title
1083	bought in 2020
1084	random page range (76-489)
1089	half the size of a previous
1090	part of a series
1091	first line challenge
1100	sci-fi
1105	domestic thriller
1108	familliar translator
1111	fire
1124	seasonal read
1125	young adult
1128	Gabby read last month
1129	three word title
1131	unwrapping the tbr #1
1132	person on the cover
1135	challenge (1/3): oldest books on shelves
1140	unwrapping the tbr #2
1141	challenge (1/1): least popular
1147	unwrapping the tbr #3
1155	previously DNF'd
1180	unwrapping the tbr #1
1186	thriller / horror
1187	set in winter
1188	vampire book / blood on the cover
1189	"hot" pick - new release or hyped
1190	war / battle / knife to throat enemies
1190	payed full price for
1192	food involves
1192	any semblence of romance
1194	tarot: ugly cover
1195	tarot: starts with 'A' + male author
1196	unwrapping the tbr #3
1200	tarot: gold or silver on the cover
1204	tarot: name in the title
1210	unwrapping the tbr #4
1211	tarot: black and white cover
1212	tarot: spin the wheel pick
1215	tarot: book I haven't bought
1219	tarot: published before 2020
1220	tarot: adjective in the title
1222	tarot: popular book, Escape the Readathon: top of the TBR
1223	tarot: three word title
1224	tarot: Booktuber's favorite
1225	unwrapping the tbr #5
1226	tarot: published this month, whatever year
1227	tarot: multiple POVs
1231	tarot: tbr veteran
1234	tarot: social media pick
1235	tarot: seasonal read
1236	tarot: creepy cover
1238	tarot: recently hauled
1239	unwrapping the tbr #6
1241	tarot: 4+ word title
1244	tarot: hyped new release
1246	tarot: male author
1247	tarot: published this month
1250	unwrapping the tbr #7, tarot: non-adult
1252	unwrapping the tbr #8
1255	tarot: previously DNFed
1256	tarot: blurbed by favorite author
1257	tarot: pair two books by a theme (recent Netflix adaptations) -> with Dear Child
1260	tarot: 4+ word title
1262	tarot: water or fire on the cover
1263	tarot: person on the cover
1264	tarot: Gabby read last month
1265	tarot: novella
1266	tarot: backlist that recently got hyped
1267	tarot: wordle challenge
1272	tarot: person on the cover
1273	tarot: unhaul if I don't read it this month
1274	tarot: illustrated cover
1276	tarot: verb in the title
1278	tarot: name in the title
1286	tarot: published this year
1293	2025 release
1294	starts with "J"
1295	something new to me
1296	white cover
1297	snowy setting
1298	novella
1299	horns on the cover
1300	historical fiction
1301	dark in the title
1302	cozy
1303	something dead on the cover
1304	Gabby read this month
1305	everyone read in 2024
1306	starts with "J"
1307	cozy
1308	romantasy
1309	starts with "F"
1310	heart in the title
1311	liquid on the cover
1312	>4.00 rating
1313	isolated setting
1314	author I love
1315	water related
1316	romantic
1317	mouth on the cover
1318	coastal setting
1319	book I bought used
1320	female author
1321	war
1322	anti-5-star prediction
1323	speculative
1324	anti-5-star-prediction
1325	plant on the cover
1328	illustrated cover
1329	brown cover
1330	quirky
1331	intimidating book
1332	4 word title
1333	green cover
1334	pretty cover
1335	ebook or audiobook
1336	animal on the cover
1337	something open on the cover
1338	title starts with "A"
1339	neurodivergent character
1343	mental health representation
1344	pink cover
1346	two people on the cover
1347	under 1000 ratings on GR
1348	title starts with 'C'
1351	motherhood
1352	Eurovision winner's flag colors on the cover
1353	paranormal element
1354	starts with "C"
1355	anticipated new release
1356	relates to Eurovisio song
1358	>5 colors on the cover
1360	twins
1361	sapphic
1363	featuring tech
1364	urban setting
1367	multiple POVs
1370	title starts with 'G'
1372	non-binary author
1373	orange cover
1375	currently 'hot' release
1376	read in Croatian
1378	dual timeline
1379	tbr veteran
1380	USA
1381	part of a series
1382	featuring a family
1383	emotional
1385	title starts with 'S'
1386	yellow cover
1387	male author
1388	book I'm not sure I'll like
1389	recently bought
1390	featuring travel
1391	popular 2024 release
1392	East Asia
1395	audiobook over 12 hours long
1396	teal cover
1397	maximalist cover
1399	<9 hour long audiobook
1400	starts with "L"
1402	"how" in the title
1404	translated
1407	dark academia
1409	minimalistic cover
1410	bookish theme
1412	highest rated new release
1414	set in the past
1415	title starts with 'N'
1416	leaves on the cover
1417	body parts
1418	13 letters in the title
1419	Scandinavia
1421	short story collection
1422	haunted house
1423	by favorite author
1425	murder
1426	creepy cover
1428	vampires
1429	rain on the cover
1432	unhinged main character
1433	cold environment
1434	one word title
1435	dark and red cover
1437	GCA romance nominee
1438	GCA horror nominee
1441	light on the cover
1442	bookclub pick
1443	magic
1444	blue cover
1445	Canada
1446	holiday related title
1447	365 pages
1448	small town setting
1451	festive cover
1454	dark academia
1455	continue a series
1458	random color generator: fawn brown
1479	new to me author
1482	trope: vacation
1511	seasonal spinner: queer books
1519	random page range: 90 - 356
1532	find on cover: lips
1534	audiobook randomizer
1537	zLibrary recommendation
1539	theme: friendship
\.


--
-- Data for Name: series; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.series (id, name, dropped, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: series_entry; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.series_entry (id, series_id, number, book_id, created_at, updated_at) FROM stdin;
\.


--
-- Name: author_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.author_id_seq', 1656, true);


--
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.book_id_seq', 3028, true);


--
-- Name: copy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.copy_id_seq', 2951, true);


--
-- Name: library_loan_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.library_loan_id_seq', 18, true);


--
-- Name: list_value_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.list_value_id_seq', 631, true);


--
-- Name: reading_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.reading_id_seq', 1552, true);


--
-- Name: series_entry_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.series_entry_id_seq', 1, false);


--
-- Name: series_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.series_id_seq', 1, false);


--
-- Name: author author_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.author
    ADD CONSTRAINT author_pkey PRIMARY KEY (id);


--
-- Name: book_author book_author_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_pkey PRIMARY KEY (book_id, "position");


--
-- Name: book_author book_author_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_uq UNIQUE (book_id, author_id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: book_genre book_genre_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_genre
    ADD CONSTRAINT book_genre_pkey PRIMARY KEY (book_id, "position");


--
-- Name: book book_key_uq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_key_uq UNIQUE (book_key);


--
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


--
-- Name: book_setting book_setting_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_setting
    ADD CONSTRAINT book_setting_pkey PRIMARY KEY (book_id, "position");


--
-- Name: copy copy_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.copy
    ADD CONSTRAINT copy_pkey PRIMARY KEY (id);


--
-- Name: flyway_schema_history flyway_schema_history_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);


--
-- Name: library_loan library_loan_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_loan
    ADD CONSTRAINT library_loan_pkey PRIMARY KEY (id);


--
-- Name: list_value list_value_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.list_value
    ADD CONSTRAINT list_value_pkey PRIMARY KEY (id);


--
-- Name: reading_bookclub reading_bookclub_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_bookclub
    ADD CONSTRAINT reading_bookclub_pkey PRIMARY KEY (reading_id, bookclub);


--
-- Name: reading_format reading_format_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_format
    ADD CONSTRAINT reading_format_pkey PRIMARY KEY (reading_id, format);


--
-- Name: reading reading_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading
    ADD CONSTRAINT reading_pkey PRIMARY KEY (id);


--
-- Name: reading_purpose reading_purpose_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_purpose
    ADD CONSTRAINT reading_purpose_pkey PRIMARY KEY (reading_id, purpose);


--
-- Name: reading_readathon reading_readathon_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_readathon
    ADD CONSTRAINT reading_readathon_pkey PRIMARY KEY (reading_id, readathon);


--
-- Name: reading_tbr_prompt reading_tbr_prompt_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_tbr_prompt
    ADD CONSTRAINT reading_tbr_prompt_pkey PRIMARY KEY (reading_id, prompt);


--
-- Name: series_entry series_entry_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_entry
    ADD CONSTRAINT series_entry_pkey PRIMARY KEY (id);


--
-- Name: series series_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series
    ADD CONSTRAINT series_pkey PRIMARY KEY (id);


--
-- Name: author_name_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX author_name_uq ON public.author USING btree (lower(name));


--
-- Name: book_author_author_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX book_author_author_idx ON public.book_author USING btree (author_id);


--
-- Name: book_title_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX book_title_idx ON public.book USING btree (lower(title));


--
-- Name: copy_book_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX copy_book_idx ON public.copy USING btree (book_id);


--
-- Name: copy_format_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX copy_format_idx ON public.copy USING btree (format);


--
-- Name: flyway_schema_history_s_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);


--
-- Name: library_loan_book_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX library_loan_book_idx ON public.library_loan USING btree (book_id);


--
-- Name: library_loan_out_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX library_loan_out_idx ON public.library_loan USING btree (date_due) WHERE (NOT returned);


--
-- Name: list_value_category_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX list_value_category_idx ON public.list_value USING btree (category, sort_order);


--
-- Name: list_value_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX list_value_uq ON public.list_value USING btree (category, lower(value));


--
-- Name: reading_book_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reading_book_idx ON public.reading USING btree (book_id);


--
-- Name: reading_year_month_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX reading_year_month_idx ON public.reading USING btree (reading_year, month);


--
-- Name: series_entry_book_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX series_entry_book_idx ON public.series_entry USING btree (book_id);


--
-- Name: series_entry_book_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX series_entry_book_uq ON public.series_entry USING btree (series_id, book_id) WHERE (book_id IS NOT NULL);


--
-- Name: series_entry_series_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX series_entry_series_idx ON public.series_entry USING btree (series_id, number);


--
-- Name: series_name_uq; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX series_name_uq ON public.series USING btree (lower(name));


--
-- Name: book_author book_author_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.author(id);


--
-- Name: book_author book_author_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_author
    ADD CONSTRAINT book_author_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id) ON DELETE CASCADE;


--
-- Name: book_genre book_genre_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_genre
    ADD CONSTRAINT book_genre_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id) ON DELETE CASCADE;


--
-- Name: book_setting book_setting_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.book_setting
    ADD CONSTRAINT book_setting_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id) ON DELETE CASCADE;


--
-- Name: copy copy_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.copy
    ADD CONSTRAINT copy_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id);


--
-- Name: library_loan library_loan_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.library_loan
    ADD CONSTRAINT library_loan_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id);


--
-- Name: reading reading_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading
    ADD CONSTRAINT reading_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id);


--
-- Name: reading_bookclub reading_bookclub_reading_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_bookclub
    ADD CONSTRAINT reading_bookclub_reading_id_fkey FOREIGN KEY (reading_id) REFERENCES public.reading(id) ON DELETE CASCADE;


--
-- Name: reading_format reading_format_reading_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_format
    ADD CONSTRAINT reading_format_reading_id_fkey FOREIGN KEY (reading_id) REFERENCES public.reading(id) ON DELETE CASCADE;


--
-- Name: reading_purpose reading_purpose_reading_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_purpose
    ADD CONSTRAINT reading_purpose_reading_id_fkey FOREIGN KEY (reading_id) REFERENCES public.reading(id) ON DELETE CASCADE;


--
-- Name: reading_readathon reading_readathon_reading_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_readathon
    ADD CONSTRAINT reading_readathon_reading_id_fkey FOREIGN KEY (reading_id) REFERENCES public.reading(id) ON DELETE CASCADE;


--
-- Name: reading_tbr_prompt reading_tbr_prompt_reading_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.reading_tbr_prompt
    ADD CONSTRAINT reading_tbr_prompt_reading_id_fkey FOREIGN KEY (reading_id) REFERENCES public.reading(id) ON DELETE CASCADE;


--
-- Name: series_entry series_entry_book_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_entry
    ADD CONSTRAINT series_entry_book_id_fkey FOREIGN KEY (book_id) REFERENCES public.book(id);


--
-- Name: series_entry series_entry_series_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.series_entry
    ADD CONSTRAINT series_entry_series_id_fkey FOREIGN KEY (series_id) REFERENCES public.series(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


