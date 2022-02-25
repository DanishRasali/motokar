const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class TripModel {
    constructor() {
        if (this.instance) return this.instance;
        TripModel.instance = this;
    }

    get() {
        return database.getList("trips");
    }

    getById(id) {
        return database.get("trips", id);
    }

    create(trip) {
        return database.create("trips", trip);
    }

    setId(trip) {
        return database.setId("trips", trip.id, trip);
    }

    delete(id) {
        return database.delete("trips", id);
    }

    update(id, trip) {
        return database.set("trips", id, trip);
    }
}

module.exports = new TripModel();
