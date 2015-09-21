FROM ubuntu:trusty
MAINTAINER Daniel R. Kerr <daniel.r.kerr@gmail.com>

ENV ERL_FLAGS +A 4

RUN apt-get update -y \
 && apt-get install -qq -y curl monit python-software-properties software-properties-common supervisor \
 && add-apt-repository -y ppa:couchdb/stable \
 && apt-get update -y \
 && apt-get install -qq -y couchdb \
 && apt-get clean \
 && rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY update_couchdb_cfg.py /tmp/update_couchdb_cfg.py
RUN mkdir /var/run/couchdb \
 && python /tmp/update_couchdb_cfg.py /etc/couchdb/default.ini

COPY monitrc /etc/monit/monitrc
RUN chmod 700 /etc/monit/monitrc \
 && chown root:root /etc/monit/monitrc

VOLUME ["/usr/local/var/lib/couchdb"]

EXPOSE 2812 5984

COPY supervisord.conf /etc/supervisord.conf
CMD ["/usr/bin/supervisord"]
