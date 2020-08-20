-- 使用cmd方式登录
mysql -uroot -p619619 或者
mysql -uroot -p 回车 然后输入密码
-- 使用cmd方式登录数据库 并且制定编码集
mysql -utey -p123456 --default-CHARACTER-SET=gbk
-- 显示数据库
SHOW DATABASES;
-- 使用哪个数据库
USE syso;
-- 显示表
SHOW TABLES;
-- 创建数据库
CREATE DATABASE f17;
-- 删除数据库
DROP DATABASE f17;
CREATE DATABASE IF  NOT EXISTS f17;
DROP DATABASE IF EXISTS f17;
-- 查询uuid
SELECT UUID();
-- 替换操作,去除uuid中的-
SELECT  REPLACE(UUID(),"-","");
-- 查询数据表结构
DESC ss;

-- 创建表 指定主键从多少开始增长
CREATE TABLE ss(
id INT PRIMARY KEY AUTO_INCREMENT,
sname VARCHAR(20) NOT NULL,
sex CHAR(1) 
)AUTO_INCREMENT=100;

-- 显示建表语句
SHOW CREATE TABLE USER;
-- 删除表
DROP TABLE IF NOT EXISTS ss;
-- 修改表
ALTER TABLE ss CHANGE sname  sname VARCHAR(20) NOT NULL UNIQUE;
ALTER TABLE ss MODIFY id INT AUTO_INCREMENT; 

-- 插入数据
INSERT INTO ss(id,sname,sex) VALUES(NULL,'jack','男');
-- 插入多条数据
INSERT INTO ss VALUES(NULL,'tom','男'),(NULL,'lose','女'),(NULL,'faker','男');
-- 更新操作
UPDATE ss SET sex='女' WHERE sname='lose';
-- 找到为空条件
IS NULL
-- 模糊查询
SELECT * FROM ss WHERE sname LIKE '%%'

-- 用cmd命令方式打开数据库并且使用utf-8
mysql -uroot -p619619 --default-CHARACTER-SET=utf8
-- 删除数据
DELETE FROM ss WHERE id='6'
-- 删除表再按照原结构建立表 自增之后的主键也从1开始  效率高 数据最重要 基本不用
TRUNCATE ss;

-- 建立表 并且添加外键约束
CREATE TABLE province(
pid INT PRIMARY KEY AUTO_INCREMENT,
pname VARCHAR(20)
);
CREATE TABLE city(
cid INT PRIMARY KEY AUTO_INCREMENT,
cname VARCHAR(20),
pid INT,
CONSTRAINT fk_p_c FOREIGN KEY (pid) REFERENCES province(pid) ON DELETE CASCADE ON UPDATE CASCADE
);
或者 ON DELETE CASCADE NULL
-- 删除外键约束
ALTER TABLE city DROP FOREIGN KEY fk_p_c;
-- 删除外键约束建立的索引`tey`
ALTER TABLE city DROP INDEX fk_p_c;

ALTER TABLE city ADD CONSTRAINT fk_p_c FOREIGN KEY(pid)  REFERENCES province(pid) ON UPDATE CASCADE ON DELETE SET NULL 

DESC city;
INSERT INTO province VALUES(NULL,'山东'),(NULL,'河北');

INSERT INTO city VALUES(NULL,'济南',1),(NULL,'青岛',1);
-- 级联操作 当主表的修改时从表也修改 当主表删除时从表设为null 或者删除
UPDATE province SET pid=1 WHERE pid=3

SELECT province.*,city.* FROM province JOIN city ON province.`pid`=city.`pid`

-- 删除外键 删除的时候必须同时把创立的索引删除
ALTER TABLE city DROP FOREIGN KEY fk_p_c;
ALTER TABLE city DROP INDEX fk_p_c;

-- 建立索引
CREATE INDEX index_pname ON province(pname);
-- 删除索引
DROP INDEX index_pname ON province;

-- 视图 视图是用来存储查询结果的表 方便以后查询使用 尤其是复杂的查询创建的视图  
-- 视图里的数据可以更改 并且会对原表的数据产生影响  可以更改 但是最好不要更改里面的数据
-- 更好原表的数据也会改变视图里的数据
-- 如果创建试图时指定条件 当更改数据时如果条件不满足了 会从视图中移除 
CREATE OR REPLACE VIEW result
AS
SELECT province.*,city.`cid`,city.`cname` FROM province JOIN city ON 
province.`pid`=city.`pid`

-- 删除视图 
DROP VIEW result;

-- 创建试图时 不允许更改创建视图的条件  但是其他依然可以更改 但是最好不要更改
CREATE OR REPLACE VIEW result
AS
(SELECT province.*,city.`cid`,city.`cname` FROM province JOIN city ON 
province.`pid`=city.`pid` WHERE province.`pid`=1) WITH CHECK OPTION;

