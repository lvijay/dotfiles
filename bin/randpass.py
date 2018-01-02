#!/usr/bin/env python

WORDFILE='/usr/share/dict/words'

def randstring(r, n, data):
    lim = len(data)
    return ' '.join([data[r.randint(0, lim)] for i in xrange(n)])

def main(argv):
    from random import SystemRandom

    if len(argv) == 1:
        print >> sys.stderr, 'Usage %s n' % argv[0]
        sys.exit(1)
        return

    try:
        n = int(argv[1])
        with open(WORDFILE, 'r') as instream:
            data = [line.strip() for line in instream.readlines() if len(line) > 4]
            print randstring(SystemRandom(), n, data)
    except ValueError:
        print >> sys.stderr, "Expected number got '%s'" % argv[1]
        sys.exit(1)
        return
    
if __name__ == '__main__':
    import sys
    main(sys.argv)

## randpass.py ends here
