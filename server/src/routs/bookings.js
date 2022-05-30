
const _ = require("lodash");
const express = require("express");
const { errorLog, httpSingleResponse, httpInternalErrorResponse, httpNotFoundResponse, httpNotAuthorizedResponse } = require("../commons/functions.js");
const { invalidCallRegex } = require("../commons/variables.js");

const Booking = require("../entities/booking.js")

const bookings = express.Router();

/**
 * @swagger
 * /{token}/bookings:
 *  get:
 *   description: Get all bookings (requires JWT as staff)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   tags:
 *     - Bookings
 *   responses:
 *     200:
 *       description: An array of all bookings
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
bookings.get("/", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || loggedInUser.type != "staff") {
        httpNotAuthorizedResponse(res);
    } else {
        try {
            let allBookings = await Booking.findAll();
            res.status(200).end(JSON.stringify(allBookings));
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Getting All Bookings", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
 * @swagger
 * /{token}/bookings:
 *  post:
 *   description: Add a booking (requires JWT as owner of the booking)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   requestBody:
 *     description: A booking object
 *     required: true
 *   tags:
 *     - Bookings
 *   responses:
 *     200:
 *       description: A booking object
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
bookings.post("/", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || loggedInUser.type != "user") {
        httpNotAuthorizedResponse(res);
    } else {
        try {
            if (req.body.userId != loggedInUser.id) {
                httpNotAuthorizedResponse(res);
            } else {
                let newBooking = new Booking(req.body);
                newBooking = await newBooking.save();
                res.status(200).end(JSON.stringify(newBooking));
            }
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Adding New Booking", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
 * @swagger
 * /{token}/bookings/{id}:
 *  patch:
 *   description: Updates a booking (requires JWT as owner of the booking)
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   requestBody:
 *     description: A booking object
 *     required: true
 *   tags:
 *     - Bookings
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
bookings.patch("/:id", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || loggedInUser.type != "user") {
        httpNotAuthorizedResponse(res);
    } else {
        let id = req.params.id;
        try {
            let booking = await Booking.find(id);
            if (booking.userId != loggedInUser.id) {
                httpNotAuthorizedResponse(res);
            } else {
                let updatedCount = await Booking.update({ id, updates: req.body });
                res.status(200).end(JSON.stringify({ updated: !!updatedCount }));
            }
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Updating a Booking", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
* @swagger
* /{token}/bookings/{id}:
*  delete:
*   description: Deletes a booking by id (requires JWT as staff or owner of the booking)
*   parameters:
*     - in: path
*       name: token
*       required: true
*     - in: path
*       name: id
*       required: true
*   tags:
*     - Bookings
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
bookings.delete("/:id", async (req, res) => {
    // -JWT
    // @ts-ignore
    let loggedInUser = req.loggedInUser;
    if (_.isUndefined(loggedInUser) || !(loggedInUser.type == "staff" || loggedInUser.type == "user")) {
        httpNotAuthorizedResponse(res);
    } else {
        let id = req.params.id;
        try {
            if (loggedInUser.type == "user") {
                let booking = await Booking.find(id);
                if (booking.userId != loggedInUser.id) {
                    httpNotAuthorizedResponse(res);
                    return;
                }
            }
            let deletedCount = await Booking.delete({ id });
            res.status(200).end(JSON.stringify({ deleted: !!deletedCount }));
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Deleting a Booking", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

module.exports = bookings;