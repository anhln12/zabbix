Dưới đây là hướng dẫn cài đặt nhanh Zabbix Agent 2 phiên bản 7.0 cho Ubuntu (24.04, 22.04 hoặc 20.04).

1. Cài đặt Repository
Chọn đúng link theo phiên bản OS của bạn:

Ubuntu 24.04 (Noble):
```
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu24.04_all.deb
sudo dpkg -i zabbix-release_7.0-2+ubuntu24.04_all.deb
```
Ubuntu 22.04 (Jammy):
```
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-2+ubuntu22.04_all.deb
sudo dpkg -i zabbix-release_7.0-2+ubuntu22.04_all.deb
```
2. Cài đặt Agent 2
Cập nhật gói và tiến hành cài đặt:
```
sudo apt update
sudo apt install zabbix-agent2 zabbix-agent2-plugin-*
```
3. Cấu hình
Sửa file config:

```
sudo nano /etc/zabbix/zabbix_agent2.conf
```
Cập nhật các tham số chính:

Server=<IP_ZABBIX_SERVER>

ServerActive=<IP_ZABBIX_SERVER>

Hostname=<Tên_Host_Trên_Web_UI>

4. Khởi chạy
```
sudo systemctl restart zabbix-agent2
sudo systemctl enable zabbix-agent2
```

5. Kiểm tra
```
systemctl status zabbix-agent2
# Hoặc kiểm tra log
tail -f /var/log/zabbix/zabbix_agent2.log
```
