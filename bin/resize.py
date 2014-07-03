#!/usr/bin/env python

from PIL import Image

if __name__ == '__main__':
    import sys

    if len(sys.argv) != 2 and len(sys.argv) != 4:
        print >> sys.stderr, '''Usage: %s filename [outputname] [resize_ratio_percentage]

    With just filename, returns dimensions of the image.\n''' % sys.argv[0]
        sys.exit(1)

    try:
        inp, out, per = sys.argv[1:]
        resize = int(per)

        iimg = Image.open(inp)
        wid, hei = iimg.size
        nwid, nhei = wid * resize / 100, hei * resize / 100
        oimg = iimg.resize((nwid, nhei))
        oimg.save(out)
    except ValueError:
        inp = sys.argv[1]

        iimg = Image.open(inp)
        wid, hei = iimg.size
        print wid, hei
