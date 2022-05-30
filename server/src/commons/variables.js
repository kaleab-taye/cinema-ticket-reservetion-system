
const path = require("path");

// database vars
let databaseName = "cinema";
let collectionNames = {
    users: "users",
    staffs: "staffs",
    movies: "movies",
    bookings: "bookings",
    schedules: "schedules"
}

// hosting vars
let defaultPort = 5000;
let hostUrl = "http://127.0.0.1";
let basePath = "/:token";
let publicFilesPath = path.resolve("public")

// Error message vars
let invalidCall = "INVALID_CALL:|:";
let invalidCallRegex = /^INVALID\_CALL\:\|\:/;
let requireParamsNotSet = invalidCall + "SOME_REQUIRED_PARAMS_NOT_SET";
let invalidId = invalidCall + "INVALID_ID";
let userPhoneAlreadyInUse = invalidCall + "USER_PHONE_ALREADY_IN_USE";
let userPhoneNotInUse = invalidCall + "USER_PHONE_NOT_IN_USE";
let noAvailableSeats = invalidCall + "NO_AVAILABLE_SEATS";
let userDoesNotExist = invalidCall + "USER_DONT_EXIST";
let scheduleDoesNotExist = invalidCall + "SCHEDULE_DONT_EXIST";
let pageNotFound = "PAGE_NOT_FOUND";

// defaults
let defaultImageUrl = "";
let defaultPrice = 50;
let userInitBalance = 200;

module.exports = {
    databaseName,
    collectionNames,
    defaultPort,
    hostUrl,
    basePath,
    publicFilesPath,
    invalidCall,
    invalidCallRegex,
    requireParamsNotSet,
    invalidId,
    userPhoneAlreadyInUse,
    userPhoneNotInUse,
    userDoesNotExist,
    scheduleDoesNotExist,
    pageNotFound,
    defaultImageUrl,
    defaultPrice,
    noAvailableSeats,
    userInitBalance
}