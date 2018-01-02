#!/usr/bin/env python

def is_prime(n):
    from math import sqrt, ceil
    if n == 1 or n == 0: return False
    if n == 2: return True
    if n & 0x01 == 0: return False # even number
    for i in xrange(2, int(ceil(sqrt(n)))):
        if n % i == 0:
            return False
    return True

def main():
    import sys
    if len(sys.argv) == 1:
        print >> sys.stderr, 'Usage: %s n\n\n    Prints the prime number greater than or equal to n'
        sys.exit(1)
        return
    n = int(sys.argv[1])
    while not is_prime(n):
        n = n + 1
    print n
    
if __name__ == '__main__':
    main()

## prime.py ends here
