from flask import Flask
import psutil,json

app = Flask(__name__)

@app.route("/version")
def index():
        return "version 0.0.1"

@app.route("/cpu")
def cpu():
        cpu = json_string = json.dumps(psutil.cpu_stats())
        return cpu

@app.route("/mem")
def mem():
        mem = json_string = json.dumps(psutil.virtual_memory())
        return mem

if __name__ == "__main__":
    app.run(host='0.0.0.0', port=4000)

