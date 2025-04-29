#!/bin/bash

export DISPLAY=:1

# Mata sessão anterior (caso exista)
vncserver -kill :1 > /dev/null 2>&1
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Inicia VNC com XFCE
vncserver :1 -geometry 1280x800 -depth 24
echo "VNC server started on DISPLAY=:1"

# Inicia noVNC no navegador
websockify --web=/usr/share/novnc/ --wrap-mode=ignore 6080 localhost:5901 &

echo "noVNC running at http://localhost:6080"

# Mantém o container ativo
tail -f /dev/null
