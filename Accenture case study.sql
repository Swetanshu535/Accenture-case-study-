use accenture;
select * from class;
select * from class_curriculum;
select * from exam;
select * from exam_paper;
select * from student;
select * from teacher;
select * from teacher_allocation;
-- In the school one teacher might be teaching more than one class. Write a query to identify how many classes each teacher is taking
select teacher_id, count(*)
from teacher_allocation
group by teacher_id;

-- John is one of the teachers who wants to find students whose name matches his. write the query for this
select class_id, count(student_name) as no_of_johns
from student
where student_name like "%John%"
group by class_id;
 
 
-- Every class teacher assign unique roll number to their students. Write a query to assign the right roll number to the students
select Class_id,student_name,row_number() over (partition by class_id Order by student_name) as roll_number 
from student;

-- The principal of the school wants to understand the diversity of students. write a query to show the male and female gender ratio
select class_id,round(sum(if(gender="M",1,0))/sum(if(Gender="F",1,0))) as ratio
from student
group by class_id;

-- every school has teachers with different years of experience. Find out the average experince at this school
select avg(timestampdiff(year,current_date(),date_of_joining)) as avg_experience
from teacher;

-- The marksheet contains half yearly and quaterly exam. Write the query that gives out student wise mark sheet 
select b.exam_name,s.student_name,b.total_marks
from student s join exam b;


-- A teacher wants to find the percentage attained by students with ids 1,4,9,16,25 in the Quaterly exam 
select m.student_id,(sum(m.marks)/sum(e.total_marks))
from exam e join exam_paper m
where m.student_id in (1,4,9,16,25) and e.exam_name="Quarterly"
group by m.student_id;

-- Class teacher want to rank the students on their marks. Write the query for their ranks for the half yearly exams 
select  student_name,rank() over (order by total_marks desc) as rnk, exam_name
from student s join exam e 
where exam_name= "Half Yearly";

select * from exam;
select * from exam_paper;
select * from student;

with c as (
select a.student_name,b.exam_Id,c.Exam_name,c.total_marks
from student a  inner join exam_paper b  on a.student_id=b.student_id inner join exam c on b.exam_id=c.exam_id
where c.Exam_name= "Half Yearly"
)

select a.student_name,rank() over (partition by a.exam_name order by a.total_marks) as rnk
from c a inner join student s on a.student_name=s.student_name

