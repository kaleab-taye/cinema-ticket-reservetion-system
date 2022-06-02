
require("dotenv").config();
const { MongoClient } = require("mongodb");
const color = require("cli-color");
const jwt = require("jsonwebtoken");
const { databaseName, collectionNames, oneHour, oneDay, todayString, tomorrowString } = require("./variables.js");
const initData = require("../../assets/init_data.json");
const { includes } = require("lodash");

const mongoClient = new MongoClient(process.env.MONGODB_URL, { connectTimeoutMS: 30000, keepAlive: true });

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
    } finally {
        await mongoClient.close();
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
    } finally {
        await mongoClient.close();
    }
}

async function getDocument(collectionName, conditions) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.findOne(conditions);
    } catch (error) {
        throw error;
    } finally {
        await mongoClient.close();
    }
}

async function getDocuments(collectionName, conditions, sort = {}) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.find(conditions).sort(sort).toArray();
    } catch (error) {
        throw error;
    } finally {
        await mongoClient.close();
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
    } finally {
        await mongoClient.close();
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
    } finally {
        await mongoClient.close();
    }
}

async function deleteDocument(collectionName, conditions) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.deleteOne(conditions);
    } catch (error) {
        throw error;
    } finally {
        await mongoClient.close();
    }
}

async function deleteDocuments(collectionName, conditions) {
    try {
        mongoClient.connect();
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.deleteMany(conditions);
    } catch (error) {
        throw error;
    } finally {
        await mongoClient.close();
    }
}

async function getCount(collectionName, conditions) {
    try {
        mongoClient.connect()
        let collection = mongoClient.db(databaseName).collection(collectionName);
        return await collection.countDocuments(conditions);
    } catch (error) {
        throw error;
    } finally {
        await mongoClient.close();
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
            let today = now - (now % oneDay)
            let startTime = today + (14 * oneHour);
            let columCount = 0;
            for (let i = 0; i < 2; i++) {
                let allMovies = await getDocuments(collectionNames.movies);
                for (let movie of allMovies) {
                    let movieId = movie._id + "";
                    let Schedule = require("../entities/schedule")
                    // @ts-ignore
                    let schedule1 = new Schedule({ movieId, startTime, endTime: startTime + (2 * oneHour) });
                    await schedule1.save();
                    // await addDocument(collectionNames.schedules, schedule);
                    startTime += 2 * oneHour;
                    // @ts-ignore
                    let schedule2 = new Schedule({ movieId, startTime, endTime: startTime + 2 * oneHour });
                    await schedule2.save();
                    // await addDocument(collectionNames.schedules, schedule2);
                    columCount += 2
                    if (columCount >= 4) {
                        columCount = 0;
                        startTime += 18 * oneHour
                    } else {
                        startTime += 2 * oneHour
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

// repository likes
function groupInDates(objects, groupBy) {
    objects = objects.sort((a, b) => {
        let asTime = a;
        groupBy.forEach(key => asTime = asTime[key]);
        let bsTime = b;
        groupBy.forEach(key => bsTime = bsTime[key]);
        asTime < bsTime ? -1 : 1
    });
    let grouped = {}
    let now = Date.now();
    let todayStart = now - (now % oneDay)
    let todayTomorrow = [todayStart, todayStart + oneDay, todayStart + 2 * oneDay];
    objects.forEach(object => {
        let time = object;
        groupBy.forEach(key => time = time[key]);
        let date;
        if (time >= todayTomorrow[0] && time < todayTomorrow[1]) {
            date = todayString
        } else if (time >= todayTomorrow[1] && time < todayTomorrow[2]) {
            date = tomorrowString
        } else {
            let dateObject = new Date(time);
            date = `${dateObject.toLocaleString('default', { month: 'short' })} ${dateObject.getDate()},${dateObject.getFullYear()}`;
        }
        if (date in grouped) {
            grouped[date].push(object);
        } else {
            grouped[date] = [object];
        }
    });
    return grouped;
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
    initDb,
    groupInDates
}
