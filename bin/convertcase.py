#!/usr/bin/python
import stringcase
import sys

def convert(s):
    if '-' in s:
        return stringcase.camelcase(stringcase.snakecase(s))
    else:
        return stringcase.spinalcase(s)

args = sys.argv[1:]
while(args):
    arg = args.pop()
    print(convert(arg))
