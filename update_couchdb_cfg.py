#!/usr/bin/env python

import os

from argparse import ArgumentParser
from ConfigParser import SafeConfigParser

if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('config')
    args = parser.parse_args()

    assert os.path.exists(args.config)
    assert os.path.isfile(args.config)

    cfg = SafeConfigParser()
    cfg.read(args.config)

    cfg.set('httpd', 'bind_address', '0.0.0.0')
    cfg.set('httpd', 'enable_cors', 'true')

    cfg.set('cors', 'origins', '*')
    cfg.set('cors', 'credentials', 'true')
    cfg.set('cors', 'methods', 'GET, PUT, POST, HEAD, DELETE')
    cfg.set('cors', 'headers', 'accept, authorization, content-type, origin, referer, x-csrf-token')

    with open(args.config, 'w') as fd:
        cfg.write(fd)
