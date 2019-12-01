#!/usr/bin/env python3
import os,sys,time
import paho.mqtt.client as mqtt
from config import *

client = mqtt.Client()
client.enable_logger()
topic = '/PPT'

def on_connect(client, userdata, flags, rc):
    print("Connected to MQTT broker with result code " + str(rc))
    client.subscribe(topic)

def on_message(client, userdata, msg):
    print("Received message " + str(msg.payload) + " from topic " + msg.topic)
    info = str(msg.payload)
    print(info, info[0])
    if msg.topic == topic:
        if 'next' in info:
            show_ppt('skyhub')
        elif 'prev' in info:
            show_ppt('vision')
        elif 'open' in info:
            show_ppt('chrome')

def show_ppt(target=''):
    os.system('show_ppt '+target)

client.on_connect = on_connect
client.on_message = on_message

client.username_pw_set(MQTT['User'], MQTT['Pass'])
client.connect(MQTT['Hostname'])

client.loop_forever()
