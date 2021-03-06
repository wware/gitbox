#! /bin/sh
### BEGIN INIT INFO
# Provides:          gitbox
# Required-Start:    $syslog
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: A box full of lovely little git repositories.
### END INIT INFO

PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/bin

. /lib/lsb/init-functions
SCRIPT=/usr/sbin/gitbox.py
PIDFILE=/var/run/gitbox.pid

start() {
    log_daemon_msg "Starting Gitbox service"
    (cd /opt/git; git instaweb --httpd=webrick --port=80) &
    $SCRIPT &
    pid=$!
    status=$?
    if [ "$status" != "0" ]; then
        log_failure_msg "ouch"
    else
        echo $pid > $PIDFILE
    fi
    echo $!
}

stop() {
    log_daemon_msg "Stopping Gitbox service"
    if [ -f $PIDFILE ]; then
        kill -9 `cat $PIDFILE`
        rm -f $PIDFILE
    fi
    kill -9 $(ps ax | grep gitweb | cut -c -6 | head -1)
}

case "$1" in
  start)
    start
    exit 0
    ;;
  stop)
    stop
    exit 0
    ;;
  restart)
    stop
    start
    exit 0
    ;;
  *)
    echo "Usage: /etc/init.d/shutdown.sh {start|stop|restart}"
    exit 1
    ;;
esac
