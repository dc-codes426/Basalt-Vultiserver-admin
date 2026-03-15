#!/bin/sh
set -e

# Generate htpasswd for Loki basic auth from env vars
LOKI_USER="${LOKI_AUTH_USER:-loki}"
LOKI_PASS="${LOKI_AUTH_PASSWORD:-changeme}"
printf '%s:%s\n' "$LOKI_USER" "$(openssl passwd -apr1 "$LOKI_PASS")" > /etc/nginx/.htpasswd

# Create Loki data directories
mkdir -p /loki/chunks /loki/rules /loki/compactor

exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf
