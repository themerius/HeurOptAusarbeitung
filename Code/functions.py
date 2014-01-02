#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import numpy as np
import matplotlib.pyplot as plt

def getPath(to):
    path = os.path.split(os.path.abspath(__file__))
    path = os.path.abspath(path[0])
    path = path + "/" + to
    return path

def makeDir(dir):
    if not os.path.exists(dir):
        os.makedirs(dir)

def parseValue(valueStr):
    try:
        return int(valueStr)
    except:
        try:
            return float(valueStr)
        except:
            return valueStr # keep the string

def generateFigure(x, y, fileName, legend = None):
    plt.figure()

    if isinstance(x[0], basestring):
        names = x
        x = range(len(names))
        plt.xticks(x, names)

    # http://matplotlib.org/examples/axes_grid/demo_parasite_axes2.html
    colors = ['blue', 'red', 'green', 'yellow'];

    for i in range(len(y)):
        ax = plt.gca()
        if i > 0:
            ax = ax.twinx()

        ax.plot(np.array(x), np.array(y[i]), colors[i % len(colors)])

        if legend != None and i < len(legend):
            ax.set_ylabel(legend[i])
            ax.yaxis.label.set_color(colors[i % len(colors)])

    plt.savefig(fileName)

