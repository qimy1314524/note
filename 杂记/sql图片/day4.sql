SELECT  s.username,s.name,s.major,c.`节数`,c.one,c.two,c.three FROM stu s JOIN cour c ON s.`major`=c.`major`
WHERE s.`major`='信息管理'
CREATE TABLE cour_copy AS SELECT * FROM cour
#创建视图 
CREATE OR REPLACE VIEW stu_cour AS 
SELECT  s.username,s.name,s.major,c.`节数`,c.one,c.two,c.three FROM stu s JOIN cour c ON s.`major`=c.`major`
WHERE s.`major`='信息管理'
#删除视图
DROP VIEW stu_cour