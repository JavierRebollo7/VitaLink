--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.4

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

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO supabase_admin;

--
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO supabase_admin;

--
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO supabase_admin;

--
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- Name: pgsodium; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA pgsodium;


ALTER SCHEMA pgsodium OWNER TO supabase_admin;

--
-- Name: pgsodium; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgsodium WITH SCHEMA pgsodium;


--
-- Name: EXTENSION pgsodium; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgsodium IS 'Pgsodium is a modern cryptography library for Postgres.';


--
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO supabase_admin;

--
-- Name: storage; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO supabase_admin;

--
-- Name: vault; Type: SCHEMA; Schema: -; Owner: supabase_admin
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO supabase_admin;

--
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- Name: pgjwt; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgjwt WITH SCHEMA extensions;


--
-- Name: EXTENSION pgjwt; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgjwt IS 'JSON Web Token API for Postgresql';


--
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- Name: action; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO supabase_admin;

--
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO supabase_admin;

--
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO supabase_admin;

--
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO supabase_admin;

--
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: supabase_admin
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO supabase_admin;

--
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user supabase_admin in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user supabase_admin in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO supabase_admin;

--
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO supabase_admin;

--
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: supabase_admin
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO supabase_admin;

--
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: supabase_admin
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: supabase_admin
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $$
BEGIN
    RAISE WARNING 'PgBouncer auth request: %', p_usename;

    RETURN QUERY
    SELECT usename::TEXT, passwd::TEXT FROM pg_catalog.pg_shadow
    WHERE usename = p_usename;
END;
$$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO supabase_admin;

--
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO supabase_admin;

--
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO supabase_admin;

--
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO supabase_admin;

--
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO supabase_admin;

--
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO supabase_admin;

--
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO supabase_admin;

--
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO supabase_admin;

--
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO supabase_admin;

--
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO supabase_admin;

--
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: supabase_admin
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO supabase_admin;

--
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

--
-- Name: secrets_encrypt_secret_secret(); Type: FUNCTION; Schema: vault; Owner: supabase_admin
--

CREATE FUNCTION vault.secrets_encrypt_secret_secret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
		BEGIN
		        new.secret = CASE WHEN new.secret IS NULL THEN NULL ELSE
			CASE WHEN new.key_id IS NULL THEN NULL ELSE pg_catalog.encode(
			  pgsodium.crypto_aead_det_encrypt(
				pg_catalog.convert_to(new.secret, 'utf8'),
				pg_catalog.convert_to((new.id::text || new.description::text || new.created_at::text || new.updated_at::text)::text, 'utf8'),
				new.key_id::uuid,
				new.nonce
			  ),
				'base64') END END;
		RETURN new;
		END;
		$$;


ALTER FUNCTION vault.secrets_encrypt_secret_secret() OWNER TO supabase_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- Name: calendar_events; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.calendar_events (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    user_id uuid,
    profile_id bigint,
    title text NOT NULL,
    description text,
    start_time timestamp with time zone NOT NULL,
    end_time timestamp with time zone NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    all_day boolean DEFAULT false
);


ALTER TABLE public.calendar_events OWNER TO postgres;

