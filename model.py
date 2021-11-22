# import panda, keras and tensorflow, flask and other dependencies to help with Flask upload
# Got some help from https://www.youtube.com/watch?v=CSEmUmkfb8Q
import pandas as pd
import tensorflow as tf
import keras
from keras.applications.imagenet_utils import preprocess_input, decode_predictions
from keras.models import load_model
import sys
import os
import glob
import re
import numpy as np
from flask import Flask, redirect, url_for_request, render_template
from werkzeug.utils import secure_filename
from gevent.pywsgi import WSGIServer

# Define flask app
app = Flask(__name__)

MODEL_PATH = 'enough_service.h5'
