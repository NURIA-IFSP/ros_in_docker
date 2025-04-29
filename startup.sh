#!/bin/bash

export DISPLAY=:1

# Define usuário padrão se não estiver definido
if [ -z "$USER" ]; then
  export USER=$(whoami)
fi

# Cria senha VNC padrão (caso não exista)
if [ ! -f "/home/$USER/.vnc/passwd" ]; then
  mkdir -p /home/$USER/.vnc
  echo "rosvnc" | vncpasswd -f > /home/$USER/.vnc/passwd
  chmod 600 /home/$USER/.vnc/passwd
fi

# Mata sessão anterior (caso exista)
vncserver -kill :1 > /dev/null 2>&1
rm -rf /tmp/.X1-lock /tmp/.X11-unix/X1

# Inicia VNC com XFCE e caminho de fontes explícito
echo "Iniciando VNC..."
vncserver :1 -geometry 1900x900 -depth 24 -fp /usr/share/fonts/X11/misc

echo "VNC server started on DISPLAY=:1"

# Inicia noVNC no navegador
websockify --web=/usr/share/novnc/ --wrap-mode=ignore 6080 localhost:5901 &

echo "noVNC running at http://localhost:6080 (senha: rosvnc)"

# Mantém o container ativo
tail -f /dev/null