UPDATE province SET pid=1 WHERE pid=3

#DCl 用户授权 创建的用户在mysql这个数据库表user中
-- 创建用户 规定只能在哪个主机上使用  规定密码多少
CREATE USER 'tey'@'192.168.137.1' IDENTIFIED BY '123456';
-- 创建用户 可以在任意电脑上使用
CREATE USER 'tey'@'%' IDENTIFIED BY '123456';
-- 授权用户 将某些库的某些权限授予'tey'这个用户
GRANT SELECT,UPDATE ON tey.`province` TO 'tey'@'%';
-- 授予所有权限
GRANT ALL ON *.* TO 'tey'@'%';
-- 授予所有权限 包括授予的权限
GRANT ALL ON *.* TO 'tey'@'%';
-- 删除 要清除权限 然后去mysql这个数据库中删除这个用户
REVOKE ALL ON *.* FROM 'tey'@'%';
USE mysql;
DROP USER 'tey'@'%';

-- 使用cmd命令导出数据库数据
-- 不需要进入mysql里面 直接在根目录下就可以
mysqldump --uroot -p123456 f17>d:\ff.sql
-- 导出某个表
mysqldump --uroot -p123456 f17 city>d:\ff.sql
-- 使用cmd导入sql文件 需要进入数据库中
source d:\123.sql;

-- in
SELECT * FROM USER WHERE id IN(85,2,7,102);

-- 去除重复数据 关键字 DISTINCT
SELECT DISTINCT PASSWORD FROM USER ;
-- 去除null null+任意数据还是null
-- 查询格式 函数ifNull(expor1,expor2) 如果不为null就使用expor1 null则使用expor2
SELECT (column1+IFNULL(column2,0));
SELECT DISTINCT PASSWORD FROM USER 
-- 排序 order by   asc 升序  desc 降序  按照多个条件排序 当前面一个相同时  使用后面的排序规则
SELECT * FROM USER ORDER BY roleid ASC,username DESC;

-- 聚合查询函数 对某列或者多列进行查询  聚合函数不计算null
-- sum avg max min count
SELECT COUNT(id) FROM USER;
SELECT SUM(id) FROM USER;
SELECT AVG(id) FROM USER; -- 计算的是参与列运算的行 比如5行有一个为null 平均就/4
SELECT SUM(id) / COUNT(id) FROM USER;

-- 分组函数 group by  聚合函数一般和分组函数一起使用 
-- 查询相同密码的个数
SELECT PASSWORD,COUNT(*) FROM USER  GROUP BY PASSWORD;
-- 查询每个工作岗位人数
SELECT job,COUNT(*) FROM emp GROUP BY job;
-- 查询每个部门的人数
SELECT deptno,COUNT(*) FROM emp GROUP BY deptno;
-- 查询每个部门中最大的薪水数
SELECT deptno,MAX(sal) FROM emp GROUP BY deptno;

-- 分组加条件 分组聚合后,对整体结果筛选 ,使用having字句
SELECT PASSWORD,COUNT(*) FROM USER GROUP BY PASSWORD HAVING COUNT(*)<40;
-- 查询每个部门及部门工资和 并且部门工资和大于85000
SELECT deptno,SUM(sal) FROM emp GROUP BY deptno HAVING SUM(sal)>85000;
-- 分组加条件  分组前对要参与的数据进行筛选 使用where字句
SELECT PASSWORD,COUNT(*) FROM USER WHERE username>20167320 GROUP BY PASSWORD;
SELECT deptno,COUNT(*) FROM emp WHERE sal>15000 GROUP BY deptno;

-- 分页查询   从第几条开始查 查多少条记录 数据库的下标是从0开始的
-- 分页查询公式  limit(page-1)*pageSize,pageSize;
SELECT * FROM USER ORDER BY id ASC LIMIT 0,20;
SELECT * FROM USER ORDER BY id ASC LIMIT 20,20;

-- 单表查询 总结
 /* 
 in  
 between and
 group by
 having 
 order by
 limit(page-1)*pagesize,pagesize; 
*/

-- mysql提供的一些常用函数
在ppt里 自己看

