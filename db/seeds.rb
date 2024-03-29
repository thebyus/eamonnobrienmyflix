# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


Drama = Category.create(cat: "Drama")
Action = Category.create(cat: "Action")
Espionage = Category.create(cat: "Espionage")


Video.find_or_create_by_title(
  title:"Argo",
  small_cover:File.open("public/uploads/covers/argo_small_cover.jpg"),
  large_cover:File.open("public/uploads/covers/argo_big_cover.jpg"),
  description:"When Iranian militants seize the American embassy in 1979, six Americans slip into the Canadian embassy for protection, prompting the CIA to concoct an elaborate plot to rescue them by pretending that they're filmmakers rather than diplomats.

").categories<<[Drama, Espionage]

Video.create(
  title:"Skyfall",
  small_cover:File.open("public/uploads/covers/skyfall_small_cover.jpg"),
  large_cover:File.open("public/uploads/covers/skyfall_big_cover.jpg"),
  description:"When a serious menace threatens MI6, James Bond is on the case -- putting aside his own life and personal issues to hunt and obliterate the perpetrators. Meanwhile, secrets arise from M's past that strain Bond's loyalty to his longtime boss.

").categories<<[Action, Espionage]

Video.create(
  title:"Lincoln",
  small_cover:File.open("public/uploads/covers/lincoln_small_cover.jpg"),
  large_cover:File.open("public/uploads/covers/lincoln_big_cover.jpg"),
  description:"Director Steven Spielberg takes on the towering legacy of Abraham Lincoln, focusing on his stewardship of the Union during the Civil War years. The biographical saga also reveals the conflicts within Lincoln's cabinet regarding the war and abolition.

").categories<<[Drama]

flight = Video.create(
  title:"Flight",
  small_cover:File.open("public/uploads/covers/flight_small_cover.jpg"),
  large_cover:File.open("public/uploads/covers/flight_big_cover.jpg"),
  description:"After his amazing safe landing of a damaged passenger plane, an airline pilot is praised for the feat, but has private questions about what happened. Further, the government's inquiry into the causes soon puts the new hero's reputation at risk.

").categories<<[Drama]

Video.create(
  title:"The Bourne Legacy",
  small_cover:File.open("public/uploads/covers/the_bourne_legacy_small_cover.jpg"),
  large_cover:File.open("public/uploads/covers/the_bourne_legacy_big_cover.jpg"),
  description:"Following the Jason Bourne debacle, the CIA finds itself dealing with a familiar threat when another estranged operative surfaces. Jeremy Renner stars alongside Edward Norton, Rachel Weisz and Joan Allen.

").categories<<[Action, Espionage]

Video.create(
  title:"Total Recall",
  small_cover:File.open("public/uploads/covers/total_recall_small_cover.jpg"),
  large_cover:File.open("public/uploads/covers/total_recall_small_cover.jpg"),
  description:"Bursting with mind-blowing action sequences and spectacular visual effects, Colin Farrell stars as Douglas Quaid, a man on the run after a mind-bending procedure at Rekall goes horribly wrong. Co-starring Kate Beckinsale and Jessica Biel.

").categories<<[Action, Espionage]

eamonn = User.create!( full_name: "Eamonn O'Brien", password: "password", email: "eamonn.p.obrien@gmail.com", admin: true )

tom = User.create!( full_name: "Tom Jones", password: "password", email: "tom@junk.com" )

dick = User.create!( full_name: "Dick Lee", password: "password", email: "dick@junk.com" )

harry = User.create!( full_name: "Harry Hoggins", password: "password", email: "harry@junk.com" )

Review.create(user_id: 1, video_id: 1, rating: 2, content: "A whole lot of hiding!")
Review.create(user_id: 1, video_id: 2, rating: 4, content: "This movie is awesome!")

QueueItem.create(user_id: 1, video_id: 1)
QueueItem.create(user_id: 1, video_id: 2)
