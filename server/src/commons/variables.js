
const path = require("path");

// constants
const oneHour = 3600000;
const oneDay = 24 * oneHour;
const todayString = "Today";
const tomorrowString = "Tomorrow";
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
let publicFilesPath = path.resolve("assets");

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
let scheduleSoldOut = invalidCall + "SCHEDULE_SOLD_OUT";
let scheduleOverlap = invalidCall + "SCHEDULE_OVERLAP";
let pageNotFound = "PAGE_NOT_FOUND";

// defaults
let defaultImageUrl = `images/movie.jpg`;
let defaultPrice = 50;
let defaultCapacity = 200;
let userInitBalance = 200;

module.exports = {
    oneHour,
    oneDay,
    todayString,
    tomorrowString,
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
    scheduleSoldOut,
    scheduleOverlap,
    pageNotFound,
    defaultImageUrl,
    defaultPrice,
    defaultCapacity,
    noAvailableSeats,
    userInitBalance
}
