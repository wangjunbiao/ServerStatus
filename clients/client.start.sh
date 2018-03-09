#/bin/bash
#Verson:1.2
#Auther:qiubian
#Pragram:This is a startup stop client script.
sergate="/home/jk_status/client-linux.py"
logfile="/home/jk_status/log/client.log"
case "$1" in
        "start")
                ps aux |grep client-linux.py |grep -v grep  >/dev/null
                if [ $? -ne 0 ]
                then
                        echo "start process....."
                        nohup $sergate  >>$logfile 2>&1 &
                        echo "start is OK!"
                else
                        echo "runing....."
                fi
                ;;
        "stop")
                ps aux |grep client-linux.py |grep -v grep  >/dev/null
                if [ $? -eq 0 ]
                then
                        echo "server stop process....."
                        kill `ps aux |grep client-linux.py |grep -v grep|awk '{print $2}'`
                        echo "stop is OK!"
                else
                        echo "server is stop....."
                fi
                ;;
        "status")
                ps aux |grep client-linux.py |grep -v grep  >/dev/null
                if [ $? -eq 0 ]
                then
                        echo "server is start....."
                else
                        echo "server is stop....."
                fi
                ;;
        "reload")
                $0 stop
                $0 start
                ;;
        *)
                #其它输入
                echo "output error,please input start/stop/status"
                ;;
esac
