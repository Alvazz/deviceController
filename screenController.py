#!/usr/bin/env python3
import os,sys,time
import paho.mqtt.client as mqtt
from config import *

client = mqtt.Client()
client.enable_logger()
topic = '/screen'

def on_connect(client, userdata, flags, rc):
    print("Connected to MQTT broker with result code " + str(rc))
    client.subscribe(topic)

def on_message(client, userdata, msg):
    print("Received message " + str(msg.payload) + " from topic " + msg.topic)
    info = str(msg.payload)
    print(info, info[0])
    if msg.topic == topic:
        if 'htop skyhub' in info:
            show_htop('skyhub')
        elif 'htop vision' in info:
            show_htop('vision')
        elif 'htop chrome' in info:
            show_htop('chrome')
        elif 'htop' in info:
            show_htop()

def show_htop(target=''):
    os.system('show_htop '+target)

client.on_connect = on_connect
client.on_message = on_message

client.username_pw_set(MQTT['User'], MQTT['Pass'])
client.connect(MQTT['Hostname'])

client.loop_forever()
