# Pin npm packages by running ./bin/importmap

pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"
pin "bootstrap", to: "bootstrap.min.js"
pin "trix"
pin "@rails/actiontext", to: "actiontext.esm.js"
pin "jsqr" # @1.4.0
pin "@stimulus-components/timeago", to: "@stimulus-components--timeago.js" # @5.0.2
pin "date-fns" # @4.1.0
