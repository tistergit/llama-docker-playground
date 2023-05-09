#!/usr/bin/env python3


import csv
import jinja2
import pandas as pd
from jinja2 import Template
from jinja2 import Environment, PackageLoader
env = jinja2.Environment(loader=jinja2.FileSystemLoader("../templates"))


template = env.get_template('templae.tpl')


df = pd.read_csv("machine.csv",sep = ",")

output_from_parsed_template = template.render(rows=df)
print(output_from_parsed_template)

with open("machine_sample.json", "w") as fh:
    fh.write(output_from_parsed_template)

