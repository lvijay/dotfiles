#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

def is_ascii(string):
    for x in string:
        if ord(x) > 127:
            return False
    return True

if __name__ == '__main__':
    if len(sys.argv) == 1:
        print 'Usage %s [args]' % sys.argv[0]
        sys.exit(1)
    input = ' '.join(sys.argv[1:])
    sys.exit(0 if is_ascii(input) else 1)
    
## isascii.py ends here
