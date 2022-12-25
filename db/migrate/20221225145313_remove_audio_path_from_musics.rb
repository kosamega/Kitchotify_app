class RemoveAudioPathFromMusics < ActiveRecord::Migration[7.0]
  def change
    remove_column :musics, :audio_path, :string
  end
end
