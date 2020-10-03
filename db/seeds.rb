User.destroy_all
Post.destroy_all
Friendship.destroy_all

u1 = User.create(name: "1", email: "1@1.com", gender: "m", password: 11111111)
u2 = User.create(name: "2", email: "2@2.com", gender: "m", password: 22222222)
u3 = User.create(name: "3", email: "3@3.com", gender: "f", password: 33333333)

u1.posts.create(body: "1")
u2.posts.create(body: "2")
u3.posts.create(body: "3")