import RPi.GPIO as GPIO
import time

pin = 7
GPIO.setmode(GPIO.BOARD)
GPIO.setup(pin, GPIO.OUT)

for n in range (0,25):
    GPIO.output(pin,GPIO.HIGH)
    time.sleep(2)
    GPIO.output(pin,GPIO.LOW)
    time.sleep(2)

GPIO.cleanup()
