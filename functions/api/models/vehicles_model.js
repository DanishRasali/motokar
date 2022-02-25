const database = require("../database");

// Here, we are implementing the class with Singleton design pattern

class VehicleModel {
    constructor() {
        if (this.instance) return this.instance;
        VehicleModel.instance = this;
    }

    get() {
        return database.getList("vehicles");
    }

    getById(id) {
        return database.get("vehicles", id);
    }

    create(vehicle) {
        return database.create("vehicles", vehicle);
    }

    setId(vehicle) {
        return database.setId("vehicles", vehicle.id, vehicle);
    }

    delete(id) {
        return database.delete("vehicles", id);
    }

    update(id, vehicle) {
        return database.set("vehicles", id, vehicle);
    }
}

module.exports = new VehicleModel();
