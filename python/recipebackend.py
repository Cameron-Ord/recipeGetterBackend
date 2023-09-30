from flask import Flask, request, make_response, jsonify,json
import dbhelper,apihelper,dbcreds, uuid
from flask_cors import CORS, cross_origin


app = Flask(__name__)
CORS(app, resources={r"/api/*": {"origins": "https://tastetroveapi.cameron-ord.online"}})

class RecipeApi:
    def __init__(self):
        print('initializing..')

    
    @app.post('/api/createNutrionalProfile')
    def createNutritionalProfile():
        error = apihelper.check_endpoint_info(request.json, ['recipe_id, protein, fat, carbs, calories, saturatedfat, sugars, salt'])
        if(error):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL createNutritionalProfile (?,?,?,?,?,?,?,?)',
            [request.json.get('recipe_id'), request.json.get('protein'), request.json.get('fat'), request.json.get('carbs'),request.json.get('calories'), request.json.get('saturatedfat'), request.json.get('sugars'), request.json.get('salt')])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)

    @app.get('/api/getInstructions')
    def getInstructions():
        error = apihelper.check_endpoint_info(request.args, ['id'])
        if(error):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL getInstructions(?)',
                                          [request.args.get('id')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify(results),400)
        
    @app.post('/api/createInstructions')
    def createInstructions():
        error = apihelper.check_endpoint_info(request.json, ['recipeId', 'recipeprep', 'cooking', 'methods'])
        if(error !=None):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL createInstructions(?,?,?,?)', 
                                          [request.json.get('recipeId'), request.json.get('recipeprep'), request.json.get('cooking'), request.json.get('methods')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify(results), 400)

    @app.get('/api/searchByName')
    def searchByName():
        error = apihelper.check_endpoint_info(request.args, ['title'])
        if(error != None):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL searchRecipe(?)', 
                                        [request.args.get('title')])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)


    @app.get('/api/searchByCuisine')
    @cross_origin()
    def searchByCuisine():
        
        error = apihelper.check_endpoint_info(request.args, ['cuisine'])
        if(error != None):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL searchByCuisine(?)', 
                                          [request.args.get('cuisine')])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)

    @app.get('/api/getRecipeId')
    def getRecipeId():
        error = apihelper.check_endpoint_info(request.args, ['name'])
        if(error != None):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL getRecipeById(?)', 
                                         [request.args.get('name')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify("Item doesn't exist."), 400)

    @app.post('/api/postRecipe')
    def postRecipe():
        
        is_valid = apihelper.check_endpoint_info(request.form, ['title', 'desc', 'image_url', 'ingredients','isHealthy', 'cuisine'])

        if(is_valid != None):
            print('requests bad')
            return make_response(jsonify(is_valid), 400)
        
        is_valid = apihelper.check_endpoint_info(request.files, ['image'])
        if(is_valid != None):
            
            return make_response(jsonify(is_valid), 400)
        results = []
        #iterates over each file, calls the fucntion to save it, then inserts the filename and other data into the DB.
        for file in request.files.getlist('image'):
            filename = apihelper.save_file(file)
            if filename is None:
                return make_response(jsonify("Sorry, something has gone wrong"), 500)
            
            if filename:
                concatURL = request.form.get('image_url') + filename
            result = dbhelper.run_procedure('CALL createRecipe(?,?,?,?,?,?)', [request.form.get('title'), request.form.get('desc'), concatURL ,request.form.get('ingredients'), request.form.get('isHealthy'), request.form.get('cuisine')])
            #if the task is sucessful, appends a success message to the empty results list and then returns the results
            if (type(results)==list):
                results.append('Success')
            else:
                results.append(str(result))
        
        return make_response(jsonify(results), 200)


    def initObj(self):
        print('initialized..')



if __name__ == "__main__":
    ObjectInst = RecipeApi()
    ObjectInst.initObj()

if(dbcreds.production_mode == True):
    print()
    print('----Running in Production Mode----')
    print()
    import bjoern #type: ignore
    bjoern.run(app,'0.0.0.0', 5301)
else:
   from flask_cors import CORS
   CORS(app, resources={r"/api/*": {"origins": "https://tastetroveapi.cameron-ord.online"}})
   print()
   print('----Running in Testing Mode----')
   print()
   app.run(debug=True)