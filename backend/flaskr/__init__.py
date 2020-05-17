import os
from flask import Flask, request, abort, jsonify
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
import random

from models import setup_db, Question, Category

QUESTIONS_PER_PAGE = 10


def paginate_questions(request, selection):
    current_page = request.args.get('page', 1, type=int)
    start = (current_page - 1) * QUESTIONS_PER_PAGE
    stop = start + QUESTIONS_PER_PAGE

    questions = [question.format() for question in selection]
    current_questions = questions[start:stop]
    return current_questions


def create_app(test_config=None):
    # create and configure the app
    app = Flask(__name__)
    setup_db(app)

    '''
   CORS set up. Allow '*' for origins.
    '''
    cors = CORS(app, resources={r"/api/*": {"origins": "*"}})

    '''
   after_request decorator to set Access-Control-Allow
    '''

    @app.after_request
    def after_request(response):
        response.headers.add('Access-Control-Allow-Headers',
                             'Content-Type,Authorization,true')
        response.headers.add('Access-Control-Allow-Methods',
                             'GET,POST,PATCH,DELETE,OPTIONS')
        return response

    '''
    Endpoint to handle GET requests for all available categories.
    '''
    @app.route('/categories')
    def get_all_catogories():
        categories = {
            category.id: category.type for category in Category.query.all()}
        return jsonify({
            "success": True,
            "categories": categories,
            "total_categories": len(categories),
        })

    '''
  Endpoint to handle GET requests for questions,
  including pagination (every 10 questions).
  This endpoint return a list of questions,
  number of total questions, current category, categories.

    '''
    @app.route('/questions')
    def get_questions():

        start = int(request.args.get('page', 1, type=int)) - 1
        end = start + QUESTIONS_PER_PAGE
        total_questions = Question.query.all()
        current_category = [
            question.category for question in total_questions[start:end]]
        questions = list(map(Question.format, total_questions))
        categories = {
            category.id: category.type for category in Category.query.all()}
        return jsonify({
            "success": True,
            "questions": questions[start:end],
            "total_questions": len(total_questions),
            "categories": categories,
            "current_category": current_category,
        })

    '''
  Endpoint to DELETE question using a question ID.

    '''
    @app.route('/questions/<int:question_id>', methods=['DELETE'])
    def delete_question(question_id):
        try:
            getQuestions = Question.query.filter(
                Question.id == question_id).first()
            getQuestions.delete()
            return jsonify({
                "success": True,
                "Question deleted": getQuestions.format(),
                "Total Question": len(Question.query.all()),

            })

        except:
            abort(422)

    '''
  Endpoint to POST a new question,
  which will require the question and answer text,
  category, and difficulty score.
    '''
    @app.route('/questions', methods=['POST'])
    def create_question():

        body = request.get_json()
        new_question = body.get('question', None)
        new_answer = body.get('answer', None)
        new_category = body.get('category', None)
        new_difficulty = body.get('difficulty', None)

        try:
            question = Question(question=new_question, category=new_category,
                                answer=new_answer, difficulty=new_difficulty)
            question.insert()

            selection = Question.query.order_by(Question.id).all()
            current_questions = paginate_questions(request, selection)

            return jsonify({
                "success": True,
                "created": question.id,
                "questions": paginate_questions(request, selection),
                "total questions": len(selection),

            })

        except:
            abort(422)

    '''
  A POST endpoint to get questions based on a search term.
  It returns any questions for whom the search term
  is a substring of the question.

    '''
    @app.route('/search', methods=['POST'])
    def search_question():

        body = request.get_json()
        search = body.get('searchTerm', None)
        search_like = "%{}%".format(search)
        try:
            search_question = Question.query.filter(
                Question.question.ilike(search_like)).all()

            current_search_page = paginate_questions(request, search_question)

            return jsonify({
                "success": True,
                "questions": current_search_page,
                "total questions": len(search_question),

            })

        except:
            abort(422)
    '''
  A GET endpoint to get questions based on category.
    '''
    @app.route('/categories/<int:current_category>/questions')
    def get_question_catogories(current_category):

        questions_query = Question.query.filter(
            Question.category == current_category).all()
        questions = [question.format() for question in questions_query]

        return jsonify({
            "success": True,
            "questions": questions,
            "total_questions": len(questions),
            "current_category": current_category,
        })

    '''
  A POST endpoint to get questions to play the quiz.
  This endpoint  take category and previous question parameters
  and return a random questions within the given category,
  if provided, and that is not one of the previous questions.
    '''

    @app.route('/quizzes', methods=['POST'])
    def play():

        body = request.get_json()
        category = body.get('quiz_category', None)
        previous_questions = body.get('previous_questions', None)
        try:
            if int(category['id']) == 0:
                questions = Question.query.all()
            else:
                questions = Question.query.filter(
                    Question.category == category['id']).all()

            question_ids = [question.id for question in questions]
            next_question_ids = list(
                set(question_ids) - set(previous_questions))
            if next_question_ids == []:
                return jsonify({
                    "success": True,
                    "question": False
                })
            else:
                random_question_id = random.choice(next_question_ids)
                question = Question.query.filter(
                    Question.id == random_question_id).first().format()
                return jsonify({
                    "success": True,
                    "question": question
                })
        except Exception as er:
            abort(422)

    '''
  Error handlers for all expected errors.
    '''
    @app.errorhandler(400)
    def bad_request(error):
        return jsonify({
            "success": False,
            "error": 400,
            "message": "Bad request",
        }), 400

    @app.errorhandler(404)
    def not_found(error):
        return jsonify({
            "success": False,
            "error": 404,
            "message": "Not found",
        }), 404

    @app.errorhandler(405)
    def method_not_allowed(error):
        return jsonify({
            "success": False,
            "error": 405,
            "message": "Method not allowed",
        }), 405

    @app.errorhandler(422)
    def unprcossable(error):
        return jsonify({
            "success": False,
            "error": 422,
            "message": "Unprocessable",
        }), 422

    @app.errorhandler(500)
    def unprcossable(error):
        return jsonify({
            "success": False,
            "error": 500,
            "message": "Internal Server Error",
        }), 500

    return app
