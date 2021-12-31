namespace :db do
  desc "Reset database with seeded data"
  task reset: [:drop, :create, :seed]
end
