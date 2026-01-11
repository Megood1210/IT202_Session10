use social_network_pro;

-- câu truy vấn Select tìm tất cả những User ở Hà Nội, kiểm tra truy vấn thực tế
explain analyze
select * from users
where hometown = 'Ha Noi';
-- Tạo một chỉ mục có tên idx_hometown cho cột hometown của bảng User
create index idx_hometown on users(hometown);
-- xóa chỉ mục idx_hometown khỏi bảng user 
 drop index idx_hometown on users;
