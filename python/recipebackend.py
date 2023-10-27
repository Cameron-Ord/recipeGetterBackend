from flask import Flask, request, make_response, jsonify,json
import dbhelper,apihelper,dbcreds, uuid,bcrypt
from flask_cors import CORS, cross_origin
from createAdmin import adminSignup,endpoint


app = Flask(__name__)
class RecipeApi:
    def __init__(self):
        print('initializing..')

    def checkData(self):
        print()

    def checkArgs(self):
        print()

    def checkHeaders(self):
        print()

    def validatePW(self,pwHashInput,usernameInput):
        results = dbhelper.run_procedure('CALL getHashedPw(?)',
                                         [usernameInput])
        if type(results) == list:
            if pwHashInput:
                return bcrypt.checkpw(results[0]['password'].encode('utf-8'), pwHashInput)
            
    def validateAdminPW(self,pwHashInput,usernameInput):
        results = dbhelper.run_procedure('CALL getAdminHashedPw(?)',
                                         [usernameInput])
        if type(results) == list:
            if pwHashInput:
                return bcrypt.checkpw(results[0]['password'].encode('utf-8'), pwHashInput)
    
    @app.post(endpoint)
    @cross_origin()
    def runSignup():
        results = adminSignup()
        if(results):
            return results

    @app.get('/api/getClientInfo')
    @cross_origin()
    def getClientInfo():
        error = apihelper.check_endpoint_info(request.args, ['client_id'])
        if(error != None):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL getClientInfo(?)', [request.args.get('client_id')])
        if(type(results)) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)

    @app.post('/api/clientSignup')
    @cross_origin()
    def clientSignup():
        error = apihelper.check_endpoint_info(request.json, ['username', 'password', 'email'])
        if(error != None):
            return make_response(jsonify(error), 400)
        salt = bcrypt.gensalt()
        hashed_pw = bcrypt.hashpw(request.json.get('password').encode('utf8'), salt)
        results = dbhelper.run_procedure('CALL clientSignup(?,?,?)',
                                         [request.json.get('username'), hashed_pw , request.json.get('email')])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)


    @app.post('/api/generateKey')
    @cross_origin()
    def generateKey():
        error = apihelper.check_endpoint_info(request.json, ['client_id', 'token'])
        if(error != None):
            return make_response(jsonify(error), 400)

        generatedKey = uuid.uuid4().hex
        results = dbhelper.run_procedure('CALL generateKey(?,?,?)',
                                         [request.json.get('client_id'), str(generatedKey), request.json.get('token')])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)


    @app.post('/api/clientLogin')
    @cross_origin()
    def clientLogin():
        error = apihelper.check_endpoint_info(request.json, ['username', 'password'])
        if(error != None):
            return make_response(jsonify(error), 400)
        salt = bcrypt.gensalt()
        pwHashInput = bcrypt.hashpw(request.json.get('password').encode('utf8'), salt)
        usernameInput = request.json.get('username')
        validatedPW = ObjectInst.validatePW(pwHashInput,usernameInput)
        generatedToken = uuid.uuid4().hex
        results = dbhelper.run_procedure('CALL clientLogin(?,?,?)',
                                         [request.json.get('username'), validatedPW , generatedToken])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)

    @app.post('/api/adminLogin')
    @cross_origin()
    def adminLogin():
        error = apihelper.check_endpoint_info(request.json, ['username', 'password'])
        if(error != None):
            return make_response(jsonify(error), 400)
        salt = bcrypt.gensalt()
        pwHashInput = bcrypt.hashpw(request.json.get('password').encode('utf8'), salt)
        usernameInput = request.json.get('username')
        validatedPW = ObjectInst.validateAdminPW(pwHashInput,usernameInput)
        generatedToken = uuid.uuid4().hex
        results = dbhelper.run_procedure('CALL adminLogin(?,?,?)',
                                         [request.json.get('username'), validatedPW , generatedToken])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)


    @app.get('/api/fetchUserKey')
    @cross_origin()
    def fetchUserKey():
        error = apihelper.check_endpoint_info(request.args, ['client_id','session_token'])
        if(error != None):
            return make_response(jsonify(error),400)
        results = dbhelper.run_procedure('CALL fetchUserKey(?,?)',
        [request.args.get('client_id'), request.args.get('session_token')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify(results),400)

    @app.get('/api/getNutritionalProfile')
    @cross_origin()
    def getNutritionalProfile():
        error = apihelper.check_endpoint_info(request.args, ['recipe_id'])
        if(error != None):
            return make_response(jsonify(error),400)
        
        error = apihelper.check_endpoint_info(request.headers, ['apikey'])
        if(error != None):
            return make_response(jsonify(error), 400)
            
        results = dbhelper.run_procedure('CALL getNutrition(?,?)',
                                         [request.args.get('recipe_id'), request.headers.get('apikey')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify(results),400)


    @app.post('/api/createNutrionalProfile')
    def createNutritionalProfile():
        error = apihelper.check_endpoint_info(request.json, ['recipe_id, protein, fat, carbs, calories, saturatedfat, sugars, salt, token, admin_id'])
        if(error != None):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL createNutritionalProfile (?,?,?,?,?,?,?,?,?,?)',
            [request.json.get('recipe_id'), request.json.get('protein'), request.json.get('fat'), request.json.get('carbs'),request.json.get('calories'), request.json.get('saturatedfat'), request.json.get('sugars'), request.json.get('salt'), request.json.get('token'), request.json.get('admin_id')])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)

    @app.get('/api/getInstructions')
    @cross_origin()
    def getInstructions():
        error = apihelper.check_endpoint_info(request.args, ['recipe_id'])
        if(error != None):
            return make_response(jsonify(error), 400)
        
        error = apihelper.check_endpoint_info(request.headers, ['apikey'])
        if(error != None):
            return make_response(jsonify(error), 400)
            
        results = dbhelper.run_procedure('CALL getInstructions(?,?)',
                                          [request.args.get('recipe_id'), request.headers.get('apikey')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify(results),400)

    @app.post('/api/createInstructions')
    def createInstructions():
        error = apihelper.check_endpoint_info(request.json, ['recipeId', 'recipeprep', 'cooking', 'methods', 'token', 'admin_id'])
        if(error !=None):
            return make_response(jsonify(error), 400)
        results = dbhelper.run_procedure('CALL createInstructions(?,?,?,?)',
                                          [request.json.get('recipeId'), request.json.get('recipeprep'), request.json.get('cooking'), request.json.get('methods'),request.json.get('token'), request.json.get('admin_id')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify(results), 400)

    @app.get('/api/searchByName')
    @cross_origin()
    def searchByName():
        error = apihelper.check_endpoint_info(request.args, ['title'])
        if(error != None):
            return make_response(jsonify(error), 400)

        error = apihelper.check_endpoint_info(request.headers, ['apikey'])
        if(error != None):
            return make_response(jsonify(error), 400)

        results = dbhelper.run_procedure('CALL searchRecipe(?,?)',
                                        [request.args.get('title'), request.headers.get('apikey')])
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
       
        error = apihelper.check_endpoint_info(request.headers, ['apikey'])
        if(error != None):
            return make_response(jsonify(error), 400)
            
        results = dbhelper.run_procedure('CALL searchByCuisine(?,?,?)',
                                          [request.args.get('cuisine'), request.headers.get('apikey'), request.args.get('isHealthy')])
        if type(results) == list:
            return make_response(jsonify(results), 200)
        else:
            return make_response(jsonify(results), 400)

    @app.get('/api/getRecipeId')
    @cross_origin()
    def getRecipeId():
        error = apihelper.check_endpoint_info(request.args, ['name'])
        if(error != None):
            return make_response(jsonify(error), 400)
        
        error = apihelper.check_endpoint_info(request.headers, ['apikey'])
        if(error != None):
            return make_response(jsonify(error), 400)
            
        results = dbhelper.run_procedure('CALL getRecipeId(?,?)',
                                         [request.args.get('name'), request.headers.get('apikey')])
        if type(results) == list:
            return make_response(jsonify(results),200)
        else:
            return make_response(jsonify("Item doesn't exist."), 400)

    @app.post('/api/postRecipe')
    def postRecipe():

        is_valid = apihelper.check_endpoint_info(request.form, ['title', 'desc', 'image_url', 'ingredients','isHealthy', 'cuisine', 'token', 'admin_id'])

        if(is_valid != None):
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
            result = dbhelper.run_procedure('CALL createRecipe(?,?,?,?,?,?,?,?)', [request.form.get('title'), request.form.get('desc'), concatURL ,request.form.get('ingredients'), request.form.get('isHealthy'), request.form.get('cuisine'), request.form.get('token'), request.form.get('admin_id')])
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
    CORS(app)
    print()
    print('----Running in Testing Mode----')
    print()
    app.run(debug=True)