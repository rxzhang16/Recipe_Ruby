# Recipe_Ruby
Recipe API coded with Ruby + Sinatra

This is an implementation of the recipe API service with Ruby + Sinatra.

To run, simply: ruby recipe.rb

To test, you can use Chrome with the Postman plug-in. I have tested it on my Windows system (Ruby 2.3.1 + Sinatra 1.4.7).

It creates a Web service on the localhost:4567. 4 services are supported now:

1. list - list all the recipes (using GET)

2. add - add one recipe (using POST)

3. remove - remove one recipe (using POST)

4. update - update one recipe (using POST)

An example:

HTTP request: 

http://localhost:4567/list

Returned JSON result:

{
    "status": "success",
    "recipes": [
        {
            "id": "RX002",
            "name": "Breakfast Burritos with Green Salsa",
            "instructions": "1. Preheat oven to 200 degrees F (95 degrees C). 2. Heat the olive oil in a large skillet over medium-high heat. Place the potato slices in the skillet and season with salt, pepper, and chili powder. Cook until the potatoes are tender, about 10 minutes. Remove from the pan to a baking sheet and put in the warm oven. 3. Stir chorizo into skillet and cook until browned and crumbly, stirring frequently to break apart. Pour off the grease, then place the chorizo in the oven with the potatoes. Wipe the skillet dry with paper towels. 4. Wrap the tortillas with aluminum foil and place in the warm oven.",
            "ingredients": "2 tablespoons olive oil 8 small red potatoes, cut into 1/4 inch slices salt and ground black pepper to taste 4 burrito-size flour tortillas 1/4 cup green salsa"
        },
        {
            "id": "RX003",
            "name": "Orange Roasted Salmon",
            "instructions": "1. Preheat the oven to 400 degrees F (200 degrees C). 2. In a small bowl or cup, stir together the lemon pepper, garlic powder, and dried parsley. Place the slices from one of the oranges in a single layer in the bottom of a 9x13 inch baking dish. Place a layer of onion slices over the orange. Drizzle with a little bit of olive oil, and sprinkle with half of the herb mixture. 3. Bake for 12 to 15 minutes in the preheated oven, or until the salmon is opaque in the center. Remove fillets to a serving dish, and discard the roasted orange. Garnish fillets with roasted onions and fresh orange slices.",
            "ingredients": "2 oranges, sliced into rounds 1 onion, thinly sliced 1 1/2 tablespoons olive oil 5 (6 ounce) salmon fillets 1 tablespoon lemon pepper1 tablespoon honey"
        }
    ]
}

Please refer to API_doc.pdf for detailed API usage.

The API service is built according to your requirements. Some "shortcuts", however, are taken as this is not a production ready solution:

1. The data are currently "hard-coded" in the program file. They are real-life recipes (all my favorites) borrowed from a website. Feel free to customize them, or use the remove and add APIs to create a new recipe list. In a realistic situation, a database should be used, but that's not required by this exercise.

2. The id of a recipe is a unique identifier. Some realistic constraints are made for the 4 services:
   
list: List all the recipes. If no recipe exists, the user should be told so.

add: Add one recipe only if the id is not found in the recipes (otherwise update instead), and "add" should include all necessary information (id, name, instructions, ingredients).

remove: Remove one recipe according to id.

update: Update one recipe only if the id is found in the recipes (otherwise add instead), and "update" can update all or some of the information (name, instructions, ingredients).
