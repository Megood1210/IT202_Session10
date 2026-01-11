use social_network_pro;

-- Tạo index
create index idx_user_gender on users (gender);
-- Tạo view
create view view_popular_posts as
select p.post_id, u.username, p.content, count(l.user_id) as total_likes, count(c.comment_id) as total_comments from posts p
join users u on p.user_id = u.user_id
left join likes l on p.post_id = l.post_id
left join comments c on p.post_id = c.post_id
group by p.post_id, u.username, p.content;
-- Truy vấn các thông tin của view view_popular_posts 
select * from view_popular_posts;
-- Liệt kê các bài viết có số like + comment > 10, ORDER BY tổng tương tác giảm dần.  
select post_id, username, content, total_likes, total_comments, (total_likes + total_comments) as total_interactions
from view_popular_posts
where (total_likes + total_comments) > 10
order by total_interactions desc;