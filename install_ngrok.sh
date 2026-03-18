#!/bin/bash

curl -sSL https://ngrok-agent.s3.amazonaws.com/ngrok.asc \
  | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null \
  && echo "deb https://ngrok-agent.s3.amazonaws.com bookworm main" \
  | sudo tee /etc/apt/sources.list.d/ngrok.list \
  && sudo apt update \
  && sudo apt install ngrok

ngrok config add-authtoken 1k5vl3Ui3IfaWKZrdJe7TME4Phr_6docL49ZMndQKBapKUXJi
service ssh start
nohup ngrok tcp 22 &
curl http://127.0.0.1:4040/api/tunnels
