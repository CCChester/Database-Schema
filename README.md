# Database-Schema
The conceptual view of the database
(and also the single external view) is illustrated by the following relational database schema.
Note that this includes an indication of primary and foreign key constraints in the manner
discussed in class.  The SQL commands for defining the base tables for this schema and
for inserting sample test data should be downloaded from the course web site.
The  schema  stores  information  about  both  ongoing  and  past  classes  for  a  course.   In
particular,  this  means  two  things:  (1)no marks  are  recorded  for  any  enrollment  of  an ongoing class, and (2) for a past class, a mark is recorded for
each of its enrollments.  Also, see the above-mentioned SQL commands for samples of data values, in particular, values for attributes cnum
and term. Finally,  you may assume that each class has at least one enrollment and that a department has at least one professor.

