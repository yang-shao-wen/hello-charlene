#!/bin/bash

# SSH tunneling is too slow due to added encryption.
# Use socat to forward camera port instead.

#ssh -N -L 192.168.1.100:8082:localhost:8081 pi@192.168.0.102

socat TCP4-LISTEN:8082,fork,reuseaddr TCP4:192.168.0.102:8081
