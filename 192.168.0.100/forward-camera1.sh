#!/bin/bash

# SSH tunneling is too slow due to added encryption.
# Use socat to forward camera port instead.

#ssh -N -L 192.168.1.100:8081:localhost:8081 pi@192.168.0.101

socat TCP4-LISTEN:8081,fork,reuseaddr TCP4:192.168.0.101:8081
