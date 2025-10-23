#!/bin/bash
# fetch_and_format_proxyscrape.sh

# ProxyScrape API endpoint: (example for HTTP & SOCKS4 & SOCKS5)
API_URL="https://api.proxyscrape.com/v2/?request=displayproxies&protocol=all&timeout=10000&country=all&ssl=all&anonymity=all"

OUT_FILE="proxyscrape_list.txt"
FORMATTED="formatted_proxies.txt"

echo "Fetching proxy list from ProxyScrape..."
curl -s "$API_URL" > "$OUT_FILE"

if [[ ! -s "$OUT_FILE" ]]; then
  echo "Failed to fetch or empty proxy list."
  exit 1
fi

echo "Parsing and formatting..."

# The ProxyScrape output is usually lines like:
#   1.2.3.4:8080
#   5.6.7.8:1080
# Each line is IP:PORT — protocol is not always given; often it's HTTP, but some are SOCKS too.

# If protocol is not known, you may assume HTTP or try both.
# Here’s a simple logic: assume HTTP by default.

echo "[ProxyList]" > "$FORMATTED"
while IFS= read -r line; do
  # skip empty or comment
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  ip="${line%%:*}"
  port="${line##*:}"
  # default to http
  echo "http $ip $port" >> "$FORMATTED"
done < "$OUT_FILE"

echo "Done. Formatted file: $FORMATTED"
echo "Paste this block into your proxychains.conf under [ProxyList]:"
echo
cat "$FORMATTED"
#!/bin/bash
# fetch_and_format_proxyscrape.sh

# ProxyScrape API endpoint: (example for HTTP & SOCKS4 & SOCKS5)
API_URL="https://api.proxyscrape.com/v2/?request=displayproxies&protocol=all&timeout=10000&country=all&ssl=all&anonymity=all"

OUT_FILE="proxyscrape_list.txt"
FORMATTED="formatted_proxies.txt"

echo "Fetching proxy list from ProxyScrape..."
curl -s "$API_URL" > "$OUT_FILE"

if [[ ! -s "$OUT_FILE" ]]; then
  echo "Failed to fetch or empty proxy list."
  exit 1
fi

echo "Parsing and formatting..."

# The ProxyScrape output is usually lines like:
#   1.2.3.4:8080
#   5.6.7.8:1080
# Each line is IP:PORT — protocol is not always given; often it's HTTP, but some are SOCKS too.

# If protocol is not known, you may assume HTTP or try both.
# Here’s a simple logic: assume HTTP by default.

echo "[ProxyList]" > "$FORMATTED"
while IFS= read -r line; do
  # skip empty or comment
  [[ -z "$line" || "$line" =~ ^# ]] && continue

  ip="${line%%:*}"
  port="${line##*:}"
  # default to http
  echo "http $ip $port" >> "$FORMATTED"
done < "$OUT_FILE"

echo "Done. Formatted file: $FORMATTED"
echo "Paste this block into your proxychains.conf under [ProxyList]:"
echo
cat "$FORMATTED"
