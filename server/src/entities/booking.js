const _ = require("lodash");
const { ObjectId } = require("mongodb");
const { addDocument, deleteDocument, getDocuments, getDocument, updateDocument } = require("../commons/functions");
const { requireParamsNotSet, collectionNames, invalidId } = require("../commons/variables");

class Booking {
    id;
    userId;
    scheduleId;

    constructor({
        id,
        userId,
        scheduleId
    }) {
        this.id = id;
        this.userId = userId;
        this.scheduleId = scheduleId;
    }

    async save() {
        if (_.isUndefined(this.userId) ||
            _.isUndefined(this.scheduleId)
        ) {
            throw new Error(requireParamsNotSet);
        } else {
            try {
                let id = await addDocument(collectionNames.bookings, this);
                this.id = id;
                // @ts-ignore
                delete this._id;
                return this;
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
            await bookings.forEach(booking => {
                booking.id = booking._id + "";
                delete booking._id;
                // @ts-ignore
                allBookings.push(new User(booking));
            });
            return allBookings;
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