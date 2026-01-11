use social_network_pro;

-- Tạo một truy vấn để tìm tất cả các bài viết (posts) trong năm 2026 của người dùng có user_id là 1. Trả về các cột post_id, content, và created_at 
select post_id, content, created_at from posts
where user_id = 1
  and year(created_at) = 2026;
-- Tạo chỉ mục phức hợp với tên idx_created_at_user_id trên bảng posts sử dụng các cột created_at và user_id 
create index idx_created_at_user_id on posts(created_at, user_id);
-- kiểm tra kế hoạch thực thi của truy vấn trên trước và sau khi tạo chỉ mục idx_created_at_user_id. So sánh kết quả thực thi giữa hai lần này 
explain analyze
select post_id, content, created_at
from posts
where user_id = 1
  and year(created_at) = 2026;
