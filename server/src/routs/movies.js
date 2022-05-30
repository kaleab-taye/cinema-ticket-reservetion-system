
const express = require("express");
const { errorLog, httpSingleResponse, httpInternalErrorResponse, httpNotFoundResponse } = require("../commons/functions.js");
const { invalidCallRegex } = require("../commons/variables.js");

const Movie = require("../entities/movie.js")

const movies = express.Router();

/**
 * @swagger
 * /{token}/movies:
 *  get:
 *   description: Get all movies
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   tags:
 *     - Movies
 *   responses:
 *     200:
 *       description: An array of all movies
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
movies.get("/", async (req, res) => {
    try {
        let allMovies = await Movie.findAll();
        res.status(200).end(JSON.stringify(allMovies));
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Getting All Movies", error);
            httpInternalErrorResponse(res);
        }
    }
})

/**
 * @swagger
 * /{token}/movies/{id}:
 *  get:
 *   description: Get a movie by its id
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   tags:
 *     - Movies
 *   responses:
 *     200:
 *       description: A movie object
 *     400:
 *       description: Invalid/incomplete parameters
 *     404:
 *       description: A movie with the given id not found
 *     500:
 *       description: Internal error
 */
movies.get("/:id", async (req, res) => {
    let id = req.params.id;
    try {
        let movie = await Movie.find({ id });
        if (movie) {
            res.status(200).end(JSON.stringify(movie));
        } else {
            httpNotFoundResponse(res);
        }
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog(`ERROR: Getting a Movie '${id}'`, error);
            httpInternalErrorResponse(res);
        }

    }
})

/**
 * @swagger
 * /{token}/movies:
 *  post:
 *   description: Add a movie (FOR TESTING ONLY)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   requestBody:
 *     description: A movie object
 *     required: true
 *   tags:
 *     - Movies
 *   responses:
 *     200:
 *       description: A movie object
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
movies.post("/", async (req, res) => {
    try {
        let newMovie = new Movie(req.body);
        newMovie = await newMovie.save();
        res.status(200).end(JSON.stringify(newMovie));
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Adding New Movie", error);
            httpInternalErrorResponse(res);
        }
    }
})

/**
 * @swagger
 * /{token}/movies/{id}:
 *  patch:
 *   description: Updates a movie (FOR TESTING ONLY)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   requestBody:
 *     description: A movie object
 *     required: true
 *   tags:
 *     - Movies
 *   responses:
 *     200:
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               updated:
 *                 type: boolean
 *                 example: false
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
movies.patch("/:id", async (req, res) => {
    let id = req.params.id;
    try {
        let updatedCount = await Movie.update({ id, updates: req.body });
        res.status(200).end(JSON.stringify({ updated: !!updatedCount }));
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Updating a Movie", error);
            httpInternalErrorResponse(res);
        }
    }
})

/**
* @swagger
* /{token}/movies/{id}:
*  delete:
*   description: Deletes a movie by id (FOR TESTING ONLY)
*   parameters:
*     - in: path
*       name: token
*       required: true
*     - in: path
*       name: id
*       required: true
*   tags:
*     - Movies
*   responses:
*     200:
*       content:
*         application/json:
*           schema:
*             type: object
*             properties:
*               deleted:
*                 type: boolean
*                 example: false
*     400:
*       description: Invalid/incomplete parameters
*     500:
*       description: Internal error
*/
movies.delete("/:id", async (req, res) => {
    let id = req.params.id;
    try {
        let deletedCount = await Movie.delete({ id });
        res.status(200).end(JSON.stringify({ deleted: !!deletedCount }));
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Deleting a Movie", error);
            httpInternalErrorResponse(res);
        }
    }
})

module.exports = movies;