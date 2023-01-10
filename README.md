# Домашнее задание к занятию `10.3 Pacemaker` - `Алаев Марат`

### Задание 1

Обнаружение и восстановление сбоев на уровне узлов и
сервисов

Независимость от подсистемы хранения: общий диск не
требуется

Независимость от типов ресурсов: все, что может быть
заскриптовано, может быть кластеризованно;

Поддержка кластеров любого размер

Автоматическая репликация конфига на все узлы кластера;


Основное назначение, менеджмент ресурсами кластера


### Задание 2

отслеживание состояния приложений

оповещение приложений о смене активной ноды кластера

отправка одинаковых сообщений процессам на всех узлах
кластера;

предоставление доступа к базе данных с конфигурацией и
статистикой, а также отправка уведомлений о ее изменениях.

Основное назначение, знать и передавать состояние всех участников кластера


### Задание 3

[Cкриншот к заданию 3](https://github.com/MaratAlaev/gitlab-hw/blob/10.3_Pacemaker/img/10-3-3.png)



www:
```
<cib crm_feature_set="3.6.1" validate-with="pacemaker-3.5" epoch="6" num_updates="4" admin_epoch="0" cib-last-written="Thu                           Jan  5 10:16:29 2023" update-origin="node1" update-client="cibadmin" update-user="root" have-quorum="1" dc-uuid="2">
  <configuration>
    <crm_config>
      <cluster_property_set id="cib-bootstrap-options">
        <nvpair id="cib-bootstrap-options-have-watchdog" name="have-watchdog" value="false"/>
        <nvpair id="cib-bootstrap-options-dc-version" name="dc-version" value="2.0.5-ba59be7122"/>
        <nvpair id="cib-bootstrap-options-cluster-infrastructure" name="cluster-infrastructure" value="corosync"/>
        <nvpair id="cib-bootstrap-options-cluster-name" name="cluster-name" value="newCluster"/>
      </cluster_property_set>
    </crm_config>
    <nodes>
      <node id="1" uname="node1"/>
      <node id="2" uname="node2"/>
    </nodes>
    <resources>
      <primitive id="virtual_ip" class="ocf" type="IPaddr2" provider="heartbeat">
        <instance_attributes id="virtual_ip-instance_attributes">
          <nvpair id="virtual_ip-instance_attributes-cidr_netmask" name="cidr_netmask" value="24"/>
          <nvpair id="virtual_ip-instance_attributes-ip" name="ip" value="192.168.0.10"/>
        </instance_attributes>
        <operations>
          <op name="monitor" interval="60s" id="virtual_ip-monitor-interval-60s"/>
          <op name="start" timeout="20s" interval="0s" id="virtual_ip-start-interval-0s"/>
          <op name="stop" timeout="20s" interval="0s" id="virtual_ip-stop-interval-0s"/>
        </operations>
      </primitive>
    </resources>
    <constraints/>
  </configuration>
  <status>
    <node_state id="2" uname="node2" in_ccm="true" crmd="online" crm-debug-origin="do_update_resource" join="member" expec                          ted="member">
      <lrm id="2">
        <lrm_resources>
          <lrm_resource id="virtual_ip" type="IPaddr2" class="ocf" provider="heartbeat">
            <lrm_rsc_op id="virtual_ip_last_0" operation_key="virtual_ip_monitor_0" operation="monitor" crm-debug-origin="                          do_update_resource" crm_feature_set="3.6.1" transition-key="2:2:7:8b246a2b-97eb-4548-a2de-452618c22e75" transition-magic="                          0:7;2:2:7:8b246a2b-97eb-4548-a2de-452618c22e75" exit-reason="" on_node="node2" call-id="5" rc-code="7" op-status="0" inter                          val="0" last-rc-change="1672931789" last-run="1672931789" exec-time="40" queue-time="0" op-digest="7b04171c8f16df1419d9188                          98cfb19ad"/>
          </lrm_resource>
        </lrm_resources>
      </lrm>
    </node_state>
    <node_state id="1" uname="node1" crmd="online" crm-debug-origin="do_update_resource" in_ccm="true" join="member" expec                          ted="member">
      <lrm id="1">
        <lrm_resources>
          <lrm_resource id="virtual_ip" type="IPaddr2" class="ocf" provider="heartbeat">
            <lrm_rsc_op id="virtual_ip_last_0" operation_key="virtual_ip_monitor_0" operation="monitor" crm-debug-origin="                          do_update_resource" crm_feature_set="3.6.1" transition-key="1:2:7:8b246a2b-97eb-4548-a2de-452618c22e75" transition-magic="                          0:7;1:2:7:8b246a2b-97eb-4548-a2de-452618c22e75" exit-reason="" on_node="node1" call-id="5" rc-code="7" op-status="0" inter                          val="0" last-rc-change="1672931789" last-run="1672931789" exec-time="75" queue-time="0" op-digest="7b04171c8f16df1419d9188                          98cfb19ad"/>
          </lrm_resource>
        </lrm_resources>
      </lrm>
    </node_state>
  </status>
</cib>
```


back:

```
<cib admin_epoch="0" epoch="5" num_updates="0" validate-with="pacemaker-1.2">
  <configuration>
    <crm_config/>
    <nodes/>
    <resources>
      <clone id="WebDate-clone">
        <primitive id="WebDate" class="ocf" type="drbd" provider="linbit">
          <instance_attributes id="WebDate-instance_attributes">
            <nvpair id="WebDate-instance_attributes-drbd_resource" name="drbd_resource" value="/dev/drbd2"/>
          </instance_attributes>
          <operations>
            <op name="demote" timeout="90" interval="0s" id="WebDate-demote-interval-0s"/>
            <op name="monitor" interval="60s" id="WebDate-monitor-interval-60s"/>
            <op name="notify" timeout="90" interval="0s" id="WebDate-notify-interval-0s"/>
            <op name="promote" timeout="90" interval="0s" id="WebDate-promote-interval-0s"/>
            <op name="reload" timeout="30" interval="0s" id="WebDate-reload-interval-0s"/>
            <op name="start" timeout="240" interval="0s" id="WebDate-start-interval-0s"/>
            <op name="stop" timeout="100" interval="0s" id="WebDate-stop-interval-0s"/>
          </operations>
        </primitive>
        <meta_attributes id="WebDate-clone-meta_attributes">
          <nvpair id="WebDate-clone-meta_attributes-clone-max" name="clone-max" value="2"/>
          <nvpair id="WebDate-clone-meta_attributes-clone-node-max" name="clone-node-max" value="1"/>
          <nvpair id="WebDate-clone-meta_attributes-notify" name="notify" value="true"/>
          <nvpair id="WebDate-clone-meta_attributes-promotable" name="promotable" value="true"/>
          <nvpair id="WebDate-clone-meta_attributes-promoted-max" name="promoted-max" value="1"/>
          <nvpair id="WebDate-clone-meta_attributes-promoted-node-max" name="promoted-node-max" value="1"/>
        </meta_attributes>
      </clone>
      <clone id="MysqlDate-clone">
        <primitive id="MysqlDate" class="ocf" type="drbd" provider="linbit">
          <instance_attributes id="MysqlDate-instance_attributes">
            <nvpair id="MysqlDate-instance_attributes-drbd_resource" name="drbd_resource" value="/dev/drbd1"/>
          </instance_attributes>
          <operations>
            <op name="demote" timeout="90" interval="0s" id="MysqlDate-demote-interval-0s"/>
            <op name="monitor" interval="60s" id="MysqlDate-monitor-interval-60s"/>
            <op name="notify" timeout="90" interval="0s" id="MysqlDate-notify-interval-0s"/>
            <op name="promote" timeout="90" interval="0s" id="MysqlDate-promote-interval-0s"/>
            <op name="reload" timeout="30" interval="0s" id="MysqlDate-reload-interval-0s"/>
            <op name="start" timeout="240" interval="0s" id="MysqlDate-start-interval-0s"/>
            <op name="stop" timeout="100" interval="0s" id="MysqlDate-stop-interval-0s"/>
          </operations>
        </primitive>
        <meta_attributes id="MysqlDate-clone-meta_attributes">
          <nvpair id="MysqlDate-clone-meta_attributes-clone-max" name="clone-max" value="2"/>
          <nvpair id="MysqlDate-clone-meta_attributes-clone-node-max" name="clone-node-max" value="1"/>
          <nvpair id="MysqlDate-clone-meta_attributes-notify" name="notify" value="true"/>
          <nvpair id="MysqlDate-clone-meta_attributes-promotable" name="promotable" value="true"/>
          <nvpair id="MysqlDate-clone-meta_attributes-promoted-max" name="promoted-max" value="1"/>
          <nvpair id="MysqlDate-clone-meta_attributes-promoted-node-max" name="promoted-node-max" value="1"/>
        </meta_attributes>
      </clone>
    </resources>
    <constraints/>
  </configuration>
  <status/>
</cib>
```

```
resource www {
    protocol C;
    disk {
        fencing resource-only;
        }
        handlers {
            fence-peer"/usr/lib/drbd/crm-fence-peer.sh";
            after-resync-target"/usr/lib/drbd/crm-unfence-peer.sh";
            }
            syncer
            {
                rate 110M;
                }
                on debian1
                {
                    device /dev/drbd2;
                    disk /dev/vg0/www;
                    address 192.168.123.4:7794;
                    meta-disk internal;
                }
                on debian2
                {
                    device /dev/drbd2;
                    disk /dev/vg0/www;
                    address 192.168.123.5:7794;
                    meta-disk internal;
                }
}
```

```
resource mysql {
    protocol C;
    disk {
        fencing resource-only;
        }
        handlers {
            fence-peer"/usr/lib/drbd/crm-fence-peer.sh";
            after-resync-target"/usr/lib/drbd/crm-unfence-peer.sh";
            }
            syncer
            {
                rate 110M;
                }
                on debian1
                {
                    device /dev/drbd1;
                    disk /dev/vg0/mysql;
                    address 192.168.123.4:7795;
                    meta-disk internal;
                }
                on debian2
                {
                    device /dev/drbd1;
                    disk /dev/vg0/mysql;
                    address 192.168.123.5:7795;
                    meta-disk internal;
                }
}
```