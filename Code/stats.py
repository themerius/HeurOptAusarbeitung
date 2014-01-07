#!/usr/bin/python
# -*- coding: utf-8 -*-

import numpy
import os
import sys
import warnings

from functions import getPath, makeDir, parseValue, generateFigure

texDir = getPath("../Chapters/gen/")
figDir = getPath("../Figures/gen/")
makeDir(texDir)
makeDir(figDir)

results = getPath(to="results")

stats = {}

class Result(object):
    def __init__(self, objectiveValues):
        self.values = objectiveValues
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
    if "_" in filename:
        (varname, value) = filename.rsplit('_', 1)
        value = parseValue(value.replace('.txt', ''))
    else:
        varname = filename.replace('.txt', '')
        value = -1

    if varname not in stats:
        stats[varname] = {}

    stats[varname][value] = obj

for root, dirs, files in os.walk(results):
    for file in files:
        if file.endswith(".txt"):
            stat(root, file)

def print_table():
    for varname, list in sorted(stats.items()):
        print '\n' + varname

        for value, obj in sorted(list.items()):
            printVal = str(value) if value != -1 else "-"
            print "%8s: %3d %7.2f %7.2f %7.2f (%d, %d)" % \
                (printVal, obj.number, obj.mean, obj.std, obj.time, obj.min, obj.max)

def save_TeXtable():
    for varname, list in sorted(stats.items()):
        with open(texDir + varname.replace('_', '.') + '.tex', 'w') as f:
            f.write((u"""%% %s
\\begin{table}[tbph]
\\begin{tabular}{ | c || r | r | r | r | r | }
\\hline
Parameter & \# Iterationen & Mittelwert & Std.-Abw. & Laufzeit & Min, Max \\\\
\\hline\n""" % varname).encode('utf-8'))

            for value, obj in sorted(list.items()):
                printVal = str(value) if value != -1 else "-"
                f.write("%8s & %3d & %7.2f & %7.2f & %7.2f & %d, %d \\\\\n" % \
                    (printVal, obj.number, obj.mean, obj.std, obj.time, obj.min, obj.max))

            f.write("""\\hline
\\end{tabular}
\\caption{%s}\\label{%s}
\\end{table}""" % (varname.replace('_', ' '), varname.replace('_', '.')))

def generateFigures():
    for varname, list in sorted(stats.items()):
        x = []
        y1 = []
        y2 = []

        if len(list) == 1 and list.keys()[0] == -1:
            obj = list[-1]
            x = numpy.arange(obj.number) + 1
            y1 = obj.values
        else:
            for value, obj in sorted(list.items()):
                x.append(value)
                y1.append(obj.mean)
                y2.append(obj.time)

        values = [y1]
        legend = None

        if varname.startswith('Number'):
            values = [y1, y2]
            legend = ['Mean', 'Duration']

        generateFigure(x, values, figDir + varname.replace('_', '.') + '.png', legend)

if __name__ == "__main__":
    if "tex" in sys.argv:
        save_TeXtable()
        generateFigures()
    else:
        print_table()

