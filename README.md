# Домашнее задание к занятию `9.3 Zabbix. Cистема мониторинга Zabbix. Часть 2` - `Алаев Марат`

### Задание 1


[Cкриншот к заданию 1](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-1.png)


### Задание 2 - 3

[1 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-2-1.png)

[2 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbiximg/93-2-2.png)

[3 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-2-3.png)

### Задание 4

[Cкриншот к заданию 4](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-4.png)

### Задние 5

[1 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-5-1.png)
[2 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-5-2.png)
[3 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-5-3.png)

### Задание 6

[Скриншот к заданию 6](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-6.png)

```bash
#!/bin/bash

if [[ $1 == 1 ]]; then
echo "Alaev Marat"; exit 0
fi

if [[ $1 == 2 ]]; then
echo $(date); exit 0
fi
```


### Задание 7

[Скриншот к заданию 7](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-7.png)

```Py
import sys
import os
import re
import datetime

if(sys.argv[1] == '1'):
    print("Marat Alaev")
elif(sys.argv[1] == '2'):
    now = datetime.datetime.now()
    print(now)

else:

    if (sys.argv[1] == '-ping'): # Если -ping
        result=os.popen("ping -c 1 " + sys.argv[2]).read() 
        result=re.findall(r"time=(.*) ms", result) 
        print(result[0])  

    elif (sys.argv[1] == '-simple_print'): # Если simple_print print(sys.argv[2]) 
        print(sys.argv[2])

    else:
        print(f"unknown input: {sys.argv[1]}")
```

### Задание 8 

[1 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-8-1.png)
[2 скриншот](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-8-2.png)

### Задание 9

