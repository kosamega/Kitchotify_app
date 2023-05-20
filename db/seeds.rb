# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(
  name: 'admin_user',
  password: 'password',
  password_confirmation: 'password',
  bio: '管理者',
  admin: true
)

Playlist.create!(
  user_id: 1,
  name: 'playlist1',
  public: true
)

5.times do |n|
  Album.create!(
    name: "月吉#{180+n}号",
    released: true,
    kiki_taikai_date: '2023-01-01',
    designer_id: n+1
  )

  Artist.create!(
    name: "アーティスト#{n+1}"
  )

  Music.create!(
    name: "music#{n+1}",
    album_id: n+1,
    artist_id: n+1
  )
  
  User.create!(
    name: "member_user#{n+1}",
    password: 'password',
    password_confirmation: 'password'
  )
  
  MusicPlaylistRelation.create!(
    music_id: n+1,
    playlist_id: 1,
    position: n
  )

  Like.create!(
    music_id: n+1,
    user_id: 1
  )

  Designer.create!(
    name: "デザイナー#{n+1}"
  )
end

Comment.create!(
  content: "最高～",
  user_id: 1,
  music_id: 1,
  album_id: 1
)

IntroQuiz.create!(
  name: "全範囲",
  range: :full,
  q_num: "5"
)
