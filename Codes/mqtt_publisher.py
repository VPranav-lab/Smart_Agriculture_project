import paho.mqtt.client as mqtt
import json
import time
import random

broker = "localhost"
port = 1883
topic = "smart_agriculture/sensors"


sensors = []
for zone_num in range(1, 21):
    zone_id = f"ZONE_{zone_num:02d}"
    sensors.extend([
        {"sensor_id": f"SENSOR_{(zone_num-1)*3+1:03d}", "sensor_type": "Temperature", "zone_id": zone_id},
        {"sensor_id": f"SENSOR_{(zone_num-1)*3+2:03d}", "sensor_type": "Moisture", "zone_id": zone_id},
        {"sensor_id": f"SENSOR_{(zone_num-1)*3+3:03d}", "sensor_type": "Soil_pH", "zone_id": zone_id},
    ])

def generate_value(sensor_type):
    if sensor_type == "Temperature":
        return round(random.uniform(-5, 50), 2)  
    elif sensor_type == "Moisture":
        return round(random.uniform(0, 100), 2)  
    elif sensor_type == "Soil_pH":
        return round(random.uniform(3.5, 9.0), 2) 
    else:
        return 0

def main():
    client = mqtt.Client()
    client.connect(broker, port)
    client.loop_start()
    try:
        while True:
            for sensor in sensors:
                value = generate_value(sensor["sensor_type"])
                message = {
                    "sensor_id": sensor["sensor_id"],
                    "sensor_type": sensor["sensor_type"],
                    "zone_id": sensor["zone_id"],
                    "value": value,
                    "timestamp": int(time.time())
                }
                client.publish(topic, json.dumps(message))
                print(f"Published: {message}")
                time.sleep(0.1)  

            time.sleep(5)  
    except KeyboardInterrupt:
        print("\nStopping publisher...")
    finally:
        client.loop_stop()
        client.disconnect()

if __name__ == "__main__":
    main()
