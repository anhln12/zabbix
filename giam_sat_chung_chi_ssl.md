# Giám sát chứng chỉ SSL của bạn với Zabbix
Điều kiện:
Bạn có Zabbix server
Máy chủ monitor đã cài đặt Zabbix agent

**Bước 1: Cài đặt script để giám sát SSL**
Bạn hãy nhập đồng thời các lệnh sau để tạo thư mục, tải file và phân quyền file.
```
mkdir -p /usr/lib/zabbix/externalscripts
cd /usr/lib/zabbix/externalscripts
wget https://www.zabbix.org/mw/images/7/71/Zext_ssl_cert.sh --no-check-certificate
mv Zext_ssl_cert.sh zext_ssl_cert.sh
chmod +x zext_ssl_cert.sh
```
Bên dưới là toàn bộ của script.
```
#! /bin/sh
#------------------------------------------------------------
# zext_ssl_cert.sh
# Script checks for number of days until certificate expires or the issuing authority
# depending on switch passed on command line.
#
#Based on script from aperto.fr (http://aperto.fr/cms/en/blog/15-blog-en/15-ssl-certificate-expiration-monitoring-with-zabbix.html)
#with additions by racooper@tamu.edu
#------------------------------------------------------------

DEBUG=0
if [ $DEBUG -gt 0 ]
then
    exec 2>>/tmp/my.log
    set -x
fi

f=$1
host=$2
port=$3
sni=$4
proto=$5

if [ -z "$sni" ]
then
    servername=$host
else
    servername=$sni
fi

if [ -n "$proto" ]
then
    starttls="-starttls $proto"
fi

case $f in
-d)
end_date=`openssl s_client -servername $servername -host $host -port $port -showcerts $starttls -prexit 2>/dev/null |
          sed -n '/BEGIN CERTIFICATE/,/END CERT/p' |
          openssl x509 -text 2>/dev/null |
          sed -n 's/ *Not After : *//p'`

if [ -n "$end_date" ]
then
    end_date_seconds=`date '+%s' --date "$end_date"`
    now_seconds=`date '+%s'`
    echo "($end_date_seconds-$now_seconds)/24/3600" | bc
fi
;;

-i)
issue_dn=`openssl s_client -servername $servername -host $host -port $port -showcerts $starttls -prexit 2>/dev/null |
          sed -n '/BEGIN CERTIFICATE/,/END CERT/p' |
          openssl x509 -text 2>/dev/null |
          sed -n 's/ *Issuer: *//p'`

if [ -n "$issue_dn" ]
then
    issuer=`echo $issue_dn | sed -n 's/.*CN=*//p'`
    echo $issuer
fi
;;
*)
echo "usage: $0 [-i|-d] hostname port sni"
echo "    -i Show Issuer"
echo "    -d Show valid days remaining"
;;
esac
```

**Kiểm tra chứng chỉ SSL**
Để kiểm tra thử script có check cert đúng hay không. Mình chạy lệnh sau để check thử. Và như ảnh thì kết quả xuất hiện site mình ssl còn 63 ngày.
```
root@sv:/usr/lib/zabbix/externalscripts# ./zext_ssl_cert.sh -d dotrungquan.info 443
63
root@sv:/usr/lib/zabbix/externalscripts# ./zext_ssl_cert.sh -i dotrungquan.info 443
= R3
```
**Bước 2: Import Template SSL check**
Bây giờ bạn hãy tải Template về và bắt đầu import. Mình để link ở Github bên dưới và bạn hãy click vào để tải về nhé.

Link download từ Github tại đây
https://github.com/muutech/zabbix-templates/blob/84775023e51cf6318ec04bb490ea567230f075b5/SSL/Template%20SSL%20Cert%20Check%20External.xml

Sau khi tải về xong, bạn hãy Import (nhập) template vào Zabbix server. Click chọn Configuration => Templates và chọn Import như ảnh.

![image](https://user-images.githubusercontent.com/18412583/187639824-7392dfb0-cd62-499f-8e83-aadcd9705209.png)

Sau đó bạn tìm template đã tải về ở máy tính và chọn Import.
![image](https://user-images.githubusercontent.com/18412583/187639936-c2dee9af-32ba-4493-b8c4-27bba1c9ef2c.png)

Kiểm tra Template đã xuất hiện thành công.
![image](https://user-images.githubusercontent.com/18412583/187639980-4a8e5cea-c107-41f4-8011-74b2c18daa49.png)

**Bước 3: Thêm Template cho host**
Tiếp đến bạn hãy thêm Template cho host. Bạn chọn Configuration => Hosts, sau đó tìm Template MyTemplates và Update
![image](https://user-images.githubusercontent.com/18412583/187640141-69bcd14e-2418-4dc5-a3e3-70514e7c8515.png)

