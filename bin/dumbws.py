#!/usr/bin/env python
"""Dumb HTTP Web Server

A very simple web-server that returns the same output for all its GET
requests.

"""

__version__ = "0.0.1"

import BaseHTTPServer
import sys

def run(server_class=BaseHTTPServer.HTTPServer,
        handler_class=BaseHTTPServer.BaseHTTPRequestHandler):
    server_address = ('', 8000)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()

class DumbHttpRequestHandler(BaseHTTPServer.BaseHTTPRequestHandler):
    server_version = "DumbHTTP/" + __version__
    protocol_version = "HTTP/1.1"

    def do_GET(self):
        response = 'Request successful'
        self.send_response(200)
        self.send_header('Content-Type', 'text/plain')
        self.send_header('Content-Length', len(response))
        self.end_headers()

        self.wfile.write(response)

    def do_POST(self):
        self.do_GET()

if __name__ == '__main__':
    port = 8000
    if len(sys.argv) > 2:
        port = int(sys.argv[1])
    server_address = ('', port)
    print 'Listening on port', port
    httpd = BaseHTTPServer.HTTPServer(server_address, DumbHttpRequestHandler)
    httpd.serve_forever()

### dumbws.py ends here
