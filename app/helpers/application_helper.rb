module ApplicationHelper


  # essai d'utilisation de la gem thumbnailer pour recupérer des images de vaisseaux
  # dynamiquement, assez infructueux, fonctionne sans doute mieux avec l'api google.

  # def image(model)

  #   # Render array of image with name attribute of a given  model

  #   @modelsname = []
  #   model.all.each do |element|
  #     @modelsname << element.name
  #   end

  #   @modelsimages = []
  #   @modelsname.each do |element|
  #     search = element.parameterize
  #     url = 'https://www.google.com/search?site=&tbm=isch&source=hp&biw=1855&bih=990&q=Executor'+search
  #     object = LinkThumbnailer.generate(url)
  #     @modelsimages << object.images.first.src.to_s
  #   end

  #   @modelsimages

  # end

end
