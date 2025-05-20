import serial
import time

# Update port to your Arduino's port
arduino = serial.Serial('COM5', 9600, timeout=1)
time.sleep(2)  # Wait for Arduino to reset

def move_motor(steps):
    print(f"Moving motor {steps} steps")
    arduino.write(f"{steps}\n".encode())
    while True:
        response = arduino.readline().decode().strip()
        if response == "DONE":
            print("Movimento completo")
            break

# Example usage
move_motor(50)    # Move 400 steps forward
arduino.close()
