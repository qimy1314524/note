#========day_2.1=========
ALTER TABLE stu ADD tea_id VARCHAR(30)
ALTER TABLE stu ADD FOREIGN KEY
(tea_id)  REFERENCES teacher(tea_id)
ALTER TABLE stu DROP FOREIGN KEY stu_ibfk_1
ALTER TABLE stu DROP INDEX tea_id
ALTER TABLE stu DROP FOREIGN KEY tea_stu_id
ALTER TABLE stu DROP INDEX tea_stu_id
ALTER TABLE stu ADD CONSTRAINT tea_stu_id FOREIGN KEY (tea_id) REFERENCES teacher(tea_id) ON UPDATE CASCADE ON DELETE CASCADE
UPDATE teacher SET tea_id=14 WHERE tea_id=11
#==========day2.2=============== 
 创建索引
CREATE INDEX sname_index ON stu(cname) 
ALTER TABLE stu DROP INDEX stu_index
DROP INDEX sname_index ON stu

SELECT * FROM product WHERE p_name LIKE '雪%'以雪开头的
SELECT * FROM product WHERE  p_name LIKE '%雪%'带雪的
SELECT * FROM product WHERE  p_name LIKE '雪__'以雪开头后面两个字符
