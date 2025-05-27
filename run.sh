#!/bin/sh

curl -X POST -H "Authorization: token $SECRET" -H 'Accept: application/vnd.github.v3+json' -d '{"event_type":"run_action"}' https://api.github.com/repos/specmatic/specmatic-order-api/dispatches
curl -X POST -H "Authorization: token $SECRET" -H 'Accept: application/vnd.github.v3+json' -d '{"event_type":"run_action"}' https://api.github.com/repos/specmatic/specmatic-order-ui/dispatches
