
# 说明文档

## 代码下载
```text
git clone https://github.com/kankanol1/yaoqishan.git
```
## 导入数据库
直接用线上数据库不做修改，如果用本地数据库操作如下

1.本地创建名称为`sq_173cmc`数据库

2.将根目录`sq_173cmc.sql`数据导入数据库

3.创建用户
```sql
CREATE USER 'dto'@'%' IDENTIFIED BY 'dtodto';
GRANT ALL  ON sq_173cms.*  TO 'dto'@'%';
FLUSH PRIVILEGES;
```
# 编译器
idea

# 软件架构
前端：javaex

后端：ssm

数据库：mysql

编译器：idea

JDK：1.8

tomcat：tomcat8

前台页面直接访问：http://localhost:8080/




