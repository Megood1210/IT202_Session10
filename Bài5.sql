use social_network_pro;

--  Tạo chỉ mục có tên idx_hometown trên cột hometown của bảng users
create index idx_hometown on users(hometown);
-- Truy vấn để tìm tất cả các người dùng (users) có hometown là "Hà Nội" 
select u.username, p.post_id, p.content 
-- Hiển thị thêm post_id và content về các lần đăng bài 
from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
-- Sắp xếp danh sách theo username giảm dần và giới hạn kết quả chỉ hiển thị 10 bài đăng đầu tiên. 
order by u.username desc
limit 10;
-- Kiểm tra kế hoạch thực thi trước và khi có chỉ mục 
explain analyze
select u.username, p.post_id, p.content from users u
join posts p on u.user_id = p.user_id
where u.hometown = 'Hà Nội'
order by u.username desc
limit 10;
