import os
from gevent.pywsgi import WSGIServer
import subprocess
from clint.textui import colored
from flask import Flask, request
from flask import send_file
from flask import Flask, render_template, request


os.system("clear")
os.system("printf '\e[92m' && figlet Social_X -f banner/larry3d.flf")
print(colored.green("------------------------------------------------------------------"))
print(colored.green("                         By:Aziz Kaplan"))
print(colored.green("                          Version:2.0"))
print(colored.green("------------------------------------------------------------------"))
print(colored.green("\n\nWeb Server is currently active. Leave this screen like this and continue with the other console."))
current_dir=subprocess.check_output(["pwd"]).decode()
app = Flask(__name__)
APP_ROOT = os.path.dirname(os.path.abspath(__file__))
@app.route("/")
def index():
    return render_template("upload.html")
@app.route("/images/<filename>")
def download(filename):
    return send_file(f"images/{filename}",as_attachment=True)
@app.route("/upload", methods=['POST'])
def upload():
    try:
        target = os.path.join(APP_ROOT, 'images/')
        print(target)
        if not os.path.isdir(target):
            os.mkdir(target)
        for file in request.files.getlist("file"):
            print(file)
            filename = file.filename
            destination = "/".join([target, filename])
            print(destination)
            file.save(destination)
        return render_template("complete.html")
    except:
        return render_template("error.html")
if __name__ == "__main__":
    http_server = WSGIServer(('0.0.0.0',80), app)
    http_server.serve_forever()

