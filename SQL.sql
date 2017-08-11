--CS348 Assignment01 Spring2017
--Name: Chen Chen
--UWID: 20518383

--Q1
select distinct s.snum, s.sname from student s \
    where s.year = 2 and exists \
	(select * from mark m1, mark m2 \
           where s.snum = m1.snum \
		and s.snum = m2.snum \
		and m1.cnum <> m2.cnum \
		and m1.cnum like 'CS1%' \
		and m2.cnum like 'CS1%' \
		and m1.grade < 65 \
		and m2.grade < 65)


--Q2
select p.pname,p.pnum from professor p,class c, student s, mark m \
  where p.pnum = c.pnum \
   and p.dept = 'CS' \
   and c.cnum = 'CS348' \
   and m.snum = s.snum \
   and m.cnum = c.cnum \
   and m.grade < 60


--Q3
select distinct p.pnum,p.pname from professor p \
   where p.dept != 'PM' and exists \
     (select * from class c \
       where c.cnum = 'CS245' \
        and c.pnum = p.pnum  and not exists \
        (select * from mark m \ 
           where m.cnum = c.cnum \
             and m.term = c.term \
             and m.section = c.section) \
        and not exists \
        (select * from class j \
         where j.cnum = 'CS245' \
          and j.pnum = p.pnum \
          and j.term != c.term))


--Q4
select distinct s.snum, s.sname from student s \
    where s.year = 4 and exists \
     (select * from mark m1, mark m2 \
       where m1.snum = s.snum \
         and m2.snum = m2.snum \
         and m1.cnum != 'CS348' \
         and m2.cnum != 'CS240')


--Q5
select p.pnum, p.pname from professor p \
  where p.dept = 'CS' and p.pnum not in \
   (select distinct c.pnum from class c, mark m \
     where c.cnum = m.cnum \
      and c.cnum = 'CS348' \
      or c.cnum = 'CS234')


--Q6
select distinct s.snum,s.sname,s.year from student s,mark m \
 where m.snum = s.snum \
  and m.cnum = 'CS240' \
  and m.grade >= (select max(n.grade-5) as highest from mark n \
     where n.cnum = 'CS240') 


--Q7
select p.pnum, p.pname from professor p,class c \
  where c.pnum = p.pnum \
   and c.cnum = 'CS240' and exists \
    (select s.snum from student s,mark m \
      where s.snum = m.snum \
       and c.cnum = m.cnum \
       and m.grade = (select max(n.grade) as hightest from mark n \
        where n.cnum = 'CS240'))


--Q8
select s.snum,s.sname from student s \
  where s.year > 3 \
    and s.snum not in (select e.snum \
    	from enrollment e, class c, professor p \
    	where p.dept = 'CO' \
    	and c.cnum = e.cnum \
    	and c.section = e.section \
    	and c.term = e.term \
    	and c.pnum = p.pnum) \
    and s.snum not in (select m.snum from mark m \
    	where m.cnum like 'CS%' \
    	and m.grade < 85)


--Q9
with lowest(pnum) as \
  (select c.pnum from class c, mark m \
  	where c.cnum = m.cnum \
  	  and c.term = m.term \
  	  and c.section = m.section \
  	  and m.grade < 65) \
  (select count(p.pnum)*1.0 / \
  (select count(p.pnum) from professor p \
  	where p.dept = 'CS' \
  	 and p.pnum in (select pnum from lowest)) \
         as ratio from professor p \
         where p.dept = 'PM' \
          and p.pnum in (select pnum from lowest))


--Q10
select p.pnum,p.pname, c.term, c.section, c.cnum, u.cname, min(m.grade) \
 as minimumgrade, max(m.grade) as maximumgrade from class c, schedule s, \
 mark m, course u, professor p \
 where p.dept = 'CS' \
  and s.cnum = c.cnum \
  and c.pnum = p.pnum \
  and s.section = c.section \
  and s.term = c.term \
  and (s.day = 'Monday' or s.day = 'Friday') \
  and m.section = c.section \
  and m.term = c.term \
  and m.cnum = c.cnum \
  and u.cnum = c.cnum \
 group by p.pnum, p.pname,u.cname,c.cnum,c.term,c.section
