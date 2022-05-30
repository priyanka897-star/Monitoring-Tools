--
-- PostgreSQL database dump
--

-- Dumped from database version 13.5
-- Dumped by pg_dump version 13.6 (Ubuntu 13.6-1.pgdg20.04+1)

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

--
-- Name: activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.activity_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.activity_log_id_seq OWNER TO techteam_live;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: activity_log; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.activity_log (
    id integer DEFAULT nextval('public.activity_log_id_seq'::regclass) NOT NULL,
    user_id character varying(100) NOT NULL,
    user_name character varying(100) NOT NULL,
    pot_id integer,
    joined_id character varying(100),
    summary text,
    json_data json NOT NULL,
    transaction_type smallint,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone NOT NULL
);


ALTER TABLE public.activity_log OWNER TO techteam_live;

--
-- Name: COLUMN activity_log.transaction_type; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.activity_log.transaction_type IS '1-Join, 2-Cancelled, 3-Winning, 4-Left, 5-Reconnect';


--
-- Name: config_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.config_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.config_id_seq OWNER TO techteam_live;

--
-- Name: fraud_activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.fraud_activity_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.fraud_activity_log_id_seq OWNER TO techteam_live;

--
-- Name: fraud_activity_log; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.fraud_activity_log (
    id integer DEFAULT nextval('public.fraud_activity_log_id_seq'::regclass) NOT NULL,
    user_id character varying(100) NOT NULL,
    user_name character varying(100) NOT NULL,
    joined_id character varying(100),
    summary text,
    json_data json NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone NOT NULL,
    reason_code smallint
);


ALTER TABLE public.fraud_activity_log OWNER TO techteam_live;

--
-- Name: fruit_slice_config; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.fruit_slice_config (
    id integer DEFAULT nextval('public.config_id_seq'::regclass) NOT NULL,
    name character varying(100) NOT NULL,
    config json,
    is_deleted smallint DEFAULT '0'::smallint NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone NOT NULL
);


ALTER TABLE public.fruit_slice_config OWNER TO techteam_live;

--
-- Name: game_mode_config; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.game_mode_config (
    game_mode smallint NOT NULL,
    game_config json DEFAULT '{}'::json NOT NULL,
    mode smallint DEFAULT '1'::smallint NOT NULL
);


ALTER TABLE public.game_mode_config OWNER TO techteam_live;

--
-- Name: COLUMN game_mode_config.mode; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.game_mode_config.mode IS '1= 2 player, 2 = single player';


--
-- Name: leader_board_assets; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.leader_board_assets (
    id integer NOT NULL,
    bkg_image character varying NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone NOT NULL
);


ALTER TABLE public.leader_board_assets OWNER TO techteam_live;

--
-- Name: leader_board_master_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.leader_board_master_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.leader_board_master_id_seq OWNER TO techteam_live;

--
-- Name: leader_board_master; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.leader_board_master (
    id integer DEFAULT nextval('public.leader_board_master_id_seq'::regclass) NOT NULL,
    name character varying NOT NULL,
    duration integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    pot_id integer DEFAULT 0 NOT NULL,
    winning_distribution json,
    subtitle json DEFAULT '{"title":"leaderboard","strikethrough":false} '::json NOT NULL,
    info text DEFAULT 'Play more games to top the leaderboard'::text NOT NULL,
    note text DEFAULT ' Winning amount will be distributed on the basis of %. If the number of entries are less than or equal to the number of winners then the winning amount will be distributed amoung top 40% based on the % given for new winning amount. Any balance amount will be equally distributed amongst the winners.'::text NOT NULL
);


ALTER TABLE public.leader_board_master OWNER TO techteam_live;

--
-- Name: leader_board_schedule_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.leader_board_schedule_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.leader_board_schedule_id_seq OWNER TO techteam_live;

--
-- Name: leader_board_schedule; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.leader_board_schedule (
    id integer DEFAULT nextval('public.leader_board_schedule_id_seq'::regclass) NOT NULL,
    lb_id integer NOT NULL,
    start_time timestamp without time zone NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone NOT NULL,
    end_time timestamp without time zone,
    status smallint DEFAULT '0'::smallint NOT NULL,
    winner_percent smallint DEFAULT '20'::smallint NOT NULL,
    assets smallint DEFAULT '1'::smallint NOT NULL,
    joined_id character varying,
    is_deleted smallint DEFAULT '0'::smallint NOT NULL,
    lb_limit integer DEFAULT 0,
    replica_id integer DEFAULT '-1'::integer NOT NULL
);


