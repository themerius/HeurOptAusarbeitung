#!/usr/bin/python

import numpy
import os
import warnings

stats = {}

class Result(object):
    def __init__(self, objectiveValues):
        self.number = objectiveValues.shape[0]
        self.mean   = numpy.mean(objectiveValues)
        self.std    = numpy.std(objectiveValues)
        self.min    = numpy.min(objectiveValues)
        self.max    = numpy.max(objectiveValues)
        self.time   = -1


def stat(dir, filename):
    data = numpy.loadtxt(os.path.join(dir, filename))
    obj = Result(data[:,0])

    # read duration of runs if available
    with warnings.catch_warnings():
        warnings.filterwarnings('ignore', \
            category = numpy.lib._iotools.ConversionWarning)
        timedata = numpy.genfromtxt(os.path.join(dir, filename), \
            usecols = (30,), invalid_raise = False)
        if timedata.size > 0:
            obj.time = numpy.sum(timedata) / timedata.size

    # add object to statistic list
    (varname, value) = filename.rsplit('_', 1)
    if varname not in stats:
        stats[varname] = {}

    stats[varname][float(value.replace('.txt', ''))] = obj


for root, dirs, files in os.walk("results"):
    for file in files:
        if file.endswith(".txt"):
            stat(root, file)

for varname, list in sorted(stats.items()):
    print '\n' + varname

    for value, obj in sorted(list.items()):
        print "%7.2f: %3d %7.2f %7.2f %7.2f (%d, %d)" % \
            (value, obj.number, obj.mean, obj.std, obj.time, obj.min, obj.max)
