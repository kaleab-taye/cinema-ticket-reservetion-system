
const _ = require("lodash");
const express = require("express");
const { errorLog,
    httpSingleResponse,
    httpInternalErrorResponse,
    httpNotFoundResponse,
    checkExistence } = require("../commons/functions.js");
const { invalidCallRegex, collectionNames, userPhoneAlreadyInUse, requireParamsNotSet, userPhoneNotInUse } = require("../commons/variables.js");
const User = require("../entities/user.js")

const users = express.Router();

/**
 * @swagger
 * /{token}/users/signup:
 *  post:
 *   description: User signup
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   requestBody:
 *     required: true
 *     content:
 *       application/json:
 *         schema:
 *           type: object
 *           properties:
 *             phone:
 *               type: string
 *               example: +251987654321
 *   tags:
 *     - Users
 *   responses:
 *     200:
 *       description: Phone number verification code
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               phoneVerificationCode:
 *                 type: number
 *                 example: 12345
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
users.post("/signup", async (req, res) => {
    let phone = req.body.phone;
    if (_.isUndefined(phone)) {
        httpSingleResponse(res, 400, requireParamsNotSet);
    } else {
        try {
            let userPhoneIsInUse = await checkExistence(collectionNames.users, { phone });
            if (userPhoneIsInUse) {
                httpSingleResponse(res, 400, userPhoneAlreadyInUse);
            } else {
                let phoneVerificationCode = 1345;
                res.status(200).end(JSON.stringify({ phoneVerificationCode }));
            }
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Signing Up a User", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
 * @swagger
 * /{token}/users/login:
 *  post:
 *   description: User login
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   requestBody:
 *     required: true
 *     content:
 *       application/json:
 *         schema:
 *           type: object
 *           properties:
 *             phone:
 *               type: string
 *               example: +251987654321
 *             passwordHash:
 *               type: string
 *               example: gvt56uf65fvgctrtfgcyf6tyggf
 *   tags:
 *     - Users
 *   responses:
 *     200:
 *       description: A user object
 *     400:
 *       description: Invalid/incomplete parameters
 *     404:
 *       description: Invalid login credentials
 *     500:
 *       description: Internal error
 */
users.post("/login", async (req, res) => {
    try {
        if (await User.verifyPassword(req.body)) {
            let user = await User.getByPhone({ phone: req.body.phone });
            if (user) {
                res.status(200).end(JSON.stringify(user));
            } else {
                errorLog("ERROR: Getting User After Password Got Verified", user);
                httpInternalErrorResponse(res);
            }
        } else {
            httpNotFoundResponse(res);
        }
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Logging In a User", error);
            httpInternalErrorResponse(res);
        }
    }
})

/**
 * @swagger
 * /{token}/users/recover:
 *  post:
 *   description: User password recovery
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   requestBody:
 *     required: true
 *     content:
 *       application/json:
 *         schema:
 *           type: object
 *           properties:
 *             phone:
 *               type: string
 *               example: +251987654321
 *   tags:
 *     - Users
 *   responses:
 *     200:
 *       description: Phone number verification code
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               phoneVerificationCode:
 *                 type: number
 *                 example: 12345
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */
 users.post("/recover", async (req, res) => {
    let phone = req.body.phone;
    if (_.isUndefined(phone)) {
        httpSingleResponse(res, 400, requireParamsNotSet);
    } else {
        try {
            let userPhoneIsInUse = await checkExistence(collectionNames.users, { phone });
            if (!userPhoneIsInUse) {
                httpSingleResponse(res, 404, userPhoneNotInUse);
            } else {
                let phoneVerificationCode = 12345;
                res.status(200).end(JSON.stringify({ phoneVerificationCode }));
            }
        } catch (error) {
            if (error.message.match(invalidCallRegex)) {
                httpSingleResponse(res, 400, error.message);
            } else {
                errorLog("ERROR: Sending Password Recovery", error);
                httpInternalErrorResponse(res);
            }
        }
    }
})

/**
 * @swagger
 * /{token}/users/{id}:
 *  get:
 *   description: Get a user by id
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   tags:
 *     - Users
 *   responses:
 *     200:
 *       description: A user object
 *     400:
 *       description: Invalid/incomplete parameters
 *     404:
 *       description: A user with the given id not found
 *     500:
 *       description: Internal error
 */
users.get("/:id", async (req, res) => {
    let id = req.params.id;
    try {
        let user = await User.find({ id });
        if (user) {
            res.status(200).end(JSON.stringify(user));
        } else {
            httpNotFoundResponse(res);
        }
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog(`ERROR: Getting a User '${id}'`, error);
            httpInternalErrorResponse(res);
        }

    }
})

/**
 * @swagger
 * /{token}/users:
 *  post:
 *   description: Add a user
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *   requestBody:
 *     description: A user object
 *     required: true
 *   tags:
 *     - Users
 *   responses:
 *     200:
 *       description: A user object
 *     400:
 *       description: Invalid/incomplete parameters
 *     500:
 *       description: Internal error
 */

users.post("/", async (req, res) => {
    try {
        let newUser = new User(req.body);
        newUser = await newUser.save();
        res.status(200).end(JSON.stringify(newUser));
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Adding New User", error);
            httpInternalErrorResponse(res);
        }
    }
})

/**
 * @swagger
 * /{token}/users/{id}:
 *  patch:
 *   description: Updates a user
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   requestBody:
 *     description: A user object
 *     required: true
 *   tags:
 *     - Users
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

users.patch("/:id", async (req, res) => {
    let id = req.params.id;
    try {
        let updatedCount = await User.update({ id, updates: req.body });
        res.status(200).end(JSON.stringify({ updated: !!updatedCount }));
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Updating a User", error);
            httpInternalErrorResponse(res);
        }
    }
})

/**
 * @swagger
 * /{token}/users/{id}:
 *  delete:
 *   description: Deletes a user by id
 *   parameters:
 *     - in: path
 *       name: token
 *       required: true
 *     - in: path
 *       name: id
 *       required: true
 *   tags:
 *     - Users
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
users.delete("/:id", async (req, res) => {
    let id = req.params.id;
    try {
        let deletedCount = await User.delete({ id });
        res.status(200).end(JSON.stringify({ deleted: !!deletedCount }));
    } catch (error) {
        if (error.message.match(invalidCallRegex)) {
            httpSingleResponse(res, 400, error.message);
        } else {
            errorLog("ERROR: Deleting a User", error);
            httpInternalErrorResponse(res);
        }
    }
})

module.exports = users;