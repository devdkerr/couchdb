Dockerized CouchDB
========================================

A dockerized CouchDB service, with Monit monitoring.

Docker Run
----------------------------------------

```bash
docker run -d -p 2812 -p 5984:5984 -v data/couchdb:/usr/local/var/lib/couchdb devdkerr/couchdb
```

Docker-Compose Run
----------------------------------------

```yaml
couchdb:
    image: devdkerr/couchdb
    ports:
     - "2812"
     - "5984:5984"
    volumes:
     - data/couchdb:/usr/local/var/lib/couchdb
```
