#!/bin/sh
### BEGIN INIT INFO
# Provides:          unicorn
# Required-Start:    $remote_fs $syslog
# Required-Stop:     $remote_fs $syslog
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start unicorn at boot time
# Description:       Run input app server
### END INIT INFO
set -e
# Example init script, this can be used with nginx, too,
# since nginx and unicorn accept the same signals

if [ -f /etc/default/unicorn ]; then
  . /etc/default/unicorn
fi

CMD="$DAEMON $UNICORN_OPTS"

action="$1"
set -u

cd $APP_ROOT || exit 1


sig () {
  test -s "$PID" && kill -s $1 `cat $PID`
}

case $action in
status )
  sig 0 && echo >&2 "unicorn is running." && exit 0
  echo >&2 "unicorn is not running." && exit 1
  ;;
start)
  sig 0 && echo >&2 "Already running" && exit 0
  su - root -c "export PID=$PID; $CMD"
  ;;
stop)
  sig QUIT && exit 0
  echo >&2 "Not running"
  ;;
force-stop)
  sig TERM && exit 0
  echo >&2 "Not running"
  ;;
restart|reload)
  sig HUP && echo reloaded OK && exit 0
  echo >&2 "Couldn't reload, starting '$CMD' instead"
  su - root -c "export PID=$PID; $CMD"
  ;;
reopen-logs)
  sig USR1
  ;;
*)
  echo >&2 "Usage: $0 <start|stop|restart|force-stop>"
  exit 1
  ;;
esac