const _ = require("lodash");
const { ObjectId } = require("mongodb");
const { checkExistence, addDocument, getDocument, updateDocument, deleteDocument, getDocuments } = require("../commons/functions");
const { requireParamsNotSet, collectionNames, userPhoneAlreadyInUse, invalidId, userInitBalance } = require("../commons/variables");

class User {
    id;
    fullName;
    phone;
    passwordHash;
    booked;
    balance;

    constructor({
        id,
        fullName,
        phone,
        passwordHash,
        booked,
        balance
    }) {
        this.id = id;
        this.fullName = fullName;
        this.phone = phone;
        this.passwordHash = passwordHash;
        this.booked = _.isUndefined(booked) ? [] : booked;
        this.balance = _.isUndefined(balance) ? userInitBalance : balance;
    }

    async save() {
        if (_.isUndefined(this.fullName) ||
            _.isUndefined(this.phone) ||
            _.isUndefined(this.passwordHash)) {
            throw new Error(requireParamsNotSet);
        } else {
            try {
                let userPhoneIsInUse = await checkExistence(collectionNames.users, { phone: this.phone });
                if (userPhoneIsInUse) {
                    throw new Error(userPhoneAlreadyInUse);
                } else {
                    let id = await addDocument(collectionNames.users, this);
                    this.id = id;
                    // @ts-ignore
                    delete this._id;
                    return this;
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
                let user = await getDocument(collectionNames.users, { _id });
                // @ts-ignore
                if (user) {
                    // @ts-ignore
                    user.id = user._id + "";
                    // @ts-ignore
                    delete user._id;
                    return new User(user);
                } else {
                    return null;
                }
            } catch (error) {
                throw error;
            }
        }
    }

    static async getByPhone({ phone }) {
        if (_.isUndefined(phone)) {
            throw new Error(requireParamsNotSet);
        } else {
            try {
                let user = await getDocument(collectionNames.users, { phone });
                // @ts-ignore
                if (user) {
                    // @ts-ignore
                    user.id = user._id + "";
                    // @ts-ignore
                    delete user._id;
                    return new User(user);
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
            let users = await getDocuments(collectionNames.users);
            let allUsers = []
            await users.forEach(user => {
                user.id = user._id + "";
                delete user._id;
                // @ts-ignore
                allUsers.push(new User(user));
            });
            return allUsers;
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

            if (updates.phone) {
                let userPhoneIsInUse = await checkExistence(collectionNames.users, { phone: updates.phone, _id: { $ne: _id } });
                if (userPhoneIsInUse) {
                    throw new Error(userPhoneAlreadyInUse);
                }
            }
            delete updates._id;
            try {
                let result = await updateDocument(collectionNames.users, { _id }, updates);
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
                let result = await deleteDocument(collectionNames.users, { _id });
                return result.deletedCount;
            } catch (error) {
                throw error;
            }
        }
    }

    static async verifyPassword({ phone, passwordHash }) {
        if (_.isUndefined(phone) || _.isUndefined(passwordHash)) {
            throw new Error(requireParamsNotSet);
        } else {
            try {
                return await checkExistence(collectionNames.users, { phone, passwordHash });
            } catch (error) {
                throw error;
            }
        }
    }
}

module.exports = User;