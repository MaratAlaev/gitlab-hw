# Домашнее задание к занятию `11.3. ELK` - `Алаев Марат`


### Задание 1


[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/1-1.png)


### Задание 2
  
[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/2-1.png)



[Cкриншот 2](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/2-2.png)



### Задание 3

[Cкриншот 1](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/3-1.png)
[Cкриншот 2](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/3-2.png)
[Cкриншот 3](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/3-3.png)
[Cкриншот 4](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/3-4.png)
[Cкриншот 5](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/3-5.png)
[Cкриншот 6](https://github.com/MaratAlaev/gitlab-hw/blob/11.4_RabbitMQ/img/3-6.png)


### Задание 4

- hosts: rmqhost
  become: yes

  tasks:

    - name: "Add IP + hosts"
      lineinfile:
       dest: /etc/hosts
       regexp: '.*{{ item }}$'
       line: "{{ hostvars[item].ansible_ssh_host }} {{item}}"
       state: present
      when: hostvars[item].ansible_ssh_host is defined
      with_items: "{{ groups.rmq }}"

    - name: "Install rabbitmq-server"
      apt:
        name: "rabbitmq-server"

    - name: "Start rabbitmq-server"
      systemd:
        name: rabbitmq-server
        enabled: true
        state: started
    
    - name: "Start rabbitmq_management"
      command: "sudo rabbitmq-plugins enable rabbitmq_management"

    - name: "Restart rabbitmq-server"
      systemd:
        name: rabbitmq-server
        state: restarted
        
    - name: "Fetch erlang.cookie rabbitmq"
      fetch:
       src:  /var/lib/rabbitmq/.erlang.cookie
       dest: /home/marat/myansible/
       flat: true

    - name: "add_user"
      command: "sudo rabbitmqctl add_user marat 123456"

    - name: "set_user_tags"
      command: "sudo rabbitmqctl set_user_tags marat administrator"


- hosts: rmqnode
  become: yes

  tasks:

    - name: "Add IP + hosts
      lineinfile:
       dest: /etc/hosts
       regexp: '.*{{ item }}$'
       line: "{{ hostvars[item].ansible_ssh_host }} {{item}}"
       state: present
      when: hostvars[item].ansible_ssh_host is defined
      with_items: "{{ groups.rmq }}"

    - name: "Install rabbitmq-server"
      apt:
        name: "rabbitmq-server"

    - name: "Start rabbitmq-server"
      systemd:
        name: rabbitmq-server
        enabled: true
        state: started
    
    - name: "Start rabbitmq_management"
      command: "sudo rabbitmq-plugins enable rabbitmq_management"

    - name: "Restart rabbitmq-server"
      systemd:
        name: rabbitmq-server
        state: restarted

    - name: "Copy .erlang.cookie"
      copy:
       src: /home/marat/myansible/.erlang.cookie
       dest: /var/lib/rabbitmq/

    - name: "Restart rabbitmq-server"
      systemd:
        name: rabbitmq-server
        state: restarted

    - name: "Stop app"
      command: "sudo rabbitmqctl stop_app"

    - name: "Join host"
      command: "sudo rabbitmqctl join_cluster rabbit@machine1"
    
    - name: "Start app"
      command: "sudo rabbitmqctl start_app"

    - name: "set_policy"
      command: sudo rabbitmqctl set_policy ha-all ".*" '{"ha-mode":"all"}'



  
