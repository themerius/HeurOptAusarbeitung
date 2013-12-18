#!/usr/bin/python

import numpy
import os


stats = {}

def stat(dir, filename):
    data = numpy.loadtxt(os.path.join(dir, filename), dtype = numpy.int)
    objectiveValues = data[:,0]
    mean = numpy.mean(objectiveValues)
    std  = numpy.std(objectiveValues)

    (varname, value) = filename.rsplit('_', 1)
    if varname not in stats:
        stats[varname] = {}

    stats[varname][int(value.replace('.txt', ''))] = (mean, std)


for root, dirs, files in os.walk("results"):
    for file in files:
        if file.endswith(".txt"):
            stat(root, file)

for varname, list in sorted(stats.items()):
    print '\n' + varname

    for value, objV in sorted(list.items()):
        (mean, std) = objV
        print "%4d: %7.2f %7.2f" % (value, mean, std)
