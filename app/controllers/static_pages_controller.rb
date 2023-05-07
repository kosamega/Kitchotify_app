class StaticPagesController < ApplicationController
  before_action :logged_in_user

  def home
    @albums_and_daikichis_released = (Album.where(released: true).includes(jacket_attachment: [blob: :variant_records]) + Daikichi.where(released: true).includes(jacket_attachment: [blob: :variant_records])).sort_by do |release|
      if release.instance_of? Album
        release.kiki_taikai_date
      elsif release.instance_of? Daikichi
        release.counting_votes_date
      end
    end.reverse
    @comments = Comment.limit(10).includes([music: :artist], :user,
                                           [album: [jacket_attachment: [blob: :variant_records]]])
    @playlists = Playlist.where(public: true).includes(:user)[0..9]
  end
end
