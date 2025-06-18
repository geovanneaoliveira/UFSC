import serial
import time

# Update port to your Arduino's port

def move_step_motor(steps):
    arduino = serial.Serial('COM5', 9600, timeout=1)
    time.sleep(2)  # Wait for Arduino to reset
    print(f"Moving motor {steps} steps")
    arduino.write(f"{steps}\n".encode())
    while True:
        response = arduino.readline().decode().strip()
        if response == "DONE":
            print("Movimento completo")
            break
    arduino.close()

