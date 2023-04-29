# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_04_29_102541) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", precision: nil, null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "albums", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "editor_id"
    t.boolean "released", default: false
    t.date "kiki_taikai_date"
    t.integer "designer_id"
    t.index ["name"], name: "index_albums_on_name", unique: true
  end

  create_table "artists", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bio"
    t.index ["name"], name: "index_artists_on_name"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "music_id"
    t.integer "album_id"
  end

  create_table "daikichi_forms", force: :cascade do |t|
    t.string "name", null: false
    t.integer "three_point", null: false
    t.integer "two_point", null: false
    t.integer "one_point", null: false
    t.boolean "closed", default: false, null: false
    t.string "albums_for_voting", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "accept_until"
  end

  create_table "daikichi_votes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "daikichi_form_id", null: false
    t.string "three_point_musics", null: false, array: true
    t.string "two_point_musics", null: false, array: true
    t.string "one_point_musics", null: false, array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "designers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bio"
  end

  create_table "intro_quizzes", force: :cascade do |t|
    t.integer "q_num"
    t.integer "range"
    t.string "name"
    t.integer "false_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.integer "music_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["music_id", "user_id"], name: "index_likes_on_music_id_and_user_id", unique: true
  end

  create_table "music_playlist_relations", force: :cascade do |t|
    t.integer "music_id"
    t.integer "playlist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position"
  end

  create_table "musics", force: :cascade do |t|
    t.string "name"
    t.integer "album_id"
    t.integer "track", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "index_info"
    t.integer "artist_id"
    t.index ["name"], name: "index_musics_on_name"
  end

  create_table "playlists", force: :cascade do |t|
    t.integer "user_id"
    t.text "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "description"
    t.boolean "public", default: false
  end

  create_table "quiz_results", force: :cascade do |t|
    t.integer "user_id"
    t.integer "intro_quiz_id"
    t.integer "time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_artist_ownerships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "artist_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["artist_id"], name: "index_user_artist_ownerships_on_artist_id"
    t.index ["user_id", "artist_id"], name: "index_user_artist_ownerships_on_user_id_and_artist_id", unique: true
    t.index ["user_id"], name: "index_user_artist_ownerships_on_user_id"
  end

  create_table "user_designer_ownerships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "designer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["designer_id"], name: "index_user_designer_ownerships_on_designer_id"
    t.index ["user_id", "designer_id"], name: "index_user_designer_ownerships_on_user_id_and_designer_id", unique: true
    t.index ["user_id"], name: "index_user_designer_ownerships_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "bio"
    t.text "remember_digest"
    t.boolean "admin", default: false
    t.boolean "editor", default: false
    t.date "join_date"
    t.float "volume", default: 0.08
    t.index ["name"], name: "index_users_on_name", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
