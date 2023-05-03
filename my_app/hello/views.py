import os
from flask import Blueprint, render_template
from flask import request
from my_app.hello.models import MESSAGES

hello = Blueprint('hello', __name__)

@hello.route('/')
@hello.route('/version')
def version():
    try:
        VERSION = os.environ['VERSION']
    except:
        VERSION = "undefined"
    return render_template('pages/hello.html', message="Hello your version is %s" % VERSION)

@hello.route('/secret')
def secret():
    try:
        ENV_SECRET = os.environ['SECRET']
    except:
        ENV_SECRET = "undefined"
    return render_template('pages/hello.html', message="Hello ENV_SECRET is %s" % ENV_SECRET)

@hello.route('/hello')
def hello_world():
    return render_template('pages/hello.html', message="Hello guys thanks for join us!!!")

@hello.route('/show/<key>')
def get_message(key):
    return MESSAGES.get(key) or "%s not found" % key

@hello.route('/add/<key>/<message>')
def add_or_update_message(key, message):
    MESSAGES[key] = message
    return "%s Added/Updated" % key

@hello.route('/adm/ip')
def show_ip():
    client_ip = request.environ['REMOTE_ADDR']
    if request.environ.get('HTTP_X_FORWARDED_FOR'):
        client_ip = str(request.environ.get('HTTP_X_FORWARDED_FOR'))
    return "dude your ip is: " + client_ip
