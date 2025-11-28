# Smart Agriculture IoT Project
##  Author: **Pranav**  
---
## **Project Overview**

This project demonstrates a real-time IoT-based Smart Agriculture System that collects sensor data from multiple farm zones, processes it, and stores it in multiple database platforms using **Python** and **MQTT**. It integrates **MySQL**, **MongoDB**, and **Neo4j** to manage structured, semi-structured, and graph data efficiently.  

The system simulates sensor data for **Temperature**, **Soil Moisture**, and **Soil pH**, generates alerts for abnormal conditions, and maintains historical and relational data for analysis.

---

## **Problem Statement**

Modern farms generate massive sensor data continuously. For farms with hundreds of sensors, managing, storing, and analyzing this data in real-time is challenging.  

**Key Challenges:**
- High volume and high-frequency data.
- Instant detection of abnormal conditions to prevent crop damage.
- Different data types requiring different storage solutions:  
  - Structured: SQL (sensor readings)  
  - Semi-structured: MongoDB (alerts)  
  - Graph relationships: Neo4j (farm-zone-sensor relationships)

**Solution:**  
- **MQTT Broker:** Handles fast and continuous sensor data streams.  
- **Python Processing:** Processes data in real-time.  
- **Multi-Database Integration:**  
  - MySQL for sensor readings  
  - MongoDB for alerts  
  - Neo4j for farm-zone-sensor relationships and alert counts  

---

## **Project Objective**

1. **Collect IoT data using MQTT:**  
   Sensors (Temperature, Moisture, Soil pH) publish readings to MQTT topics.  

2. **Process data using Python:**  
   Python subscriber receives the MQTT messages, decodes the data, checks thresholds, and triggers alerts if needed.  

3. **Store data in multiple databases:**  
   - **MySQL:** Stores all sensor readings with timestamps.  
   - **MongoDB:** Stores alerts with sensor details, zone info, and timestamp.  
   - **Neo4j:** Maintains graph relationships between farms, zones, and sensors; updates min/max values, timestamps, and alert counts.

---

## **Database Structures**

### **MySQL: `smart_agriculture`**

- **farms**: `farm_id`, `farm_name`, `owner_name`, `contact_email`, `contact_phone`  
- **zones**: `zone_id`, `farm_id`, `crop_name`  
- **sensors**: `sensor_id`, `zone_id`, `sensor_type`  
- **readings**: `reading_id`, `sensor_id`, `value`, `timestamp`  

> Each farm has 4 zones, and each zone has 3 sensors (Temperature, Moisture, Soil pH).  

### **MongoDB: `alerts` collection**

- Stores alert documents with fields:  
`sensor_id`, `zone_id`, `sensor_type`, `alert_type`, `value`, `unit`, `timestamp`  

### **Neo4j: Graph Database `smart_agriculture`**

- **Nodes:** `Farm`, `Zone`, `Sensor`  
- **Relationships:**  
  - `HAS_ZONE` (Farm → Zone)  
  - `COLLECTS_DATA_OF` (Sensor → Zone) with `high_alert_count`, `low_alert_count`, `last_updated`  
- **Attributes:**  
  - Sensor nodes track `min_value`, `max_value`, `min_value_timestamp`, `max_value_timestamp`  

---

## **MQTT Setup**

- **Broker:** Mosquitto (localhost:1883)  
- **Topics:** `smart_agriculture/sensors`  
- **Publisher:** Simulates sensor data for all zones and sensors.  
- **Subscriber:** Receives sensor data, processes it, and stores it in databases.  

---


---

## **Setup Instructions**

### **1. Install Dependencies**
```bash
pip install -r requirements.txt
```
### **2. Setup Databases**
- MySQL
```sql
CREATE DATABASE smart_agriculture;
USE smart_agriculture;

CREATE TABLE farms(farm_id INT PRIMARY KEY, farm_name VARCHAR(100), owner_name VARCHAR(100), contact_email VARCHAR(100), contact_phone VARCHAR(15));
CREATE TABLE zones(zone_id VARCHAR(10) PRIMARY KEY, farm_id INT, crop_name VARCHAR(50));
CREATE TABLE sensors(sensor_id VARCHAR(10) PRIMARY KEY, zone_id VARCHAR(10), sensor_type VARCHAR(20));
CREATE TABLE readings(reading_id INT AUTO_INCREMENT PRIMARY KEY, sensor_id VARCHAR(10), value FLOAT, timestamp DATETIME);
```
- MongoDB
Create
Database: smart_agriculture
Collection: alerts

- Neo4j
Create
Database: smart_agriculture
Nodes: Farm, Zone, Sensor
Relationships: Farm HAS_ZONE Zone, Sensor COLLECTS_DATA_OF Zone

3. Download and Start MQTT Broker (mosquitto) in the terminal 
``` bash
mosquitto.exe
```

4.  Run Publisher in another tab of terminal
```bash
python mqtt_publisher.py
```

5. Run Subscriber in another tab of terminal
```bash
python mqtt_subscriber.py
```
## **How It Works**
1. Publisher simulates sensor readings and publishes to MQTT topics.
2. Subscriber listens for messages, decodes JSON, and calls process_sensor_data() from handlers.py.
3. Data Handling:
     - Insert readings into MySQL
     - Generate alerts for out-of-threshold values in MongoDB
     -Update min/max readings, timestamps, and alert counts in Neo4j

## Key Features
    - Real-time data collection and processing
    - Multi-database integration (SQL, MongoDB, Neo4j)
    - Dynamic alert generation based on thresholds
    - Graph-based relationships between farms, zones, and sensors
    - Scalable and modular Python code