import os
import sys
import time
from subprocess import check_output

import daemon


def get_dashd_pid():
    try:
        with open(dashd_pidfile, 'r') as f:
            return int(f.read().strip())
    except Exception:
        return 0

def is_executed_pid(name, pid):
    try:
        ll = check_output(["pidof", name]).split()
        for id in ll[:]:
            if int(id) == pid:
                return True
        return False
    except:
        return False

def write_log(msg):
    try:
        with open(logfile, 'a+') as f:
                f.write(time.strftime("%Y-%m-%d %H:%M:%S ",time.localtime()) + msg + '\n')
    except IOError:
        pass

class DaemonDashd(daemon.daemon_base) :

    def __init__(self, pdfile, workpath):
        daemon.daemon_base.__init__(self, pdfile, workpath)
        self.dashd_pid = get_dashd_pid()
    def run(self):
        write_log("................................")
        write_log(">> mnservice run - pid = {0}".format(self.pid))
        write_log("................................")
        if self.dashd_pid :
            write_log("-> dashd find - pid = {0}".format(self.dashd_pid))
        while True:
            if not is_executed_pid('dashd', self.dashd_pid):
                write_log("** dashd not find - pid = {0}".format(self.dashd_pid))
                pp = self.workpath + '/' + 'dashd'
                try:
                    os.spawnl(os.P_WAIT, pp, '')
                    time.sleep(2)
                    self.dashd_pid = get_dashd_pid()
                    write_log("-> dashd restart - pid = {0}".format(self.dashd_pid))

                except:
                    pass
            time.sleep(10*60)


    def stop(self):
        if self.dashd_pid:
            write_log("<< mnservice stop - pid = {0}".format(self.pid))


if __name__ == '__main__':
    """Daemon test logic.

	This logic must be called as seperate executable (i.e. python3
	daemon.py start/stop/restart).	See test_daemon.py for
	implementation.
	"""
    usage = 'Missing parameter, usage of test logic:\n' + \
            ' % python3 mnservice.py start|stop dash_daemon_directory dashd_pidfile\n'
    if len(sys.argv) < 3:
        sys.stderr.write(usage)
        sys.exit(2)

    pidfile = '/tmp/mnservice.pid'
    logfile = '/tmp/mnservice.log'
    dashd_pidfile = sys.argv[3]

    dc = daemon.daemon_ctl(DaemonDashd, pidfile, sys.argv[2])

    if sys.argv[1] == 'start':
        dc.start()
    elif sys.argv[1] == 'stop':
        dc.stop()

