# Copied from: https://hub.docker.com/r/fluent/fluentd

FROM fluent/fluentd:v1.12-debian-1

# Use root account to use apt
USER root

# below RUN includes plugin as examples elasticsearch is not required
# you may customize including plugins as you wish
RUN buildDeps="sudo make gcc g++ libc-dev" \
 && apt-get update \
 && apt-get install -y --no-install-recommends $buildDeps \
 && sudo gem install fluent-plugin-google-cloud \
 && sudo gem sources --clear-all \
 && SUDO_FORCE_REMOVE=yes \
    apt-get purge -y --auto-remove \
                  -o APT::AutoRemove::RecommendsImportant=false \
                  $buildDeps \
 && rm -rf /var/lib/apt/lists/* \
 && rm -rf /tmp/* /var/tmp/* /usr/lib/ruby/gems/*/cache/*.gem

RUN mkdir -p /var/log/google-fluentd
RUN chown fluent /var/log/google-fluentd

COPY default.conf /fluentd/etc/
COPY entrypoint.sh /bin/

COPY keyfile-52w-logging-bigquery.json /app/keyfile-52w-logging-bigquery.json

ENV FLUENTD_CONF default.conf
ENV GOOGLE_APPLICATION_CREDENTIALS /app/keyfile-52w-logging-bigquery.json
ENV LOG_LEVEL INFO 

RUN fluentd --dry-run -c /fluentd/etc/default.conf

USER fluent
