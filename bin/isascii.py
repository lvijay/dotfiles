#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys

if __name__ == '__main__':
    if len(sys.argv) == 1:
        print 'Usage %s [args]' % sys.argv[0]
        sys.exit(1)
    input = ' '.join(sys.argv[1:])
    isascii = all([ord(x) < 127 for x in input])
    sys.exit(0 if isascii else 1)
    
## isascii.py ends here
