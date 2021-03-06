#!/bin/sh

set -e # Do not continue if jmeter fails

: ${JMETER:=jmeter}
export HEAP="-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m"
date="$(date +%F-%H-%M-%S)"

for scenario in nginx golang-net-http golang-fasthttp; do
  echo
  echo "================================================================================"
  echo "Running scenario $scenario..."
  echo "================================================================================"
  echo
  export JVM_ARGS="-Djmeter.reportgenerator.report_title=$scenario"
  $JMETER -n -t golang-http-benchmark.jmx -l "results-$date-$scenario.csv" -e -o "report-$date-$scenario" -Jscenario=$scenario
  sleep 2
done