## 连接查询 内连接 外连接  自然连接
-- 内连接 仅仅做组合 table1的数据*table2的数据
SELECT * FROM table1,table2;
SELECT * FROM table1 INNER JOIN table2;
-- 加上where 条件 过滤无用的数据
SELECT * FROM table1,table2 WHERE table1.column1=table2.column2;
# 外连接查询 就是以某个表为主要查询表
-- 左外连接 左表 left join on 右表 左表里的数据必然查出 右表没有对应数据则为null
SELECT * FROM table1 LEFT JOIN table2 ON table1.column1=table2.column WHERE table1/2.columnN=''
-- 右外连接  左表 right join 右表 右表里的数据必然查出 左表里没有数据则为null
SELECT * FROM table1 RIGHT JOIN table2 ON table1.column1=table2.column WHERE table1/2.columnN=''
-- 自然连接  系统帮你找到两个表的关联的列 帮你做内连接查询
SELECT * FROM table1 NATURAL JOIN table2;
# 子查询  
-- 一个select语句中的查询条件的条件值有可能来自另一个查询
-- 查询工资大于关羽的员工名字和工资
SELECT ename,sal FROM emp WHERE sal>(SELECT sal FROM emp WHERE ename='关羽');
-- 一个 select 语句中 查询的列们中的某列或者多列可能来自另一个查询的结果表中
-- 查询工资大于20部门所与人的工资的人和工资
-- all表示大于每一个相当于max any表示大于任何一个相当于min
SELECT ename,sal FROM emp WHERE sal>ALL(SELECT  sal FROM emp WHERE deptno='20');
SELECT ename,sal FROM emp WHERE sal>ANY(SELECT  sal FROM emp WHERE deptno='20');
-- case when then else end 语句  类似java中的switch
-- 给员工加薪
SELECT ename,sal,
(
 CASE
 WHEN sal<20000 THEN sal*5
 WHEN sal>=20000 THEN sal*2
 ELSE sal
 END
) AS '本月工资' FROM emp;

SELECT user_id,user_name,
(
CASE 
WHEN user_id<10 THEN  10
WHEN user_id>=10 AND user_id<20 THEN  user_id+20
ELSE user_id
END
) AS '加后的学号' FROM USER;

-- 一行显示某个职位人数
SELECT SUM(
CASE 
WHEN job='文员' THEN 1
ELSE o
END
) AS 文员人数,
SUM(
CASE 
WHEN job='销售员' THEN 1
ELSE o
END
) AS 销售人员人数 FROM emp

SELECT SUM(
CASE 
WHEN role_id='admin' THEN 1
ELSE 0
END
) AS admin,
SUM(
CASE 
WHEN role_id='plain' THEN 1
ELSE 0
END
) AS plain FROM USER

#事务
-- 事物的四个特性:
-- 1.一致性经过事务操作后数据库里的数据仍会符合约束
-- 2.隔离性/原子性/持久性
-- 事务隔离 
-- 1.脏读:事务A读到了事务B未提交的数据(有可能提交有可能回滚),并
--   基于数据做了修改
-- 2.不可重复读  两次读取结果不一样 在两次读取之间事务B对数据做了修改
-- 3.虚读幻读 事务A先后使用相同条件进行查询,两次结果读取不一致
-- 因为事务B在两次查询之间插入了符合查询条件的数据
-- 2,3不是毛病 特殊业务场景下可能会有问题  eg:银行统计报表
-- 数据库隔离级别
-- read uncommitted 读为提交 123都能出现
-- read commit 读已提交  防止脏读 23 不能防止
-- repeatable read :读可重读 可以防止12和部分3问题 mysql默认这个级别
-- serializable:串行化  可以防止123 效率极其低
-- 一般使用默认级别
-- 查看数据库隔离级别
SHOW VARIABLES LIKE 'tx_isolation';
SELECT @@tx_isolation;
-- 显示创建表的语句
SHOW CREATE TABLE stu;
-- 设置自动增长从多少开始
ALTER TABLE tablename AUTO_INCREMENT=100

-- 设置自动提交手动 0手动 1自动提交
SET autocommit =0;
INSERT INTO USER(id,username,PASSWORD,NAME,roleid)VALUES(NULL,'20167358','619619tey','孙慧云',1);
COMMIT; -- 提交
ROLLBACK;-- 回滚
SET autocommit=1; -- 自动提交
SHOW VARIABLES LIKE 'autocommit';

ALTER TABLE USER  AUTO_INCREMENT=47;


INSERT INTO USER(id,username,PASSWORD,NAME,roleid)VALUES(NULL,'20167361','619619tey','孙慧云',1);

UPDATE USER SET id =0

SHOW CREATE TABLE USER;

#开启事务 开启事务之后默认不会自动提交
START TRANSACTION;
SELECT * FROM USER;
UPDATE USER SET NAME='任启浩' WHERE id=21;
ROLLBACK;

-- 存储过程在这里有问题
DROP PROCEDURE IF EXISTS insertUser;
DELIMITER //
CREATE PROCEDURE insertUser(IN username VARCHAR(20),IN PASSWORD VARCHAR(20),IN NAME VARCHAR(20),IN roleid INT)
BEGIN
INSERT INTO USER ('username','password','name','roleid') VALUES(username,PASSWORD,NAME,roleid);
END//
DELIMITER ;



