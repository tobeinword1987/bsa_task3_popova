#Запрос выводит всех пользователей в возрасте от 20 лет с количеством книг более 5
select u.*,count(u.id) as count_books 
from users u 
join users_books ub on ub.user_id=u.id  
where u.age>20 
group by u.id 
having count_books>5;

#Запрос выводит пользователей, в имени которых присутствует число 3
select * from users where first_name like '%3%';
#или
select * from users where instr(first_name,'3')>0;

#Запрос выводит список пользователей которые не брали книгу с именем "Book #21"
select users.* 
from users 
where id not in
(select u.id 
from users u 
join users_books ub on ub.user_id=u.id 
join books b on b.id=ub.book_id 
where b.title='Book #21');

#Запрос добавляет поле is_active в таблицу users;
ALTER TABLE users ADD is_active int;

#Запрос проставляет is_active = 1 для пользователей, которые взяли как минимум одну книгу
update users u join users_books ub on ub.user_id=u.id set u.is_active=1;

#Запрос добавит поле isbestseller (bool) в таблицу books
ALTER TABLE books ADD isbestseller bool;

#Запрос выставит isbestseller = 1 для книг, которые были взяты пользователями более 10 раз
update books set isbestseller=1 
where id in
(
select book_id 
from (select ub.book_id,count(book_id) as times from users_books ub join books b on b.id=ub.book_id group by book_id having(times>10)) ub2
);





