for i in $(seq -w 1 50); do
  pw=$(cat /dev/urandom | tr -dc 'A-Za-z0-9' | head -c12)
  echo "user${i}:${pw}"
done > users.csv
