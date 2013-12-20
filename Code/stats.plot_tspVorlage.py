#!/usr/bin/python
# -*- coding: utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt

# example data
x = np.arange(15) + 1
y = np.array([3324,
 3041,
 3180,
 3148,
 3102,
 2898,
 2980,
 2764,
 2982,
 3490,
 2974,
 3281,
 2991,
 2967,
 3047])

plt.errorbar(x, y)
plt.savefig("Figures/tspVorlage.png")
#plt.show()
