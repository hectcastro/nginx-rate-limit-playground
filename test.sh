#!/bin/bash

set -e
set -o pipefail

# Ensure that we cleanup on exit (regardless of outcome)
trap 'docker-compose rm --stop --force' EXIT

docker-compose up -d nginx

# Wait for Nginx to be up before executing tests
until $(curl --output /dev/null --silent --head --fail http://localhost:8000); do
    printf '.'
    sleep 3
done

echo -e "\nStarting rate limit tests:\n"

if curl -o /dev/null -s -w "%{http_code}\n" "http://localhost:8000?token=Joker" | grep 200 &> /dev/null; then
    echo "  Successfully ALLOWED first request"
else
    echo -e "  Failed ALLOWING first request\n"
    exit 1
fi

# Request allowed via `burst` parameter to `limit_req`
if curl -o /dev/null -s -w "%{http_code}\n" -H "Authorization: Joker" "http://localhost:8000" | grep 200 &> /dev/null; then
    echo "  Successfully ALLOWED second request"
else
    echo -e "  Failed ALLOWING second request\n"
    exit 1
fi

# Fails because both `Authorization` header and `token` query string are keys
if curl -o /dev/null -s -w "%{http_code}\n" "http://localhost:8000?token=Joker" | grep 429 &> /dev/null; then
    echo "  Successfully LIMITED third request"
else
    echo -e "  Failed LIMITING third request\n"
    exit 1
fi

echo -e "\nAll tests succeeded!\n"
