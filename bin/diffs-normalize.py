#!/usr/bin/env python

## replace tabs with four spaces at the start of a diff

import sys
import re

def replace_line(line):
    if line[0] != '+':
        return line
    return line.replace('\t', '    ')

TRAILING_WS = re.compile('[ \t]+$')

def replace_trailing_ws(line):
    global TRAILING_WS
    m = TRAILING_WS.search(line)
    if not m: return line
    return line[:m.start()] + '\n'

def compose(*fns):
    if not fns: return lambda x: x
    return reduce(lambda x, y: lambda z: y(x(z)), fns)

def handle_stream(stream):
    operators = compose(replace_line, replace_trailing_ws)
    for line in stream:
        if line[0] == '+': line = operators(line)
        sys.stdout.write(line)

if __name__ == '__main__':
    handle_stream(sys.stdin)

# diffs-tab-to-space.py ends here