[Скриншот к заданию 9](https://github.com/MaratAlaev/gitlab-hw/blob/9.3_Zabbix/img/93-9.png)

```bash
sed -i 's/us.archive.ubuntu.com/mirror.linux-ia64.org/g' /etc/apt/sources.list

useradd $1 -s /bin/bash -d /home/test
mkdir /home/test
chown -R test:test /home/test
echo ''$1'    ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers

usermod --password $(openssl passwd -6 $2) root
usermod --password $(openssl passwd -6 $2) $1

if [ $3 == "true" ]; then apt upgrade -y; else echo '$3'=$3; fi

echo "*******************************************************************************"
echo "************************** INSTALLING ZABBIX-AGENT ****************************"
echo "*******************************************************************************"
wget https://repo.zabbix.com/zabbix/6.0/debian/pool/main/z/zabbix-release/zabbix-release_6.0-4%2Bdebian11_all.deb
dpkg -i zabbix-release_6.0-4+debian11_all.deb
apt update 
apt install zabbix-agent -y
sed -i "s/Server=127.0.0.1/Server=$6/g" /etc/zabbix/zabbix_agentd.conf
echo 'UserParameter=bashping[*], /etc/zabbix/bashping $1' >> /etc/zabbix/zabbix_agentd.conf
echo 'UserParameter=my_script[*], python3 /etc/zabbix/test_python_script.py $1 $2' > /etc/zabbix/zabbix_agentd.d/test_user_parameter.conf
systemctl restart zabbix-agent
systemctl enable zabbix-agent

if [[ ! -f /etc/zabbix/test_python_script.py ]]
then
    echo 'import sys' >> /etc/zabbix/test_python_script.py
    echo 'import os' >> /etc/zabbix/test_python_script.py
    echo 'import re' >> /etc/zabbix/test_python_script.py
    echo 'import datetime' >> /etc/zabbix/test_python_script.py
    echo 'if(sys.argv[1] == "1"):' >> /etc/zabbix/test_python_script.py
    echo '  print("Marat Alaev")' >> /etc/zabbix/test_python_script.py
    echo 'elif(sys.argv[1] == "2"):' >> /etc/zabbix/test_python_script.py
    echo '  print(datetime.datetime.now())' >> /etc/zabbix/test_python_script.py
    echo 'else:' >> /etc/zabbix/test_python_script.py
    echo '  if (sys.argv[1] == "-ping"):' >> /etc/zabbix/test_python_script.py
    echo '      result=os.popen("ping -c 1 " + sys.argv[2]).read()' >> /etc/zabbix/test_python_script.py
    echo '      result=re.findall(r"time=(.*) ms", result)' >> /etc/zabbix/test_python_script.py
    echo '      print(result[0])' >> /etc/zabbix/test_python_script.py
    echo '  elif (sys.argv[1] == "-simple_print"):' >> /etc/zabbix/test_python_script.py
    echo '      print(sys.argv[2])' >> /etc/zabbix/test_python_script.py
    echo '  else:' >> /etc/zabbix/test_python_script.py
    echo '      print(f"unknown input: {sys.argv[1]}")' >> /etc/zabbix/test_python_script.py
fi

if [[ ! -f /etc/zabbix/bashping ]]
then
    echo '#!/bin/bash' >> /etc/zabbix/bashping
    echo 'if [[ $1 == 1 ]]; then' >> /etc/zabbix/bashping
    echo 'echo "Alaev Marat"; exit 0' >> /etc/zabbix/bashping
    echo 'fi' >> /etc/zabbix/bashping
    echo 'if [[ $1 == 2 ]]; then' >> /etc/zabbix/bashping
    echo 'echo $(date); exit 0' >> /etc/zabbix/bashping
    echo 'fi' >> /etc/zabbix/bashping
fi

chmod +x /etc/zabbix/bashping


echo "*******************************************************************************"
echo "********************************* END *****************************************"
echo "*******************************************************************************"
```

```Ruby
virt_machines=[
  {
    :hostname => "zabbixagent1",
    :ip => "192.168.56.102"
  },
  {
    :hostname => "zabbixagent2",
    :ip => "192.168.56.103"
  }
]

# Show VM GUI
# Показывать гуй виртмашины
HOST_SHOW_GUI = false 

# VM RAM
# Оперативная память ВМ
HOST_MEMMORY = "512" 

# VM vCPU
# Количество ядер ВМ
HOST_CPUS = 1

# Network adapter to bridge
# В какой сетевой адаптер делать бридж
#HOST_BRIDGE = "Intel(R) Ethernet Connection (2) I219-V" 
HOST_BRIDGE = "Intel PRO/1000 MT Desktop (82540EM)"

# Which box to use
# Из какого бокса выкатываемся
HOST_VM_BOX = "ubuntu/bionic64" 

################################################
# Parameters passed to provision script
# Параметры передаваемые в скрипт инициализации
################################################

# Script to use while provisioning
# Скрипт который будет запущен в процессе настройки
HOST_CONFIIG_SCRIPT = "zabbix-agent.sh" 

# Additional user
# Дополнительный пользователь
HOST_USER = 'test'

# Additional user pass. Root pass will be same
# Пароль дополнительного пользователя. Пароль рута будет таким же
HOST_USER_PASS = '1234' 

# Run apt dist-upgrade
# Выполнить apt dist-upgrade
HOST_UPGRADE = 'false' 

ZABBIX_SERVER_IP = '192.168.56.101'

Vagrant.configure("2") do |config|
	virt_machines.each do |machine|
		config.vm.box = HOST_VM_BOX
		config.vm.define machine[:hostname] do |node|
			node.vm.hostname = machine[:hostname]
			node.vm.network :private_network, bridge: HOST_BRIDGE, ip: machine[:ip], name: "VirtualBox Host-Only Ethernet Adapter", nic_type: "virtio"
			node.vm.provider "virtualbox" do |current_vm, override|
				current_vm.name = machine[:hostname]
				current_vm.gui = HOST_SHOW_GUI
				current_vm.memory = HOST_MEMMORY
				current_vm.cpus = HOST_CPUS
				override.vm.provision "shell", path: 'zabbix-agent.sh', args: [	'test', 	'1234',	'false', 	machine[:hostname], 	machine[:ip],	'192.168.56.101'], run: "once"
			end
		end
	end
end
```