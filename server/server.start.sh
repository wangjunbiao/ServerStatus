#/bin/bash
#Verson:1.2
#Auther:qiubian
#Pragram:This is a startup stop service script.
sergate="/home/jk_status/server/sergate"
config="/home/jk_status/server/config.json"
webdir="/var/www/html/F118/"
logfile="/home/jk_status/server/log/status.log"
case "$1" in
        "start")
                ps aux |grep sergate |grep -v grep  >/dev/null
                if [ $? -ne 0 ]
                then
                        echo "start process....."
                        nohup $sergate --config=$config --web-dir=$webdir >>$logfile 2>&1 &
                        echo "start is OK!"
                else
                        echo "runing....."
                fi
                ;;
        "stop")
                ps aux |grep sergate |grep -v grep  >/dev/null
                if [ $? -eq 0 ]
                then
                        echo "server stop process....."
                        kill `ps aux |grep sergate |grep -v grep|awk '{print $2}'`
                        echo "stop is OK!"
                else
                        echo "server is stop....."
                fi
                ;;
        "status")
                ps aux |grep sergate |grep -v grep  >/dev/null
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
