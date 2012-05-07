#!/usr/bin/env python

import sys
import re

TAB = '	'
TAB_REPLACEMENT = '    '
CR = '\r'
CR_REPLACEMENT = ''
TRAILING_WS = re.compile(r'[ ]+\n')
TRAILING_WS_REPLACEMENT = '\n'

def process(filename):
    f = file(filename); data = f.read(); f.close(); del f
    cleaned_up = cleanup(data)
    f = file(filename, 'w')
    f.write(cleaned_up)
    f.close()

def cleanup(data):
    data = data.replace(TAB, TAB_REPLACEMENT)
    data = data.replace(CR, CR_REPLACEMENT)
    data = replace_all(data)
    return data

def replace_all(dt):
    while True:
        nd = TRAILING_WS.sub(TRAILING_WS_REPLACEMENT, dt)
        if nd == dt:
            dt = nd
            break
        dt = nd
    return dt

if __name__ == '__main__':
    if len(sys.argv) == 1:
        print 'Usage: %s patch_files*' % sys.argv[0]
        sys.exit(1)

    for filename in sys.argv[1:]:
        print 'processing %s...' % filename
        process(filename)
