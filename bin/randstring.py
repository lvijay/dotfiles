#!/usr/bin/env python3

ALPHANUMERICS = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'

## make ALPHANUMERICS more probable than others
PRINTABLE_ASCII = ALPHANUMERICS + ALPHANUMERICS + ALPHANUMERICS + '!"#$%&\'()*+,-./:;<=>?@[\\]^_`{|}~ '

def randstring(r, n):
    lim = len(PRINTABLE_ASCII) - 1
    return ''.join([PRINTABLE_ASCII[r.randint(0, lim)] for i in range(n)])

def main(argv):
    from random import SystemRandom

    if len(argv) == 1:
        print('Usage %s n' % argv[0], file=sys.stderr)
        sys.exit(1)
        return

    try:
        n = int(argv[1])
    except ValueError:
        print("Expected number got '%s'" % argv[1], file=sys.stderr)
        sys.exit(2)
        return

    print(randstring(SystemRandom(), n))

if __name__ == '__main__':
    import sys
    main(sys.argv)

## randstring.py ends here
