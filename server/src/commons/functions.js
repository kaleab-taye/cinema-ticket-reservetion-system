
const { MongoClient } = require("mongodb");
const color = require("cli-color");
const { databaseName } = require("./variables.js");
require("dotenv").config();

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
module.exports = {
    errorLog,
    httpSingleResponse,
    httpInternalErrorResponse,
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
    getCount
}