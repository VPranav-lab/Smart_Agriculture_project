import paho.mqtt.client as mqtt
import json
from handlers import process_sensor_data

broker = "localhost"
port = 1883
topic = "smart_agriculture/sensors"

def on_connect(client, userdata, flags, rc):
    print(f"Connected with result code {rc}")
    client.subscribe(topic)

def on_message(client, userdata, msg):
    data = json.loads(msg.payload.decode())
    print(f"Received: {data}")
    process_sensor_data(data)

def main():
    client = mqtt.Client()
    client.on_connect = on_connect
    client.on_message = on_message

    client.connect(broker, port)
    client.loop_forever()

if __name__ == "__main__":
    main()
