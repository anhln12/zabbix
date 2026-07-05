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

```
Problem: {EVENT.NAME}

Problem started at {EVENT.TIME} on {EVENT.DATE}
Problem name: {EVENT.NAME}
Host: {HOST.NAME}
Severity: {EVENT.SEVERITY}
Operational data: {EVENT.OPDATA}
Original problem ID: {EVENT.ID}
{TRIGGER.URL}
⚠️⚠️⚠️
```

Với cấu hình Media Type → Script → telegram.sh, Zabbix sẽ tìm script trong thư mục được cấu hình bởi tham số
```
AlertScriptsPath=
```
```
grep ^AlertScriptsPath /etc/zabbix/zabbix_server.conf
AlertScriptsPath=/usr/lib/zabbix/alertscripts
```
- Nhấn Save

3. Gán Media cho User
- Truy cập Administration > Users > Chọn user quản trị (hoặc tạo user mới).
- Chuyển sang tab Media > Nhấn Add.Chọn Type: Telegram.
- Điền Send to: Nhập dãy Chat ID đã lấy ở bước 1.
- Nhấn Add và Save/Update

<img width="1143" height="464" alt="image" src="https://github.com/user-attachments/assets/772b8e57-e9b5-4c7c-9161-785e1a93a053" />

<img width="844" height="249" alt="image" src="https://github.com/user-attachments/assets/9bc25485-e7cd-427d-93a6-e8e39bdfefd6" />

4. Tạo Action kích hoạt cảnh báo
- Truy cập Alert > Actions > Trigger actions > Nhấn Create action.
- Đặt tên Action (hoặc dùng lại Action đã tạo sẵn)
<img width="1314" height="603" alt="image" src="https://github.com/user-attachments/assets/de59e6ba-a997-46e9-acfd-916af8022723" />

Ở tab Operations, thiết lập gửi thông báo qua phương thức Telegram tới user bạn vừa gán

<img width="1321" height="605" alt="image" src="https://github.com/user-attachments/assets/50cfe63f-e20e-4e50-9b3a-85d3072169c8" />

<img width="1311" height="618" alt="image" src="https://github.com/user-attachments/assets/e113d079-73f0-4901-a804-b90640c7d382" />

Subject: OK Resolved: {HOSTNAME}:{TRIGGER.NAME}-status-{TRIGGER.STATUS}

Message:
```
{TRIGGER.NAME} on {HOSTNAME}
Status: {TRIGGER.STATUS}
Severity: {TRIGGER.SEVERITY}
Values: {ITEM.VALUE1}

☑️☑️☑️
```

<img width="1048" height="602" alt="image" src="https://github.com/user-attachments/assets/711221cf-17ff-467e-afa5-3e0fe79787d9" />