--
-- Name: cleared_notifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cleared_notifications (
    id bigint NOT NULL,
    user_id uuid NOT NULL,
    event_id uuid NOT NULL,
    cleared_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE public.cleared_notifications OWNER TO postgres;

--
-- Name: cleared_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.cleared_notifications ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.cleared_notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: conversations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conversations (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    title text NOT NULL,
    user_id uuid NOT NULL
);


ALTER TABLE public.conversations OWNER TO postgres;

--
-- Name: files; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.files (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    user_id uuid NOT NULL,
    profile_id uuid,
    name text NOT NULL,
    type text,
    document_type text,
    category text,
    description text,
    tags text[],
    size bigint,
    url text,
    path text
);


ALTER TABLE public.files OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.messages (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    content text NOT NULL,
    type text NOT NULL,
    conversation_id uuid NOT NULL
);


ALTER TABLE public.messages OWNER TO postgres;

--
-- Name: profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.profiles (
    id uuid DEFAULT extensions.uuid_generate_v4() NOT NULL,
    created_at timestamp with time zone DEFAULT timezone('utc'::text, now()) NOT NULL,
    user_id uuid NOT NULL,
    name text,
    date_of_birth text,
    gender text,
    height text,
    weight text,
    blood_type text,
    family_role text,
    allergies text[],
    medical_conditions text[],
    medications text[],
    image_url text
);


ALTER TABLE public.profiles OWNER TO postgres;

--
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO supabase_admin;

--
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: supabase_admin
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO supabase_admin;

--
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- Name: decrypted_secrets; Type: VIEW; Schema: vault; Owner: supabase_admin
--

CREATE VIEW vault.decrypted_secrets AS
 SELECT secrets.id,
    secrets.name,
    secrets.description,
    secrets.secret,
        CASE
            WHEN (secrets.secret IS NULL) THEN NULL::text
            ELSE
            CASE
                WHEN (secrets.key_id IS NULL) THEN NULL::text
                ELSE convert_from(pgsodium.crypto_aead_det_decrypt(decode(secrets.secret, 'base64'::text), convert_to(((((secrets.id)::text || secrets.description) || (secrets.created_at)::text) || (secrets.updated_at)::text), 'utf8'::name), secrets.key_id, secrets.nonce), 'utf8'::name)
            END
        END AS decrypted_secret,
    secrets.key_id,
    secrets.nonce,
    secrets.created_at,
    secrets.updated_at
   FROM vault.secrets;


ALTER VIEW vault.decrypted_secrets OWNER TO supabase_admin;

--
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;
00000000-0000-0000-0000-000000000000	14804db2-c290-45aa-ad19-395f8d3e6adc	{"action":"user_confirmation_requested","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-02-12 16:24:45.234734+00	
00000000-0000-0000-0000-000000000000	8185c0e0-a9c2-4a60-b730-d5f6516929bd	{"action":"user_signedup","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"team"}	2025-02-12 16:27:34.041542+00	
00000000-0000-0000-0000-000000000000	a83e69a2-a3ed-477b-b3cc-0258af208e78	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 16:27:42.88553+00	
00000000-0000-0000-0000-000000000000	40106d83-18be-49ba-b04d-1b2c5ee35073	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 16:27:55.62245+00	
00000000-0000-0000-0000-000000000000	916ef114-bccc-4e82-af62-9184bfcd1ac6	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 16:40:35.772146+00	
00000000-0000-0000-0000-000000000000	5402e5d5-8220-4766-89d3-0a0e8f3d03e1	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 16:46:00.639653+00	
00000000-0000-0000-0000-000000000000	6b8349e2-498b-4840-80d2-23919d998766	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 16:47:47.819711+00	
00000000-0000-0000-0000-000000000000	3ff2aabc-b5ed-4043-996e-b14fe122faaf	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 16:47:49.984472+00	
00000000-0000-0000-0000-000000000000	60997af7-6a2d-4487-bd9a-fc157dc82f4e	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 16:49:33.250409+00	
00000000-0000-0000-0000-000000000000	c8d07ef1-759f-49ad-acb1-2b3c17ac07da	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 16:49:35.440231+00	
00000000-0000-0000-0000-000000000000	c839d459-b886-47a7-818e-951fbe0f53ba	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 16:50:11.305929+00	
00000000-0000-0000-0000-000000000000	0a6b8093-95ef-4222-a272-2adcd4aca8f8	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-02-12 17:04:01.180013+00	
00000000-0000-0000-0000-000000000000	231a07ad-cb59-4a11-82ef-9a48f84d89a5	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"google"}}	2025-02-12 17:04:01.684876+00	
00000000-0000-0000-0000-000000000000	08181961-7de5-48dd-be4a-f1b2fe82f7b4	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 17:04:03.482717+00	
00000000-0000-0000-0000-000000000000	f5a73425-8916-49b5-8742-892d7aa0bf30	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"github"}}	2025-02-12 17:06:16.117718+00	
00000000-0000-0000-0000-000000000000	be006fc5-b869-4546-aa82-3930c74e718a	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"github"}}	2025-02-12 17:06:16.592532+00	
00000000-0000-0000-0000-000000000000	033e012b-7191-4795-be8e-f85da62fb072	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 17:06:19.747317+00	
00000000-0000-0000-0000-000000000000	b06bed56-b975-4079-b431-0cf487ef9513	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 17:06:25.063672+00	
00000000-0000-0000-0000-000000000000	46cf7645-2fad-4f79-ae6f-642277406f1c	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 18:04:27.331833+00	
00000000-0000-0000-0000-000000000000	4d612c42-3189-47aa-9c9d-a2b9c7dbfc2a	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 18:04:27.335023+00	
00000000-0000-0000-0000-000000000000	957cea19-32ba-4494-bf26-55cb2033668b	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 19:02:55.425602+00	
00000000-0000-0000-0000-000000000000	1eaeae3d-a8b8-4228-910b-deb4ec55bc60	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 19:02:55.427033+00	
00000000-0000-0000-0000-000000000000	fd0fda97-5592-41fe-a246-0b03d6f3d955	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 19:21:40.632987+00	
00000000-0000-0000-0000-000000000000	eba4a93b-ec5f-4128-91f3-c53c59f5a3fd	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 19:21:43.104432+00	
00000000-0000-0000-0000-000000000000	45d5bada-53ab-41be-94d8-9c2f0f8767fd	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 19:25:19.715019+00	
00000000-0000-0000-0000-000000000000	cf61edac-11e2-41ba-8740-afae95a518cf	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 19:25:23.371494+00	
00000000-0000-0000-0000-000000000000	32ef56d4-50c9-44e0-b3db-46fbdc6b5891	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 21:03:34.501227+00	
00000000-0000-0000-0000-000000000000	add4d8ff-f25b-4658-8ea6-2aa0518f302e	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 21:03:34.503297+00	
00000000-0000-0000-0000-000000000000	1c6a619b-9b63-4894-9fad-fea511b0f8f3	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 21:09:53.446637+00	
00000000-0000-0000-0000-000000000000	fcd43fae-ee1d-434c-9e8b-c5af4e4a55a5	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 21:10:01.355478+00	
00000000-0000-0000-0000-000000000000	6593aa12-684c-4a49-9dcc-d4a20ed32cbf	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 21:10:20.047531+00	
00000000-0000-0000-0000-000000000000	eaf4806c-e864-48fb-8c4f-ec67754d52ae	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 21:10:25.005727+00	
00000000-0000-0000-0000-000000000000	d1b82b96-88ea-4464-895c-4df9e3b78ef8	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 22:09:54.505416+00	
00000000-0000-0000-0000-000000000000	8735ed2d-11e7-4075-9495-e2bff1010e5d	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 22:09:54.515457+00	
00000000-0000-0000-0000-000000000000	104b437d-3a4a-4a39-a430-dd9423f3b93f	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 22:48:16.978701+00	
00000000-0000-0000-0000-000000000000	32906d83-6162-45ad-87a2-57c7fdbef913	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 22:49:00.248547+00	
00000000-0000-0000-0000-000000000000	28102f16-91a1-4b1c-a263-9068e011e257	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 22:53:02.566963+00	
00000000-0000-0000-0000-000000000000	4ae0fc24-85ae-4417-a159-334ba0121af1	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 22:53:05.298945+00	
00000000-0000-0000-0000-000000000000	dc4970c1-7023-4572-aaec-d76967ad81f3	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-12 22:53:06.143848+00	
00000000-0000-0000-0000-000000000000	90eacc04-aa90-4278-a5fd-dd05f1583627	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-12 22:53:44.469048+00	
00000000-0000-0000-0000-000000000000	648005eb-fcb5-4652-8edd-b9bdb4ea30dc	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 23:52:00.072321+00	
00000000-0000-0000-0000-000000000000	dc4f064e-70fb-4caf-9681-2bbb6307be74	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-12 23:52:00.076512+00	
00000000-0000-0000-0000-000000000000	ae85fbc0-f960-43aa-a178-5176d711e837	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 00:50:14.824153+00	
00000000-0000-0000-0000-000000000000	92eb29a3-7494-4eba-a14e-1a20bd343fe3	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 00:50:14.831575+00	
00000000-0000-0000-0000-000000000000	f3661991-980d-470b-b37c-9361ddbcba94	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 01:48:27.116182+00	
00000000-0000-0000-0000-000000000000	db6621d9-a358-4413-a9c1-ecc22ff9fcc1	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 01:48:27.129434+00	
00000000-0000-0000-0000-000000000000	af0ed864-fc4f-4b85-9c6b-cbb820911012	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 02:46:30.543449+00	
00000000-0000-0000-0000-000000000000	ef2e9b15-2b52-4929-a8c4-b9b971c4a653	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 02:46:30.564898+00	
00000000-0000-0000-0000-000000000000	c5ed12dc-7630-4dcd-9589-4e5e9cf367f8	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 04:12:08.938347+00	
00000000-0000-0000-0000-000000000000	9b4c3d82-7b60-402c-9125-f13d089c6ac0	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 04:12:08.965937+00	
00000000-0000-0000-0000-000000000000	40200b52-1ea2-4047-acb2-ae00f79e9eff	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 05:10:10.482087+00	
00000000-0000-0000-0000-000000000000	a26a3495-5221-4eb8-8e8f-3e53d5e3fd26	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 05:10:10.490405+00	
00000000-0000-0000-0000-000000000000	d2e4277b-df0b-414f-901e-d52742810402	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 15:28:43.205531+00	
00000000-0000-0000-0000-000000000000	8e269b1a-a69b-4752-a7ec-a8d59a30412c	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 15:28:43.234917+00	
00000000-0000-0000-0000-000000000000	2bd7a673-1aa4-4a1a-b9dc-9c2cce8f5a94	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 16:27:01.379981+00	
00000000-0000-0000-0000-000000000000	645d403d-b3c7-4df0-aef7-3068b96b8f11	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 16:27:01.386416+00	
00000000-0000-0000-0000-000000000000	54b62837-8369-4690-b308-c4cc784ea6aa	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 17:25:00.466349+00	
00000000-0000-0000-0000-000000000000	f7685f64-acb7-4677-9647-8c260184019a	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 17:25:00.485813+00	
00000000-0000-0000-0000-000000000000	2709046e-6233-419e-a0df-e19f31dd3f84	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 18:23:18.539988+00	
00000000-0000-0000-0000-000000000000	65c2dafe-a013-47cc-9190-ef4d9aa005f4	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 18:23:18.544619+00	
00000000-0000-0000-0000-000000000000	be38588a-08ea-4d1c-b5e0-c0bbfd1411af	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 19:21:27.048382+00	
00000000-0000-0000-0000-000000000000	0f5f8669-89fc-40c7-8a93-05bd68425fef	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 19:21:27.049541+00	
00000000-0000-0000-0000-000000000000	62c06b75-5738-4751-8cd2-a92cba67ccc1	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-13 19:38:06.662063+00	
00000000-0000-0000-0000-000000000000	153eaf4e-d2f4-4807-8554-49fc0ce0b7a3	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 20:19:50.056788+00	
00000000-0000-0000-0000-000000000000	0aa264ec-2b89-4664-9df7-01ef0a62b2c1	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 20:19:50.058373+00	
00000000-0000-0000-0000-000000000000	eed79a90-fc99-47e8-8094-a15fca809538	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 21:21:47.250404+00	
00000000-0000-0000-0000-000000000000	1f793645-350a-49a9-9cca-744dcbb9e4f3	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 21:21:47.251465+00	
00000000-0000-0000-0000-000000000000	8f6667b7-070d-46d6-a2ca-afd9d6ed535e	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 21:21:47.281468+00	
00000000-0000-0000-0000-000000000000	73ecd64e-e2cf-4c45-8c96-622b86a5e86b	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 21:21:47.960823+00	
00000000-0000-0000-0000-000000000000	ed96c085-42f1-4786-950a-24c9c031b7b7	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 22:20:02.660615+00	
00000000-0000-0000-0000-000000000000	99677249-d037-45c3-80de-76c4627a8c9a	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-13 22:20:02.66257+00	
00000000-0000-0000-0000-000000000000	061858b8-7feb-45b9-a059-0fbf1bf4adfa	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 00:58:33.511841+00	
00000000-0000-0000-0000-000000000000	8bc03fd7-64c4-4314-9fad-0fea17f66fe2	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 00:58:33.514207+00	
00000000-0000-0000-0000-000000000000	9b26b31d-0917-4885-b673-5ab8f6bca232	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 01:56:40.807319+00	
00000000-0000-0000-0000-000000000000	7d40131c-8718-490f-85af-ec85e0b75d8e	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 01:56:40.818111+00	
00000000-0000-0000-0000-000000000000	e1d35b9e-b4db-4612-b48c-86c1540e3846	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 02:54:53.660606+00	
00000000-0000-0000-0000-000000000000	26a500f5-eba8-493a-83ce-3f4ce37e5321	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 02:54:53.662598+00	
00000000-0000-0000-0000-000000000000	0129a0c9-665a-4eba-9d1c-0bdda3bcadbf	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 03:53:21.445753+00	
00000000-0000-0000-0000-000000000000	814b03be-4e2c-49df-bbe8-510706d4b28d	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 03:53:21.451496+00	
00000000-0000-0000-0000-000000000000	eb267939-7e38-48e7-8dc9-d009c6328096	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 03:58:48.06016+00	
00000000-0000-0000-0000-000000000000	5bd9b495-4835-4862-9344-52827e379b36	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 04:18:18.621514+00	
00000000-0000-0000-0000-000000000000	b7a0cb37-3453-42ec-9103-820123719316	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 04:21:44.037444+00	
00000000-0000-0000-0000-000000000000	206669c3-a45b-4322-915b-a3718f9ce4e4	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 04:21:55.824555+00	
00000000-0000-0000-0000-000000000000	fff6f86d-b709-41e4-a2d2-4ace410bed1f	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 04:22:02.003624+00	
00000000-0000-0000-0000-000000000000	955c16a9-74bc-4d56-a42e-6481e1d62119	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 04:22:09.82983+00	
00000000-0000-0000-0000-000000000000	9cd10c1d-a463-4ff5-af28-7f8e25aebce1	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 04:23:50.112842+00	
00000000-0000-0000-0000-000000000000	dee4318e-4806-4165-90e4-40e967885f55	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-02-14 04:25:32.012929+00	
00000000-0000-0000-0000-000000000000	9f3f19c5-d36e-4782-8ccb-91aac833c2b5	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-14 04:25:34.713659+00	
00000000-0000-0000-0000-000000000000	00fda3fa-6448-488b-99c6-7291783a5204	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 05:25:49.458483+00	
00000000-0000-0000-0000-000000000000	ab22f8a2-c8c1-426d-a048-cec388bf1617	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-14 05:25:49.46007+00	
00000000-0000-0000-0000-000000000000	3ee99fc3-fa7e-42e6-8d0a-4aa200290032	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 19:57:41.725638+00	
00000000-0000-0000-0000-000000000000	6722f1bf-1dae-4c8d-843d-fa652461cb45	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 19:57:41.747849+00	
00000000-0000-0000-0000-000000000000	36df3a87-7115-4c1d-9b9f-fc8913935f47	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 20:56:53.219061+00	
00000000-0000-0000-0000-000000000000	404865c8-268f-4a88-8106-ddaa73cb2785	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 20:56:53.220586+00	
00000000-0000-0000-0000-000000000000	2f4c2f08-7512-46d7-9795-6320943f98dc	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 21:55:14.179838+00	
00000000-0000-0000-0000-000000000000	3db11e43-2a36-46dc-ae1b-e2b8da22eb79	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 21:55:14.185223+00	
00000000-0000-0000-0000-000000000000	760f59d4-0445-44e5-bf36-81b634d8b433	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 22:53:17.79257+00	
00000000-0000-0000-0000-000000000000	76c29bae-b564-4f42-a888-dc786a5132e2	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 22:53:17.796023+00	
00000000-0000-0000-0000-000000000000	91695063-873b-40b0-84f6-d372cebbfcd4	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 23:54:14.17153+00	
00000000-0000-0000-0000-000000000000	6e4ea9ed-bafc-45b1-922f-dcbc17451b23	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-17 23:54:14.173073+00	
00000000-0000-0000-0000-000000000000	02b511b5-2931-4ba2-8a75-f23402c9db0b	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 00:52:41.380224+00	
00000000-0000-0000-0000-000000000000	2d439671-2247-4199-91de-9105482c43d4	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 00:52:41.381732+00	
00000000-0000-0000-0000-000000000000	bdacadec-9ef5-4ef6-bc52-ada827783bfa	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 02:05:51.197708+00	
00000000-0000-0000-0000-000000000000	a65f1159-3d26-412e-99d8-948d6083d8d1	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-18 02:05:51.199805+00	
00000000-0000-0000-0000-000000000000	70e91d7b-5eb2-42f7-8a71-9cad9f6da6b9	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 17:52:48.346587+00	
00000000-0000-0000-0000-000000000000	41818a9c-8616-4820-9dec-ef5c1f5ba03b	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 17:52:48.359511+00	
00000000-0000-0000-0000-000000000000	15fdcc28-a010-4496-9e36-f2db1db2d6c4	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 17:52:49.357529+00	
00000000-0000-0000-0000-000000000000	5705b7fa-ec17-4788-a8e7-d0f687de1125	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 18:53:01.173011+00	
00000000-0000-0000-0000-000000000000	0d79e718-71b8-4f9d-ac6e-acfe244b48fd	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 18:53:01.175374+00	
00000000-0000-0000-0000-000000000000	588b56f0-00ba-437c-98d6-7f4266f2d036	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 18:53:01.19666+00	
00000000-0000-0000-0000-000000000000	006ed4a7-1b84-4c6e-8303-761e7b35ec46	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 19:52:55.03132+00	
00000000-0000-0000-0000-000000000000	f59e05ec-e7c0-4444-9cf5-747867083c4d	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 19:52:55.034268+00	
00000000-0000-0000-0000-000000000000	45660f20-e12c-4b5f-9fe4-391faef412b1	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 20:50:59.067142+00	
00000000-0000-0000-0000-000000000000	ceec0987-cd48-4e90-9956-24b9b20d5983	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 20:50:59.071711+00	
00000000-0000-0000-0000-000000000000	0f27515b-0c73-4abd-a2fa-616b552ea111	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 21:01:23.096035+00	
00000000-0000-0000-0000-000000000000	9dc0f0ab-883a-4b05-af08-92fc78113a22	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-02-25 21:14:07.821243+00	
00000000-0000-0000-0000-000000000000	7739ca33-4ec9-4550-a533-3cacfb58d8b0	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 22:29:46.118704+00	
00000000-0000-0000-0000-000000000000	fdf85231-e546-419a-a153-892cdbd96659	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 22:29:46.123743+00	
00000000-0000-0000-0000-000000000000	543e1d7a-ae89-4001-8a2c-0f37f29b37ac	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 23:27:53.470581+00	
00000000-0000-0000-0000-000000000000	34fe6424-47a7-4313-984b-c07d1c8411e6	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-25 23:27:53.47871+00	
00000000-0000-0000-0000-000000000000	dad95799-0532-4bf4-94fd-753406af066c	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 04:17:39.957629+00	
00000000-0000-0000-0000-000000000000	7f98f0df-bbe8-4f03-8f1d-0c9fb6258cb5	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 04:17:39.95869+00	
00000000-0000-0000-0000-000000000000	27d65547-89e4-4b0b-b423-81d3f7c513a3	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 17:35:20.234306+00	
00000000-0000-0000-0000-000000000000	7b7574b2-0180-42b0-a034-271c448631ab	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 17:35:20.254609+00	
00000000-0000-0000-0000-000000000000	7f2f65c9-d4e5-4d91-a420-f8d7effe6c66	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 20:27:38.883752+00	
00000000-0000-0000-0000-000000000000	25e07532-b37b-4f25-bc4a-d89e5099fad8	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 20:27:38.887476+00	
00000000-0000-0000-0000-000000000000	f5398098-9a6e-43b4-ac3e-75028a89cfa2	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 21:27:01.463979+00	
00000000-0000-0000-0000-000000000000	de8b6d3e-9209-40cb-887e-68bc7b71d61d	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 21:27:01.470493+00	
00000000-0000-0000-0000-000000000000	d9d6f483-b0bf-4eb2-bdb7-110a2f3d67d2	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 22:25:09.979218+00	
00000000-0000-0000-0000-000000000000	56282f40-7b27-495f-be9b-36849e4bcf65	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 22:25:09.98184+00	
00000000-0000-0000-0000-000000000000	4a1d0653-4080-4ff0-b4d2-d9e03388ca74	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 23:23:29.372438+00	
00000000-0000-0000-0000-000000000000	659b3085-b687-41db-84c9-0990b7f7373d	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-02-26 23:23:29.374591+00	
00000000-0000-0000-0000-000000000000	33555f9d-2e62-41c7-8eb7-3acd375e3437	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 02:25:59.590104+00	
00000000-0000-0000-0000-000000000000	877955b9-6408-4ce3-b1a2-378407e6f057	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 02:25:59.604853+00	
00000000-0000-0000-0000-000000000000	8135a6d4-2799-4da2-9032-3d572deae1a9	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 03:24:46.868488+00	
00000000-0000-0000-0000-000000000000	6c73e307-d313-4596-bf2d-bf618c194f7c	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-26 03:24:46.879797+00	
00000000-0000-0000-0000-000000000000	4cb5aa53-f9fd-4137-8913-0c1ab4b98adf	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-29 18:34:17.937649+00	
00000000-0000-0000-0000-000000000000	4e2eab18-6030-4fa5-b87a-8ad8110dab4f	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-29 18:34:17.953235+00	
00000000-0000-0000-0000-000000000000	9125d5c6-d360-48f8-ac5d-cd0218256a93	{"action":"token_refreshed","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-29 20:37:33.481276+00	
00000000-0000-0000-0000-000000000000	35f292ab-4b2f-4b98-8c1d-298bf5090a00	{"action":"token_revoked","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"token"}	2025-03-29 20:37:33.483148+00	
00000000-0000-0000-0000-000000000000	0c977440-5803-4ddd-94e8-01cd8777407c	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-29 21:15:03.73607+00	
00000000-0000-0000-0000-000000000000	e8ed698f-68fe-42bc-b2d1-9ed2316f6be6	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-29 21:19:24.962842+00	
00000000-0000-0000-0000-000000000000	1a1d95e2-cac9-4420-80de-63a89fbcdbd0	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-29 21:32:04.13388+00	
00000000-0000-0000-0000-000000000000	0996165d-0932-4b8a-bfa0-cf98138ccbb6	{"action":"logout","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account"}	2025-03-29 22:00:21.590281+00	
00000000-0000-0000-0000-000000000000	cfdf3118-6115-401b-b577-18277ebec11b	{"action":"user_signedup","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-29 22:02:43.504544+00	
00000000-0000-0000-0000-000000000000	a160649f-41b2-4ebc-b641-06557f0a45a9	{"action":"login","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"google"}}	2025-03-29 22:02:44.114973+00	
00000000-0000-0000-0000-000000000000	925715f9-4e76-49dc-a850-ee2ea907b794	{"action":"login","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"account","traits":{"provider":"google"}}	2025-03-29 22:12:21.942912+00	
00000000-0000-0000-0000-000000000000	47cf8347-6a40-43e4-832b-35f0a0bea5b8	{"action":"login","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"google"}}	2025-03-29 22:12:22.288827+00	
00000000-0000-0000-0000-000000000000	10d364ca-b158-4e5f-aba5-4a17bc7e5fd3	{"action":"user_confirmation_requested","actor_id":"92d9135e-ec3e-4f90-a3b8-2dcdafe0549b","actor_username":"angelagrewal4@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}	2025-03-29 23:00:40.350009+00	
00000000-0000-0000-0000-000000000000	713bd1a2-fbc3-43b1-8e28-d67af1c82d75	{"action":"user_signedup","actor_id":"92d9135e-ec3e-4f90-a3b8-2dcdafe0549b","actor_username":"angelagrewal4@gmail.com","actor_via_sso":false,"log_type":"team"}	2025-03-29 23:00:53.666053+00	
00000000-0000-0000-0000-000000000000	c598f255-4ff4-4159-8af5-9c9df1df1be7	{"action":"login","actor_id":"92d9135e-ec3e-4f90-a3b8-2dcdafe0549b","actor_username":"angelagrewal4@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"email"}}	2025-03-29 23:00:54.652906+00	
00000000-0000-0000-0000-000000000000	2d6cad3e-8065-4de3-85c3-675eeed59dd3	{"action":"token_refreshed","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-29 23:08:41.827685+00	
00000000-0000-0000-0000-000000000000	d6b1b615-f49d-4ae8-8ce9-c2bf4c01a51c	{"action":"token_revoked","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-29 23:08:41.83138+00	
00000000-0000-0000-0000-000000000000	a184498b-c93f-41e9-9bfd-abc86c6e0c36	{"action":"token_refreshed","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-30 01:20:37.10703+00	
00000000-0000-0000-0000-000000000000	c468e9af-9ef1-461b-9aac-f1f841b8e4f4	{"action":"token_revoked","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-30 01:20:37.110522+00	
00000000-0000-0000-0000-000000000000	ae765bb4-e028-435c-97a8-ccf6ed9819f9	{"action":"token_refreshed","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 13:35:36.140911+00	
00000000-0000-0000-0000-000000000000	dd0e2c3f-a1d8-40be-91e9-2cff359920f0	{"action":"token_revoked","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 13:35:36.155291+00	
00000000-0000-0000-0000-000000000000	6d1f62ac-0abd-4e53-bce3-12d1882d9766	{"action":"user_signedup","actor_id":"93e8ebcd-3b87-4278-b72f-c021efdbf182","actor_name":"sophia","actor_username":"sophia.wiggins14@gmail.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-31 13:45:12.794121+00	
00000000-0000-0000-0000-000000000000	5030175f-5a13-4f26-8d71-8a33abaa72ca	{"action":"login","actor_id":"93e8ebcd-3b87-4278-b72f-c021efdbf182","actor_name":"sophia","actor_username":"sophia.wiggins14@gmail.com","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"google"}}	2025-03-31 13:45:14.166804+00	
00000000-0000-0000-0000-000000000000	d0e5a3e1-346b-48f9-afc9-d55302596319	{"action":"login","actor_id":"6cee78c7-9138-4dc2-8b5c-a8557eb9a082","actor_name":"Nicolas Rebollo","actor_username":"rebollo.nicolas@yahoo.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}	2025-03-31 14:02:43.758157+00	
00000000-0000-0000-0000-000000000000	16090be9-2116-42d0-8d2c-bcc156697a3c	{"action":"token_refreshed","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 14:49:34.001239+00	
00000000-0000-0000-0000-000000000000	c005ce52-ff2b-4bbc-8675-5f198df7cf07	{"action":"token_revoked","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 14:49:34.004033+00	
00000000-0000-0000-0000-000000000000	41a73d12-3762-4cdf-9293-5ff80ef29f07	{"action":"token_refreshed","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 19:15:11.009+00	
00000000-0000-0000-0000-000000000000	7d68b55c-d465-4d76-b3fe-40c4733a7962	{"action":"token_revoked","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 19:15:11.012895+00	
00000000-0000-0000-0000-000000000000	e9a94190-a078-462f-8b25-63cc3d0ce176	{"action":"user_signedup","actor_id":"e3dbd976-4fce-480c-a5ef-ab9614259930","actor_name":"Rafael III Germinal","actor_username":"rgerminal@torontomu.ca","actor_via_sso":false,"log_type":"team","traits":{"provider":"google"}}	2025-03-31 22:13:14.530362+00	
00000000-0000-0000-0000-000000000000	fd0bf7a7-c473-4f56-87b2-fc4ced07e74e	{"action":"login","actor_id":"e3dbd976-4fce-480c-a5ef-ab9614259930","actor_name":"Rafael III Germinal","actor_username":"rgerminal@torontomu.ca","actor_via_sso":false,"log_type":"account","traits":{"provider_type":"google"}}	2025-03-31 22:13:14.976644+00	
00000000-0000-0000-0000-000000000000	c9d7d15f-ff51-4ecb-933d-c52b402879bd	{"action":"token_refreshed","actor_id":"e3dbd976-4fce-480c-a5ef-ab9614259930","actor_name":"Rafael III Germinal","actor_username":"rgerminal@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 23:28:08.484682+00	
00000000-0000-0000-0000-000000000000	1db4b24a-4a77-49b0-85a5-bb0a8349cb4f	{"action":"token_revoked","actor_id":"e3dbd976-4fce-480c-a5ef-ab9614259930","actor_name":"Rafael III Germinal","actor_username":"rgerminal@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-03-31 23:28:08.487961+00	
00000000-0000-0000-0000-000000000000	5149ff8f-9c30-4bcc-b1d5-4cfab3a1c845	{"action":"token_refreshed","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-04-01 12:32:06.197066+00	
00000000-0000-0000-0000-000000000000	56e3923c-f733-4421-8491-feafa37674d5	{"action":"token_revoked","actor_id":"8fda9421-bd57-4edc-a2ff-e56fd35ce99f","actor_name":"Javier Rebollo Canedo-Arguelles","actor_username":"javier.rebollo@torontomu.ca","actor_via_sso":false,"log_type":"token"}	2025-04-01 12:32:06.232434+00	
\.


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;
1b77e9b4-8bed-41c1-a49e-690ab66bbb68	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	d5c7ade2-f34a-465e-80f7-85c39f754ae2	s256	hAqAB_vAVIPkD9Eyf_jTjzhl5eZm0kNrHw6-xCbsJXU	email			2025-02-12 16:24:45.243052+00	2025-02-12 16:27:34.052401+00	email/signup	2025-02-12 16:27:34.05236+00
36b7c12e-1187-4895-ae4a-cf57dcffd5ad	\N	e97175b9-8dc8-462c-a9a3-3bd34eff2a19	s256	TweoKwziBAS7gl_MeWu--FHwazGZNZaOBQUjlr8z7kg	google			2025-02-12 22:48:55.685707+00	2025-02-12 22:48:55.685707+00	oauth	\N
08b89ded-bd9c-4e9a-ae1d-b38d2ca84642	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	33d84449-d6cd-4488-aee2-3d76a286acfc	s256	mktVAZz52GydYWJ6s7ALW6xxUeBJLpOgdjTS_yENMdA	google	ya29.a0AeXRPp4Ij554Ctu1WWTM3jjiQhAiN_06zlkRDl4X2_FdsJ09-Cw3ziFDckqs_HJCn4OfESVaGwwGgxI7vtpOCius3EE1kX7XyYPbGfoPKFgqf88DMVplRrSK3Pf86pdQ4hAr8UVDSR50m8R-AGqmDKc4MsTutG7H4BJL-eV0YdsaCgYKASYSARMSFQHGX2MiobGV2Vd_EKyXTEIcoLpYIQ0178		2025-03-29 21:14:59.939561+00	2025-03-29 21:15:03.740118+00	oauth	2025-03-29 21:15:03.740059+00
11e080b9-eece-4814-81fe-363604aab1eb	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	ac39fcb5-0309-4602-8145-14522833f5b8	s256	HlVLtynsA2-14OcFE5q7IMuVocZTEKKa4OUdfHaCka0	google	ya29.a0AeXRPp5mFlG3N47q2beBXBVpSyFkJ4xz-KcijU8HuSPPnry5S24hhxIRRU-rlgTRcOPxjzszpdmYhg9WdwubFfmlmZuETkMB3grs3uId3_fMySodEojYBISPtLoPSK0N55_w_OWubNX05QtNJAwOO5_mKKLIBrdM0m1nNUwR2s8aCgYKAW0SARMSFQHGX2Mia4i7_oc1QxRU14xVepc53w0178		2025-03-29 21:19:22.468367+00	2025-03-29 21:19:24.965468+00	oauth	2025-03-29 21:19:24.96542+00
8d5bb60f-6869-45c9-957c-d43dde56117f	\N	5c65a7a1-379b-4670-afe4-a1fa5a3065b6	s256	YkQSL4AVFtZpVNl3SjqMT2_36uDFbvQ6AlgZe-ZIUHE	google			2025-03-31 22:13:05.089239+00	2025-03-31 22:13:05.089239+00	oauth	\N
\.


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;
6cee78c7-9138-4dc2-8b5c-a8557eb9a082	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{"sub": "6cee78c7-9138-4dc2-8b5c-a8557eb9a082", "email": "rebollo.nicolas@yahoo.com", "email_verified": true, "phone_verified": false}	email	2025-02-12 16:24:45.218103+00	2025-02-12 16:24:45.218182+00	2025-02-12 16:24:45.218182+00	88112c21-67c4-44cf-ac1b-3e7f1d9b8e71
103585168	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{"iss": "https://api.github.com", "sub": "103585168", "name": "Nicolas Rebollo", "email": "rebollo.nicolas@yahoo.com", "full_name": "Nicolas Rebollo", "user_name": "nickcanedo", "avatar_url": "https://avatars.githubusercontent.com/u/103585168?v=4", "provider_id": "103585168", "email_verified": true, "phone_verified": false, "preferred_username": "nickcanedo"}	github	2025-02-12 17:06:16.113471+00	2025-02-12 17:06:16.113528+00	2025-02-12 17:06:16.113528+00	df479284-305e-441f-b46f-3cf918798535
106788197976840967841	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{"iss": "https://accounts.google.com", "sub": "106788197976840967841", "name": "Nicolas Rebollo", "email": "rebollo.nicolas@yahoo.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocK0dhGlROJNJAeAA6Q6YSvOxZVy6ntnLFvE0NfFH9tRDFnuMw=s96-c", "full_name": "Nicolas Rebollo", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocK0dhGlROJNJAeAA6Q6YSvOxZVy6ntnLFvE0NfFH9tRDFnuMw=s96-c", "provider_id": "106788197976840967841", "email_verified": true, "phone_verified": false}	google	2025-02-12 17:04:01.17254+00	2025-02-12 17:04:01.172597+00	2025-03-29 21:19:24.957033+00	c09906df-8bdd-4561-a6e7-5714823b3bd1
113659753912014151475	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	{"iss": "https://accounts.google.com", "sub": "113659753912014151475", "name": "Javier Rebollo Canedo-Arguelles", "email": "javier.rebollo@torontomu.ca", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIOsYgo5OBOASA1rJ7935X5UrTSW3xYRDDA0pMK24n5ebqqAA=s96-c", "full_name": "Javier Rebollo Canedo-Arguelles", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIOsYgo5OBOASA1rJ7935X5UrTSW3xYRDDA0pMK24n5ebqqAA=s96-c", "provider_id": "113659753912014151475", "custom_claims": {"hd": "torontomu.ca"}, "email_verified": true, "phone_verified": false}	google	2025-03-29 22:02:43.500117+00	2025-03-29 22:02:43.500178+00	2025-03-29 22:12:21.938632+00	2a2ed27b-441b-47d5-9fa3-11e5c04ab6ff
92d9135e-ec3e-4f90-a3b8-2dcdafe0549b	92d9135e-ec3e-4f90-a3b8-2dcdafe0549b	{"sub": "92d9135e-ec3e-4f90-a3b8-2dcdafe0549b", "email": "angelagrewal4@gmail.com", "email_verified": true, "phone_verified": false}	email	2025-03-29 23:00:40.345789+00	2025-03-29 23:00:40.345838+00	2025-03-29 23:00:40.345838+00	6fa8539e-c4b9-4997-b54c-89f6b61d2a30
109595175426545431832	93e8ebcd-3b87-4278-b72f-c021efdbf182	{"iss": "https://accounts.google.com", "sub": "109595175426545431832", "name": "sophia", "email": "sophia.wiggins14@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIEglDj7iJdp1BbuVylQCN9miGno_OamUrTdFJJBBfUmkmfuSM=s96-c", "full_name": "sophia", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIEglDj7iJdp1BbuVylQCN9miGno_OamUrTdFJJBBfUmkmfuSM=s96-c", "provider_id": "109595175426545431832", "email_verified": true, "phone_verified": false}	google	2025-03-31 13:45:12.788495+00	2025-03-31 13:45:12.788546+00	2025-03-31 13:45:12.788546+00	33d0b7b7-8cb0-4e20-884a-1d85fd4b2e6f
118338792337472149298	e3dbd976-4fce-480c-a5ef-ab9614259930	{"iss": "https://accounts.google.com", "sub": "118338792337472149298", "name": "Rafael III Germinal", "email": "rgerminal@torontomu.ca", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLN6HwzsJcJNExac6CoCu_o1o2h49QOYOwZZzjNXsN90Utqig=s96-c", "full_name": "Rafael III Germinal", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocLN6HwzsJcJNExac6CoCu_o1o2h49QOYOwZZzjNXsN90Utqig=s96-c", "provider_id": "118338792337472149298", "custom_claims": {"hd": "torontomu.ca"}, "email_verified": true, "phone_verified": false}	google	2025-03-31 22:13:14.525976+00	2025-03-31 22:13:14.526023+00	2025-03-31 22:13:14.526023+00	71564f6c-153a-4215-8dcc-6bf4fee2dc95
\.


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;
74aa54a2-b191-42d0-8cfa-0a0331edb63a	2025-03-29 22:02:44.123771+00	2025-03-29 22:02:44.123771+00	oauth	65c63712-79de-4e6d-8b4e-9f3f2a5a5846
43396504-4f1b-45be-8ad6-a38b679fe840	2025-03-29 22:12:22.295453+00	2025-03-29 22:12:22.295453+00	oauth	18a71684-bcd0-4b0c-bedb-4bc121220919
41cb6dd0-64bb-4a71-89d4-1ce8f94fe3f0	2025-03-29 23:00:54.658219+00	2025-03-29 23:00:54.658219+00	email/signup	b23c8bae-708b-4ea5-86ee-133287279368
f3bbd1d3-b9d1-48c3-b32c-8d3bc741b2e9	2025-03-31 13:45:14.175517+00	2025-03-31 13:45:14.175517+00	oauth	37763cfe-6a57-41c3-84d3-23b1c8d8fe57
83365c1a-206d-4bf6-94c9-32b39f35b705	2025-03-31 14:02:43.767258+00	2025-03-31 14:02:43.767258+00	password	c17e02d5-8c16-4cb0-bacc-0a0bdde3bdcd
6d0970fb-a8c9-4153-9b4c-cd0e79e130e7	2025-03-31 22:13:14.983077+00	2025-03-31 22:13:14.983077+00	oauth	385012d5-b220-4d67-a9ec-878a6cd07c01
\.


--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;
\.


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;
\.


--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;
00000000-0000-0000-0000-000000000000	75	8JvAOYU6bIm_2hqLNaD4dg	92d9135e-ec3e-4f90-a3b8-2dcdafe0549b	f	2025-03-29 23:00:54.655104+00	2025-03-29 23:00:54.655104+00	\N	41cb6dd0-64bb-4a71-89d4-1ce8f94fe3f0
00000000-0000-0000-0000-000000000000	73	Rb1fI0HdMwiMb1VGUi0pbQ	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	t	2025-03-29 22:02:44.121202+00	2025-03-29 23:08:41.832009+00	\N	74aa54a2-b191-42d0-8cfa-0a0331edb63a
00000000-0000-0000-0000-000000000000	74	OrsbvdWs3xsiIlzTRmblWA	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	t	2025-03-29 22:12:22.290601+00	2025-03-30 01:20:37.111124+00	\N	43396504-4f1b-45be-8ad6-a38b679fe840
00000000-0000-0000-0000-000000000000	77	dcWgAzPsvr_CEfsROooK7A	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	f	2025-03-30 01:20:37.113319+00	2025-03-30 01:20:37.113319+00	OrsbvdWs3xsiIlzTRmblWA	43396504-4f1b-45be-8ad6-a38b679fe840
00000000-0000-0000-0000-000000000000	76	ZxRYR4x06xO-eP2F0Tt7wA	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	t	2025-03-29 23:08:41.834916+00	2025-03-31 13:35:36.15594+00	Rb1fI0HdMwiMb1VGUi0pbQ	74aa54a2-b191-42d0-8cfa-0a0331edb63a
00000000-0000-0000-0000-000000000000	79	SeTVMB0gNh9gSL4rSFH1Fw	93e8ebcd-3b87-4278-b72f-c021efdbf182	f	2025-03-31 13:45:14.17103+00	2025-03-31 13:45:14.17103+00	\N	f3bbd1d3-b9d1-48c3-b32c-8d3bc741b2e9
00000000-0000-0000-0000-000000000000	80	Rr1-zoAMgoE1-kAlCZtGOQ	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	f	2025-03-31 14:02:43.763956+00	2025-03-31 14:02:43.763956+00	\N	83365c1a-206d-4bf6-94c9-32b39f35b705
00000000-0000-0000-0000-000000000000	78	_ADmNPy2gOeprZhTieskxQ	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	t	2025-03-31 13:35:36.164975+00	2025-03-31 14:49:34.004719+00	ZxRYR4x06xO-eP2F0Tt7wA	74aa54a2-b191-42d0-8cfa-0a0331edb63a
00000000-0000-0000-0000-000000000000	81	2d5f5sCyjWGmzTGl0iX9zw	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	t	2025-03-31 14:49:34.006858+00	2025-03-31 19:15:11.01354+00	_ADmNPy2gOeprZhTieskxQ	74aa54a2-b191-42d0-8cfa-0a0331edb63a
00000000-0000-0000-0000-000000000000	83	WM8AYnml9UbggXE_MfLiyQ	e3dbd976-4fce-480c-a5ef-ab9614259930	t	2025-03-31 22:13:14.9795+00	2025-03-31 23:28:08.488772+00	\N	6d0970fb-a8c9-4153-9b4c-cd0e79e130e7
00000000-0000-0000-0000-000000000000	84	TQD4Xy-vm8zRNyBpAnWt9w	e3dbd976-4fce-480c-a5ef-ab9614259930	f	2025-03-31 23:28:08.491979+00	2025-03-31 23:28:08.491979+00	WM8AYnml9UbggXE_MfLiyQ	6d0970fb-a8c9-4153-9b4c-cd0e79e130e7
00000000-0000-0000-0000-000000000000	82	fQNF0jN8hH7qElW7mfXa9w	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	t	2025-03-31 19:15:11.015563+00	2025-04-01 12:32:06.233801+00	2d5f5sCyjWGmzTGl0iX9zw	74aa54a2-b191-42d0-8cfa-0a0331edb63a
00000000-0000-0000-0000-000000000000	85	c4ac9-AECJYdBM7EmWg5Bg	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	f	2025-04-01 12:32:06.244042+00	2025-04-01 12:32:06.244042+00	fQNF0jN8hH7qElW7mfXa9w	74aa54a2-b191-42d0-8cfa-0a0331edb63a
\.


--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;
\.


--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.schema_migrations (version) FROM stdin;
20171026211738
20171026211808
20171026211834
20180103212743
20180108183307
20180119214651
20180125194653
00
20210710035447
20210722035447
20210730183235
20210909172000
20210927181326
20211122151130
20211124214934
20211202183645
20220114185221
20220114185340
20220224000811
20220323170000
20220429102000
20220531120530
20220614074223
20220811173540
20221003041349
20221003041400
20221011041400
20221020193600
20221021073300
20221021082433
20221027105023
20221114143122
20221114143410
20221125140132
20221208132122
20221215195500
20221215195800
20221215195900
20230116124310
20230116124412
20230131181311
20230322519590
20230402418590
20230411005111
20230508135423
20230523124323
20230818113222
20230914180801
20231027141322
20231114161723
20231117164230
20240115144230
20240214120130
20240306115329
20240314092811
20240427152123
20240612123726
20240729123726
20240802193726
20240806073726
20241009103726
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;
41cb6dd0-64bb-4a71-89d4-1ce8f94fe3f0	92d9135e-ec3e-4f90-a3b8-2dcdafe0549b	2025-03-29 23:00:54.653551+00	2025-03-29 23:00:54.653551+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	136.143.215.176	\N
43396504-4f1b-45be-8ad6-a38b679fe840	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	2025-03-29 22:12:22.289428+00	2025-03-30 01:20:37.119198+00	\N	aal1	\N	2025-03-30 01:20:37.119108	Mozilla/5.0 (iPhone; CPU iPhone OS 18_1_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.1.1 Mobile/15E148 Safari/604.1	184.151.190.162	\N
f3bbd1d3-b9d1-48c3-b32c-8d3bc741b2e9	93e8ebcd-3b87-4278-b72f-c021efdbf182	2025-03-31 13:45:14.167418+00	2025-03-31 13:45:14.167418+00	\N	aal1	\N	\N	Mozilla/5.0 (iPhone; CPU iPhone OS 18_3_2 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.3.1 Mobile/15E148 Safari/604.1	104.28.28.42	\N
83365c1a-206d-4bf6-94c9-32b39f35b705	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-03-31 14:02:43.761648+00	2025-03-31 14:02:43.761648+00	\N	aal1	\N	\N	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	99.240.142.133	\N
6d0970fb-a8c9-4153-9b4c-cd0e79e130e7	e3dbd976-4fce-480c-a5ef-ab9614259930	2025-03-31 22:13:14.977203+00	2025-03-31 23:28:08.495244+00	\N	aal1	\N	2025-03-31 23:28:08.495177	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36 Edg/134.0.0.0	142.198.217.93	\N
74aa54a2-b191-42d0-8cfa-0a0331edb63a	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	2025-03-29 22:02:44.119515+00	2025-04-01 12:32:06.261708+00	\N	aal1	\N	2025-04-01 12:32:06.261602	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/134.0.0.0 Safari/537.36	99.240.142.133	\N
\.


--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;
00000000-0000-0000-0000-000000000000	8fda9421-bd57-4edc-a2ff-e56fd35ce99f	authenticated	authenticated	javier.rebollo@torontomu.ca	\N	2025-03-29 22:02:43.506704+00	\N		\N		\N			\N	2025-03-29 22:12:22.28934+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "113659753912014151475", "name": "Javier Rebollo Canedo-Arguelles", "email": "javier.rebollo@torontomu.ca", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIOsYgo5OBOASA1rJ7935X5UrTSW3xYRDDA0pMK24n5ebqqAA=s96-c", "full_name": "Javier Rebollo Canedo-Arguelles", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIOsYgo5OBOASA1rJ7935X5UrTSW3xYRDDA0pMK24n5ebqqAA=s96-c", "provider_id": "113659753912014151475", "custom_claims": {"hd": "torontomu.ca"}, "email_verified": true, "phone_verified": false}	\N	2025-03-29 22:02:43.491973+00	2025-04-01 12:32:06.249238+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	92d9135e-ec3e-4f90-a3b8-2dcdafe0549b	authenticated	authenticated	angelagrewal4@gmail.com	$2a$10$nBBHGmThyItkvSfK4h3KnuQnoqhCOuxB2r8/mUBdBIC9a/rGFgOVC	2025-03-29 23:00:53.666616+00	\N		2025-03-29 23:00:40.352422+00		\N			\N	2025-03-29 23:00:54.653475+00	{"provider": "email", "providers": ["email"]}	{"sub": "92d9135e-ec3e-4f90-a3b8-2dcdafe0549b", "email": "angelagrewal4@gmail.com", "email_verified": true, "phone_verified": false}	\N	2025-03-29 23:00:40.340603+00	2025-03-29 23:00:54.657684+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	authenticated	authenticated	rebollo.nicolas@yahoo.com	$2a$10$c92FoMPlxj67gIdo10ReKuONO3GWWPZeXdcMMJQwy0GTVZiX1UvN6	2025-02-12 16:27:34.042488+00	\N		2025-02-12 16:24:45.254498+00		\N			\N	2025-03-31 14:02:43.761565+00	{"provider": "email", "providers": ["email", "google", "github"]}	{"iss": "https://accounts.google.com", "sub": "106788197976840967841", "name": "Nicolas Rebollo", "email": "rebollo.nicolas@yahoo.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocK0dhGlROJNJAeAA6Q6YSvOxZVy6ntnLFvE0NfFH9tRDFnuMw=s96-c", "full_name": "Nicolas Rebollo", "user_name": "nickcanedo", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocK0dhGlROJNJAeAA6Q6YSvOxZVy6ntnLFvE0NfFH9tRDFnuMw=s96-c", "provider_id": "106788197976840967841", "email_verified": true, "phone_verified": false, "preferred_username": "nickcanedo"}	\N	2025-02-12 16:24:45.177306+00	2025-03-31 14:02:43.766642+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	93e8ebcd-3b87-4278-b72f-c021efdbf182	authenticated	authenticated	sophia.wiggins14@gmail.com	\N	2025-03-31 13:45:12.796818+00	\N		\N		\N			\N	2025-03-31 13:45:14.167348+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "109595175426545431832", "name": "sophia", "email": "sophia.wiggins14@gmail.com", "picture": "https://lh3.googleusercontent.com/a/ACg8ocIEglDj7iJdp1BbuVylQCN9miGno_OamUrTdFJJBBfUmkmfuSM=s96-c", "full_name": "sophia", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocIEglDj7iJdp1BbuVylQCN9miGno_OamUrTdFJJBBfUmkmfuSM=s96-c", "provider_id": "109595175426545431832", "email_verified": true, "phone_verified": false}	\N	2025-03-31 13:45:12.771486+00	2025-03-31 13:45:14.175018+00	\N	\N			\N		0	\N		\N	f	\N	f
00000000-0000-0000-0000-000000000000	e3dbd976-4fce-480c-a5ef-ab9614259930	authenticated	authenticated	rgerminal@torontomu.ca	\N	2025-03-31 22:13:14.532244+00	\N		\N		\N			\N	2025-03-31 22:13:14.97714+00	{"provider": "google", "providers": ["google"]}	{"iss": "https://accounts.google.com", "sub": "118338792337472149298", "name": "Rafael III Germinal", "email": "rgerminal@torontomu.ca", "picture": "https://lh3.googleusercontent.com/a/ACg8ocLN6HwzsJcJNExac6CoCu_o1o2h49QOYOwZZzjNXsN90Utqig=s96-c", "full_name": "Rafael III Germinal", "avatar_url": "https://lh3.googleusercontent.com/a/ACg8ocLN6HwzsJcJNExac6CoCu_o1o2h49QOYOwZZzjNXsN90Utqig=s96-c", "provider_id": "118338792337472149298", "custom_claims": {"hd": "torontomu.ca"}, "email_verified": true, "phone_verified": false}	\N	2025-03-31 22:13:14.517773+00	2025-03-31 23:28:08.493219+00	\N	\N			\N		0	\N		\N	f	\N	f
\.


--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--

COPY pgsodium.key (id, status, created, expires, key_type, key_id, key_context, name, associated_data, raw_key, raw_key_nonce, parent_key, comment, user_data) FROM stdin;
\.


--
-- Data for Name: calendar_events; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.calendar_events (id, user_id, profile_id, title, description, start_time, end_time, created_at, updated_at, all_day) FROM stdin;
fc2bf69b-02c9-47c0-a670-deee11fc629c	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	4	Test	Test	2025-02-13 23:00:00+00	2025-02-14 00:00:00+00	2025-02-14 03:14:20.625346+00	2025-02-14 03:14:20.625346+00	f
e53f69cb-3409-445e-b06b-7e57ccbcd140	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	7	Code AI App	Learning AI	2025-02-13 22:00:00+00	2025-02-14 00:00:00+00	2025-02-14 03:16:55.065301+00	2025-02-14 03:16:55.065301+00	f
92834dd2-972e-456a-936c-15a5bb125d70	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	4	Work		2025-02-13 20:00:00+00	2025-02-13 21:00:00+00	2025-02-14 04:01:19.17378+00	2025-02-14 04:01:19.17378+00	f
4ea343a0-cdc4-4207-83ab-78d5319cdde5	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	5	Work V2		2025-02-14 01:00:00+00	2025-02-14 02:00:00+00	2025-02-14 04:01:46.461996+00	2025-02-14 04:01:46.461996+00	f
e48c14a1-27c5-4495-88b2-a943af7a4b85	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	4	Work		2025-02-14 20:00:00+00	2025-02-14 21:00:00+00	2025-02-14 04:01:55.781573+00	2025-02-14 04:01:55.781573+00	f
7f93b862-6eb7-4df7-a9df-4caaa02bcacc	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	5	Pick up passport!	Test	2025-02-13 17:00:00+00	2025-02-13 19:00:00+00	2025-02-13 21:27:22.779424+00	2025-02-13 21:27:22.779424+00	f
ec2ef59f-7a45-432a-ab0f-d5f54cb59f30	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	5	Walk		2025-02-14 21:00:00+00	2025-02-14 22:00:00+00	2025-02-14 04:08:50.636128+00	2025-02-14 04:08:50.636128+00	f
d8e3f186-6d8c-493d-a7cf-352d88124608	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	5	Call Mom		2025-02-14 22:00:00+00	2025-02-14 23:00:00+00	2025-02-14 04:11:29.661607+00	2025-02-14 04:11:29.661607+00	f
01ba15eb-86f7-41b5-aec7-4f40feac406b	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	5	Call Mom		2025-02-15 21:00:00+00	2025-02-15 21:30:00+00	2025-02-14 04:13:49.828918+00	2025-02-14 04:13:49.828918+00	f
a15c7902-467c-4213-b008-fa71e0bccdfd	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	7	Basketball Game		2025-02-16 11:00:00+00	2025-02-16 13:00:00+00	2025-02-14 04:25:22.806707+00	2025-02-14 04:25:22.806707+00	f
d671233a-90e8-41bc-90fe-fe9068a6a05e	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	11	Work		2025-02-27 10:00:00+00	2025-02-27 16:00:00+00	2025-02-26 22:51:13.46767+00	2025-02-26 22:51:13.46767+00	f
1e67c1ad-2a4d-4dca-8258-b05e54a6d1ee	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	11	Workout #1		2025-03-30 10:30:00+00	2025-03-30 13:00:00+00	2025-03-29 21:36:05.109193+00	2025-03-29 21:36:05.109193+00	f
\.


--
-- Data for Name: cleared_notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cleared_notifications (id, user_id, event_id, cleared_at) FROM stdin;
1	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	fc2bf69b-02c9-47c0-a670-deee11fc629c	2025-02-14 03:24:17.122774+00
2	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	e53f69cb-3409-445e-b06b-7e57ccbcd140	2025-02-14 03:24:21.87445+00
3	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	7f93b862-6eb7-4df7-a9df-4caaa02bcacc	2025-02-14 03:24:22.683017+00
8	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	e48c14a1-27c5-4495-88b2-a943af7a4b85	2025-02-14 04:03:08.355097+00
10	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	d671233a-90e8-41bc-90fe-fe9068a6a05e	2025-02-26 22:51:26.595322+00
12	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	1e67c1ad-2a4d-4dca-8258-b05e54a6d1ee	2025-03-29 21:36:12.239663+00
\.


--
-- Data for Name: conversations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conversations (id, created_at, title, user_id) FROM stdin;
d5f8ef70-d00b-4c3f-bc5f-9a9acd86c8fa	2025-03-29 21:59:57.296582+00	Neck Rash	6cee78c7-9138-4dc2-8b5c-a8557eb9a082
e3ca3b69-ab14-4bc4-a4fc-97ae7ab3cbfc	2025-03-29 22:02:51.104855+00	New Conversation	8fda9421-bd57-4edc-a2ff-e56fd35ce99f
ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9	2025-03-29 23:00:56.722304+00	New Conversation	92d9135e-ec3e-4f90-a3b8-2dcdafe0549b
f9beb203-e762-41b5-a26c-ef608206da74	2025-03-31 13:43:38.356865+00	child #1	8fda9421-bd57-4edc-a2ff-e56fd35ce99f
8711d30f-7613-464e-8fb7-af33119fc0da	2025-03-31 13:45:49.252243+00	New Conversation	93e8ebcd-3b87-4278-b72f-c021efdbf182
6cafce18-6144-4fb7-a620-b39436807035	2025-03-31 22:13:18.305877+00	New Conversation	e3dbd976-4fce-480c-a5ef-ab9614259930
\.


--
-- Data for Name: files; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.files (id, created_at, user_id, profile_id, name, type, document_type, category, description, tags, size, url, path) FROM stdin;
009dbcd1-8d78-43fc-88dd-a7702a11abe1	2025-03-29 21:42:48.814223+00	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	11e2b9e4-3e7a-4e18-9c37-83cc525b66a3	Mount Fuji	image/jpeg	other	other	My favorite mountain	{fuji,mount,fun,white,snow}	489105	https://zlzfdxdfmxlkixbodniy.supabase.co/storage/v1/object/public/files/6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1743284568699.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1743284568699.jpg
\.


--
-- Data for Name: messages; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.messages (id, created_at, content, type, conversation_id) FROM stdin;
99d2b05c-ceea-4751-99fc-733f8e0ae90d	2025-03-29 21:59:57.362973+00	Hello! I'm your AI assistant. How can I help you today?	assistant	d5f8ef70-d00b-4c3f-bc5f-9a9acd86c8fa
726f26ae-af98-4c55-86c3-04dd5f8e373a	2025-03-29 22:00:06.805905+00	Hi I have a neck rash, please help!	user	d5f8ef70-d00b-4c3f-bc5f-9a9acd86c8fa
54175573-017c-44ab-851d-c2f2c855b69f	2025-03-29 22:00:11.037774+00	To better assist you, I need more information about your neck rash. Here are some questions that can help narrow down the potential causes:\n\n1. **Appearance**: How does the rash look? Is it red, raised, scaly, or blistered? Are there any distinct borders?\n2. **Symptoms**: Are you experiencing any itching, burning, or pain in the area?\n3. **Duration**: How long have you had the rash?\n4. **Triggers**: Have you used any new products on your skin, such as soaps, lotions, or detergents? Have you recently changed your laundry detergent or come into contact with any new fabrics?\n5. **Medical History**: Do you have any known allergies or a history of skin conditions, such as eczema or psoriasis?\n6. **Location**: Is the rash confined to your neck, or has it spread to other areas of your body?\n7. **Accompanying Symptoms**: Are you experiencing any other symptoms, such as fever, swollen lymph nodes, or respiratory issues?\n\nWith this information, I can provide a more accurate assessment and recommend appropriate treatment options.	assistant	d5f8ef70-d00b-4c3f-bc5f-9a9acd86c8fa
d8d0e9ca-f2fa-4ba5-81ad-a7e0a84c3cf5	2025-03-29 22:02:51.197631+00	Hello! I'm your AI assistant. How can I help you today?	assistant	e3ca3b69-ab14-4bc4-a4fc-97ae7ab3cbfc
a9dcf473-17c6-4df4-aa82-689c06d4d68a	2025-03-29 22:04:32.843854+00	hi what do you do 	user	e3ca3b69-ab14-4bc4-a4fc-97ae7ab3cbfc
baf1b539-5f45-499c-bcdb-c0b3b29fae77	2025-03-29 22:04:34.971404+00	I provide detailed medical advice, diagnoses, treatment recommendations, and explanations of various medical conditions. I can discuss symptoms, preventive care, lifestyle changes, and offer insights into health improvements. How can I assist you today?	assistant	e3ca3b69-ab14-4bc4-a4fc-97ae7ab3cbfc
a64d8365-810a-4059-9296-224fd8463141	2025-03-29 23:00:56.831022+00	Hello! I'm your AI assistant. How can I help you today?	assistant	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
58bbf47c-4b77-44b4-9cfe-81643c92cc55	2025-03-29 23:01:29.266118+00	hi, i think my child has the flu	user	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
a2d8842f-0c65-4f12-ae05-00686f341082	2025-03-29 23:01:32.504893+00	I understand your concern. Influenza, commonly known as the flu, can present with a variety of symptoms. Please provide me with more details about your child's symptoms, including:\n\n1. What specific symptoms are they experiencing? (e.g., fever, cough, sore throat, body aches, fatigue, headache, chills)\n2. How long have they been experiencing these symptoms?\n3. Have they had any recent exposure to other individuals who were sick?\n4. Are there any other underlying health conditions or concerns you are aware of?\n\nWith this information, I can provide you with more specific guidance.	assistant	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
5b99b4f4-6363-4130-bb95-010117454640	2025-03-29 23:01:52.897389+00	fever, chills for 3 days 	user	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
7a750c1c-a9c5-4414-8f20-2447a9bfdfef	2025-03-29 23:01:56.776244+00	Thank you for that information. A fever and chills lasting for three days in a child can indeed be indicative of the flu, but it can also be associated with other viral or bacterial infections. Here are some considerations and recommendations:\n\n### Symptoms to Monitor:\n1. **Fever**: If the fever is high (above 102°F or 39°C), or if it persists despite treatment.\n2. **Respiratory Symptoms**: Cough, sore throat, nasal congestion, or difficulty breathing.\n3. **Gastrointestinal Symptoms**: Nausea, vomiting, or diarrhea.\n4. **Fatigue and Activity Level**: If your child seems excessively tired or lethargic.\n5. **Hydration**: Ensure they are drinking enough fluids.\n\n### Recommended Actions:\n1. **Symptomatic Treatment**:\n   - **Fever and Pain Relief**: You can administer acetaminophen (Tylenol) or ibuprofen (Advil, Motrin) for fever and body aches. Follow the dosing instructions based on your child's age and weight.\n   - **Rest**: Encourage your child to rest as much as possible.\n\n2. **Hydration**: Offer clear fluids like water, broth, or electrolyte solutions to prevent dehydration.\n\n3. **Monitoring**: Keep an eye on their symptoms. If they worsen or do not improve in a couple of days, or if they develop difficulty breathing, persistent high fever, or severe dehydration, seek medical attention.\n\n4. **Prevention of Spread**: Keep your child away from others as much as possible to prevent the spread of the virus.\n\n### When to Seek Medical Attention:\n- If the fever persists beyond 3 days.\n- If your child has difficulty breathing or persistent chest pain.\n- If they exhibit confusion or difficulty waking.\n- If there are signs of dehydration, such as dry mouth, no tears when crying, or decreased urination.\n\nIf you have access to a healthcare provider and feel it is necessary, consider consulting them for a proper evaluation and potential testing for influenza or other infections.	assistant	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
164e6c67-50c5-4fe4-a97e-2c37ac7a0b9b	2025-03-29 23:02:10.84765+00	what should i do	user	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
363a8447-ddd4-4cfb-903b-d5e0a8d2b241	2025-03-29 23:02:31.923044+00	where is the nearerst doctor	user	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
3ef9581c-d52a-43c4-b389-f70947d5b875	2025-03-29 23:02:16.855037+00	Here’s a step-by-step approach for managing your child's flu-like symptoms:\n\n### Step 1: Symptomatic Relief\n- **Fever Management**: \n  - Administer acetaminophen (Tylenol) or ibuprofen (Advil, Motrin) according to the dosing instructions appropriate for your child's age and weight. This will help reduce fever and alleviate body aches.\n  \n### Step 2: Ensure Hydration\n- **Fluids**: Encourage your child to drink plenty of fluids. Options include:\n  - Water\n  - Clear broth\n  - Oral rehydration solutions (like Pedialyte)\n  - Diluted fruit juices\n- Monitor for signs of dehydration, such as dry mouth, dizziness, or decreased urination.\n\n### Step 3: Rest\n- Ensure your child gets plenty of rest. Sleep is crucial for recovery.\n\n### Step 4: Monitor Symptoms\n- Keep track of your child’s symptoms, including:\n  - Fever: Measure temperature regularly.\n  - Respiratory symptoms: Watch for cough severity or any difficulty breathing.\n  - General condition: Note any changes in energy levels or alertness.\n\n### Step 5: Comfort Measures\n- **Environment**: Maintain a comfortable room temperature. Use a humidifier if needed to ease breathing.\n- **Nutrition**: Offer light, easily digestible foods if your child feels up to eating (e.g., toast, bananas, applesauce).\n\n### Step 6: When to Seek Medical Attention\n- **Immediate Action**: If your child develops any of the following symptoms, seek medical help promptly:\n  - Difficulty breathing or rapid breathing\n  - Persistent high fever (above 102°F or 39°C) that does not respond to treatment\n  - Signs of dehydration (e.g., little or no urination, dry mouth)\n  - Severe headache or abdominal pain\n  - Confusion or difficulty waking up\n\n### Step 7: Preventive Measures\n- Keep your child away from others to prevent spreading the illness.\n- Practice good hygiene, including frequent hand washing.\n\nIf symptoms do not improve within a few days or worsen, it is advisable to consult a healthcare provider for further evaluation and potential testing for influenza or other conditions.	assistant	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
0cbe030e-ff71-4992-8cef-9de08cd5a630	2025-03-29 23:02:35.802347+00	I don’t have access to real-time location data, so I cannot provide specific information about nearby doctors or clinics. However, you can find a nearby doctor or medical facility by:\n\n1. **Using a Search Engine**: Type "urgent care near me" or "pediatrician near me" into a search engine like Google. This will provide you with a list of nearby healthcare providers along with their ratings and hours of operation.\n\n2. **Health Insurance Provider**: If you have health insurance, check your provider’s website for a list of in-network doctors or urgent care facilities.\n\n3. **Local Health Department**: You can also contact your local health department for information on nearby healthcare services.\n\n4. **Mobile Apps**: Use health-related mobile apps that can help you locate doctors, schedule appointments, and even offer telehealth services.\n\nIf your child's symptoms are severe or concerning, consider going to the nearest urgent care or hospital emergency department for immediate assistance.	assistant	ceb5ce0b-f3fc-44a5-b4c5-8649bf59fdf9
e821b93f-ba26-4526-a8b9-afe4491d72cb	2025-03-31 13:43:38.594138+00	Hello! I'm your AI assistant. How can I help you today?	assistant	f9beb203-e762-41b5-a26c-ef608206da74
0a71c714-2e70-454f-8541-7ed0feac6c6b	2025-03-31 13:45:49.655845+00	Hello! I'm your AI assistant. How can I help you today?	assistant	8711d30f-7613-464e-8fb7-af33119fc0da
33b5a20a-e04c-4b96-bd1a-aa3e5295ad55	2025-03-31 14:49:47.044632+00	Hello! what do you do?	user	f9beb203-e762-41b5-a26c-ef608206da74
9caf35e8-9b39-44d4-990a-ed8827bb01b4	2025-03-31 14:49:50.362389+00	I provide medical advice, diagnoses, treatment recommendations, and information on various medical conditions. I can help explain symptoms, discuss preventive care, suggest lifestyle changes, and offer insights into health improvement. If you have specific questions or concerns about your health, feel free to ask!	assistant	f9beb203-e762-41b5-a26c-ef608206da74
bf1c9a0c-ec43-4140-a26a-039efda99fbd	2025-03-31 22:13:18.380704+00	Hello! I'm your AI assistant. How can I help you today?	assistant	6cafce18-6144-4fb7-a620-b39436807035
\.


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.profiles (id, created_at, user_id, name, date_of_birth, gender, height, weight, blood_type, family_role, allergies, medical_conditions, medications, image_url) FROM stdin;
11e2b9e4-3e7a-4e18-9c37-83cc525b66a3	2025-02-26 21:30:36.095+00	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	Nicolas Rebollo	1971-01-15	male	185	81.2	O-	father	\N	\N	\N	https://zlzfdxdfmxlkixbodniy.supabase.co/storage/v1/object/public/profile-images/32c9f778-fec1-4966-89b1-3cd6ea64c4fd.jpg
382b45b2-7d60-4952-a92d-403394eb2125	2025-02-26 21:31:16.188+00	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	Jane Doe	1971-05-27	female	160	65.8	AB+	mother	\N	\N	\N	https://zlzfdxdfmxlkixbodniy.supabase.co/storage/v1/object/public/profile-images/f1c7095c-d404-42b2-b356-b966e0fe7cd9.webp
349fe3a4-515c-4045-9c83-24c2349d169b	2025-02-26 21:31:52.242+00	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	Tim Doe	2009-01-28	male	168	63.5	A+	son	\N	\N	\N	https://zlzfdxdfmxlkixbodniy.supabase.co/storage/v1/object/public/profile-images/e8d515b0-c4ea-4e28-bb92-c4619ca9ac54.webp
001ee566-5fcd-4d59-af04-1413b889b28f	2025-02-26 21:32:31.874+00	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	Mary Doe	2015-04-03	female	105	40.8	B-	daughter	\N	\N	\N	https://zlzfdxdfmxlkixbodniy.supabase.co/storage/v1/object/public/profile-images/15566dff-68fd-4677-a23f-e1cef7e26d56.jpg
\.


--
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-02-12 03:42:47
20211116045059	2025-02-12 03:42:47
20211116050929	2025-02-12 03:42:47
20211116051442	2025-02-12 03:42:47
20211116212300	2025-02-12 03:42:47
20211116213355	2025-02-12 03:42:48
20211116213934	2025-02-12 03:42:48
20211116214523	2025-02-12 03:42:48
20211122062447	2025-02-12 03:42:48
20211124070109	2025-02-12 03:42:48
20211202204204	2025-02-12 03:42:48
20211202204605	2025-02-12 03:42:49
20211210212804	2025-02-12 03:42:49
20211228014915	2025-02-12 03:42:49
20220107221237	2025-02-12 03:42:49
20220228202821	2025-02-12 03:42:50
20220312004840	2025-02-12 03:42:50
20220603231003	2025-02-12 03:42:50
20220603232444	2025-02-12 03:42:50
20220615214548	2025-02-12 03:42:50
20220712093339	2025-02-12 03:42:50
20220908172859	2025-02-12 03:42:51
20220916233421	2025-02-12 03:42:51
20230119133233	2025-02-12 03:42:51
20230128025114	2025-02-12 03:42:51
20230128025212	2025-02-12 03:42:51
20230227211149	2025-02-12 03:42:51
20230228184745	2025-02-12 03:42:52
20230308225145	2025-02-12 03:42:52
20230328144023	2025-02-12 03:42:52
20231018144023	2025-02-12 03:42:52
20231204144023	2025-02-12 03:42:52
20231204144024	2025-02-12 03:42:52
20231204144025	2025-02-12 03:42:53
20240108234812	2025-02-12 03:42:53
20240109165339	2025-02-12 03:42:53
20240227174441	2025-02-12 03:42:53
20240311171622	2025-02-12 03:42:53
20240321100241	2025-02-12 03:42:54
20240401105812	2025-02-12 03:42:54
20240418121054	2025-02-12 03:42:54
20240523004032	2025-02-12 03:42:55
20240618124746	2025-02-12 03:42:55
20240801235015	2025-02-12 03:42:55
20240805133720	2025-02-12 03:42:55
20240827160934	2025-02-12 03:42:56
20240919163303	2025-02-12 03:42:56
20240919163305	2025-02-12 03:42:56
20241019105805	2025-02-12 03:42:56
20241030150047	2025-02-12 03:42:57
20241108114728	2025-02-12 03:42:57
20241121104152	2025-02-12 03:42:57
20241130184212	2025-02-12 03:42:57
20241220035512	2025-02-12 03:42:57
20241220123912	2025-02-12 03:42:57
20241224161212	2025-02-12 03:42:58
20250107150512	2025-02-12 03:42:58
20250110162412	2025-02-12 03:42:58
20250123174212	2025-02-12 03:42:58
20250128220012	2025-02-12 03:42:58
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: supabase_admin
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;
\.


--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;
profile-images	profile-images	\N	2025-02-12 17:25:11.888338+00	2025-02-12 17:25:11.888338+00	t	f	\N	\N	\N
files	files	\N	2025-02-12 21:23:17.342286+00	2025-02-12 21:23:17.342286+00	t	f	\N	\N	\N
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-02-12 03:38:47.981609
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-02-12 03:38:48.004449
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-02-12 03:38:48.01491
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-02-12 03:38:48.048324
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-02-12 03:38:48.082742
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-02-12 03:38:48.094418
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-02-12 03:38:48.108016
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-02-12 03:38:48.120354
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-02-12 03:38:48.130586
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-02-12 03:38:48.141911
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-02-12 03:38:48.152778
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-02-12 03:38:48.165942
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-02-12 03:38:48.180754
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-02-12 03:38:48.192085
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-02-12 03:38:48.20491
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-02-12 03:38:48.243724
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-02-12 03:38:48.254782
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-02-12 03:38:48.266152
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-02-12 03:38:48.282037
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-02-12 03:38:48.29401
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-02-12 03:38:48.30615
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-02-12 03:38:48.327028
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-02-12 03:38:48.363353
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-02-12 03:38:48.396759
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-02-12 03:38:48.408166
25	custom-metadata	67eb93b7e8d401cafcdc97f9ac779e71a79bfe03	2025-02-12 03:38:48.418937
\.


--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;
42bb9b66-bd90-4565-b19d-bdecaa0c30f3	profile-images	.emptyFolderPlaceholder	\N	2025-02-12 18:34:18.914584+00	2025-02-12 18:34:18.914584+00	2025-02-12 18:34:18.914584+00	{"eTag": "\\"d41d8cd98f00b204e9800998ecf8427e\\"", "size": 0, "mimetype": "application/octet-stream", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T18:34:19.000Z", "contentLength": 0, "httpStatusCode": 200}	c19e1e84-c4b1-4c6d-aa7c-5c5a8254ef69	\N	{}
47cbc714-6664-452d-aaea-af07e8544f9f	profile-images	6215201a-310d-4767-9193-e445567aeda9.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 18:34:35.260951+00	2025-02-12 18:34:35.260951+00	2025-02-12 18:34:35.260951+00	{"eTag": "\\"aa24e77fda1ba5030055f6a4e53e684b\\"", "size": 91917, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T18:34:36.000Z", "contentLength": 91917, "httpStatusCode": 200}	6af35b8c-cb29-47fb-8ad5-8e44fec22e6e	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
82902f05-9718-44e8-9938-5f74b6afda59	profile-images	85feca3a-052c-43a8-b1f1-035c901019c4.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 18:48:17.875973+00	2025-02-12 18:48:17.875973+00	2025-02-12 18:48:17.875973+00	{"eTag": "\\"6250bb83a261f7ec4d8ee184eef51eaa\\"", "size": 113442, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T18:48:18.000Z", "contentLength": 113442, "httpStatusCode": 200}	8110ed9e-29dd-464e-b1d7-790d023d829f	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
22fc2193-a146-4319-9930-e245ee56dd65	profile-images	78642bee-1d6b-4c4d-9c82-cf03f7b197b1.webp	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 19:10:11.172551+00	2025-02-12 19:10:11.172551+00	2025-02-12 19:10:11.172551+00	{"eTag": "\\"bd6e3ed83803250b5f504eb6227bba1b\\"", "size": 22870, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T19:10:12.000Z", "contentLength": 22870, "httpStatusCode": 200}	1764ff31-bd01-48f5-8e99-7258339bc2a3	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
44cc9d14-9a1f-4ff8-87eb-86938af55d20	profile-images	a9104e69-1f0b-47e9-9def-9ba3bc50789e.webp	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 19:28:56.534517+00	2025-02-12 19:28:56.534517+00	2025-02-12 19:28:56.534517+00	{"eTag": "\\"bd6e3ed83803250b5f504eb6227bba1b\\"", "size": 22870, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T19:28:57.000Z", "contentLength": 22870, "httpStatusCode": 200}	59f42ef6-8c1b-4920-9680-68b96f449761	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
c0ff8d57-1af1-4412-8e44-8729c90fdbb2	profile-images	7d6191e2-33e7-4b40-997e-f7e1486a5749.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 19:29:03.444629+00	2025-02-12 19:29:03.444629+00	2025-02-12 19:29:03.444629+00	{"eTag": "\\"6250bb83a261f7ec4d8ee184eef51eaa\\"", "size": 113442, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T19:29:04.000Z", "contentLength": 113442, "httpStatusCode": 200}	3d729082-97bc-411a-8a77-56bd4b2777bd	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
7ebfca35-3725-4686-b840-82c6ef773393	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1739395863647.pdf	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 21:31:03.751218+00	2025-02-12 21:31:03.751218+00	2025-02-12 21:31:03.751218+00	{"eTag": "\\"0f97490e0ac75af7bce9ad4b39497674\\"", "size": 265561, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T21:31:04.000Z", "contentLength": 265561, "httpStatusCode": 200}	1f156a28-3537-4d59-bf22-299732a5d439	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
3f1c5be7-e26f-4fbe-9a99-8beb51ba533c	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1739395921275.pdf	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 21:32:01.189504+00	2025-02-12 21:32:01.189504+00	2025-02-12 21:32:01.189504+00	{"eTag": "\\"0f97490e0ac75af7bce9ad4b39497674\\"", "size": 265561, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T21:32:02.000Z", "contentLength": 265561, "httpStatusCode": 200}	b8ddccba-7aa0-415b-96f7-f226d8d400fd	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
37a7b523-78a1-4bb9-ad4e-f8acbf57e753	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1739396155602.pdf	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 21:35:55.641276+00	2025-02-12 21:35:55.641276+00	2025-02-12 21:35:55.641276+00	{"eTag": "\\"0f97490e0ac75af7bce9ad4b39497674\\"", "size": 265561, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T21:35:56.000Z", "contentLength": 265561, "httpStatusCode": 200}	8010b4e3-e966-450c-bd65-4b3932fe97da	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
fc3b96c1-8291-4f83-b53d-25e9c73bf0fe	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1739396787296.pdf	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 21:46:27.33807+00	2025-02-12 21:46:27.33807+00	2025-02-12 21:46:27.33807+00	{"eTag": "\\"0f97490e0ac75af7bce9ad4b39497674\\"", "size": 265561, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T21:46:28.000Z", "contentLength": 265561, "httpStatusCode": 200}	bf44ef42-4d9a-4525-902d-7cb93927d67e	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
0730ee2f-b318-47a0-b30e-327ac4e50ba2	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1739396965006.pdf	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 21:49:24.957654+00	2025-02-12 21:49:24.957654+00	2025-02-12 21:49:24.957654+00	{"eTag": "\\"0f97490e0ac75af7bce9ad4b39497674\\"", "size": 265561, "mimetype": "application/pdf", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T21:49:25.000Z", "contentLength": 265561, "httpStatusCode": 200}	c4f316cc-c0f0-4c41-9bc2-62dd7ce9dadb	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
bc75eb86-bf90-4866-910e-a76fa0d2de0f	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1739404067050.docx	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-12 23:47:46.800658+00	2025-02-12 23:47:46.800658+00	2025-02-12 23:47:46.800658+00	{"eTag": "\\"247e937bb12225dac69d5c042fc3bbcd\\"", "size": 128612, "mimetype": "application/vnd.openxmlformats-officedocument.wordprocessingml.document", "cacheControl": "max-age=3600", "lastModified": "2025-02-12T23:47:47.000Z", "contentLength": 128612, "httpStatusCode": 200}	a30b3ca1-52d0-4bdd-8a68-e8ade482e931	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
23e9ad8f-6c24-41ba-9ebf-1077c651cfad	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1739406410554.txt	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-13 00:26:50.427522+00	2025-02-13 00:26:50.427522+00	2025-02-13 00:26:50.427522+00	{"eTag": "\\"78831f2c7a4c46cc29ed759eeb7ac69a\\"", "size": 3259, "mimetype": "text/plain", "cacheControl": "max-age=3600", "lastModified": "2025-02-13T00:26:51.000Z", "contentLength": 3259, "httpStatusCode": 200}	b8083301-31c6-4cc9-bb42-3e6bbbcf3984	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
251b2f2a-ff4d-461a-83a5-9a7c79f2cb53	profile-images	a2de0d0b-e2b9-4f73-bc72-073d2e1d8819.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-25 20:49:51.0691+00	2025-02-25 20:49:51.0691+00	2025-02-25 20:49:51.0691+00	{"eTag": "\\"141f7e1b7df36bceea26851639518ddb\\"", "size": 206096, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-25T20:49:51.000Z", "contentLength": 206096, "httpStatusCode": 200}	f34025ff-df26-4e15-87c9-fc8b83cee25a	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
9a18aa51-9f05-468c-a2f1-80d141f6bd92	profile-images	fad16a44-c68a-44d2-a7dc-c7d3b31d7479.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-26 21:26:34.763441+00	2025-02-26 21:26:34.763441+00	2025-02-26 21:26:34.763441+00	{"eTag": "\\"d4ff10ed3de201d83d6f19f970fc748d\\"", "size": 24306, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-26T21:26:35.000Z", "contentLength": 24306, "httpStatusCode": 200}	3a076ffc-3fb9-474b-b223-4cd50565a1d2	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
4d540408-da19-473f-9427-bc5e5d740490	profile-images	32c9f778-fec1-4966-89b1-3cd6ea64c4fd.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-26 21:30:16.077005+00	2025-02-26 21:30:16.077005+00	2025-02-26 21:30:16.077005+00	{"eTag": "\\"d4ff10ed3de201d83d6f19f970fc748d\\"", "size": 24306, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-26T21:30:17.000Z", "contentLength": 24306, "httpStatusCode": 200}	42050d4b-3c21-4337-bd07-f779ee4f7e9c	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
fb1ba489-f10c-4faf-b844-734af33d988a	profile-images	f1c7095c-d404-42b2-b356-b966e0fe7cd9.webp	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-26 21:30:55.569813+00	2025-02-26 21:30:55.569813+00	2025-02-26 21:30:55.569813+00	{"eTag": "\\"01da328b921947e2c7957b40038756d1\\"", "size": 16910, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2025-02-26T21:30:56.000Z", "contentLength": 16910, "httpStatusCode": 200}	c96318e1-f788-4591-8267-9f08b9044f99	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
819c6ab4-e728-46d3-b5fb-ab307ed34e57	profile-images	e8d515b0-c4ea-4e28-bb92-c4619ca9ac54.webp	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-26 21:31:24.965998+00	2025-02-26 21:31:24.965998+00	2025-02-26 21:31:24.965998+00	{"eTag": "\\"7ccd9c3f418c359bc5ef4cf4ccc6e953\\"", "size": 63586, "mimetype": "image/webp", "cacheControl": "max-age=3600", "lastModified": "2025-02-26T21:31:25.000Z", "contentLength": 63586, "httpStatusCode": 200}	9c9a8acb-d777-4da4-8841-1475e70d36bd	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
8253395f-5c78-4555-a890-4b6b564c38f7	profile-images	15566dff-68fd-4677-a23f-e1cef7e26d56.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-02-26 21:31:57.033943+00	2025-02-26 21:31:57.033943+00	2025-02-26 21:31:57.033943+00	{"eTag": "\\"c01036a8ec1501b38d9d5eb9d6eb6d64\\"", "size": 33553, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-02-26T21:31:57.000Z", "contentLength": 33553, "httpStatusCode": 200}	d8e276bb-c175-40a2-a0fc-8bdf4c574299	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
5acffa5d-94f2-45e5-9558-0ddaa7ace7b7	profile-images	79a01185-0792-4ce5-8fea-72ae2b3dc97b.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-03-29 21:37:45.850326+00	2025-03-29 21:37:45.850326+00	2025-03-29 21:37:45.850326+00	{"eTag": "\\"ede8d7d85e9c9d37f49f57b478403b72\\"", "size": 515367, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-29T21:37:46.000Z", "contentLength": 515367, "httpStatusCode": 200}	e0e67874-27b3-4553-ba95-f5ff30dd25b9	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
303375a8-6f1f-4013-9e8d-d51461ba993a	files	6cee78c7-9138-4dc2-8b5c-a8557eb9a082/1743284568699.jpg	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	2025-03-29 21:42:48.700599+00	2025-03-29 21:42:48.700599+00	2025-03-29 21:42:48.700599+00	{"eTag": "\\"c05d4292dd578209eaa5ba82f49dfe15\\"", "size": 489105, "mimetype": "image/jpeg", "cacheControl": "max-age=3600", "lastModified": "2025-03-29T21:42:49.000Z", "contentLength": 489105, "httpStatusCode": 200}	87d195bd-e7cb-4585-b532-6cfb6979f9a6	6cee78c7-9138-4dc2-8b5c-a8557eb9a082	{}
\.


--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;
\.


--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;
\.


--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;
\.


--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 85, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('pgsodium.key_key_id_seq', 1, false);


--
-- Name: cleared_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cleared_notifications_id_seq', 12, true);


--
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: supabase_admin
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 1, false);


--
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: calendar_events calendar_events_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT calendar_events_pkey PRIMARY KEY (id);


--
-- Name: cleared_notifications cleared_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleared_notifications
    ADD CONSTRAINT cleared_notifications_pkey PRIMARY KEY (id);


--
-- Name: cleared_notifications cleared_notifications_user_id_event_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleared_notifications
    ADD CONSTRAINT cleared_notifications_user_id_event_id_key UNIQUE (user_id, event_id);


--
-- Name: conversations conversations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_pkey PRIMARY KEY (id);


--
-- Name: files files_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_admin
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: supabase_admin
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: supabase_admin
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- Name: calendar_events calendar_events_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.calendar_events
    ADD CONSTRAINT calendar_events_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: cleared_notifications cleared_notifications_event_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleared_notifications
    ADD CONSTRAINT cleared_notifications_event_id_fkey FOREIGN KEY (event_id) REFERENCES public.calendar_events(id) ON DELETE CASCADE;


--
-- Name: cleared_notifications cleared_notifications_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cleared_notifications
    ADD CONSTRAINT cleared_notifications_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id);


--
-- Name: conversations conversations_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conversations
    ADD CONSTRAINT conversations_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: files files_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(id) ON DELETE SET NULL;


--
-- Name: files files_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.files
    ADD CONSTRAINT files_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: messages messages_conversation_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.messages
    ADD CONSTRAINT messages_conversation_id_fkey FOREIGN KEY (conversation_id) REFERENCES public.conversations(id) ON DELETE CASCADE;


--
-- Name: profiles profiles_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles Users can create own profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create own profiles" ON public.profiles FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: conversations Users can create their own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can create their own conversations" ON public.conversations FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: messages Users can delete messages in their conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete messages in their conversations" ON public.messages FOR DELETE USING ((auth.uid() IN ( SELECT conversations.user_id
   FROM public.conversations
  WHERE (conversations.id = messages.conversation_id))));


--
-- Name: files Users can delete own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own files" ON public.files FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: profiles Users can delete own profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete own profiles" ON public.profiles FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: calendar_events Users can delete their own calendar events; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own calendar events" ON public.calendar_events FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: conversations Users can delete their own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can delete their own conversations" ON public.conversations FOR DELETE USING ((auth.uid() = user_id));


--
-- Name: messages Users can insert messages in their conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert messages in their conversations" ON public.messages FOR INSERT WITH CHECK ((auth.uid() IN ( SELECT conversations.user_id
   FROM public.conversations
  WHERE (conversations.id = messages.conversation_id))));


--
-- Name: files Users can insert own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert own files" ON public.files FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: calendar_events Users can insert their own calendar events; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own calendar events" ON public.calendar_events FOR INSERT WITH CHECK ((auth.uid() = user_id));


--
-- Name: cleared_notifications Users can insert their own cleared notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can insert their own cleared notifications" ON public.cleared_notifications FOR INSERT TO authenticated WITH CHECK ((auth.uid() = user_id));


--
-- Name: cleared_notifications Users can read their own cleared notifications; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can read their own cleared notifications" ON public.cleared_notifications FOR SELECT TO authenticated USING ((auth.uid() = user_id));


--
-- Name: messages Users can update messages in their conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update messages in their conversations" ON public.messages FOR UPDATE USING ((auth.uid() IN ( SELECT conversations.user_id
   FROM public.conversations
  WHERE (conversations.id = messages.conversation_id))));


--
-- Name: files Users can update own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own files" ON public.files FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: profiles Users can update own profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update own profiles" ON public.profiles FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: calendar_events Users can update their own calendar events; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own calendar events" ON public.calendar_events FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: conversations Users can update their own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can update their own conversations" ON public.conversations FOR UPDATE USING ((auth.uid() = user_id));


--
-- Name: messages Users can view messages in their conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view messages in their conversations" ON public.messages FOR SELECT USING ((auth.uid() IN ( SELECT conversations.user_id
   FROM public.conversations
  WHERE (conversations.id = messages.conversation_id))));


--
-- Name: files Users can view own files; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own files" ON public.files FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: profiles Users can view own profiles; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view own profiles" ON public.profiles FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: calendar_events Users can view their own calendar events; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own calendar events" ON public.calendar_events FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: conversations Users can view their own conversations; Type: POLICY; Schema: public; Owner: postgres
--

CREATE POLICY "Users can view their own conversations" ON public.conversations FOR SELECT USING ((auth.uid() = user_id));


--
-- Name: calendar_events; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.calendar_events ENABLE ROW LEVEL SECURITY;

--
-- Name: cleared_notifications; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.cleared_notifications ENABLE ROW LEVEL SECURITY;

--
-- Name: conversations; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.conversations ENABLE ROW LEVEL SECURITY;

--
-- Name: files; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.files ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: profiles; Type: ROW SECURITY; Schema: public; Owner: postgres
--

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

--
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- Name: objects Allow authenticated users to insert files; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated users to insert files" ON storage.objects FOR INSERT WITH CHECK ((auth.uid() IS NOT NULL));


--
-- Name: objects Allow authenticated users to upload files 1m0cqf_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Allow authenticated users to upload files 1m0cqf_0" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'files'::text) AND (auth.uid() = auth.uid())));


--
-- Name: objects Authenticated Upload vejz8c_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Authenticated Upload vejz8c_0" ON storage.objects FOR INSERT TO authenticated WITH CHECK (((bucket_id = 'profile-images'::text) AND (auth.jwt() IS NOT NULL)));


--
-- Name: objects Public Access vejz8c_0; Type: POLICY; Schema: storage; Owner: supabase_storage_admin
--

CREATE POLICY "Public Access vejz8c_0" ON storage.objects FOR SELECT TO authenticated, anon USING ((bucket_id = 'profile-images'::text));


--
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT ALL ON SCHEMA auth TO postgres;


--
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: pg_database_owner
--

GRANT USAGE ON SCHEMA public TO postgres;
GRANT USAGE ON SCHEMA public TO anon;
GRANT USAGE ON SCHEMA public TO authenticated;
GRANT USAGE ON SCHEMA public TO service_role;


--
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: supabase_admin
--

GRANT ALL ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;
GRANT ALL ON FUNCTION auth.email() TO postgres;


--
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;
GRANT ALL ON FUNCTION auth.role() TO postgres;


--
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;
GRANT ALL ON FUNCTION auth.uid() TO postgres;


--
-- Name: FUNCTION algorithm_sign(signables text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.algorithm_sign(signables text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- Name: FUNCTION sign(payload json, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.sign(payload json, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION try_cast_double(inp text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.try_cast_double(inp text) TO dashboard_user;


--
-- Name: FUNCTION url_decode(data text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_decode(data text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_decode(data text) TO dashboard_user;


--
-- Name: FUNCTION url_encode(data bytea); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.url_encode(data bytea) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- Name: FUNCTION verify(token text, secret text, algorithm text); Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.verify(token text, secret text, algorithm text) TO dashboard_user;


--
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: supabase_admin
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: supabase_admin
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- Name: FUNCTION crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_decrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea); Type: ACL; Schema: pgsodium; Owner: pgsodium_keymaker
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_encrypt(message bytea, additional bytea, key_uuid uuid, nonce bytea) TO service_role;


--
-- Name: FUNCTION crypto_aead_det_keygen(); Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT ALL ON FUNCTION pgsodium.crypto_aead_det_keygen() TO service_role;


--
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- Name: FUNCTION can_insert_object(bucketid text, name text, owner uuid, metadata jsonb); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) TO postgres;


--
-- Name: FUNCTION extension(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.extension(name text) TO postgres;


--
-- Name: FUNCTION filename(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.filename(name text) TO postgres;


--
-- Name: FUNCTION foldername(name text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.foldername(name text) TO postgres;


--
-- Name: FUNCTION get_size_by_bucket(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.get_size_by_bucket() TO postgres;


--
-- Name: FUNCTION list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) TO postgres;


--
-- Name: FUNCTION list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) TO postgres;


--
-- Name: FUNCTION operation(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.operation() TO postgres;


--
-- Name: FUNCTION search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) TO postgres;


--
-- Name: FUNCTION update_updated_at_column(); Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON FUNCTION storage.update_updated_at_column() TO postgres;


--
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO dashboard_user;


--
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO dashboard_user;


--
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO dashboard_user;


--
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO dashboard_user;


--
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.schema_migrations TO postgres;
GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO dashboard_user;


--
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO dashboard_user;


--
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO dashboard_user;


--
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- Name: TABLE decrypted_key; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.decrypted_key TO pgsodium_keyholder;


--
-- Name: TABLE masking_rule; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.masking_rule TO pgsodium_keyholder;


--
-- Name: TABLE mask_columns; Type: ACL; Schema: pgsodium; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE pgsodium.mask_columns TO pgsodium_keyholder;


--
-- Name: TABLE calendar_events; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.calendar_events TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.calendar_events TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.calendar_events TO service_role;


--
-- Name: TABLE cleared_notifications; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.cleared_notifications TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.cleared_notifications TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.cleared_notifications TO service_role;


--
-- Name: SEQUENCE cleared_notifications_id_seq; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON SEQUENCE public.cleared_notifications_id_seq TO anon;
GRANT ALL ON SEQUENCE public.cleared_notifications_id_seq TO authenticated;
GRANT ALL ON SEQUENCE public.cleared_notifications_id_seq TO service_role;


--
-- Name: TABLE conversations; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.conversations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.conversations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.conversations TO service_role;


--
-- Name: TABLE files; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.files TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.files TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.files TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.messages TO service_role;


--
-- Name: TABLE profiles; Type: ACL; Schema: public; Owner: postgres
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE public.profiles TO service_role;


--
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO postgres;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: supabase_admin
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.buckets TO postgres;


--
-- Name: TABLE migrations; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.migrations TO postgres;


--
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO authenticated;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO service_role;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.objects TO postgres;


--
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads TO postgres;


--
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;
GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE storage.s3_multipart_uploads_parts TO postgres;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON SEQUENCES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT ALL ON FUNCTIONS TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA extensions GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres WITH GRANT OPTION;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA graphql_public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT ALL ON SEQUENCES TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO pgsodium_keyholder;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON SEQUENCES TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT ALL ON FUNCTIONS TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: pgsodium_masks; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA pgsodium_masks GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO pgsodium_keyiduser;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: public; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA public GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON SEQUENCES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT ALL ON FUNCTIONS TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: supabase_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_admin IN SCHEMA realtime GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO dashboard_user;


--
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS TO service_role;


--
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT SELECT,INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLES TO service_role;


--
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO supabase_admin;

--
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO supabase_admin;

--
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO supabase_admin;

--
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO supabase_admin;

--
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: supabase_admin
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO supabase_admin;

--
-- PostgreSQL database dump complete
--

