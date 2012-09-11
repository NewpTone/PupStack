#! /usr/bin/python
# vim: tabstop=4 shiftwidth=4 softtabstop=4

"""
A ssh based cmd dispatch system

"""

import subprocess
import ConfigParser
import os


def readconfig(file="config.ini"):
	""" Get ip address and cmds from config file and return tuples"""
	ips = []
	cmds = []
	path = os.getcwd()
	Config = ConfigParser.ConfigParser()
	Config.read(file)
	machines = Config.items("MACHINES")
	commands = Config.items("COMMANDS")
	path = Config.items('SCRIPTS_PATH')
	for ip in machines:
		ips.append(ip[1])
	for cmd in commands:
		cmds.append(cmd[1])
	return ips,cmds,path

ips,cmds,path = readconfig()


for ip in ips:
	for cmd in cmds:
		#print os.getcwd()
		subprocess.call("ssh root@%s %s"%(ip,cmd),shell=True)
