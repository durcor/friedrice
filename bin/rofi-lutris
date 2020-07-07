#!/usr/bin/env python
import json
import os
import subprocess

tmp = os.popen("lutris -ojl").read()
games = json.loads(tmp)

gameslist = ""
concat = ""
for item in games:
	gameslist = gameslist + concat + item["name"]
	concat = "\n"

tmp = subprocess.getoutput("echo \"" + gameslist + "\" | rofi -i -dmenu -p \"Select Game:\"")

for item in games:
	if item["name"] == tmp:
		subprocess.Popen(["lutris", "lutris:rungameid/" + str(item["id"])])
		break
