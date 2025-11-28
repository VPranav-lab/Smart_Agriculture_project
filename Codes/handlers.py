import mysql.connector
from pymongo import MongoClient
from neo4j import GraphDatabase
from datetime import datetime


mysql_conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="your_password",
    database="smart_agriculture"
)


mongo_client = MongoClient("mongodb://localhost:27017/")
mongo_db = mongo_client["smart_agriculture"]
alerts_collection = mongo_db["alerts"]


neo4j_driver = GraphDatabase.driver("bolt://localhost:7687", auth=("neo4j", "your_password"))

thresholds = {
    "Temperature": {"high": 45, "low": 0},
    "Moisture": {"high": 75, "low": 6},
    "Soil_pH": {"high": 7.5, "low": 5.0}
}

def save_reading_mysql(sensor_id, value, timestamp):
    with mysql_conn.cursor() as cursor:
        querry = """
            INSERT INTO readings (sensor_id, value, timestamp)
            VALUES (%s, %s, FROM_UNIXTIME(%s))
        """
        cursor.execute(querry, (sensor_id, value, timestamp))
    mysql_conn.commit()

def save_alert_mongodb(sensor_id, zone_id, sensor_type, alert_type, value, timestamp):
    if sensor_type == "Temperature":
        unit = "°C"
    elif sensor_type == "Moisture":
        unit = "%"
    elif sensor_type == "Soil_pH":
        unit = "pH"
    alert_doc = {
        "sensor_id": sensor_id,
        "zone_id": zone_id,
        "sensor_type": sensor_type,
        "alert_type": alert_type,
        "value": value,
        "units": unit,
        "timestamp": datetime.fromtimestamp(timestamp).isoformat()
    }
    alerts_collection.insert_one(alert_doc)

def update_neo4j(sensor_id, zone_id, value, timestamp, alert_type1):
    with neo4j_driver.session() as session:
        
        session.run("""
            MATCH (s:Sensors {sensor_id: $sensor_id})
            SET 
                s.min_value = CASE WHEN s.min_value IS NULL OR $value < s.min_value THEN $value ELSE s.min_value END,
                s.min_value_timestamp = CASE WHEN s.min_value IS NULL OR $value < s.min_value THEN datetime($timestamp) ELSE s.min_value_timestamp END,
                s.max_value = CASE WHEN s.max_value IS NULL OR $value > s.max_value THEN $value ELSE s.max_value END,
                s.max_value_timestamp = CASE WHEN s.max_value IS NULL OR $value > s.max_value THEN datetime($timestamp) ELSE s.max_value_timestamp END
        """, sensor_id=sensor_id, value=value, timestamp=datetime.fromtimestamp(timestamp).isoformat())

        
        alert_type = alert_type1
        querry = None
        if alert_type:
            if (alert_type == "high_temperature" or alert_type == "high_moisture" or alert_type == "high_soil_ph"):
                querry ="""
                    MATCH (s:Sensors {sensor_id: $sensor_id})-[r:COLLECTS_DATA_OF]->(z:Zone {zone_id: $zone_id})
                    
                    SET 
                        r.high_alert_count = CASE WHEN r.high_alert_count IS NULL  THEN 1 ELSE r.high_alert_count+1 END,
                        r.last_updated = datetime($timestamp)
                """
            elif (alert_type == "low_temperature" or alert_type == "low_moisture" or alert_type == "low_soil_ph"):
                querry ="""
                    MATCH (s:Sensors {sensor_id: $sensor_id})-[r:COLLECTS_DATA_OF]->(z:Zone {zone_id: $zone_id})
                    
                    SET 
                        r.low_alert_count = CASE WHEN r.low_alert_count IS NULL  THEN 1 ELSE r.low_alert_count+1 END,
                        r.last_updated = datetime($timestamp)
                """
            session.run(querry, sensor_id=sensor_id, zone_id=zone_id, alert_type=alert_type, timestamp=datetime.fromtimestamp(timestamp).isoformat())

def process_sensor_data(data):
    sensor_id = data["sensor_id"]
    sensor_type = data["sensor_type"]
    zone_id = data["zone_id"]
    value = data["value"]
    timestamp = data["timestamp"]

    
    save_reading_mysql(sensor_id, value, timestamp)

    
    alert_type = None
    if sensor_type in thresholds:
        if value > thresholds[sensor_type]["high"]:
            alert_type = f"high_{sensor_type.lower()}"
        elif value < thresholds[sensor_type]["low"]:
            alert_type = f"low_{sensor_type.lower()}"

    
    if alert_type:
        save_alert_mongodb(sensor_id, zone_id, sensor_type, alert_type, value, timestamp)

    
    update_neo4j(sensor_id, zone_id, value, timestamp, alert_type)
