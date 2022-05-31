
require("dotenv").config();
const { MongoClient } = require("mongodb");
const color = require("cli-color");
const jwt = require("jsonwebtoken");
const { databaseName, collectionNames } = require("./variables.js");
const initData = require("../../assets/init_data.json");

const mongoClient = new MongoClient(process.env.MONGODB_URL);

// utility functions
function errorLog(errorMessage, error) {
    console.error(color.red(errorMessage), color.red("\n[\n"), error, color.red("\n]"));
}

function generateRandomInt(digits = 1) {
    let digitMaker = Math.pow(10, digits);
    let randomInt = Math.round(Math.random() * digitMaker);
    return randomInt < digitMaker ? randomInt : digitMaker - 1;
}

// http functions
function httpSingleResponse(res, code, message) {
    return res.status(code).end(JSON.stringify({ message }));
}

function httpInternalErrorResponse(res) {
    return httpSingleResponse(res, 500, "INTERNAL_ERROR");
}

function httpNotAuthorizedResponse(res) {
    return httpSingleResponse(res, 401, "NOT_AUTHORIZED");
}

function httpNotFoundResponse(res) {
    return httpSingleResponse(res, 404, "NOT_FOUND");
}

// database functions
async function addDocument(collectionName, document) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        let result = await collection.insertOne(document);
        return result.insertedId + "";
    } catch (error) {
        throw error;
    }
}

async function checkExistence(collectionName, conditions) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        let result = await collection.findOne(conditions);
        return result != null;
    } catch (error) {
        throw error;
    }
}

async function getDocument(collectionName, conditions) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.findOne(conditions);
    } catch (error) {
        throw error;
    }
}

async function getDocuments(collectionName, conditions, sort = {}) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.find(conditions).sort(sort);
    } catch (error) {
        throw error;
    }
}

async function updateDocument(collectionName, filters, updates, operator = "$set") {
    updates = { [operator]: updates };
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.updateOne(filters, updates);
    } catch (error) {
        throw error;
    }
}

async function updateDocuments(collectionName, filters, updates, operator = "$set") {
    updates = { [operator]: updates };
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.updateMany(filters, updates);
    } catch (error) {
        throw error;
    }
}

async function deleteDocument(collectionName, conditions) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.deleteOne(conditions);
    } catch (error) {
        throw error;
    }
}

async function deleteDocuments(collectionName, conditions) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.deleteMany(conditions);
    } catch (error) {
        throw error;
    }
}

async function getCount(collectionName, conditions) {
    try {
        mongoClient.connect()
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.countDocuments(conditions);
    } catch (error) {
        throw error;
    }
}

// JWT
function createLoginJwt(type, id) {
    let loggedInUser = { type, id };
    return jwt.sign(loggedInUser, process.env.SECURE_JWT_TOKEN);
}

function getLoginJwt(req, res, next) {
    let headerToken = req.headers["authorization"]?.split(" ")[1]
    jwt.verify(headerToken, process.env.SECURE_JWT_TOKEN, (error, loggedInUser) => {
        req.loggedInUser = loggedInUser;
        next()
    })
}

// initializations
async function initDb() {
    try {
        let inited = await checkExistence("init", { "init": true });
        if (!inited) {
            for (let [collectionName, documents] of Object.entries(initData)) {
                for (let document of documents) {
                    await addDocument(collectionName, document);
                }
            }
            let now = Date.now();
            let today = now - (now % (24 * 3600000))
            let startTime = today + (14 * 3600000);
            let columCount = 0;
            for (let i = 0; i < 2; i++) {
                let allMovies = await getDocuments(collectionNames.movies);
                for await (let movie of allMovies) {
                    let movieId = movie._id + "";
                    let Schedule = require("../entities/schedule")
                    // @ts-ignore
                    let schedule1 = new  Schedule({ movieId, startTime, endTime: startTime + (2 * 3600000) });
                    await schedule1.save();
                    // await addDocument(collectionNames.schedules, schedule);
                    startTime += 2 * 3600000;
                    // @ts-ignore
                    let schedule2 = new  Schedule({ movieId, startTime, endTime: startTime + 2 * 3600000 });
                    await schedule2.save();
                    // await addDocument(collectionNames.schedules, schedule2);
                    columCount += 2
                    if (columCount >= 4) {
                        columCount = 0;
                        startTime += 18 * 3600000
                    } else {
                        startTime += 2 * 3600000
                    }
                }
            }
            await addDocument("init", { "init": true });
            console.log("Database initialized with: 5 movies, 20 schedules");
            return true;
        } else {
            return true;
        }
    } catch (error) {
        errorLog("Error while initializing db", error);
        return false
    }
}
module.exports = {
    errorLog,
    httpSingleResponse,
    httpInternalErrorResponse,
    httpNotAuthorizedResponse,
    httpNotFoundResponse,
    addDocument,
    checkExistence,
    getDocument,
    getDocuments,
    updateDocument,
    updateDocuments,
    deleteDocument,
    deleteDocuments,
    generateRandomInt,
    getCount,
    createLoginJwt,
    getLoginJwt,
    initDb
}
