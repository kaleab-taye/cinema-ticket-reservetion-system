
const _ = require("lodash");
const express = require("express");
const { errorLog, httpSingleResponse, httpInternalErrorResponse, httpNotFoundResponse, httpNotAuthorizedResponse } = require("../commons/functions.js");
const { invalidCallRegex } = require("../commons/variables.js");

const Schedule = require("../entities/schedule.js")

const schedules = express.Router();

/**
 * @swagger
 * /{token}/schedules:
 *  get:
 *   description: Get all schedules (Requires JWT as user or staff)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   tags:
 *     - Schedules
 *   responses:
 *     200:
 *       description: An array of all schedules
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
schedules.get("/", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || !(loggedInUser.type == "staff" || loggedInUser.type == "user")) {
        httpNotAuthorizedResponse(res);
    } else {
        try {
            let allSchedules = await Schedule.findAll();
            res.status(200).end(JSON.stringify(allSchedules));
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Getting All Schedules", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
 * @swagger
 * /{token}/schedules/{id}:
 *  get:
 *   description: Get a schedule by its id (Requires JWT as user or staff)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   tags:
 *     - Schedules
 *   responses:
 *     200:
 *       description: A schedule object
 *     400:
 *       description: Invalid/incomplete parameters
 *     404:
 *       description: A schedule with the given id not found
 *     500:
 *       description: Internal error
 */
schedules.get("/:id", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || !(loggedInUser.type == "staff" || loggedInUser.type == "user")) {
        httpNotAuthorizedResponse(res);
    } else {
        let id = req.params.id;
        try {
            let schedule = await Schedule.find({ id });
            if (schedule) {
                res.status(200).end(JSON.stringify(schedule));
            } else {
                httpNotFoundResponse(res);
            }
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog(`ERROR: Getting a Schedule '${id}'`, error);
                httpInternalErrorResponse(res);
            }

        }
    }
})

/**
 * @swagger
 * /{token}/schedules:
 *  post:
 *   description: Add a schedule (Requires JWT as staff)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   requestBody:
 *     description: A schedule object
 *     required: true
 *   tags:
 *     - Schedules
 *   responses:
 *     200:
 *       description: A schedule object
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
schedules.post("/", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || loggedInUser.type != "staff") {
        httpNotAuthorizedResponse(res);
    } else {
        try {
            let newSchedule = new Schedule(req.body);
            newSchedule = await newSchedule.save();
            res.status(200).end(JSON.stringify(newSchedule));
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Adding New Schedule", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
 * @swagger
 * /{token}/schedules/{id}:
 *  patch:
 *   description: Updates a schedule (Requires JWT as staff)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   requestBody:
 *     description: A schedule object
 *     required: true
 *   tags:
 *     - Schedules
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
schedules.patch("/:id", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || loggedInUser.type != "staff") {
        httpNotAuthorizedResponse(res);
    } else {
        let id = req.params.id;
        try {
            let updatedCount = await Schedule.update({ id, updates: req.body });
            res.status(200).end(JSON.stringify({ updated: !!updatedCount }));
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Updating a Schedule", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
* @swagger
* /{token}/schedules/{id}:
*  delete:
*   description: Deletes a schedule by id (Requires JWT as staff)
*   parameters:
*     - in: path
*       name: token
*       required: true
*     - in: path
*       name: id
*       required: true
*   tags:
*     - Schedules
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
schedules.delete("/:id", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || loggedInUser.type != "staff") {
        httpNotAuthorizedResponse(res);
    } else {
        let id = req.params.id;
        try {
            let deletedCount = await Schedule.delete({ id });
            res.status(200).end(JSON.stringify({ deleted: !!deletedCount }));
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Deleting a Schedule", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

module.exports = schedules;