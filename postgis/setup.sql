CREATE SCHEMA api;
CREATE ROLE web_anon NOLOGIN;
GRANT USAGE ON SCHEMA api TO web_anon;
CREATE ROLE authenticator NOINHERIT LOGIN PASSWORD 'gisops';
GRANT web_anon TO authenticator;
