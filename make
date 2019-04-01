#!/usr/bin/env python3
import jinja2
import os
import configparser
import argparse

parser = argparse.ArgumentParser()
parser.add_argument("--env", required=True, help="Environment, dev|prod")
args = parser.parse_args()

config = configparser.ConfigParser()
config.read(os.path.join(os.path.dirname(__file__), "cfg.ini"))

def render(context, template):
    content = jinja2.Environment(
        loader=jinja2.FileSystemLoader(os.path.join(os.path.dirname(__file__), "templates"))
    ).get_template(template).render(context)
    out = ".".join(f.split(".")[:-1])
    _write(content, out)

def _write(content, file):
    with open(file, 'w') as f:
        f.write(content)

if __name__ == "__main__":
    env = args.env.upper()

    if env not in config:
        print("Environment '{}' not defined in config file!".format(env.lower()))
        exit(-1)

    for f in os.listdir("templates"):
        if f.endswith(".j2"):
            render(dict(config[env]), f)
            