ALTER TABLE public.leader_board_schedule OWNER TO techteam_live;

--
-- Name: COLUMN leader_board_schedule.status; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.leader_board_schedule.status IS '0- to begin 1- ongoing 2- completed 3-win distribution';


--
-- Name: potsmaster_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.potsmaster_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.potsmaster_id_seq OWNER TO techteam_live;

--
-- Name: pot_master; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.pot_master (
    id integer DEFAULT nextval('public.potsmaster_id_seq'::regclass) NOT NULL,
    catid smallint DEFAULT '1'::smallint NOT NULL,
    base_amount integer DEFAULT 0 NOT NULL,
    win_amount integer DEFAULT 0 NOT NULL,
    percentage_on_total real DEFAULT '16.67'::real NOT NULL,
    max_users smallint DEFAULT '2'::smallint NOT NULL,
    no_of_winners smallint DEFAULT '1'::smallint NOT NULL,
    is_multiple_winner smallint DEFAULT '0'::smallint NOT NULL,
    priority smallint DEFAULT '0'::smallint NOT NULL,
    "order" smallint DEFAULT '0'::smallint NOT NULL,
    timer_type smallint DEFAULT '0'::smallint NOT NULL,
    "time" timestamp without time zone,
    discount_json character varying(255),
    is_all_pot_discount smallint DEFAULT '0'::smallint NOT NULL,
    is_deleted smallint DEFAULT '0'::smallint NOT NULL,
    is_active smallint DEFAULT '1'::smallint NOT NULL,
    winner_list json,
    is_private boolean DEFAULT false NOT NULL,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    deduct_json json DEFAULT '[0]'::json NOT NULL,
    wait_time integer DEFAULT 90 NOT NULL,
    test_only smallint DEFAULT '0'::smallint NOT NULL,
    game_mode smallint DEFAULT '0'::smallint NOT NULL,
    active_since_version smallint DEFAULT '81'::smallint NOT NULL,
    active_since_version_ios smallint NOT NULL,
    pot_config json DEFAULT '{}'::json NOT NULL
);


ALTER TABLE public.pot_master OWNER TO techteam_live;

--
-- Name: COLUMN pot_master.game_mode; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.pot_master.game_mode IS '0 multiple/regular 1 private  2 freestyle/ pachisi 3 single player';


--
-- Name: s2s_activity_log_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.s2s_activity_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.s2s_activity_log_id_seq OWNER TO techteam_live;

--
-- Name: s2s_activity_log; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.s2s_activity_log (
    id integer DEFAULT nextval('public.s2s_activity_log_id_seq'::regclass) NOT NULL,
    joined_id character varying(100) NOT NULL,
    transaction_type smallint NOT NULL,
    status smallint NOT NULL,
    req_json json,
    res_json json,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    cron_status smallint DEFAULT '0'::smallint NOT NULL
);


ALTER TABLE public.s2s_activity_log OWNER TO techteam_live;

--
-- Name: COLUMN s2s_activity_log.transaction_type; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.s2s_activity_log.transaction_type IS '1-verify, 2- refund, 3-winning';


--
-- Name: COLUMN s2s_activity_log.status; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.s2s_activity_log.status IS '1-initiated, 2-completed, 3-error';


--
-- Name: suspicious_user_points_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.suspicious_user_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.suspicious_user_points_id_seq OWNER TO techteam_live;

--
-- Name: suspicious_user_points; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.suspicious_user_points (
    id integer DEFAULT nextval('public.suspicious_user_points_id_seq'::regclass) NOT NULL,
    user_id character varying(100) NOT NULL,
    leader_board_schedule_id integer,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    user_name character varying(100),
    user_image character varying(300),
    matches integer DEFAULT 1 NOT NULL,
    joined_id character varying DEFAULT ''::character varying,
    user_sent_score integer,
    score integer
);


ALTER TABLE public.suspicious_user_points OWNER TO techteam_live;

