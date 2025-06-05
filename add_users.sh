# add_users.sh
#!/usr/bin/env bash
set -e

CSV_FILE="/etc/rstudio/users.csv"

while IFS=: read -r UN PW; do
  id "$UN" &>/dev/null && { echo "user $UN exists – skip"; continue; }
  useradd -m -s /bin/bash "$UN"
  echo "$UN:$PW" | chpasswd
  printf 'created %-10s | pass=%s\n' "$UN" "$PW"
done < "$CSV_FILE"

exec /init
