SELECT * FROM stu WHERE cname IS NULL
SELECT *  FROM stu WHERE c_id IN('1','2') 枚举方法查询
#函数 当期日期与日期加函数 date_add(date,interval 2 month) 和 addDate(date,int days)
SELECT * FROM product WHERE CURDATE()-ADDDATE(bir_date,longdate)>0
SELECT DATE_ADD((SELECT bir_date FROM product WHERE id=1),INTERVAL  2 MONTH) AS da 只能一条数据？？？？
SELECT * FROM product WHERE CURDATE()-DATE_ADD(bir_date,INTERVAL 2 MONTH)>0
#去处重复数据
SELECT DISTINCT p_name FROM product
SELECT DISTINCT p_name,p_price FROM product
#排序  排序的类型必须是数值类型 默认正序
SELECT * FROM product ORDER BY p_price ASC 正序
SELECT * FROM product ORDER BY p_price DESC 倒序
SELECT * FROM product ORDER BY p_price DESC,id DESC
#char_length(str)
SELECT * FROM product WHERE CHAR_LENGTH(p_name)>3
#md5加密
INSERT INTO puser VALUES('1002',MD5('123456'))
SELECT * FROM puser WHERE username=1002 AND PASSWORD=MD5(123456)
#ifnull函数 汉字必须使用utf-8才能编码 ???
SELECT c_id,IFNULL(cname,'weizhi') gender,card,phone FROM stu

#if函数类似于三目函数 这里不知道为什么又可以用汉字了 ???
SELECT id,p_name,IF(p_price>1000,'奢侈品','平价') FROM product
#相当于java的switch case 函数
SELECT username,PASSWORD,
CASE gender WHEN 0 THEN '男'
WHEN 1 THEN '女' 
ELSE '未知' 
END AS '性别' FROM puser
#case when 第二种使用方式
SELECT username,PASSWORD , CASE WHEN age>=20 THEN '成年' 
WHEN age<=20 THEN '未成年'
ELSE '其他'
END AS 年龄 FROM puser
#计算平均值
SELECT p_name,AVG(p_price) FROM product WHERE p_name LIKE '%雪%'

SELECT COUNT(username) FROM puser
 
SELECT username,PASSWORD ,gender,age FROM puser WHERE age=(SELECT MAX(age) FROM puser)
#这个是错误的,username是默认的第一个数据 而不是查询结果中的数据  所以错误!!!
SELECT MAX(age),username,PASSWORD FROM puser 

SELECT id,SUM(p_price),p_type FROM product GROUP BY p_type 