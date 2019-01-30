# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do

  Cat.delete_all
  cat1 = Cat.create!(birth_date: '2015/01/20', color: 'black', name: 'fluffy', sex: 'm', description: 'black cat')
  cat2 = Cat.create!(birth_date: '2015/02/20', color: 'brown', name: 'poofy', sex: 'f', description: 'brown cat')
  cat3 = Cat.create!(birth_date: '2015/03/20', color: 'calico', name: 'smelly', sex: 'f', description: 'gross cat')

  CatRentalRequest.delete_all
  crr1 = CatRentalRequest.create!(cat_id: cat1.id, start_date: '2018/01/23', end_date: '2018/01/30', status: 'APPROVED')
  crr2 = CatRentalRequest.create!(cat_id: cat1.id, start_date: '2018/02/23', end_date: '2018/02/28', status: 'APPROVED')
  crr3 = CatRentalRequest.create!(cat_id: cat1.id, start_date: '2018/03/23', end_date: '2018/03/30', status: 'APPROVED')
  crr4 = CatRentalRequest.create!(cat_id: cat2.id, start_date: '2018/01/23', end_date: '2018/01/30', status: 'APPROVED')
  crr5 = CatRentalRequest.create!(cat_id: cat1.id, start_date: '2018/01/25', end_date: '2018/01/29', status: 'PENDING')


end