const _ = require("lodash");
const { ObjectId } = require("mongodb");
const { addDocument, deleteDocument, getDocuments, getDocument, updateDocument, checkExistence, groupInDates } = require("../commons/functions");
const { requireParamsNotSet, collectionNames, invalidId, userDoesNotExist, scheduleDoesNotExist, scheduleSoldOut, oneDay } = require("../commons/variables");

class Booking {
    id;
    userId;
    scheduleId;
    schedule;
    user;

    constructor({
        id,
        userId,
        scheduleId,
        schedule,
        user
    }) {
        this.id = id;
        this.userId = userId;
        this.scheduleId = scheduleId;
        this.user = user;
        this.schedule = schedule;
    }

    async save() {
        if (_.isUndefined(this.userId) ||
            _.isUndefined(this.scheduleId)
        ) {
            throw new Error(requireParamsNotSet);
        } else {
            let userIdObject, scheduleIdObject;
            try {
                userIdObject = new ObjectId(this.userId);
                scheduleIdObject = new ObjectId(this.scheduleId);
            } catch (error) {
                throw new Error(invalidId);
            }
            try {
                let userExist = await checkExistence(collectionNames.users, { _id: userIdObject });
                if (!userExist) {
                    throw new Error(userDoesNotExist);
                } else {
                    let User = require("./user")
                    let user = await User.find(this.userId);
                    if (!user) {
                        throw new Error(userDoesNotExist);
                        // @ts-ignore
                    } else {
                        this.user = user;
                        let Schedule = require("./schedule")
                        let schedule = await Schedule.find(this.scheduleId);
                        if (!schedule) {
                            throw new Error(scheduleDoesNotExist);
                            // @ts-ignore
                        } else if (schedule.seatsLeft < 1) {
                            throw new Error(scheduleSoldOut);
                        } else {
                            this.schedule = schedule;
                            let bookingId = await addDocument(collectionNames.bookings, this);
                            // @ts-ignore
                            await updateDocument(collectionNames.schedules, { _id: scheduleIdObject }, { seatsLeft: -1 }, "$inc");
                            this.id = bookingId;
                            // @ts-ignore
                            delete this._id;
                            return this;
                        }
                    }
                }
            } catch (error) {
                throw error;
            }
        }
    }

    static async find(id) {
        if (_.isUndefined(id)) {
            throw new Error(requireParamsNotSet);
        } else {
            let _id;
            try {
                _id = new ObjectId(id);
            } catch (error) {
                throw new Error(invalidId);
            }
            try {
                let booking = await getDocument(collectionNames.bookings, { _id });
                // @ts-ignore
                if (booking) {
                    // @ts-ignore
                    booking.id = booking._id + "";
                    // @ts-ignore
                    delete booking._id;
                    return new Booking(booking);
                } else {
                    return null;
                }
            } catch (error) {
                throw error;
            }
        }
    }

    static async findAll() {
        try {
            let bookings = await getDocuments(collectionNames.bookings);
            let allBookings = []
            let now = Date.now();
            let today = now - (now % oneDay)
            for (let booking of bookings) {
                if (booking.schedule?.startTime < today) continue;
                booking.id = booking._id + "";
                delete booking._id;
                // @ts-ignore
                allBookings.push(new Booking(booking));
            };
            // @ts-ignore
            return groupInDates(allBookings, ["schedule", "startTime"]);
            // return allBookings
        } catch (error) {
            throw error;
        }
    }

    static async update({ id, updates }) {
        if (_.isUndefined(id) || _.isEmpty(updates)) {
            throw new Error(requireParamsNotSet);
        } else {
            let _id;
            try {
                _id = new ObjectId(id);
            } catch (error) {
                throw new Error(invalidId);
            }
            delete updates._id;
            try {
                let result = await updateDocument(collectionNames.bookings, { _id }, updates);
                return result.modifiedCount;
            } catch (error) {
                throw error;
            }
        }
    }

    static async delete({ id }) {
        if (_.isUndefined(id)) {
            throw new Error(requireParamsNotSet);
        } else {
            let _id;
            try {
                _id = new ObjectId(id);
            } catch (error) {
                throw new Error(invalidId);
            }
            try {
                let result = await deleteDocument(collectionNames.bookings, { _id });
                return result.deletedCount;
            } catch (error) {
                throw error;
            }
        }
    }
}

module.exports = Booking;
