#!/usr/bin/env python3

WORDFILE='/usr/share/dict/words'

def randstring(r, n, data):
    lim = len(data)
    return ' '.join([data[r.randint(0, lim)] for i in range(n)])

def main(argv):
    from random import SystemRandom

    if len(argv) == 1:
        print('Usage %s n' % argv[0], file=sys.stderr)
        sys.exit(1)
        return

    try:
        n = int(argv[1])
        with open(WORDFILE, 'r') as instream:
            data = [line.strip() for line in instream.readlines() if len(line) > 4]
            print(randstring(SystemRandom(), n, data))
    except ValueError:
        print(f"Expected number got '{argv[1]}'", file=sys.stderr)
        sys.exit(1)
        return                  # unreachable
    
if __name__ == '__main__':
    import sys
    main(sys.argv)

## randpass.py ends here
