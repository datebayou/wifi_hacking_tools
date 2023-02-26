#!/usr/bin/env python3

#Passar nome do blocoip e IP/CIDR

import xml.etree.ElementTree as ET
import sys
import datetime
import requests
import os
import shutil
import uuid
import json
import string
from time import strftime

dic = {}
filetxt = open('/dados/businesscorp/nmap/nmap.txt', 'w')
filecsv = open('/dados/businesscorp/nmap/nmap.csv', 'w')

def nmap_function(ip):
    
    os.system("sudo nmap -sSV -Pn --allports --randomize-hosts "+ip+" -oX nmap.xml")

def parse_function():
#Parse do XML
	tree = ET.parse('nmap.xml')
	root = tree.getroot()    
	for i in root.iter('nmaprun'):
	    for j in i:
	        for host in j:
	            if(host.tag == 'address'):
	                if(':' not in host.attrib['addr']):
	                    dic['ip'] = host.attrib['addr']
	                    dic['serveraddress'] = host.attrib['addr']
	                    dic['tipo'] = host.attrib['addrtype']
	            if(host.tag == 'ports'):
	                for port in host:
	                    if(port.tag == 'port'):
	                        dic['porta'] = port.attrib['portid']
	                        dic['protocolo'] = port.attrib['protocol']
	                        for service in port:
	                            if(service.tag == 'state'):
	                                dic['status'] = service.attrib['state']
	                            if(service.tag == 'service'):
	                                dic['name'] = service.attrib['name']
	                                try:
	                                    dic['product'] = service.attrib['product']
	                                except:
	                                    dic['product'] = ''
	                                try:
	                                    dic['version'] = service.attrib['version']
	                                except:
	                                    dic['version']  = ''
	                                print(dic)
	                                filetxt.write("Ip: "+dic['ip']+" | Server Address: "+dic['serveraddress']+" | Tipo: "+dic['tipo']+" | Porta: "+dic['porta']+" | Protocolo: "+dic['protocolo']+" | Status: "+dic['status']+" | Name:"+dic['name']+" | Produto:"+dic['product']+" | Versao: "+dic['version']+"\n")
                                	filecsv.write(dic['ip']+","+dic['serveraddress']+","+dic['tipo']+","+dic['porta']+","+dic['protocolo']+","+dic['status']+","+dic['name']+","+dic['product']+","+dic['version']+"\n")

def main():

	nmap_function(sys.argv[1])
	parse_function()
	filetxt.close()
	filecsv.close()

if __name__ == '__main__':
    main()
