const _ = require("lodash");
const { ObjectId } = require("mongodb");
const { addDocument, getDocument, getDocuments, updateDocument, deleteDocument } = require("../commons/functions");
const { defaultImageUrl, requireParamsNotSet, collectionNames, invalidId } = require("../commons/variables");

class Movie {
    id;
    title;
    description;
    imageUrl;
    casts;
    genera;

    constructor({
        id,
        title,
        description,
        imageUrl,
        casts,
        genera
    }) {
        this.id = id;
        this.title = title;
        this.description = _.isUndefined(description) ? "" : description;
        this.imageUrl = _.isUndefined(imageUrl) ? defaultImageUrl : imageUrl;
        this.casts = _.isUndefined(casts) ? [] : casts;
        this.genera = _.isUndefined(genera) ? "" : genera;
    }

    async save() {
        if (_.isUndefined(this.title)) {
            throw new Error(requireParamsNotSet);
        } else {
            try {
                let id = await addDocument(collectionNames.movies, this);
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
                let movie = await getDocument(collectionNames.movies, { _id });
                // @ts-ignore
                if (movie) {
                    // @ts-ignore
                    movie.id = movie._id + "";
                    // @ts-ignore
                    delete movie._id;
                    return new Movie(movie);
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
            let movies = await getDocuments(collectionNames.movies);
            let allMovies = []
            await movies.forEach(movie => {
                movie.id = movie._id + "";
                delete movie._id;
                // @ts-ignore
                allMovies.push(new Movie(movie));
            });
            return allMovies;
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
                let result = await updateDocument(collectionNames.movies, { _id }, updates);
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
                let result = await deleteDocument(collectionNames.movies, { _id });
                return result.deletedCount;
            } catch (error) {
                throw error;
            }
        }
    }
}

module.exports = Movie;