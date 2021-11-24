# Got this template from https://medium.com/analytics-vidhya/how-to-load-keras-h5-model-format-from-google-cloud-bucket-abf9a77d3cb4
# and https://www.tensorflow.org/guide/saved_model


from keras.models import load_model
import h5py
import gcsfs
from config import google_pass

PROJECT_NAME = 'Final Project'
CREDENTIALS = 'final-project-333017-c4b081ce8faf.json'
MODEL_PATH = 'gs://final_project_ml_bucket/enough_service.h5'
FS = gcsfs.GCSFileSystem(project=PROJECT_NAME,
                         token=CREDENTIALS)
with FS.open(MODEL_PATH, 'rb') as model_file:
     model_gcs = h5py.File(model_file)
     myModel = load_model(model_gcs)