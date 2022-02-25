const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class RatingModel {
    constructor() {
        if (this.instance) return this.instance;
        RatingModel.instance = this;
    }

    get() {
        return database.getList("ratings");
    }

    getById(id) {
        return database.get("ratings", id);
    }

    create(rating) {
        return database.create("ratings", rating);
    }

    setId(rating) {
        return database.setId("ratings", rating.id, rating);
    }

    delete(id) {
        return database.delete("ratings", id);
    }

    update(id, rating) {
        return database.set("ratings", id, rating);
    }
}

module.exports = new RatingModel();
