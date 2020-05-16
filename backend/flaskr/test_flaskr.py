import os
import unittest
import json

from flaskr import create_app
from models import setup_db, Question, Category


class Trivia_apiTestCase(unittest.TestCase):
    #""" This class represent the trivia_api test case"""

    def setUp(self):
        #"""Define test variables and initialize app."""

        self.app = create_app()
        self.client = self.app.test_client
        self.database_name = "trivia_test"
        self.database_path = "postgres://postgres:temp101@localhost:5432/trivia_test"
        setup_db(self.app, self.database_path)

        self.new_question = {
            "question": "This is my test question?",
            "answer": "This is my test answer.",
            "category": 3,
            "difficulty": 4,
        }

        self.search_data = {
            "searchTerm": "this",
        }

        self.quizzes_data = {
            "quiz_category": {"id": 1, "category": "science"},
            "previous_questions": [],
        }

    def tearDown(self):
        pass

    def test_get_paginated_questions(self):
        res = self.client().get('/questions')
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 200)
        self.assertEqual(data['success'], True)
        self.assertTrue(data['total_questions'])
        self.assertTrue(len(data['questions']))

    def test_405_error_get_paginated_questions(self):
        res = self.client().get('/questions/1000')
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 405)
        self.assertEqual(data['success'], False)
        self.assertEqual(data['message'], "Method not allowed")

    def test_404_error_get_paginated_questions(self):
        res = self.client().get('/adsatete')
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 404)
        self.assertEqual(data['success'], False)
        self.assertEqual(data['message'], "Not found")

    def test_get_all_categories(self):
        res = self.client().get('/categories')
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 200)
        self.assertEqual(data['success'], True)
        self.assertTrue(data['total_categories'])
        self.assertTrue(len(data['categories']))

    def test_404_error_get_all_categories(self):
        res = self.client().get('/categories/wqrwtwe')
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 404)
        self.assertEqual(data['success'], False)
        self.assertEqual(data['message'], "Not found")

    def test_delete_questions(self):
        res = self.client().delete('/questions/7')
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 200)
        self.assertEqual(data['success'], True)

    def test_422_error_delete_questions(self):
        res = self.client().delete('/questions/100')
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 422)
        self.assertEqual(data['success'], False)

    def test_create_questions(self):
        res = self.client().post('/questions', json=self.new_question)
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 200)
        self.assertEqual(data['success'], True)
        self.assertTrue(data['total questions'])
        self.assertTrue(len(data['questions']))

    def test_405_error_create_questions(self):
        res = self.client().post('/questions/10', json=self.new_question)
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 405)
        self.assertEqual(data['success'], False)

    def test_search_question(self):
        res = self.client().post('/search', json=self.search_data)
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 200)
        self.assertEqual(data['success'], True)

    def test_404_error_search_question(self):
        res = self.client().post('/search/233', json=self.search_data)
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 404)
        self.assertEqual(data['success'], False)

    def test_quizzes(self):
        res = self.client().post('/quizzes', json=self.quizzes_data)
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 200)
        self.assertEqual(data['success'], True)

    def test_422_error_quizzes(self):
        res = self.client().post('/quizzes', json=self.search_data)
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 422)
        self.assertEqual(data['success'], False)

    def test_404_error_quizzes(self):
        res = self.client().post('/quizzes/1', json=self.search_data)
        data = json.loads(res.data)

        self.assertEqual(res.status_code, 404)
        self.assertEqual(data['success'], False)

if __name__ == '__main__':
    unittest.main()
