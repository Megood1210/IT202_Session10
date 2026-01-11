DROP DATABASE IF EXISTS social_network;
CREATE DATABASE social_network;
USE social_network;

CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE posts (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    content TEXT,
    privacy ENUM('PUBLIC', 'FRIEND', 'PRIVATE') DEFAULT 'PUBLIC',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    content TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE likes (
    like_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(post_id),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Users
INSERT INTO users (username, email, phone) VALUES
('alice', 'alice@gmail.com', '0901111111'),
('bob', 'bob@gmail.com', '0902222222'),
('charlie', 'charlie@gmail.com', '0903333333'),
('david', 'david@gmail.com', '0904444444');

-- Posts
INSERT INTO posts (user_id, content, privacy, created_at) VALUES
(1, 'Hello world from Alice', 'PUBLIC', '2024-01-10'),
(2, 'Bob private post', 'PRIVATE', '2024-02-01'),
(3, 'Charlie public sharing', 'PUBLIC', '2024-03-05'),
(1, 'Alice friend-only post', 'FRIEND', '2024-03-20'),
(4, 'David public post', 'PUBLIC', '2024-04-01');

-- Comments
INSERT INTO comments (post_id, user_id, content) VALUES
(1, 2, 'Nice post!'),
(1, 3, 'Welcome Alice'),
(3, 1, 'Good content'),
(5, 2, 'Great post David');

-- Likes
INSERT INTO likes (post_id, user_id) VALUES
(1, 2),
(1, 3),
(3, 1),
(3, 2),
(5, 1),
(5, 3);
-- View hồ sơ người dùng công khai
create view v_user_profile as
select username, email, created_at from users;
-- View News Feed bài viết công khai 
create view v_public_posts as
select u.username, p.content, p.created_at,count(l.like_id) as total_likes from posts p
join users u on p.user_id = u.user_id
left join likes l on p.post_id = l.post_id
where p.privacy = 'PUBLIC'
group by p.post_id, u.username, p.content, p.created_at;
select * from v_public_posts;
-- View có CHECK OPTION
create view v_public_posts_rw as
select post_id, user_id, content, privacy, created_at from posts
where privacy = 'PUBLIC'
with check option;
-- Thử thao tác dữ liệu không hợp lệ
insert into v_public_posts_rw (user_id, content, privacy)
values (2, 'New public post', 'PUBLIC');
SELECT *FROM posts WHERE privacy = 'PUBLIC' ORDER BY created_at DESC;
-- Phân tích truy vấn News Feed
explain select * from posts
where privacy = 'PUBLIC'
order by created_at desc;
 -- Tăng tốc truy vấn hiển thị news feed 
 create index idx_posts_privacy_created on posts (privacy, created_at desc);
-- Tăng tốc truy vấn lấy bài viết theo người dùng
create index idx_posts_user_created on posts (user_id, created_at desc);
 -- So sánh kết quả EXPLAIN trước và sau khi tạo index.
 explain select * from posts
where privacy = 'PUBLIC'
order by created_at desc;
