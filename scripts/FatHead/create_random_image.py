#!/usr/bin/python3
import os
import requests
import json
from pathlib import Path
from numpy import random
from pylab import imshow, show, get_cmap


def main():
    Z = random.random((50,50))   # Test data
    imshow(Z, cmap=get_cmap("Spectral"), interpolation='nearest')
    show()