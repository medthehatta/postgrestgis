FROM kartoza/postgis
RUN apt-get update -y && apt-get install -y postgis
COPY setup.sql /scripts/setup.sql
COPY functions.sql /scripts/functions.sql
