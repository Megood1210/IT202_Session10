use social_network_pro;

-- Tạo view
create view view_user_activity_status as
select u.user_id, u.username, u.gender, u.created_at,
    case
        when count(p.post_id) > 0 
          or count(c.comment_id) > 0
        then 'Active'
        else 'Inactive'
    end as status
from users u
left join posts p on u.user_id = p.user_id
left join comments c on u.user_id = c.user_id
group by u.user_id, u.username, u.gender, u.created_at;
-- Truy vấn view view_user_activity_status và kiểm tra kết quả thu được
select * from view_user_activity_status;
-- Thống kê số lượng người dùng theo từng trạng thái 
select status, count(*) as user_count from view_user_activity_status
group by status
order by user_count desc;