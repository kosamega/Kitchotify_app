# Pin npm packages by running ./bin/importmap pin @rails/ujs

pin 'application', preload: true
pin '@rails/ujs', to: 'https://ga.jspm.io/npm:@rails/ujs@7.0.4/lib/assets/compiled/rails-ujs.js'
pin "jquery", to: "https://ga.jspm.io/npm:jquery@3.6.0/dist/jquery.js"
