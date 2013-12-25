#!/usr/bin/python
# -*- coding: utf-8 -*-

import numpy
import os
import sys
import warnings

def getPath(to):
    path = os.path.split(os.path.abspath(__file__))
    path = os.path.abspath(path[0])
    path = path + "/" + to
    return path

dir = getPath("../Chapters/gen/")

if not os.path.exists(dir):
    os.makedirs(dir)

results = getPath(to="results")

stats = {}

class Result(object):
    def __init__(self, objectiveValues):
        self.number = objectiveValues.shape[0]
        self.mean   = numpy.mean(objectiveValues)
        self.std    = numpy.std(objectiveValues)
        self.min    = numpy.min(objectiveValues)
        self.max    = numpy.max(objectiveValues)
        self.time   = -1

def parseValue(valueStr):
    try:
        return int(valueStr)
    except:
        try:
            return float(valueStr)
        except:
            return valueStr # keep the string

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

    value = parseValue(value.replace('.txt', ''))
    stats[varname][value] = obj


for root, dirs, files in os.walk(results):
    for file in files:
        if file.endswith(".txt"):
            stat(root, file)

def print_table():
    for varname, list in sorted(stats.items()):
        print '\n' + varname

        for value, obj in sorted(list.items()):
            print "%8s: %3d %7.2f %7.2f %7.2f (%d, %d)" % \
                (str(value), obj.number, obj.mean, obj.std, obj.time, obj.min, obj.max)

def save_TeXtable():
    for varname, list in sorted(stats.items()):
        with open(dir + varname.replace('_', '.') + '.tex', 'w') as f:
            f.write((u"""%% %s
\\begin{table}[tbph]
\\begin{tabular}{ | c || r | r | r | r | r | }
\\hline
Parameter & \# Iterationen & Mittelwert & Std.-Abw. & Laufzeit & Min, Max \\\\
\\hline\n""" % varname).encode('utf-8'))

            for value, obj in sorted(list.items()):
                f.write("%8s & %3d & %7.2f & %7.2f & %7.2f & %d, %d \\\\\n" % \
                    (str(value), obj.number, obj.mean, obj.std, obj.time, obj.min, obj.max))

            f.write("""\\hline
\\end{tabular}
\\caption{%s}\\label{%s}
\\end{table}""" % (varname.replace('_', ' '), varname.replace('_', '.')))

if __name__ == "__main__":
    if "tex" in sys.argv:
        save_TeXtable()
    else:
        print_table()

