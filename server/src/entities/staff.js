const _ = require("lodash");
const { ObjectId } = require("mongodb");
const { checkExistence, addDocument, getDocument, updateDocument, deleteDocument, getDocuments } = require("../commons/functions");
const { requireParamsNotSet, collectionNames, userPhoneAlreadyInUse, invalidId } = require("../commons/variables");

class Staff {
    id;
    fullName;
    phone;
    passwordHash;

    constructor({
        id,
        fullName,
        phone,
        passwordHash
    }) {
        this.id = id;
        this.fullName = fullName;
        this.phone = phone;
        this.passwordHash = passwordHash;
    }

    async save() {
        if (_.isUndefined(this.fullName) ||
            _.isUndefined(this.phone) ||
            _.isUndefined(this.passwordHash)) {
            throw new Error(requireParamsNotSet);
        } else {
            try {
                let staffPhoneIsInUse = await checkExistence(collectionNames.staffs, { phone: this.phone });
                if (staffPhoneIsInUse) {
                    throw new Error(userPhoneAlreadyInUse);
                } else {
                    let id = await addDocument(collectionNames.staffs, this);
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
                let staff = await getDocument(collectionNames.staffs, { _id });
                // @ts-ignore
                if (staff) {
                    // @ts-ignore
                    staff.id = staff._id + "";
                    // @ts-ignore
                    delete staff._id;
                    return new Staff(staff);
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
                let staff = await getDocument(collectionNames.staffs, { phone });
                // @ts-ignore
                if (staff) {
                    // @ts-ignore
                    staff.id = staff._id + "";
                    // @ts-ignore
                    delete staff._id;
                    return new Staff(staff);
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
            let staffs = await getDocuments(collectionNames.staffs);
            let allStaffs = []
            staffs.forEach(staff => {
                staff.id = staff._id + "";
                delete staff._id;
                // @ts-ignore
                allStaffs.push(new Staff(staff));
            });
            return allStaffs;
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
                let staffPhoneIsInUse = await checkExistence(collectionNames.staffs, { phone: updates.phone, _id: { $ne: _id } });
                if (staffPhoneIsInUse) {
                    throw new Error(userPhoneAlreadyInUse);
                }
            }
            delete updates._id;
            try {
                let result = await updateDocument(collectionNames.staffs, { _id }, updates);
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
                let result = await deleteDocument(collectionNames.staffs, { _id });
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
                return await checkExistence(collectionNames.staffs, { phone, passwordHash });
            } catch (error) {
                throw error;
            }
        }
    }
}

module.exports = Staff;