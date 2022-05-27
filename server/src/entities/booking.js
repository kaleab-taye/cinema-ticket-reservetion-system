const _ = require("lodash");
const { ObjectId } = require("mongodb");
const { addDocument, deleteDocument } = require("../commons/functions");
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