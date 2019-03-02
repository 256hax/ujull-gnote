## Like Action Flow

### 1. Show Likes
1. Call messages#index
2. Show messages/index.html
3. Render partial Like button and Count template (likes/\_likes.html)

### 2. Create Likes
1. Click Like Button (message_likes_path) via Ajax (remote:true)
2. Call likes#create then call reload method

### 3. Show Likes Latest
1. Reload rendering likes/create.js with latest likes count
2. Show latest likes count
