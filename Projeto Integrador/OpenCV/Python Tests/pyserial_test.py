import serial
try:
    ser = serial.Serial('COM5', 9600)  # Windows
    # ser = serial.Serial('/dev/ttyUSB0', 9600)  # Linux/macOS
    print(f"Port {ser.name} open: {ser.is_open}")
except serial.SerialException as e:
    print(f"Error opening port: {e}")
    exit()