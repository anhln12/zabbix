# Giám sát máy chủ với Zabbix Server
**Bước 1: Tạo một Host mới để giám sát**
Bạn click vào Configuration => Host => Create Host để tạo mới.
![image](https://user-images.githubusercontent.com/18412583/187640930-a19b79e8-38d9-4ab2-9d63-dacde340f7a0.png)

Tiếp theo bạn hãy nhập vào thông tin sau

Hostname: Đặt tên cho Host
Group: Mỗi Host có thể có ít nhất 1 group, ở đây mình chọn Linux servers
Interfaces: Nhập vào IP máy chủ cần monitor
![image](https://user-images.githubusercontent.com/18412583/187640953-cc6e01a5-137d-4fea-8511-72b2dc825b4a.png)

**Bước 2: Chọn Templates để giám sát dịch vụ**
Ở Zabbix hỗ trợ rất nhiều Templates, tuy nhiên ở bài viết này mình chỉ hướng dẫn thêm một số Template thường sử dụng nhất để giám sát một máy chủ web.

Sau đó bạn chuyển sang Tab Templates. Link new templates hãy chọn Template cần Monitor. Một số Template mình thường sử dụng nhất là.

HTTPS Service
ICMP Ping
Linux by Zabbix agent
MySQL by Zabbix agent
Sau kho thêm xong, bạn click Add để thêm vào.
![image](https://user-images.githubusercontent.com/18412583/187641016-d37085c7-3330-41f2-9276-4d3945191525.png)
Bây giờ bạn quay lại mục Host bạn sẽ thấy Host vừa thêm.
![image](https://user-images.githubusercontent.com/18412583/187641062-b637ea46-eccc-415f-98fd-72ee419d026d.png)
