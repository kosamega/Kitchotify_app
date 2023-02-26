require 'csv'

header = %w[album_name track music_name artist_name kiki_taikai_date]

csv = ::CSV.generate('', col_sep: ',', row_sep: "\r\n") do |csv_rows|
  csv_rows << header
  csv_rows << %w[月吉999号 1 sample_music アーティスト1 2999-01-01]
end
"\xEF\xBB\xBF#{csv}"
