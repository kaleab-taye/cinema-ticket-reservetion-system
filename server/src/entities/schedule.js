const _ = require("lodash");
const { ObjectId } = require("mongodb");
const { addDocument, getDocuments, updateDocument, deleteDocument } = require("../commons/functions");
const { requireParamsNotSet, collectionNames, invalidId, defaultPrice } = require("../commons/variables");

class Schedule {
    id;
    movieId;
    startTime;
    endTime;
    soldOut;
    price;

    constructor({
        id,
        movieId,
        startTime,
        endTime,
        soldOut,
        price
    }) {
        this.id = id;
        this.movieId = movieId;
        this.startTime = startTime;
        this.endTime = endTime;
        this.soldOut = _.isUndefined(soldOut) ? false : soldOut;
        this.price = _.isUndefined(price) ? defaultPrice : price;
    }

    async save() {
        if (_.isUndefined(this.movieId) ||
            _.isUndefined(this.startTime) ||
            _.isUndefined(this.endTime)
        ) {
            throw new Error(requireParamsNotSet);
        } else {
            try {
                let id = await addDocument(collectionNames.schedules, this);
                this.id = id;
                // @ts-ignore
                delete this._id;
                return this;
            } catch (error) {
                throw error;
            }
        }
    }

    static async findAll() {
        try {
            let schedule = await getDocuments(collectionNames.schedules);
            let allSchedules = []
            await schedule.forEach(schedule => {
                schedule.id = schedule._id + "";
                delete schedule._id;
                // @ts-ignore
                allSchedules.push(new Schedule(schedule));
            });
            return allSchedules;
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
                let result = await updateDocument(collectionNames.schedules, { _id }, updates);
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
                let result = await deleteDocument(collectionNames.schedules, { _id });
                return result.deletedCount;
            } catch (error) {
                throw error;
            }
        }
    }
}

module.exports = Schedule;