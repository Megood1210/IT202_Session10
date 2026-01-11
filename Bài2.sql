CREATE DATABASE IF NOT EXISTS social_network_pro
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE social_network_pro;
--  Tạo một view tên view_user_post hiển thị danh sách các User với các cột: user_id(mã người dùng) và total_user_post 
-- (Tổng số bài viết mà từng người dùng đã đăng) 
create view view_user_post as
select u.user_id, count(p.post_id) as total_user_post
from users u
left join posts p on u.user_id = p.user_id
group by u.user_id;

select * from view_user_post;
-- Kết hợp view view_user_post với bảng users để hiển thị các cột: full_name(họ tên) và  total_user_post (Tổng số bài viết mà từng người dùng đã đăng) 
select u.full_name, v.total_user_post from users u
join view_user_post v on u.user_id = v.user_id; -- Join để không loại bỏ user chưa có bài viết 