--
-- Name: temp; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.temp (
    id integer,
    user_id text,
    leader_board_schedule_id integer,
    points integer,
    rank integer NOT NULL,
    created_date timestamp without time zone,
    modified_date timestamp without time zone,
    user_name text,
    user_image text,
    "partitionId" integer NOT NULL,
    win_amount integer DEFAULT 0 NOT NULL,
    matches integer DEFAULT 1 NOT NULL,
    best_score integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.temp OWNER TO techteam_live;

--
-- Name: user_points_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.user_points_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_points_id_seq OWNER TO techteam_live;

--
-- Name: user_points; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.user_points (
    id integer DEFAULT nextval('public.user_points_id_seq'::regclass) NOT NULL,
    user_id character varying(100) NOT NULL,
    leader_board_schedule_id integer NOT NULL,
    points integer NOT NULL,
    rank integer NOT NULL,
    created_date timestamp without time zone NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL,
    user_name character varying(100),
    user_image character varying(300),
    win_amount integer DEFAULT 0 NOT NULL,
    matches integer DEFAULT 1 NOT NULL,
    best_score integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_points OWNER TO techteam_live;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.users_id_seq OWNER TO techteam_live;

--
-- Name: users_joined_lists_id_seq; Type: SEQUENCE; Schema: public; Owner: techteam_live
--

CREATE SEQUENCE public.users_joined_lists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER TABLE public.users_joined_lists_id_seq OWNER TO techteam_live;

--
-- Name: users_joined_lists; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.users_joined_lists (
    id integer DEFAULT nextval('public.users_joined_lists_id_seq'::regclass) NOT NULL,
    user_id character varying(100) NOT NULL,
    user_name character varying(100) NOT NULL,
    user_image character varying(300),
    msc_id integer,
    joined_id character varying(100),
    rank smallint DEFAULT '0'::smallint,
    total_score numeric DEFAULT '0'::numeric,
    winning_amount numeric DEFAULT '0'::numeric,
    status smallint DEFAULT '0'::smallint,
    coin_movements json,
    transaction_id character varying(100),
    amount numeric NOT NULL,
    winning numeric NOT NULL,
    deposit numeric NOT NULL,
    bonus numeric NOT NULL,
    winner boolean DEFAULT false NOT NULL,
    final_result json,
    created_date timestamp without time zone DEFAULT now(),
    modified_date timestamp without time zone DEFAULT now(),
    is_private smallint DEFAULT '0'::smallint,
    sch_id smallint
);


ALTER TABLE public.users_joined_lists OWNER TO techteam_live;

--
-- Name: users_q; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.users_q (
    id integer DEFAULT nextval('public.users_id_seq'::regclass) NOT NULL,
    user_id character varying(100) NOT NULL,
    user_name character varying(100) NOT NULL,
    user_image character varying(100),
    type integer DEFAULT 1 NOT NULL,
    is_deleted smallint DEFAULT '0'::smallint,
    created_date timestamp without time zone DEFAULT now() NOT NULL,
    modified_date timestamp without time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users_q OWNER TO techteam_live;

--
-- Name: COLUMN users_q.type; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.users_q.type IS '1-winnerBot, 2-looserBot, 3-ActualUser';


--
-- Name: COLUMN users_q.is_deleted; Type: COMMENT; Schema: public; Owner: techteam_live
--

COMMENT ON COLUMN public.users_q.is_deleted IS '0-active, 1-deleted';


--
-- Name: users_q_joined_lists; Type: TABLE; Schema: public; Owner: techteam_live
--

CREATE TABLE public.users_q_joined_lists (
    user_id character varying(100) NOT NULL,
    sch_id integer NOT NULL
);


ALTER TABLE public.users_q_joined_lists OWNER TO techteam_live;

--
-- Name: activity_log activity_log_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.activity_log
    ADD CONSTRAINT activity_log_id PRIMARY KEY (id);


--
-- Name: fraud_activity_log fraud_activity_log_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.fraud_activity_log
    ADD CONSTRAINT fraud_activity_log_id PRIMARY KEY (id);


--
-- Name: game_mode_config game_mode_config_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.game_mode_config
    ADD CONSTRAINT game_mode_config_id PRIMARY KEY (game_mode);


--
-- Name: leader_board_assets leader_board_assets_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.leader_board_assets
    ADD CONSTRAINT leader_board_assets_id PRIMARY KEY (id);


--
-- Name: leader_board_master leader_board_master_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.leader_board_master
    ADD CONSTRAINT leader_board_master_id PRIMARY KEY (id);


--
-- Name: leader_board_schedule leader_board_schedule_pkey; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.leader_board_schedule
    ADD CONSTRAINT leader_board_schedule_pkey PRIMARY KEY (id);


--
-- Name: pot_master potsmaster_pkey; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.pot_master
    ADD CONSTRAINT potsmaster_pkey PRIMARY KEY (id);


--
-- Name: s2s_activity_log s2s_activity_log_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.s2s_activity_log
    ADD CONSTRAINT s2s_activity_log_id PRIMARY KEY (id);


--
-- Name: fruit_slice_config sll_config_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.fruit_slice_config
    ADD CONSTRAINT sll_config_id PRIMARY KEY (id);


--
-- Name: suspicious_user_points suspicious_user_points_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.suspicious_user_points
    ADD CONSTRAINT suspicious_user_points_id PRIMARY KEY (id);


--
-- Name: user_points user_points_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.user_points
    ADD CONSTRAINT user_points_id PRIMARY KEY (id);


--
-- Name: users_joined_lists users_joined_lists_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.users_joined_lists
    ADD CONSTRAINT users_joined_lists_id PRIMARY KEY (id);


--
-- Name: users_q users_q_id; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.users_q
    ADD CONSTRAINT users_q_id PRIMARY KEY (id);


--
-- Name: users_q_joined_lists users_q_joined_lists_pkey; Type: CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.users_q_joined_lists
    ADD CONSTRAINT users_q_joined_lists_pkey PRIMARY KEY (user_id, sch_id);


--
-- Name: activity_log_joined_id; Type: INDEX; Schema: public; Owner: techteam_live
--

CREATE INDEX activity_log_joined_id ON public.activity_log USING btree (joined_id);


--
-- Name: s2s_activity_log_joined_id; Type: INDEX; Schema: public; Owner: techteam_live
--

CREATE INDEX s2s_activity_log_joined_id ON public.s2s_activity_log USING btree (joined_id);


--
-- Name: user_points_leader_board_schedule_id; Type: INDEX; Schema: public; Owner: techteam_live
--

CREATE INDEX user_points_leader_board_schedule_id ON public.user_points USING btree (leader_board_schedule_id);


--
-- Name: user_points_points; Type: INDEX; Schema: public; Owner: techteam_live
--

CREATE INDEX user_points_points ON public.user_points USING btree (points);


--
-- Name: users_joined_lists_joined_id; Type: INDEX; Schema: public; Owner: techteam_live
--

CREATE INDEX users_joined_lists_joined_id ON public.users_joined_lists USING btree (joined_id);


--
-- Name: users_joined_lists_status; Type: INDEX; Schema: public; Owner: techteam_live
--

CREATE INDEX users_joined_lists_status ON public.users_joined_lists USING btree (status);


--
-- Name: users_joined_lists_user_id_joined_id; Type: INDEX; Schema: public; Owner: techteam_live
--

CREATE INDEX users_joined_lists_user_id_joined_id ON public.users_joined_lists USING btree (user_id, joined_id);


--
-- Name: leader_board_master leader_board_master_pot_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.leader_board_master
    ADD CONSTRAINT leader_board_master_pot_id_fkey FOREIGN KEY (pot_id) REFERENCES public.pot_master(id);


--
-- Name: leader_board_schedule leader_board_schedule_assets_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.leader_board_schedule
    ADD CONSTRAINT leader_board_schedule_assets_fkey FOREIGN KEY (assets) REFERENCES public.leader_board_assets(id);


--
-- Name: leader_board_schedule leader_board_schedule_lb_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.leader_board_schedule
    ADD CONSTRAINT leader_board_schedule_lb_id_fkey FOREIGN KEY (lb_id) REFERENCES public.leader_board_master(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: pot_master pot_master_game_mode_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.pot_master
    ADD CONSTRAINT pot_master_game_mode_fkey FOREIGN KEY (game_mode) REFERENCES public.game_mode_config(game_mode);


--
-- Name: user_points user_points_leader_board_schedule_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: techteam_live
--

ALTER TABLE ONLY public.user_points
    ADD CONSTRAINT user_points_leader_board_schedule_id_fkey FOREIGN KEY (leader_board_schedule_id) REFERENCES public.leader_board_schedule(id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: techteam_live
--

REVOKE ALL ON SCHEMA public FROM pg1050165897;
REVOKE ALL ON SCHEMA public FROM PUBLIC;
GRANT ALL ON SCHEMA public TO techteam_live;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

