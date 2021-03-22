#!/bin/bash
if [[ "$1" == "up" ]] || [[ "$1" == "all" ]]; then
    docker-compose up -d
fi

if [[ "$1" == "test" ]] || [[ "$1" == "all" ]]; then
    until docker-compose ps | grep -e "${TEST_NAME:-test}"; do sleep 1; done;
    docker-compose exec -T ${TEST_NAME:-test} /bin/sh -c "timeout 10s sh -c 'until wget -qO- http://${TEST_SERVICE_HOST:-localhost}:${TEST_SERVICE_PORT:-8089}/v1/version; do sleep 1; done'"
    docker-compose exec -T ${TEST_NAME:-test} /bin/sh -c "run-tests-in-virtual-screen.sh"
    TEST_EXIT_CODE=$?
fi

if [[ "$1" == "down" ]] || [[ "$1" == "all" ]]; then
    docker-compose down
fi

if [[ "$1" == "restart" ]]; then
    docker-compose restart
fi

if [[ $UNIT_EXIT_CODE -gt 0 ]] || [[ $TEST_EXIT_CODE -gt 0 ]]; then
    echo -e "\033[0;31mRUN FAIL\033[0m"
    exit 1
else
    echo -e "\033[0;32mRUN PASS\033[0m"
    exit 0
fi
