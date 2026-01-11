use social_network_pro;

-- Tạo view
create view view_users_summary as
select u.user_id, u.username, count(p.post_id) as total_posts
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id, u.username;
-- Truy vấn
 select user_id, username, total_posts from view_users_summary
where total_posts > 5;
