require_relative 'narrative-distance'

chunk = Chunk.new("FWTBT.full.hyph.txt")

# This should go in a seeds file.
# %w(Moscow Guaranty-Trust-Company Missoula Paris Foyot’s Butte Billings Red-Lodge Cooke-City Fort-Kearny Sun-Valley same-town-as-Franco St.-Jean-de-Luz Irun San-Sebastian Lugo Negreira Vitoria Pamplona Noya Cathedral-at-Léon Tafalla Burgos Soria Zaragoza Café-Colon Valladolid Barcelona Siguenza Santa-Maria-del-Real Arevalo Buitrago Segovia La-Granja Alpine-Club Villacastín Trijueque Brihuega Torija Cerce Navacerrada Manzanares-el-Real San-Rafael Alto-del-Léon Guadar Colmenar Avila Guadalajara Peguerinos Escorial Puente-de-los-Franceses Velazquez-63 Florida Plaza-del-Callao Gran-Via Calle-de-Salud Gaylord Opera Fornos Mantequerías-Leonesas Parque-of-the-Buen-Retiro Ppalace Villa-Rosa Prado Jardín-Botánico Circus-of-Price Madrid Puente-de-Toledo Usera Béjar Carabanchel Barco-de-Avila Arganda Villaconejos Aranjuez Plasencia Otero Talavera Alcazar Toledo Valencia Pozoblanco Alicante Fuente-Ovejuna Tarsus Puerto-de-Santa-Maria Cádiz Vicksburg Corpus-Christi Gredos Spain Estremadura Rrussia Navarr(e|a) Aamerica Castile Montana Galicia Sierra Andalucía Black-Sea Córdoba France Lenin-Institute Little-Big-Horn Soviet-Union United-States Africa Agincourt Aragon Asturias Avenue-du-Maine Azerbaijan Basque-country Bear-Tooth-plateau Butte-Chaumont Cantabrico Caucasus Chartres-Cathedral China Cuba Dardanelles Europe Idaho Ile-de-la-Cité Maine Mmanzanares Mediterranean Mexico Morocco Mount-Everest Ohio Parc-Montsouris Poland Pyrenees Tambre damned-Jordan Scotland Siberia Sierra-de-Paramera Stade-Buffalo Straits-of-Marmora Texas two-Castiles Thermopylæ University-of-Montana Venezuela Republican-Embassy).each do |word|
File.read("fwtbt.seeds.txt").split(" ").each do |word|
  Token.create(string: word)
end

puts "Starting processing at #{Time.now}"
chunk.process
puts "Finished processing at #{Time.now}"
puts "There are #{Edge.all.length} edges."
puts "Now calculating averages at #{Time.now}"
chunk.calculate_averages
puts "Done with that."
puts "Now dumping to csv at #{Time.now}"
chunk.dump_csv
puts "All done (at #{Time.now})!"
puts "Consider renaming the database and moving the files out of the directory now!"
