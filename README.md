# Assignment 3
Assignment 3 for Application Development in the iOS Environment: https://github.com/Alazarelle/Ass3

Group: Federico Amor, Lucas Infantino, Isabelle Leggat and Alexander Korabelnikoff

This project is a pantry app where the user can:
- Add new items to: pantry, fridge or freezer
- Add items to shopping list
- Automatically add the shopping list items to the corresponding storage
- Manually create recipes
- Ask an openAI Bot to create a new recipe with the ingredients the user has in his inventory (Not all ingredients are necessarily used)
- Save the AI generated recipes for later reviewing
- Add preferred food categories
- Add dietary restrictions such as allergies
- Visualise which items have already expired
- Have a list with all their recipes

The API key for the OpenAI bot is disabled as soon as it is pushed to github. That is why we will append a new one within the zip file with the source code. This key will have to be changed manually in the APICaller file, line 19 in order for the AI generated recipes to work.
