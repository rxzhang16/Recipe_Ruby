# This script builds a RESTful JSON API service for recipe operations.

# Author: Renxian Zhang
# Email: rx.zhang@hotmail.com

require 'sinatra'
require 'json'

# Let's start with a basic recipe list, which includes 3 recipes. Feel free to edit it.
RECIPE_LIST = [{'id': 'RX001',
                'name': 'Bacon Crackers',
                'instructions': '1. Preheat oven to 250 degrees F (120 degrees C). '+
                    '2. Arrange the crackers in a single layer on a large baking sheet. '+
                    'Top each cracker with 1/3 slice bacon, and sprinkle desired amount of brown sugar over all. '+
                    '3. Bake 1 hour in the preheated oven, or until browned and crisp. Serve warm.',
                'ingredients': '1 (16 ounce) package buttery round crackers '+
                    '1 pound brown sugar '+
                    '1 pound sliced bacon, cut into thirds'},
               {'id': 'RX002',
                'name': 'Breakfast Burritos with Green Salsa',
                'instructions': '1. Preheat oven to 200 degrees F (95 degrees C). '+
                    '2. Heat the olive oil in a large skillet over medium-high heat. '+
                    'Place the potato slices in the skillet and season with salt, pepper, and chili powder. '+
                    'Cook until the potatoes are tender, about 10 minutes. Remove from the pan to a baking sheet '+
                    'and put in the warm oven. '+
                    '3. Stir chorizo into skillet and cook until browned and crumbly, stirring frequently to break '+
                    'apart. Pour off the grease, then place the chorizo in the oven with the potatoes. Wipe the '+
                    'skillet dry with paper towels. '+
                    '4. Wrap the tortillas with aluminum foil and place in the warm oven.',
                'ingredients': '2 tablespoons olive oil '+
                    '8 small red potatoes, cut into 1/4 inch slices '+
                    'salt and ground black pepper to taste '+
                    '4 burrito-size flour tortillas '+
                    '1/4 cup green salsa'},
               {'id': 'RX003',
                'name': 'Orange Roasted Salmon',
                'instructions': '1. Preheat the oven to 400 degrees F (200 degrees C). '+
                    '2. In a small bowl or cup, stir together the lemon pepper, garlic powder, and dried parsley. '+
                    'Place the slices from one of the oranges in a single layer in the bottom of a 9x13 inch '+
                    'baking dish. Place a layer of onion slices over the orange. Drizzle with a little bit of olive '+
                    'oil, and sprinkle with half of the herb mixture. '+
                    '3. Bake for 12 to 15 minutes in the preheated oven, or until the salmon is opaque in the center. '+
                    'Remove fillets to a serving dish, and discard the roasted orange. Garnish fillets with roasted '+
                    'onions and fresh orange slices.',
                'ingredients': '2 oranges, sliced into rounds '+
                    '1 onion, thinly sliced '+
                    '1 1/2 tablespoons olive oil '+
                    '5 (6 ounce) salmon fillets '+
                    '1 tablespoon lemon pepper' +
                    '1 tablespoon honey'}
                ]

# API service support logic
class APIServer
  attr_accessor :recipes

  def initialize
    @recipes = RECIPE_LIST
  end

  def listRecipes
    return false unless @recipes.size > 0
    recipes = @recipes.dup
    return recipes
  end

  def addRecipe(id, name, instructions, ingredients)
    notExist = true
    @recipes.each do |recipe|
      if recipe[:id] == id
        notExist = false
        break
      end
    end
    if notExist
      @recipes.push({'id': id, 'name': name, 'instructions': instructions, 'ingredients': ingredients})
      return true
      #puts "addRecipe result: #{@recipes}"
    else
      return false
    end
  end

  def removeRecipe(id)
    notExist = true
    @recipes.each do |recipe|
      if recipe[:id] == id
        notExist = false
        @recipes.delete(recipe)
        # puts "removeRecipe result: #{@recipes}"
        break
      end
    end
    return !notExist
  end

  def updateRecipe(id, name, instructions, ingredients)
    notExist = true
    @recipes.each do |recipe|
      if recipe[:id] == id
        notExist = false
        recipe[:name] = name if name
        recipe[:instructions] = instructions if instructions
        recipe[:ingredients] = ingredients if ingredients
        # puts "updateRecipe result: #{@recipes}"
        break
      end
    end
    return !notExist
  end

end

recipeAPI = APIServer.new

# Sinatra server
not_found do
  'oops, the API service must be one of list, add, remove, or update'
end

get '/list' do
  res = {}
  recipes = recipeAPI.listRecipes
  if recipes
    res[:status] = 'success'
    res[:recipes] = recipes
  else
    res[:status] = 'sorry, no recipes found'
    res[:recipes] = []
  end
  return res.to_json
end

post '/add' do
  res = {}
  if params.has_key?('id') && params.has_key?('name') && params.has_key?('instructions') && params.has_key?('ingredients')
    ret = recipeAPI.addRecipe(params[:id], params[:name], params[:instructions], params[:ingredients])
    if ret
      res[:status] = 'success'
    else
      res[:statue] = 'sorry, a recipe with the same id already exists. Use update instead'
    end
  else
    res[:status] = 'sorry, you need to provide the new recipe\'s id, name, instructions, and ingredients'
  end
  return res.to_json
end

post '/remove' do
  res = {}
  if params.has_key?('id')
    ret = recipeAPI.removeRecipe(params[:id])
    if ret
      res[:status] = 'success'
    else
      res[:statue] = 'sorry, the id of the recipe to be removed is not found'
    end
  else
    res[:status] = 'sorry, you need to provide the recipe\'s id to remove it'
  end
  return res.to_json
end

post '/update' do
  res = {}
  if params.has_key?('id')
    ret = recipeAPI.updateRecipe(params[:id], params[:name], params[:instructions], params[:ingredients])
    if ret
      res[:status] = 'success'
    else
      res[:statue] = 'sorry, the id of the recipe to be updated is not found. Use add instead'
    end
  else
    res[:status] = 'sorry, you need to provide the id of the recipe to update it'
  end
  return res.to_json
end

# if __FILE__ == $0
#   id = 'RX001'
#   name = nil
#   instructions = 'inst1'
#   ingredients = 'ingd1'
#   # recipeAPI.addRecipe(id, name, instructions, ingredients)
#   # recipeAPI.updateRecipe(id, name, instructions, ingredients)
#   recipeAPI.removeRecipe(id)
# end
