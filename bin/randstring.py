#!/usr/bin/env python

## removed some characters from string.printable
PRINTABLE_ASCII = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ '

def randstring(r, n):
    lim = len(PRINTABLE_ASCII) - 1
    return ''.join([PRINTABLE_ASCII[r.randint(0, lim)] for i in xrange(n)])

def main(argv):
    from random import SystemRandom

    if len(argv) == 1:
        print >> sys.stderr, 'Usage %s n' % argv[0]
        sys.exit(1)
        return

    try:
        n = int(argv[1])
    except ValueError:
        print >> sys.stderr, "Expected number got '%s'" % argv[1]
        sys.exit(1)
        return

    print randstring(SystemRandom(), n)

if __name__ == '__main__':
    import sys
    main(sys.argv)

## randstring.py ends here
