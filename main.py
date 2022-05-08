from flask import Flask
import requests

app = Flask(__name__)

@app.route('/')
def hello():
    r = requests.get('https://api.github.com/events')
    return r.text