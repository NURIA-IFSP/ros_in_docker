#!/bin/bash
export DISPLAY=:1

# Usa TurboVNC
VNC_CMD="/opt/TurboVNC/bin/vncserver"

# Cria senha se não existir
mkdir -p ~/.vnc
[ ! -f ~/.vnc/passwd ] && echo "rosvnc" | $VNC_CMD -passwd ~/.vnc/passwd

# Mata sessões antigas
$VNC_CMD -kill :1 > /dev/null 2>&1
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Inicia VNC
$vncserver :1 -geometry 1900x900 -depth 24

# Inicia noVNC
websockify --web=/usr/share/novnc/ --wrap-mode=ignore 6080 localhost:5901 &

echo "noVNC running at http://localhost:6080 (senha: rosvnc)"

# Mantém o container ativo
tail -f /dev/null
