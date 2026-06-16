# Tích hợp Zabbix với Telegram thông qua Media Types Telegram

1. Chuẩn bị Bot Telegram và Chat ID
2. Cấu hình Media Type trên Zabbix Web UI
- Truy cập Alert > Media Types
- Tạo một media type: Telegram-XXX
<img width="722" height="550" alt="image" src="https://github.com/user-attachments/assets/d437f2b7-a0f5-4ad4-b014-cecc28875f6d" />
  * telegram.sh
  * {ALERT.SUBJECT}
  * {ALERT.MESSAGE}
<img width="723" height="232" alt="image" src="https://github.com/user-attachments/assets/aff50de1-c005-46e5-9e14-7e32cecb46ae" />
<img width="720" height="299" alt="image" src="https://github.com/user-attachments/assets/d0f585c6-60c6-4246-abc2-7f434df2b43d" />

Problem: {EVENT.NAME}

Problem started at {EVENT.TIME} on {EVENT.DATE}
Problem name: {EVENT.NAME}
Host: {HOST.NAME}
Severity: {EVENT.SEVERITY}
Operational data: {EVENT.OPDATA}
Original problem ID: {EVENT.ID}
{TRIGGER.URL}
⚠️⚠️⚠️

Với cấu hình Media Type → Script → telegram.sh, Zabbix sẽ tìm script trong thư mục được cấu hình bởi tham số
```
AlertScriptsPath=
```
```
grep ^AlertScriptsPath /etc/zabbix/zabbix_server.conf
AlertScriptsPath=/usr/lib/zabbix/alertscripts
```



