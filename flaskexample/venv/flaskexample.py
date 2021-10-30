import http.client
import requests
import json
import numpy as np
from flask import Flask
from PIL import Image

app = Flask(__name__)

@app.route('/')
def index():
    data=np.random.randint(low=0,high=256,size=128*128*3, dtype=np.uint8)
    data=data.reshape(128,128,3)
    Image.fromarray(data,'RGB').save("output.png")
    conn = http.client.HTTPConnection('http://127.0.0.1:5001')
    headers = {'Content-type': 'application/x-directory','Content-Disposition': 'form-data','name':'file','filename':'output.png'}
    # foo = {'file' :'output.png'}
    json_data = json.dumps(foo)
    conn.request('POST', '/post', headers)
    response = conn.getresponse()
    print(response.read().decode())

app.run(host='0.0.0.0', port=81)
